from pathlib import Path
from PIL import Image
import hashlib,json
r=Path.cwd();p=r/'resources/characters/senko-160/turn-side-front-v1';m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['turn_side_front'];unique=set();colors=set();bounds=[]
for f in c['files']:
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b and b[0]>0 and b[1]>0 and b[2]<160 and b[3]==153;bounds.append(b);colors.update(im.getdata());unique.add(hashlib.sha256(im.tobytes()).hexdigest())
assert len(unique)==12 and len(colors)<=32 and set(c['frame_ms'])=={22,23}
result={'drawings':len(unique),'palette_rgba':len(colors),'duration_ms':sum(c['frame_ms']),'bounds':bounds,'height_range':[min(b[3]-b[1] for b in bounds),max(b[3]-b[1] for b in bounds)],'hardalpha':True,'baseline':152,'scale_per_sheet':True,'visual_acceptance':'pending','not_integrated':True}
inv=json.loads((r/'ai/logs/SENKO-ANIM-A01/inventory.json').read_text(encoding='utf-8-sig'));protected={**inv['protected_sources'],**inv['source_manifest_sha256']}
for f,h in protected.items():assert hashlib.sha256((r/f).read_bytes()).hexdigest()==h,f
result['baseline_hashes_unchanged']=len(protected)
(r/'ai/logs/SENKO-ANIM-A04-M/audit.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
