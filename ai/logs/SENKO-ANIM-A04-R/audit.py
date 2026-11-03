from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/run-contact-v1';old=r/'resources/characters/senko-160/run-review-only-v1';m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['run_side'];clock=m['clips']['run_clock_preview'];seen=set();colors=set();clear=[];heights=[];changed=[]
for i,f in enumerate(c['files']):
 im=Image.open(p/f).convert('RGBA');src=Image.open(old/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]<=153;clear.append(153-b[3]);heights.append(b[3]-b[1]);colors.update(im.getdata());seen.add(hashlib.sha256(im.tobytes()).hexdigest())
 if im.tobytes()!=src.tobytes():changed.append(i)
assert changed==[0,1,9,10] and len(seen)==18 and len(colors)<=32
assert clear[0]<=1 and clear[9]<=1 and clear[5]>=2 and clear[14]>=2 and abs(heights[0]-heights[9])<=3
assert c['sync']==[0,9] and c['stride_px']*18==128 and sum(clock['frame_ms'])==400
res=dict(drawings=18,changed_phases=changed,unchanged_frames=14,contact_clearance=[clear[0],clear[9]],flight_clearance=[clear[5],clear[14]],touchdown_heights=[heights[0],heights[9]],palette_rgba=len(colors),cycle_ms=400,cycle_px=128,source_scale='one common scale for four newly drawn grounded keys',acceptance='numerical contacts passed; per-leg stance and internal joins pending; not integrated')
(r/'ai/logs/SENKO-ANIM-A04-R/audit.json').write_text(json.dumps(res,indent=2));print(json.dumps(res,indent=2))
