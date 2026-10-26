"""Byte-preserving plugin tree: parse, edit selected records, write back.

Untouched records keep their exact bytes (compressed payload included).
"""
import struct, zlib


class Rec:
    __slots__ = ('sig', 'hdr', 'raw', 'subs', 'dirty')

    def __init__(self, sig, hdr, raw):
        self.sig, self.hdr, self.raw = sig, bytearray(hdr), raw
        self.subs = None
        self.dirty = False

    @property
    def flags(self):
        return struct.unpack_from('<I', self.hdr, 8)[0]

    @property
    def fid(self):
        return struct.unpack_from('<I', self.hdr, 12)[0]

    @fid.setter
    def fid(self, v):
        struct.pack_into('<I', self.hdr, 12, v)

    def data(self):
        if self.flags & 0x00040000:
            return zlib.decompress(self.raw[4:])
        return self.raw

    def load_subs(self):
        if self.subs is None:
            self.subs = split_subs(self.data())
        return self.subs

    def set_subs(self, subs):
        self.subs = subs
        self.dirty = True

    def encode(self):
        if self.dirty:
            body = join_subs(self.subs)
            if self.flags & 0x00040000:
                body = struct.pack('<I', len(body)) + zlib.compress(body, 9)
            self.raw = body
            self.dirty = False
        struct.pack_into('<I', self.hdr, 4, len(self.raw))
        return bytes(self.hdr) + self.raw


class Grp:
    __slots__ = ('hdr', 'kids')

    def __init__(self, hdr, kids):
        self.hdr, self.kids = bytearray(hdr), kids

    @property
    def gtype(self):
        return struct.unpack_from('<i', self.hdr, 12)[0]

    @property
    def label(self):
        return struct.unpack_from('<I', self.hdr, 8)[0]

    @label.setter
    def label(self, v):
        struct.pack_into('<I', self.hdr, 8, v)

    def encode(self):
        body = b''.join(k.encode() for k in self.kids)
        struct.pack_into('<I', self.hdr, 4, 24 + len(body))
        return bytes(self.hdr) + body


def split_subs(data):
    out = []
    off = 0
    big = None
    while off + 6 <= len(data):
        sig = data[off:off + 4].decode('latin1')
        sz = struct.unpack_from('<H', data, off + 4)[0]
        if big is not None:
            sz = big
            big = None
        payload = data[off + 6: off + 6 + sz]
        if sig == 'XXXX':
            big = struct.unpack_from('<I', payload)[0]
        else:
            out.append([sig, bytes(payload)])
        off += 6 + sz
    assert off == len(data), 'trailing bytes in record'
    return out


def join_subs(subs):
    out = bytearray()
    for sig, p in subs:
        if len(p) > 0xFFFF:
            out += b'XXXX' + struct.pack('<HI', 4, len(p))
            out += sig.encode('latin1') + struct.pack('<H', 0) + p
        else:
            out += sig.encode('latin1') + struct.pack('<H', len(p)) + p
    return bytes(out)


def parse(path):
    buf = open(path, 'rb').read()
    tes4size = struct.unpack_from('<I', buf, 4)[0]
    tes4 = Rec('TES4', buf[:24], buf[24:24 + tes4size])

    def walk(off, end):
        kids = []
        while off < end:
            sig = buf[off:off + 4].decode('latin1')
            size = struct.unpack_from('<I', buf, off + 4)[0]
            if sig == 'GRUP':
                kids.append(Grp(buf[off:off + 24], walk(off + 24, off + size)))
                off += size
            else:
                kids.append(Rec(sig, buf[off:off + 24], buf[off + 24:off + 24 + size]))
                off += 24 + size
        return kids

    top = walk(24 + tes4size, len(buf))
    return tes4, top


def write(path, tes4, top):
    with open(path, 'wb') as f:
        f.write(tes4.encode())
        for g in top:
            f.write(g.encode())


def iter_nodes(kids, parents=()):
    for k in kids:
        yield k, parents
        if isinstance(k, Grp):
            yield from iter_nodes(k.kids, parents + (k,))


def count_records_and_groups(top):
    n = 0
    for k, _ in iter_nodes(top):
        n += 1
    return n


def remove_where(kids, pred):
    """Remove nodes for which pred(node) is True; drops groups left empty."""
    out = []
    for k in kids:
        if pred(k):
            continue
        if isinstance(k, Grp):
            k.kids = remove_where(k.kids, pred)
            if not k.kids:
                continue
        out.append(k)
    return out


