from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/run-side-v1';m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['run_side'];clock=m['clips']['run_clock_preview'];seen=set();colors=set();clearance=[];feet=[]
for i,f in enumerate(c['files']):
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]<=153;clearance.append(153-b[3]);seen.add(hashlib.sha256(im.tobytes()).hexdigest());colors.update(im.getdata());xs=[x for y in range(149,153) for x in range(160) if im.getpixel((x,y))[3]];feet.append([min(xs),max(xs)] if xs else None)
assert len(seen)==18 and len(colors)<=32 and sum(clock['frame_ms'])==400 and set(clock['frame_ms'])=={22,23};assert c['stride_px']*18==128
res=dict(drawings=18,palette_rgba=len(colors),cycle_ms=400,reference_hz=45,cycle_px=128,reference_speed_px_s=320,clearance=clearance,bottom_band_x=feet,art_qa='provisional; pixel clearance is not per-leg stance/flight certification; no integration')
(r/'ai/logs/SENKO-ANIM-A04-Q/audit.json').write_text(json.dumps(res,indent=2));print(json.dumps(res,indent=2))
