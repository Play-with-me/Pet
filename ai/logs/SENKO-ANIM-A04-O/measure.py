"""Read-only shape comparison; never alters pixels or certifies a pivot from a bbox."""
from pathlib import Path
from PIL import Image
import json,statistics,sys
root=Path.cwd();reports={}
for folder in sys.argv[1:]:
 p=root/folder;m=json.loads((p/'senko.anim.json').read_text());c=m['clips']['turn_side_front'];rows=[]
 for i,f in enumerate(c['files']):
  im=Image.open(p/f).convert('RGBA');b=im.getbbox();opaque=sum(1 for px in im.getdata() if px[3]);waist=[]
  for y in range(120,133):
   for x in range(160):
    rr,g,bb,a=im.getpixel((x,y))
    if a and rr>g*1.4 and rr>bb*1.4:waist.append(x)
  rows.append(dict(frame=i,height=b[3]-b[1],bounds=b,opaque_area=opaque,red_waist_median=statistics.median(waist) if waist else None))
 reports[folder]={'height_range':[min(r['height'] for r in rows),max(r['height'] for r in rows)],'area_range':[min(r['opaque_area'] for r in rows),max(r['opaque_area'] for r in rows)],'rows':rows,'interpretation':'Read-only raster measurements; projected area changes with yaw; waist color median is a diagnostic, not proven skeletal pivot.'}
print(json.dumps(reports,indent=2));(root/'ai/logs/SENKO-ANIM-A04-O/shape-audit.json').write_text(json.dumps(reports,indent=2))
