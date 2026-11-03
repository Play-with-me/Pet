// Offline vector-path authoring only. Approved raster body is never transformed.
const fs=require('node:fs'),path=require('node:path'),assert=require('node:assert/strict');
const root=process.cwd(), sharp=require('C:/Users/kyuu4/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/sharp');
const base=path.join(root,'resources/characters/senko-160'), src=path.join(root,'resources/characters/senko-160-source/gait/walk-grounded-v6');
const out=path.join(base,'side-sequence-grounded-v8'), source=path.join(root,'resources/characters/senko-160-source/gait/transitions-v2');
assert(!fs.existsSync(out)&&!fs.existsSync(source));fs.cpSync(path.join(base,'side-sequence-grounded-v6'),out,{recursive:true});fs.mkdirSync(source);
const body=fs.readFileSync(path.join(src,'svg/0.svg'),'utf8');
const lower=body.match(/<g clip-path="url\(#lower\)">([\s\S]*?)<\/g>/)[1];
const polygons=[...lower.matchAll(/<polygon points="([^"]+)" fill="([^"]+)"\/>/g)];assert.equal(polygons.length,14);
const reference=[[78,152],[114,152]], idle=[[76,152],[111,152]];
const palette=[...new Set((fs.readFileSync(path.join(root,'BongoCat/crates/bongocat-overlay/src/bin/senko_asset_pipeline/normalize.rs'),'utf8').match(/pub const PALETTE:[\s\S]*?= \[([\s\S]*?)\];/)[1].match(/\[\d+, \d+, \d+\]/g)))].map(s=>JSON.parse(s));
async function draw(name,feet){
 let paths=polygons.map((p,i)=>{let leg=i<7?0:1,dx=feet[leg][0]-reference[leg][0],dy=feet[leg][1]-152;return `<polygon points="${p[1].split(' ').map(v=>{let [x,y]=v.split(',').map(Number);return `${Math.round(x+dx)},${Math.round(y+dy)}`}).join(' ')}" fill="${p[2]}"/>`}).join('');
 let svg=body.replace(lower,paths);fs.writeFileSync(path.join(source,name+'.svg'),svg);
 let {data,info}=await sharp(Buffer.from(svg)).ensureAlpha().raw().toBuffer({resolveWithObject:true});
 for(let i=0;i<data.length;i+=4){if(!data[i+3]){data.fill(0,i,i+4);continue;}let best=palette.reduce((a,b)=>{const d=c=>(c[0]-data[i])**2+(c[1]-data[i+1])**2+(c[2]-data[i+2])**2;return d(b)<d(a)?b:a;});for(let k=0;k<3;k++)data[i+k]=best[k];data[i+3]=255;}
 const file=`transition_new/${name}.png`;fs.mkdirSync(path.join(out,'transition_new'),{recursive:true});await sharp(data,{raw:{width:info.width,height:info.height,channels:4}}).png().toFile(path.join(out,file));return file;
}
(async()=>{
const m=JSON.parse(fs.readFileSync(path.join(out,'senko.anim.json'))), idleFile=await draw('idle',idle);m.clips.idle_side.files=[idleFile];
const endpoints={walk_start:[idle,reference],walk_stop:[reference,idle],walk_stop_sync27:[[[114,152],[78,152]],idle]};
for(const [name,[from,to]] of Object.entries(endpoints)){
 const files=[],contacts=[];
 for(let i=0;i<18;i++){let t=i/17;let feet=from.map((p,j)=>{let u=Math.max(0,Math.min(1,t*2-j)),s=u*u*(3-2*u);return [p[0]+(to[j][0]-p[0])*s,152-3*Math.sin(Math.PI*u)];});
 let f=i===0?(name==='walk_start'?idleFile:`walk_side/${name.endsWith('27')?27:0}.png`):i===17?(name==='walk_start'?'walk_side/0.png':idleFile):await draw(name+'-'+i,feet);
 files.push(f);contacts.push({foot_right:feet[0].map(Math.round),foot_left:feet[1].map(Math.round)});
 }
 let delays=Array.from({length:18},(_,i)=>Math.floor((i+1)*1000/45)-Math.floor(i*1000/45));
 m.clips[name]={...m.clips[name],files,frames:18,frame_ms:delays,ms:22,contacts};
}
fs.writeFileSync(path.join(out,'senko.anim.json'),JSON.stringify(m,null,2));fs.writeFileSync(path.join(source,'README.md'),'A04-K: vector ankle/tabi paths redrawn at each pose. Raster upper146 rows and hem unchanged. Sequential foot recovery with low lift; no runtime movement changes. Partial pack; visual acceptance pending.');
console.log(JSON.stringify({output:out,transition_frames:18,transition_ms:400,clips:Object.keys(endpoints)}));
})().catch(e=>{console.error(e);process.exitCode=1});

