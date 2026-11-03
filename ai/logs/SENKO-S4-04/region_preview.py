from pathlib import Path
import json, math
from PIL import Image, ImageDraw
root=Path(r'C:\Users\kyuu4\OneDrive\Documents\Pet\resources\characters\senko-v3-g2\candidate-v5-flow')
manifest=json.loads((root/'senko.anim.json').read_text())
entries=[]
for name, clip in manifest['clips'].items():
    if name.startswith('idle_') or name in ['sit_enter','sit_loop','sit_exit','headpat','look_up']:
        for i,file in enumerate(clip['files']): entries.append((name,i,file,clip['facing']))
sheet=Image.new('RGB',(8*240,math.ceil(len(entries)/8)*265),'#dde4ea')
d=ImageDraw.Draw(sheet)
for n,(name,i,file,facing) in enumerate(entries):
    img=Image.open(root/file).convert('RGBA')
    box=img.getbbox(); left,top,right,bottom=box
    head=top+math.ceil((bottom-top)*0.3)
    tail_top=max(head+8,bottom-31)
    overlay=img.copy()
    for y in range(80):
        for x in range(80):
            px=img.getpixel((x,y))
            if not px[3]: continue
            if y<head: overlay.putpixel((x,y),(240,70,80,255))
            elif tail_top<=y<bottom-3 and (x<26 if facing not in ['front','back'] else x>=56):
                overlay.putpixel((x,y),(40,130,255,255))
    ox,oy=n%8*240,n//8*265
    d.text((ox+4,oy+4),f'{name}/{i}',fill='black')
    overlay=overlay.resize((240,240),Image.Resampling.NEAREST)
    sheet.paste(overlay,(ox,oy+23),overlay)
sheet.save(Path(__file__).parent/'region-preview.png')
print(f'{len(entries)} frame masks for visual QA; red=head, blue=conservative tail')