# ---- VMAD (version 5, object format 2) -------------------------------------

def _wstr(b, o):
    n = struct.unpack_from('<H', b, o)[0]
    return b[o + 2:o + 2 + n].decode('latin1'), o + 2 + n


def _prop_value_len(b, o, ptype):
    if ptype == 1:
        return 8
    if ptype == 2:
        return 2 + struct.unpack_from('<H', b, o)[0]
    if ptype in (3, 4):
        return 4
    if ptype == 5:
        return 1
    if ptype in (11, 12, 13, 14, 15):
        n = struct.unpack_from('<I', b, o)[0]
        if ptype == 11:
            return 4 + 8 * n
        if ptype == 13 or ptype == 14:
            return 4 + 4 * n
        if ptype == 15:
            return 4 + n
        p = o + 4
        for _ in range(n):
            p += 2 + struct.unpack_from('<H', b, p)[0]
        return p - o
    raise ValueError(f'property type {ptype}')


def parse_scripts(b, o, count):
    """-> (list of scripts, end offset). script = dict(name, status, props=[(name, raw_bytes)])"""
    scripts = []
    for _ in range(count):
        name, o = _wstr(b, o)
        status = b[o]
        o += 1
        pcount = struct.unpack_from('<H', b, o)[0]
        o += 2
        props = []
        for _ in range(pcount):
            start = o
            pname, o = _wstr(b, o)
            ptype = b[o]
            o += 2  # type + status
            o += _prop_value_len(b, o, ptype)
            props.append((pname, b[start:o]))
        scripts.append(dict(name=name, status=status, props=props))
    return scripts, o


def encode_scripts(scripts):
    out = bytearray()
    for s in scripts:
        n = s['name'].encode('latin1')
        out += struct.pack('<H', len(n)) + n + bytes([s['status']]) + struct.pack('<H', len(s['props']))
        for _, raw in s['props']:
            out += raw
    return bytes(out)


def vmad_drop_props_simple(vmad, drop):
    """VMAD whose tail after the scripts is kept raw (INFO, MGEF, REFR...). drop: {script: {prop,...}}"""
    ver, fmt, cnt = struct.unpack_from('<hhH', vmad, 0)
    scripts, end = parse_scripts(vmad, 6, cnt)
    removed = []
    for s in scripts:
        for p in list(s['props']):
            if p[0] in drop.get(s['name'].lower(), ()):
                s['props'].remove(p)
                removed.append((s['name'], p[0]))
    return vmad[:6] + encode_scripts(scripts) + vmad[end:], removed


def vmad_quest_drop_props(vmad, drop):
    """QUST VMAD: scripts, fragments, then aliases with their own scripts."""
    ver, fmt, cnt = struct.unpack_from('<hhH', vmad, 0)
    scripts, o = parse_scripts(vmad, 6, cnt)
    frag_start = o
    # quest fragments: u8 unk, u16 count, wstring file, frags
    unk = vmad[o]
    fcount = struct.unpack_from('<H', vmad, o + 1)[0]
    o += 3
    fname, o = _wstr(vmad, o)
    for _ in range(fcount):
        o += 2 + 2 + 4 + 1
        _, o = _wstr(vmad, o)
        _, o = _wstr(vmad, o)
    frag_bytes = vmad[frag_start:o]
    acount = struct.unpack_from('<H', vmad, o)[0]
    o += 2
    aliases = []
    for _ in range(acount):
        obj = vmad[o:o + 8]
        aver, afmt, ascnt = struct.unpack_from('<hhH', vmad, o + 8)
        ascripts, o = parse_scripts(vmad, o + 14, ascnt)
        aliases.append((obj, aver, afmt, ascripts))
    assert o == len(vmad), f'QUST VMAD parse ended at {o} of {len(vmad)}'
    removed = []
    for s in scripts + [s for a in aliases for s in a[3]]:
        for p in list(s['props']):
            if p[0] in drop.get(s['name'].lower(), ()):
                s['props'].remove(p)
                removed.append((s['name'], p[0]))
    out = bytearray(vmad[:6]) + encode_scripts(scripts) + frag_bytes + struct.pack('<H', len(aliases))
    for obj, aver, afmt, ascripts in aliases:
        out += obj + struct.pack('<hhH', aver, afmt, len(ascripts)) + encode_scripts(ascripts)
    return bytes(out), removed
