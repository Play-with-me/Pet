from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/run-integration-v3';base=r/'resources/characters/senko-160/run-integration-v2';m=json.loads((p/'senko.anim.json').read_text());colors=set();unique=set()
for i in range(18):
 im=Image.open(p/f'run_transition_art/{i}.png').convert('RGBA');assert im.size==(160,160) and set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b and b[0]>0 and b[1]>0 and b[2]<160 and b[3]<=153;colors.update(im.getdata());unique.add(hashlib.sha256(im.tobytes()).hexdigest())
assert len(unique)==18 and len(colors)<=32
for i in range(24):assert (p/f'run_side/{i}.png').read_bytes()==(base/f'run_side/{i}.png').read_bytes()
for name,entry,exit in [('run_start',m['clips']['idle_side']['files'][0],'run_side/0.png'),('run_stop','run_side/0.png',m['clips']['idle_side']['files'][0]),('run_stop_sync12','run_side/12.png',m['clips']['idle_side']['files'][0])]:
 c=m['clips'][name];assert c['files'][0]==entry and c['files'][-1]==exit and len(c['files'])==8 and sum(c['frame_ms'])==177
w=json.loads((r/'resources/characters/senko-160/run-world-v6/world-trace.json').read_text());assert len(w['cases'])==12 and all(c['start_seam']['canonical_last_frame_matches'] and c['stop_seam']['canonical_first_frame_matches'] for c in w['cases']);assert len(w['speed_switch_checks'])==78
assert (r/'resources/characters/senko-160/run-world-v5/world-trace.json').read_bytes()==(r/'resources/characters/senko-160/run-world-v6/world-trace.json').read_bytes()
result=dict(new_drawings=18,clips=3,clip_frame_refs=8,clip_ms=177,palette_rgba=len(colors),run_loop24_unchanged=True,start_canonical_matches=12,stop_canonical_matches=12,switch_checks=78,native_trace_same_after_caption_fix=True,visual_acceptance='pending; aliases do not certify internal seams/volume/leg identity')
(r/'ai/logs/SENKO-ANIM-A04-U/audit.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
