"""Read-only artifact QA; no drawing, image editing or runtime business logic."""
from pathlib import Path
from PIL import Image
import hashlib, json

root = Path.cwd()
out = root / 'ai/logs/SENKO-ANIM-A04-G'
base = root / 'resources/characters/senko-160'
before = base / 'walk-waist-36-v6'
after = base / 'walk-waist-36-v7'
hashes, colors = set(), set()
for i in range(36):
    a = Image.open(before / f'walk_side/{i}.png').convert('RGBA')
    b = Image.open(after / f'walk_side/{i}.png').convert('RGBA')
    assert b.size == (160, 160)
    assert set(b.getchannel('A').getdata()) <= {0, 255}
    colors.update(b.getdata())
    hashes.add(hashlib.sha256(b.tobytes()).hexdigest())
    if i not in (10, 28):
        assert a.tobytes() == b.tobytes()
    else:
        assert a.tobytes() != b.tobytes()
        assert all(a.getpixel((x,y)) == b.getpixel((x,y)) for y in range(160) for x in range(160)
                   if not (58 <= x < 128 and 132 <= y < 153))
assert len(hashes) == 36 and len(colors) <= 32
inventory = json.loads((root / 'ai/logs/SENKO-ANIM-A01/inventory.json').read_text(encoding='utf-8-sig'))
protected = {**inventory['protected_sources'], **inventory['source_manifest_sha256']}
for name, digest in protected.items():
    assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
sources = []
for v in (3,4):
    p = root / f'resources/characters/senko-160-source/gait/walk-stance-keys-v{v}-raw.png'
    im = Image.open(p).convert('RGBA')
    alpha = im.getchannel('A').getextrema()
    sources.append(dict(file=str(p.relative_to(root)), alpha_extrema=alpha,
                        fully_transparent_pixels=im.getchannel('A').histogram()[0],
                        accepted=False, reason='incorrect stance/swing phases; alpha0 background exists despite hidden brown RGB'))
report = dict(unique_frames=len(hashes),colors_rgba=len(colors), unchanged_frames=34,
              patch_outside_unchanged=True,protected_hashes=len(protected),
              generated_sources=sources,stance_approval=False)
(out / 'artifact-check.json').write_text(json.dumps(report,indent=2),encoding='utf-8')
print(json.dumps(report,indent=2))
