const fs=require('node:fs'),vm=require('node:vm'),assert=require('node:assert/strict');
const html=fs.readFileSync('ai/logs/SENKO-ANIM-A03-B/player-clock45/index.html','utf8');
const data=html.match(/<script type="application\/json" id="manifest">([\s\S]*?)<\/script>/)[1];
const script=[...html.matchAll(/<script>([\s\S]*?)<\/script>/g)][0][1];
let next;const dots=[];const context={clearRect(){},save(){},restore(){},translate(){},scale(){},drawImage(){},fillRect(...p){dots.push(p)},fillText(){}};
const elements={};for(const id of ['manifest','clip','play','scrub','status','stage','mirror','points','reset','speed'])elements[id]={value:id==='speed'?'140':'0',checked:id==='points',append(){},getContext(){return context}};
elements.manifest.textContent=data;
const sandbox={document:{getElementById:id=>elements[id],createElement:()=>({})},Image:class{set src(s){queueMicrotask(()=>this.onload())}},requestAnimationFrame:fn=>{next=fn},console};
vm.createContext(sandbox);vm.runInContext(script,sandbox);
const run=s=>vm.runInContext(s,sandbox);
(async()=>{await new Promise(setImmediate);
 for(const hz of [30,60,120]){run("select.value=0;configure();playing=true;last=null");for(let tick=0;tick<=hz*10;tick++)next(tick*1000/hz);assert.equal(run('clock'),10000);assert.equal(run('index'),0);}
 run('playing=false');const frozen=run('clock');next(12000);next(13000);assert.equal(run('clock'),frozen);
 run("select.value=data.clips.findIndex(c=>c.name==='distance45');configure();playing=true;last=null");next(0);next(1000);assert.equal(run('index'),35);assert.equal(run('distance'),140);
 elements.scrub.value='12';elements.scrub.oninput();assert.equal(run('distance'),48);assert.equal(run('playing'),false);
 run("select.value=data.clips.findIndex(c=>c.name==='once45');configure();playing=true;last=null");next(0);next(1000);assert.equal(run('index'),44);assert.equal(run('playing'),false);
 dots.length=0;elements.mirror.checked=true;run('draw()');assert.equal(dots.at(-1)[0],157);
 console.log('PASS actual exported player JS:10s@30/60/120Hz, pause, distance/per-frame stride, scrub, one-shot completion and mirrored contacts. DOM/RAF stubs; not browser visual or hardware cadence proof.');
})().catch(e=>{console.error(e);process.exitCode=1});
