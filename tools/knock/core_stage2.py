"""Stage 2: drop master SimplyKnock.esp (index 3) from the stage-1 plugin by byte patching.

SLS's own FormIDs move from index 04 to 03. Where they sit inside subrecords is learned from two
Mutagen writes of the same plugin (A keeps 4 masters, B has 3): every A->B difference is one
renumbered FormID. The positions are applied to the stage-1 bytes, so every other byte stays.
"""
import struct, sys
from collections import defaultdict
from esptree import *

stage1, oracle_a, oracle_b, dst = sys.argv[1:5]
OLD, NEW = 0x04, 0x03

def recs_by_fid(top):
    return {n.fid: n for n, _ in iter_nodes(top) if isinstance(n, Rec)}

_, ta = parse(oracle_a)
_, tb = parse(oracle_b)
tes4, top = parse(stage1)
A, B, S = recs_by_fid(ta), recs_by_fid(tb), recs_by_fid(top)

def occ(subs):
    seen = defaultdict(int)
    out = {}
    for i, (s, p) in enumerate(subs):
        out[(s, seen[s])] = i
        seen[s] += 1
    return out

problems = []
patched = 0
for fid, sa in A.items():
    sb = B[(NEW << 24) | (fid & 0xFFFFFF)] if fid >> 24 == OLD else B[fid]
    subs_a, subs_b = sa.load_subs(), sb.load_subs()
    assert [s for s, _ in subs_a] == [s for s, _ in subs_b]
    pos = {}
    for (s, pa), (_, pb) in zip(subs_a, subs_b):
        pass
    ia = occ(subs_a)
    targets = {}
    for key, i in ia.items():
        pa, pb = subs_a[i][1], subs_b[i][1]
        if pa == pb:
            continue
        assert len(pa) == len(pb)
        offs = []
        j = 0
        while j < len(pa):
            if pa[j] != pb[j]:
                # renumbered FormIDs differ only in their top byte
                assert pa[j] == OLD and pb[j] == NEW and j >= 3, (fid, key, j)
                offs.append(j - 3)
            j += 1
        targets[key] = (offs, pa)
    if not targets:
        continue
    srec = S[fid]
    subs_s = srec.load_subs()
    is_ = occ(subs_s)
    for key, (offs, pa) in targets.items():
        if key not in is_:
            problems.append(f'{srec.sig} {fid:08X} {key}: missing in stage 1')
            continue
        idx = is_[key]
        ps = bytearray(subs_s[idx][1])
        for o in offs:
            want = pa[o:o + 4]
            if ps[o:o + 4] != want:
                problems.append(f'{srec.sig} {fid:08X} {key}@{o}: stage1 {ps[o:o+4].hex()} oracle {want.hex()}')
                continue
            ps[o + 3] = NEW
            patched += 1
        subs_s[idx][1] = bytes(ps)
    srec.set_subs(subs_s)

# record headers and FormID-labelled groups
hdrs = labels = 0
for n, _ in iter_nodes(top):
    if isinstance(n, Rec):
        if n.fid >> 24 == OLD:
            n.fid = (NEW << 24) | (n.fid & 0xFFFFFF)
            hdrs += 1
    elif n.gtype in (1, 6, 7, 8, 9, 10) and n.label >> 24 == OLD:
        n.label = (NEW << 24) | (n.label & 0xFFFFFF)
        labels += 1

# master list: drop SimplyKnock.esp and its DATA
subs = split_subs(tes4.raw)
out = []
skip_data = False
for s, p in subs:
    if s == 'MAST' and p[:-1].decode() == 'SimplyKnock.esp':
        skip_data = True
        continue
    if s == 'DATA' and skip_data:
        skip_data = False
        continue
    out.append([s, p])
tes4.raw = join_subs(out)

write(dst, tes4, top)
print(f'patched {patched} FormIDs in subrecords, {hdrs} record headers, {labels} group labels')
print(f'{len(problems)} problems')
for p in problems[:50]:
    print('  ', p)
