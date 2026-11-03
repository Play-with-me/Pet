const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict');
const dir='resources/characters/senko-160/waist-review-v1/';
const html=fs.readFileSync(dir+'index.html','utf8'),data=html.match(/<script type="application\/json" id="data">([\s\S]*?)<\/script>/)[1],script=html.match(/<script>([\s\S]*?)<\/script>/)[1];
const report=JSON.parse(data);assert.equal(report.packs.length,2);
for(const p of report.packs){assert.equal(p.rows.length,36);assert.equal(p.cycle_distance,96);for(const r of p.rows)assert.ok(fs.existsSync(dir+r.image));}
let next;const scales=[],draws=[];const ctx={clearRect(){},fillText(){},beginPath(){},moveTo(){},lineTo(){},stroke(){},save(){},restore(){},translate(){},scale(...v){scales.push(v)},drawImage(...v){draws.push(v)},fillRect(){}};
const ids={};for(const id of ['data','view','play','scrub','mirror','marks','status','reset'])ids[id]={value:'0',checked:false,getContext:()=>ctx};ids.data.textContent=data;ids.marks.checked=true;
const box={document:{getElementById:id=>ids[id]},Image:class{set src(v){assert.ok(fs.existsSync(dir+v));queueMicrotask(()=>this.onload())}},requestAnimationFrame:fn=>{next=fn}};
vm.createContext(box);vm.runInContext(script,box);const run=s=>vm.runInContext(s,box);
(async()=>{await new Promise(setImmediate);assert.equal(run('ready'),true);
for(let i=0;i<36;i++){ids.scrub.value=String(i);ids.scrub.oninput();assert.equal(run('index'),i);}
for(const hz of [30,60,120]){run('clock=0;index=0;last=null;playing=true');for(let t=0;t<=hz*10;t++)next(t*1000/hz);assert.equal(run('clock'),10000);assert.equal(run('index'),18);}
ids.mirror.checked=true;ids.mirror.onchange();assert.ok(scales.some(v=>v[0]===-1));
ids.scrub.value='9';ids.scrub.oninput();const clock=run('clock');next(20000);assert.equal(run('clock'),clock);
ids.reset.onclick();assert.equal(run('index'),0);assert.equal(run('clock'),0);assert.ok(draws.length>72);
console.log('PASS:72 PNG references;36-phase scrub;10s clock at30/60/120Hz;mirror;pause;reset. Node DOM/RAF stubs, not browser/GPU/cadence QA.');})().catch(e=>{console.error(e);process.exitCode=1});
