"""Headless driver for Grognak's UBE_Tex_Convert StencilTool.blend (Multi-Mesh Diffuse Baker 2.1, from the
LoversLab UBE Tex Convert download; not bundled). Same bake set-up as its Batch_Bake_Diffuse.py, minus the popup
and the Linux NVTT calls, so it runs on Windows. Normally started by convert.py.

Usage: blender -b StencilTool.blend --python bake_ube.py -- jobs.json [samples]
jobs.json: [{"src": "in.tga", "out": "out.tga", "area": "body|hands|feet|head", "res": 2048}, ...]"""
import bpy, json, sys

args = sys.argv[sys.argv.index("--") + 1:]
jobs = json.load(open(args[0]))

scene = bpy.context.scene
scene.render.engine = 'CYCLES'
scene.cycles.bake_type = 'DIFFUSE'
scene.cycles.samples = int(args[1]) if len(args) > 1 else 512
scene.render.bake.use_selected_to_active = True
scene.render.bake.target = 'IMAGE_TEXTURES'
scene.render.bake.cage_extrusion = 0.04
scene.render.bake.max_ray_distance = 0.04
scene.render.bake.margin = 1
scene.render.bake.margin_type = 'ADJACENT_FACES'
scene.render.bake.use_clear = False
cprefs = bpy.context.preferences.addons['cycles'].preferences
try:
    cprefs.compute_device_type = 'OPTIX'
    cprefs.get_devices()
    for d in cprefs.devices:
        d.use = d.type == 'OPTIX'
    scene.cycles.device = 'GPU'
except TypeError:  # no NVIDIA card: bake on the CPU
    scene.cycles.device = 'CPU'

# Base_* carry the vanilla/CBBE UVs, New_Mesh the UBE body (body, hands and feet share one UV atlas),
# New_Head the UBE head.
BASE = {"body": ("Base_Mesh", "Base_Material"), "feet": ("Base_Feet", "Base_Feet_Material"),
        "hands": ("Base_Hands", "Base_Hand_Material"), "head": ("Base_Head", "Base_Head_Material")}


def tex_node(mat):
    return next(n for n in mat.node_tree.nodes if n.type == 'TEX_IMAGE')


for job in jobs:
    head = job["area"] == "head"
    new_mesh = bpy.data.objects["New_Head" if head else "New_Mesh"]
    new_mat = bpy.data.materials["New_Head_Material" if head else "New_Material"]
    mesh = bpy.data.objects[BASE[job["area"]][0]]
    mat = bpy.data.materials[BASE[job["area"]][1]]
    img = bpy.data.images.load(job["src"], check_existing=False)
    bake_img = bpy.data.images.new(name="Baked", width=job["res"], height=job["res"], alpha=True, float_buffer=False)
    bake_img.generated_color = (0.0, 0.0, 0.0, 0.0)
    nn = tex_node(new_mat)
    nn.image = bake_img
    new_mat.node_tree.nodes.active = nn
    bpy.ops.object.select_all(action='DESELECT')
    bn = tex_node(mat)
    bn.image = img
    mat.node_tree.nodes.active = bn
    mesh.select_set(True)
    new_mesh.select_set(True)
    bpy.context.view_layer.objects.active = new_mesh
    bpy.ops.object.bake(type='DIFFUSE', pass_filter={'COLOR'}, use_selected_to_active=True, target='IMAGE_TEXTURES')
    bake_img.filepath_raw = job["out"]
    bake_img.file_format = 'TARGA'
    bake_img.save()
    print("BAKED", job["area"], job["out"], flush=True)
    bpy.data.images.remove(img)
    bpy.data.images.remove(bake_img)
