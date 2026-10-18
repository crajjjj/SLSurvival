"""Convert SLS overlay textures (vanilla/CBBE UV) to the UBE 2.0 UV layout, one copy per overlay area.

    python convert.py --tool <StencilTool.blend> --out <dir> <source.dds>:<Area>[,<Area>...] ...

Areas are SLS's overlay areas: Body, Face, Hands, Feet. Each copy lands at <dir>/<Area>/<name>.dds as BC7
with mipmaps, at the source resolution (capped at 4096). An area the overlay paints nothing on gets a 64x64
transparent texture, so a UBE actor shows nothing there instead of a misplaced vanilla-layout texture.

Needs Blender (env BLENDER), Microsoft texconv (env TEXCONV) and Pillow. The StencilTool.blend comes from
Grognak's UBE_Tex_Convert on LoversLab. 0.800 made textures/SL Survival/UBE/ (optional/BattleWoundsUBE) and the
SlaveTats Pack's UBE gap fills with it: Oral1/Oral2 for Body,Face; bikini_curse_body and magic_silence_collar
for Body,Face,Hands,Feet, from the original mod's 0.685 SE textures."""
import argparse, json, os, struct, subprocess, sys, tempfile
from PIL import Image

AREA = {"body": "body", "face": "head", "hands": "hands", "feet": "feet"}
HERE = os.path.dirname(os.path.abspath(__file__))

ap = argparse.ArgumentParser()
ap.add_argument("--tool", required=True, help="StencilTool.blend from UBE_Tex_Convert")
ap.add_argument("--out", required=True)
ap.add_argument("--samples", default="512")
ap.add_argument("jobs", nargs="+")
a = ap.parse_args()
blender = os.environ.get("BLENDER", r"C:\Program Files\Blender Foundation\Blender 5.2\blender.exe")
texconv = os.environ.get("TEXCONV", "texconv.exe")

work = tempfile.mkdtemp(prefix="ube_")
bake, finals = [], []
for spec in a.jobs:
    src, areas = spec.rsplit(":", 1)
    stem = os.path.splitext(os.path.basename(src))[0]
    subprocess.run([texconv, "-nologo", "-y", "-ft", "tga", "-m", "1", "-o", work, src], check=True, capture_output=True)
    res = min(struct.unpack_from("<I", open(src, "rb").read(20), 16)[0], 4096)
    for area in areas.split(","):
        tga = os.path.join(work, "%s_%s.tga" % (stem, area))
        bake.append({"src": os.path.join(work, stem + ".tga"), "out": tga, "area": AREA[area.lower()], "res": res})
        finals.append((tga, os.path.join(a.out, area), stem))

jf = os.path.join(work, "jobs.json")
json.dump(bake, open(jf, "w"))
r = subprocess.run([blender, "-b", a.tool, "--python", os.path.join(HERE, "bake_ube.py"), "--", jf, a.samples],
                   capture_output=True, text=True, errors="replace")
if r.returncode != 0 or r.stdout.count("BAKED") != len(bake):
    sys.exit(r.stdout[-3000:] + r.stderr[-3000:])

for tga, outdir, stem in finals:
    os.makedirs(outdir, exist_ok=True)
    if Image.open(tga).convert("RGBA").getchannel("A").getbbox() is None:
        Image.new("RGBA", (64, 64), (0, 0, 0, 0)).save(tga)
    subprocess.run([texconv, "-nologo", "-y", "-f", "BC7_UNORM", "-m", "0", "-o", work, tga], check=True, capture_output=True)
    os.replace(os.path.splitext(tga)[0] + ".dds", os.path.join(outdir, stem + ".dds"))
    print("wrote", os.path.join(outdir, stem + ".dds"))
