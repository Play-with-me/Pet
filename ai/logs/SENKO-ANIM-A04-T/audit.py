from pathlib import Path
from PIL import Image
import json,hashlib,math
r=Path.cwd();p=r/'resources/characters/senko-160/run-24-v2';base=r/'resources/characters/senko-160/run-contact-v1';m=json.loads((p/'senko.anim.json').read_text());rep=json.loads((p/'run-report.json').read_text());c=m['clips']['run_side'];clock=m['clips']['run_clock_preview'];seen=set();colors=set();preserved=0;new=0;clear=[]
for i,(f,src) in enumerate(zip(c['files'],rep['source_map'])):
 im=Image.open(p/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};b=im.getbbox();assert b[0]>0 and b[1]>0 and b[2]<160 and b[3]<=153;clear.append(153-b[3]);colors.update(im.getdata());seen.add(hashlib.sha256(im.tobytes()).hexdigest())
 if 'base_frame' in src:assert im.tobytes()==Image.open(base/f"run_side/{src['base_frame']}.png").convert('RGBA').tobytes();preserved+=1
 else:new+=1
assert len(seen)==24 and preserved==18 and new==6 and len(colors)<=32;assert c['sync']==[0,12] and c['stride_px']*24==128;assert clear[0]<=1 and clear[12]<=1 and clear[7]>=2 and clear[19]>=2;assert sum(clock['frame_ms'])==533
world=json.loads((r/'resources/characters/senko-160/run-world-v4/world-trace.json').read_text());assert len(world['cases'])==12 and len(world['speed_switch_checks'])==78 and world['unique_drawings_per_second_at_max_speed']==52.5
seen60=[len({x['frame'] for x in case['rows'] if x['clip']=='run_side'}) for case in world['cases'] if case['hz']==60];assert all(n==24 for n in seen60)
max_phase_error=0
for hz in [30,60,120]:
 for t in range(10*hz+1):
  ms=t*1000/hz;elapsed=ms%533;total=0;actual=0
  for j,d in enumerate(clock['frame_ms']):
   total+=d
   if elapsed<total:actual=j;break
  expected=int(ms*45/1000)%24;delta=abs(actual-expected);max_phase_error=max(max_phase_error,min(delta,24-delta))
assert max_phase_error<=1
result=dict(unique_frames=24,preserved_base_frames=18,new_drawings=6,palette_rgba=len(colors),contact_clearance=[clear[0],clear[12]],flight_clearance=[clear[7],clear[19]],cycle_px=128,distance_hz_at240=45,distance_hz_at280=52.5,clock_cycle_ms=533,nominal_cycle_ms=24/45*1000,clock_phase_error_frames_over10s=max_phase_error,world_cases=12,switch_checks=78,frames_seen60Hz=seen60,art_acceptance='pending; intermediate meaning, body volume and start/stop joins not certified')
(r/'ai/logs/SENKO-ANIM-A04-T/audit.json').write_text(json.dumps(result,indent=2));print(json.dumps(result,indent=2))
