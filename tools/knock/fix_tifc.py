"""Set TIFC on the beg-topic overrides to the topic's real info count (1 each) in a patch."""
import struct, sys
from esptree import *
path = sys.argv[1]
t, top = parse(path)
masters = [p[:-1].decode() for s, p in split_subs(t.raw) if s == 'MAST']
sls = masters.index('SL Survival.esp')
BEG = {0x007369, 0x009EAE, 0x009EB0, 0x009EB2, 0x009EB6, 0x009EB8}
for n, _ in iter_nodes(top):
    if isinstance(n, Rec) and n.sig == 'DIAL' and n.fid >> 24 == sls and (n.fid & 0xFFFFFF) in BEG:
        subs = n.load_subs()
        for sp in subs:
            if sp[0] == 'TIFC' and struct.unpack('<I', sp[1])[0] == 0:
                sp[1] = struct.pack('<I', 1)
                print(f'{n.fid:08X} TIFC 0 -> 1')
        n.set_subs(subs)
write(path, t, top)
