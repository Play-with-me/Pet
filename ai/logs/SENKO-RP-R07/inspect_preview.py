from PIL import Image, ImageDraw
from pathlib import Path
root=Path(r'C:\Users\kyuu4\OneDrive\Documents\Pet\ai\logs\SENKO-RP-R07')
gif=Image.open(root/'native-rest-return.gif')
frames=[]
clock=0
for i in range(gif.n_frames):
    gif.seek(i)
    frames.append((clock,gif.convert('RGB').copy()))
    clock+=gif.info.get('duration',50)
canvas=Image.new('RGB',(1600,700),'#f5f5f5')
draw=ImageDraw.Draw(canvas)
for k in range(10):
    index=round((len(frames)-1)*k/9)
    at,frame=frames[index]
    x=(k%5)*320; y=(k//5)*350
    canvas.paste(frame,(x,y+20))
    draw.text((x+12,y+5),f'{index}: {at} ms',fill='black')
canvas.save(root/'rest-contact-sheet.png')
print(f'frames={len(frames)} duration_ms={clock}')
