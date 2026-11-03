from pathlib import Path
import json
from PIL import Image, ImageDraw
root = Path(r'C:\Users\kyuu4\OneDrive\Documents\Pet\resources\characters\senko-v3-g2\candidate-v5-flow')
out = Path(__file__).parent
manifest = json.loads((root/'senko.anim.json').read_text())
entries = list(manifest['clips'].items())
sheet = Image.new('RGB', (5*320, ((len(entries)+4)//5)*350), '#d7e1e8')
draw = ImageDraw.Draw(sheet)
for index, (name, clip) in enumerate(entries):
    source = Image.open(root/clip['files'][0]).convert('RGBA')
    tile = source.resize((320,320), Image.Resampling.NEAREST)
    x, y = (index%5)*320, (index//5)*350
    sheet.paste(tile,(x,y+25),tile)
    draw.text((x+6,y+5),name,fill='black')
    for gx in range(0,81,10):
        draw.line((x+gx*4,y+25,x+gx*4,y+345),fill='#b8c5cd',width=1)
    for gy in range(0,81,10):
        draw.line((x,y+25+gy*4,x+320,y+25+gy*4),fill='#b8c5cd',width=1)
sheet.save(out/'first-frames.png')
print(f'{len(entries)} clips; source PNGs unchanged')
