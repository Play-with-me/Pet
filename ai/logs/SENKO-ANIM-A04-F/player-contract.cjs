const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict');
const html=fs.readFileSync('resources/characters/senko-160/moving-world-v5/index.html','utf8');
const data=html.match(/<script type="application\/json" id="world">([\s\S]*?)<\/script>/)[1];
const script=html.match(/<script>([\s\S]*?)<\/script>/)[1];
const expected=JSON.parse(data);let next;const draws=[];const ctx={clearRect(){},beginPath(){},moveTo(){},lineTo(){},stroke(){},save(){},restore(){},translate(){},scale(){},drawImage(...args){draws.push(args)},fillRect(){},fillText(){}};
const ids={};for(const id of ['world','scenario','stage','play','reset','scrub','status'])ids[id]={value:'0',append(){},getContext(){return ctx}};ids.world.textContent=data;
const sandbox={document:{getElementById:id=>ids[id],createElement:()=>({})},Image:class{set src(v){queueMicrotask(()=>this.onload())}},requestAnimationFrame:fn=>{next=fn}};
vm.createContext(sandbox);vm.runInContext(script,sandbox);const run=s=>vm.runInContext(s,sandbox);
(async()=>{await new Promise(setImmediate);assert.equal(expected.cases.length,13);
for(let i=0;i<13;i++){run(`select.value=${i};reset();playing=true;last=null`);next(0);next(expected.cases[i].rows.at(-1).time_ms+100);assert.equal(run('index'),expected.cases[i].rows.length-1);assert.equal(run('playing'),false);assert.match(ids.status.textContent,/Idle/);}
run('select.value=12;reset()');ids.scrub.value='150';ids.scrub.oninput();assert.equal(run('index'),150);const old=run('clock');next(10000);assert.equal(run('clock'),old);assert.ok(draws.length>13);
console.log('PASS exported world-player JS:13scenarios load/render/finish, negative-world viewport projection, null diagnostic display, reversal selection andscrub/pause. DOM/RAFstubs, not browser visual or hardware proof.');})().catch(e=>{console.error(e);process.exitCode=1});
