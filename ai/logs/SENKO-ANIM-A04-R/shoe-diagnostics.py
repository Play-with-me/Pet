"""Read-only visible shoe-color diagnostics, no automatic leg identity labels."""
from PIL import Image
from pathlib import Path
import json,sys
p=Path(sys.argv[1]);m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['run_clock_preview'];rows=[]
for i,f in enumerate(c['files']):
 im=Image.open(p/f).convert('RGBA');pts={(x,y) for y in range(135,153) for x in range(45,145) if (lambda q:q[3]==255 and q[0]>180 and q[1]>150 and q[2]>120)(im.getpixel((x,y)))};groups=[]
 while pts:
  seed=pts.pop();g=[seed];stack=[seed]
  while stack:
   x,y=stack.pop()
   for dx,dy in [(1,0),(-1,0),(0,1),(0,-1)]:
    q=(x+dx,y+dy)
    if q in pts:pts.remove(q);g.append(q);stack.append(q)
  if len(g)>=2:groups.append({'area':len(g),'center':[round(sum(v[k] for v in g)/len(g),2) for k in (0,1)],'bottom_y':max(v[1] for v in g)})
 rows.append({'frame':i,'visible_light_components':groups})
print(json.dumps(rows,indent=2))
