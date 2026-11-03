const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict');
const dir='resources/characters/senko-160/walking-review-v7/',html=fs.readFileSync(dir+'index.html','utf8'),data=html.match(/<script type="application\/json" id="data">([\s\S]*?)<\/script>/)[1],script=html.match(/<script>([\s\S]*?)<\/script>/)[1],report=JSON.parse(data);
assert.deepEqual(report.packs.map(p=>p.rows.length),[54,54]);assert.deepEqual(report.packs.map(p=>p.cycle_ms),[1200,1200]);
let next;const scales=[];const ctx={clearRect(){},fillText(){},beginPath(){},moveTo(){},lineTo(){},stroke(){},save(){},restore(){},translate(){},scale(...v){scales.push(v)},drawImage(){},fillRect(){}};
const ids={};for(const id of ['data','view','play','scrub','mirror','marks','status','reset'])ids[id]={value:'0',checked:false,getContext:()=>ctx};ids.data.textContent=data;ids.marks.checked=true;
const box={document:{getElementById:id=>ids[id]},Image:class{set src(v){assert.ok(fs.existsSync(dir+v));queueMicrotask(()=>this.onload())}},requestAnimationFrame:fn=>{next=fn}};
vm.createContext(box);vm.runInContext(script,box);const run=s=>vm.runInContext(s,box);
(async()=>{next(1000);next(5000);assert.equal(run('clock'),0);await new Promise(setImmediate);assert.equal(run('ready'),true);
for(let k=0;k<2;k++){let t=0;for(let i=0;i<report.packs[k].rows.length;i++){assert.equal(run(`frameAt(data.packs[${k}],${t})`),i);assert.equal(run(`frameAt(data.packs[${k}],${t+report.packs[k].frame_ms[i]-0.01})`),i);t+=report.packs[k].frame_ms[i];}}
for(const hz of [30,60,120]){run('clock=0;index=0;last=null;playing=true');for(let t=0;t<=hz*10;t++)next(t*1000/hz);assert.equal(run('clock'),10000);assert.equal(run('frameAt(data.packs[0],clock)'),18);assert.equal(run('frameAt(data.packs[1],clock)'),18);}
ids.scrub.value='1199';ids.scrub.oninput();assert.equal(run('index'),53);const clock=run('clock');next(20000);assert.equal(run('clock'),clock);ids.mirror.checked=true;ids.mirror.onchange();assert.ok(scales.some(v=>v[0]===-1));ids.reset.onclick();assert.equal(run('clock'),0);assert.match(ids.status.textContent,/45 tư thế\/s/);
console.log('PASS108PNG refs; all54/54pose manifest boundaries;10s30/60/120Hz;pause/scrub/mirror/reset. DOM/RAF stubs, not hardware cadence.');})().catch(e=>{console.error(e);process.exitCode=1});
