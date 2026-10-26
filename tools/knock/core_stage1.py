"""Stage 1 of the 0.802 core cut: detach SL Survival.esp from Simply Knock (masters untouched).

- drop the 27 Simply Knock records SLS overrides (they move to SL Survival - Simply Knock.esp)
- the 6 beg topics stay, detached: quest -> _SLS_KnockForceGreet, no branch
- INFO 0400736A loses its Simply Knock condition
- the fragments 9EB1/9EB3/9EB9 lose their 'Knock' property
- _SLS_Main loses KnockMain, _SK_LinkedDoor, SkDoorAlias
"""
import struct, sys
from esptree import *

src, dst = sys.argv[1], sys.argv[2]
SK = 0x03
tes4, top = parse(src)

BEG_TOPICS = [0x04007369, 0x04009EAE, 0x04009EB0, 0x04009EB2, 0x04009EB6, 0x04009EB8]
FORCEGREET = 0x0400736E
log = []

for node, parents in iter_nodes(top):
    if not isinstance(node, Rec):
        continue
    fid = node.fid
    if fid in BEG_TOPICS:
        subs = node.load_subs()
        new = []
        for s, p in subs:
            if s == 'QNAM':
                assert struct.unpack('<I', p)[0] == 0x0300284F
                p = struct.pack('<I', FORCEGREET)
            elif s == 'BNAM':
                assert struct.unpack('<I', p)[0] == 0x03002853
                continue
            new.append([s, p])
        node.set_subs(new)
        log.append(f'DIAL {fid:08X}: quest -> {FORCEGREET:08X}, branch dropped')
    elif fid == 0x0400736A:
        subs = node.load_subs()
        new = []
        skip_cis = False
        for s, p in subs:
            if s == 'CTDA':
                skip_cis = struct.unpack_from('<I', p, 12)[0] >> 24 == SK
                if skip_cis:
                    log.append(f'INFO {fid:08X}: dropped CTDA param {struct.unpack_from("<I", p, 12)[0]:08X}')
                    continue
            elif s in ('CIS1', 'CIS2'):
                if skip_cis:
                    log.append(f'INFO {fid:08X}: dropped {s} {p[:-1].decode()}')
                    continue
            else:
                skip_cis = False
            new.append([s, p])
        node.set_subs(new)
    elif fid in (0x04009EB1, 0x04009EB3, 0x04009EB9):
        subs = node.load_subs()
        for sp in subs:
            if sp[0] == 'VMAD':
                sp[1], removed = vmad_drop_props_simple(sp[1], {f'tif__{(fid & 0xFFFFFF) | 0x05000000:08x}': {'Knock'}})
                assert len(removed) == 1, removed
                log.append(f'INFO {fid:08X}: removed {removed}')
        node.set_subs(subs)
    elif fid == 0x04000D64 and node.sig == 'QUST':
        subs = node.load_subs()
        for sp in subs:
            if sp[0] == 'VMAD':
                sp[1], removed = vmad_quest_drop_props(sp[1], {'sls_main': {'KnockMain', '_SK_LinkedDoor'},
                                                               'sls_knocklockdoor': {'SkDoorAlias'}})
                assert len(removed) == 3, removed
                log.append(f'QUST {fid:08X}: removed {removed}')
        node.set_subs(subs)

# the Simply Knock records themselves, and the topic-children groups under them
def is_sk(node):
    if isinstance(node, Rec):
        return node.fid >> 24 == SK
    return node.gtype == 7 and node.label >> 24 == SK

before = count_records_and_groups(top)
removed_recs = [f'{n.sig}:{n.fid:08X}' for n, _ in iter_nodes(top) if isinstance(n, Rec) and n.fid >> 24 == SK]
top = remove_where(top, is_sk)
after = count_records_and_groups(top)
log.append(f'removed {len(removed_recs)} records: {" ".join(removed_recs)}')
log.append(f'records+groups {before} -> {after}')

subs = split_subs(tes4.raw)
for sp in subs:
    if sp[0] == 'HEDR':
        ver, nrec, nextid = struct.unpack('<fiI', sp[1])
        assert nrec == before
        sp[1] = struct.pack('<fiI', ver, after, nextid)
tes4.raw = join_subs(subs)

write(dst, tes4, top)
print('\n'.join(log))
