from pathlib import Path
from PIL import Image
import json,hashlib
r=Path.cwd();p=r/'resources/characters/senko-160/side-sequence-grounded-v8';m=json.loads((p/'senko.anim.json').read_text());body=Image.open(r/'resources/characters/senko-160/model-v1/pose-02.png').convert('RGBA');upper=body.crop((0,0,160,146)).tobytes()
result={}
for name in ['walk_start','walk_stop','walk_stop_sync27']:
 c=m['clips'][name];assert len(c['files']) in (14,18) and sum(c['frame_ms'])==400 and min(c['frame_ms'])>=22
 hashes=[]
 for i,f in enumerate(c['files']):
  im=Image.open(p/f).convert('RGBA');assert im.size==(160,160);assert set(im.getchannel('A').getdata())<={0,255};assert im.crop((0,0,160,146)).tobytes()==upper
  hashes.append(hashlib.sha256(im.tobytes()).hexdigest())
  for x,y in c['contacts'][i].values():assert im.getpixel((x,y))[3]==255,(name,i,x,y)
 result[name]={'frames':len(c['files']),'unique_raster':len(set(hashes)),'duration_ms':400}
assert m['clips']['walk_start']['files'][0]==m['clips']['idle_side']['files'][0]
assert m['clips']['walk_start']['files'][-1]=='walk_side/0.png'
assert m['clips']['walk_stop']['files'][0]=='walk_side/0.png'
assert m['clips']['walk_stop_sync27']['files'][0]=='walk_side/27.png'
for n in ['walk_stop','walk_stop_sync27']: assert m['clips'][n]['files'][-1]==m['clips']['idle_side']['files'][0]
print(json.dumps(result,indent=2));(r/'ai/logs/SENKO-ANIM-A04-K/audit.json').write_text(json.dumps(result,indent=2))

