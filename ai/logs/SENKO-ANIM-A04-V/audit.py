from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/walk-34-keys-v3';m=json.loads((p/'senko.anim.json').read_text());assert list(m['clips'])==['walk_34_key_review'];c=m['clips']['walk_34_key_review'];assert c['facing']=='three_quarter' and c['mirror'] and c['stride_px']==0 and c['ms']==100 and c['frames']==12
seen=set();colors=set();height=[]
for f in c['files']:
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160) and set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]==153;seen.add(hashlib.sha256(im.tobytes()).hexdigest());colors.update(im.getdata());height.append(b[3]-b[1])
assert len(seen)==12 and len(colors)<=32
res=dict(drawings=12,palette_rgba=len(colors),height_range=[min(height),max(height)],hardalpha=True,no_clipping=True,facing=c['facing'],mirror=True,preview_hz=10,cycle_ms=1200,distance_clip_absent=True,visual_acceptance='direction/phase/volume still pending; not45fps locomotion')
(r/'ai/logs/SENKO-ANIM-A04-V/audit.json').write_text(json.dumps(res,indent=2));print(json.dumps(res,indent=2))
