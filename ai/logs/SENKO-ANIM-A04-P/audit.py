from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/turn-side-back-v2';m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['turn_side_back'];seen=set();colors=set();height=[]
for f in c['files']:
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]==153;seen.add(hashlib.sha256(im.tobytes()).hexdigest());colors.update(im.getdata());height.append(b[3]-b[1])
assert len(seen)==12 and len(colors)<=32
pack=r/'resources/characters/senko-160/side-sequence-turn-v2';pm=json.loads((pack/'senko.anim.json').read_text());edges={k:v for k,v in pm['clips'].items() if k.startswith('turn_')};assert len(edges)==8
for name,e in edges.items():
 _,a,b=name.split('_');assert e['files'][0]==pm['clips']['idle_'+a]['files'][0] and e['files'][-1]==pm['clips']['idle_'+b]['files'][0];assert e['frames']==8 and sum(e['frame_ms'])==177
result=dict(new_back_drawings=len(seen),palette_rgba=len(colors),height_range=[min(height),max(height)],hardalpha=True,baseline=152,edges=8,edge_frame_refs=8,edge_ms=177,canonical_endpoints=True,art_acceptance='pending; tail center pose added, semantic pivot/volume not certified')
(r/'ai/logs/SENKO-ANIM-A04-P/audit.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
