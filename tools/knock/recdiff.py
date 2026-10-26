"""Record-level diff of two plugins.

usage: recdiff.py A.esp B.esp [--remap OLD:NEW ...] [--drop-master-index N] [-v]

Records are matched by FormID (after remapping A's top byte). Each record's
header (flags minus compression, form version) and its decompressed subrecord
list are compared. With --remap 04:03, a 4-byte window in A equal to
0x04xxxxxx is allowed to read 0x03xxxxxx in B (and nothing else may differ).
"""
import os, struct, sys, zlib
from collections import Counter, defaultdict

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from esptree import split_subs as subrecords


def load(path):
    buf = open(path, 'rb').read()
    tes4size = struct.unpack_from('<I', buf, 4)[0]
    hdr = buf[24:24 + tes4size]
    recs = {}
    order = []

    def walk(off, end, parents):
        while off < end:
            sig = buf[off:off + 4].decode('latin1')
            size = struct.unpack_from('<I', buf, off + 4)[0]
            if sig == 'GRUP':
                label = buf[off + 8:off + 12]
                gtype = struct.unpack_from('<i', buf, off + 12)[0]
                walk(off + 24, off + size, parents + [(gtype, label)])
                off += size
                continue
            flags, fid, vc, fv, unk = struct.unpack_from('<IIIHH', buf, off + 8)
            data = buf[off + 24: off + 24 + size]
            if flags & 0x00040000:
                data = zlib.decompress(data[4:])
            recs[fid] = dict(sig=sig, flags=flags & ~0x00040000, vc=vc, fv=fv, unk=unk,
                             subs=list(subrecords(data)), parents=parents)
            order.append(fid)
            off += 24 + size

    walk(24 + tes4size, len(buf), [])
    return list(subrecords(hdr)), recs, order


def same_mod_remap(a, b, remap):
    if len(a) != len(b):
        return False
    if a == b:
        return True
    i = 0
    n = len(a)
    while i < n:
        if a[i] == b[i]:
            i += 1
            continue
        # find a 4-byte window covering i whose A value remaps to B value
        ok = False
        for s in range(max(0, i - 3), min(i, n - 4) + 1):
            va = struct.unpack_from('<I', a, s)[0]
            vb = struct.unpack_from('<I', b, s)[0]
            if (va >> 24) in remap and remap[va >> 24] == (vb >> 24) and (va & 0xFFFFFF) == (vb & 0xFFFFFF):
                if a[s:s + 4] != b[s:s + 4]:
                    ok = True
                    i = s + 4
                    break
        if not ok:
            return False
    return True


def main():
    args = sys.argv[1:]
    verbose = '-v' in args
    remap = {}
    pos = []
    i = 0
    while i < len(args):
        if args[i] == '--remap':
            o, nw = args[i + 1].split(':')
            remap[int(o, 16)] = int(nw, 16)
            i += 2
        elif args[i] == '-v':
            i += 1
        else:
            pos.append(args[i])
            i += 1
    ha, ra, oa = load(pos[0])
    hb, rb, ob = load(pos[1])
    print('A masters', [p[:-1].decode() for s, p in ha if s == 'MAST'])
    print('B masters', [p[:-1].decode() for s, p in hb if s == 'MAST'])

    def mapfid(f):
        return ((remap.get(f >> 24, f >> 24)) << 24) | (f & 0xFFFFFF)

    only_a = [f for f in oa if mapfid(f) not in rb]
    mapped = {mapfid(f) for f in oa}
    only_b = [f for f in ob if f not in mapped]
    print(f'records: A {len(ra)}  B {len(rb)}  only A {len(only_a)}  only B {len(only_b)}')
    kinds = Counter()
    examples = defaultdict(list)
    for f in oa:
        g = mapfid(f)
        if g not in rb:
            continue
        x, y = ra[f], rb[g]
        diffs = []
        if x['sig'] != y['sig']:
            diffs.append('sig')
        if x['flags'] != y['flags']:
            diffs.append('flags')
        if x['fv'] != y['fv']:
            diffs.append('formversion')
        if x['vc'] != y['vc'] or x['unk'] != y['unk']:
            diffs.append('vc')
        sa = [s for s, p in x['subs']]
        sb = [s for s, p in y['subs']]
        if sa != sb:
            diffs.append('suborder:' + x['sig'])
        else:
            for (s, p), (s2, p2) in zip(x['subs'], y['subs']):
                if not same_mod_remap(p, p2, remap):
                    diffs.append(f'data:{x["sig"]}.{s}')
        for d in set(diffs):
            kinds[d] += 1
            if len(examples[d]) < 4:
                examples[d].append(f'{f:08X}')
    for k, v in kinds.most_common():
        print(f'  {v:5d}  {k}  e.g. {" ".join(examples[k])}')
    if verbose:
        print('only A:', ' '.join(f'{ra[f]["sig"]}:{f:08X}' for f in only_a))
        print('only B:', ' '.join(f'{rb[f]["sig"]}:{f:08X}' for f in only_b))


main()
