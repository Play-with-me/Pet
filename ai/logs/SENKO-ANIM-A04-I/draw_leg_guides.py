"""Draw schematic gait blueprints only, never character artwork."""
from PIL import Image, ImageDraw
from pathlib import Path
import math,json
out=Path('resources/characters/senko-160-source/gait')
all_rows=[]
for group in range(3):
    im=Image.new('RGB',(2304,1152),'white');d=ImageDraw.Draw(im)
    rows=[]
    for cell in range(18):
        phase=group*18+cell;half=phase//27;t=(phase%27)/27
        near_support=half==0
        support=(18-36*t,152.)
        swing=(-18+36*t,152-3.5*math.sin(math.pi*t))
        feet=[support,swing] if near_support else [swing,support]
        ox=(cell%6)*384;oy=(cell//6)*384
        def p(x,y):return ox+192+x*8,oy+80+(y-130)*8
        d.rectangle((ox,oy,ox+383,oy+383),outline='#bbb')
        d.text((ox+12,oy+12),f'FRAME {phase:02} / NEAR=BLUE FAR=RED',fill='black')
        d.line((ox+12,oy+256,ox+372,oy+256),fill='#999',width=2)
        d.rectangle((*p(-7,126),*p(7,131)),outline='#333',width=3)
        for leg,(x,y) in enumerate(feet):
            color='#2365b6' if leg==0 else '#c44337'
            # Diagram knees only; not a body simulation or generated animation.
            knee=(x*.45+2,140.)
            d.line((p(0,130),p(*knee),p(x,y-1)),fill=color,width=6)
            d.line((p(x-2,y),p(x+4,y)),fill=color,width=7)
        row=dict(frame=phase,near_support=near_support,feet_native_relative_x=feet)
        rows.append(row);all_rows.append(row)
    im.save(out/f'walk-leg-blueprint-{group}.png')
(out/'walk-leg-blueprint.json').write_text(json.dumps(all_rows,indent=2),encoding='utf-8')
