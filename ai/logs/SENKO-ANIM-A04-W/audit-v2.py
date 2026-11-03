from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/walk-34-54-v2';key=r/'resources/characters/senko-160/walk-34-dense-keys-v1';m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['walk_34'];clock=m['clips']['walk_34_clock_preview'];seen=set();colors=set();height=[];ims=[]
for i,f in enumerate(c['files']):
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160) and set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]==153;seen.add(hashlib.sha256(im.tobytes()).hexdigest());colors.update(im.getdata());height.append(b[3]-b[1]);ims.append(im)
 if i%3==0:assert im.tobytes()==Image.open(key/f'walk_34/{i//3}.png').convert('RGBA').tobytes()
assert len(seen)==54 and len(colors)<=32 and c['sync']==[0,27] and c['stride_px']*54==144 and sum(clock['frame_ms'])==1200
for i in range(54):assert sum(clock['frame_ms'][(i+k)%54] for k in range(45))==1000
changes=[]
for i in range(54):changes.append(sum(1 for a,b in zip(ims[i].getdata(),ims[(i+1)%54].getdata()) if a!=b))
res=dict(drawings=54,key_drawings_preserved=18,inbetween_drawings=36,palette_rgba=len(colors),height_range=[min(height),max(height)],cycle_ms=1200,reference_hz=45,every45_delays_ms=1000,cycle_px=144,reference_speed=120,changed_pixels_by_phase_group=[sum(changes[k::3])/18 for k in range(3)],loop_changed_pixels=changes[-1],visual_acceptance='pending; pixel change numbers do not prove true inbetween or constant volume',not_runtime_integrated=True)
(r/'ai/logs/SENKO-ANIM-A04-W/audit.json').write_text(json.dumps(res,indent=2));print(json.dumps(res,indent=2))

