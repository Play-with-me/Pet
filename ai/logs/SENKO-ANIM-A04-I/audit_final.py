"""Read-only raster/contact/protected-source audit, no image editing."""
from pathlib import Path
from PIL import Image
import hashlib,json,math
root=Path.cwd(); pack=root/'resources/characters/senko-160/walk-grounded-54-v7'
model=Image.open(root/'resources/characters/senko-160/model-v1/pose-02.png').convert('RGBA')
m=json.loads((pack/'senko.anim.json').read_text()); c=m['clips']['walk_side']; clock=m['clips']['walk_side_clock_preview']
assert len(c['files'])==54 and c['sync']==[0,27]
assert abs(c['stride_px']*54-144)<1e-9
assert set(clock['frame_ms'])=={22,23} and sum(clock['frame_ms'])==1200
for start in range(54): assert sum(clock['frame_ms'][(start+k)%54] for k in range(45))==1000
unique=set();colors=set()
for i,f in enumerate(c['files']):
    im=Image.open(pack/f).convert('RGBA'); assert im.size==(160,160)
    unique.add(hashlib.sha256(im.tobytes()).hexdigest()); colors.update(im.getdata())
    assert set(im.getchannel('A').getdata())<={0,255}
    assert im.crop((0,0,160,131)).tobytes()==model.crop((0,0,160,131)).tobytes(),('upper changed',i)
    for x,y in c['contacts'][i].values(): assert im.getpixel((int(x),int(y)))[3]==255,('sole not drawn',i,x,y)
assert len(unique)==54 and len(colors)<=32
r=json.loads((pack/'vector-report.json').read_text()); double=0;max_length_error=0
for row in r['rows']:
    assert row['near']['planted'] or row['far']['planted']
    double+=int(row['near']['planted'] and row['far']['planted'])
    for leg in [row['near'],row['far']]:
        foot,knee=leg['foot'],leg['knee'];hip=r['hip'];L=r['segment_length_native_px']
        max_length_error=max(max_length_error,abs(math.dist(hip,knee)-L),abs(math.dist(knee,[foot[0],foot[1]-3])-L))
        assert 148.5-1e-9<=foot[1]<=152+1e-9
        if leg['planted']: assert foot[1]==152
assert max_length_error<1e-9 and double>=10
inv=json.loads((root/'ai/logs/SENKO-ANIM-A01/inventory.json').read_text(encoding='utf-8-sig'))
protected={**inv['protected_sources'],**inv['source_manifest_sha256']}
for p,digest in protected.items(): assert hashlib.sha256((root/p).read_bytes()).hexdigest()==digest,p
result=dict(unique_frames=len(unique),palette_rgba=len(colors),all_alpha_hard=True,upper_131_rows_byte_identical=True,contacts_on_opaque_pixels=True,double_support_frames=double,no_flight=True,max_segment_length_error=max_length_error,cycle_ms=1200,every45_frames_ms=1000,protected_hashes=len(protected),visual_acceptance='pending',browser_gui='file URL blocked by browser-use policy; native Present and local PNG inspection are separate evidence')
(root/'ai/logs/SENKO-ANIM-A04-I/artifact-check.json').write_text(json.dumps(result,indent=2),encoding='utf-8');print(json.dumps(result,indent=2))
