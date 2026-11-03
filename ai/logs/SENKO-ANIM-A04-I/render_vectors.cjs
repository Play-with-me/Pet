// Offline SVG authoring renderer, not app code. No raster warping/interpolation.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const [source,output,sharpPackage]=process.argv.slice(2),sharp=require(sharpPackage);
assert.ok(!fs.existsSync(output),'output must be new');fs.mkdirSync(output);fs.mkdirSync(path.join(output,'walk_side'));
const body='data:image/png;base64,'+fs.readFileSync(path.join(source,'body.png')).toString('base64');
(async()=>{const tiles=[];for(let i=0;i<54;i++){const svgPath=path.join(source,`svg/${i}.svg`);const svg=fs.readFileSync(svgPath,'utf8').replace('__BODY_DATA_URI__',body);fs.writeFileSync(svgPath,svg);const png=path.join(output,`walk_side/${i}.png`);await sharp(Buffer.from(svg)).png().toFile(png);tiles.push({input:png,left:i%6*160,top:Math.floor(i/6)*160});}
await sharp({create:{width:960,height:1440,channels:4,background:{r:0,g:0,b:0,alpha:0}}}).composite(tiles).png().toFile(path.join(output,'contact.png'));
for(const file of ['senko.anim.json','vector-report.json'])fs.copyFileSync(path.join(source,file),path.join(output,file));console.log('Rendered54 new vector leg poses with canonical raster upper body; sourceSVGs embedded, no raster deformation.');})().catch(e=>{console.error(e);process.exitCode=1});
