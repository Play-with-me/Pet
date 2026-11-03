const fs=require('fs'),path=require('path'),vm=require('vm'),assert=require('assert/strict');
const {createCanvas,loadImage}=require('C:/Users/kyuu4/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/@napi-rs/canvas');
const root='resources/characters/senko-160/walk-34-contact-review-v2',out='ai/logs/SENKO-ANIM-A04-Y',html=fs.readFileSync(root+'/index.html','utf8'),d=JSON.parse(fs.readFileSync(root+'/preview-data.json'));
function surface(w,h){const c=createCanvas(w,h),n=c.getContext('2d');return {native:c,getContext:()=>new Proxy(n,{get(t,k){if(k==='drawImage')return(im,...a)=>t.drawImage(im.native||im,...a);const v=t[k];return typeof v==='function'?v.bind(t):v;},set(t,k,v){t[k]=v;return true;}})};}
const e={stage:surface(800,360),feet:surface(800,140),data:{textContent:JSON.stringify(d)}};
for(const id of ['play','reset','prev','next','mirror','lock','guide','scrub','status','speed','carry'])e[id]={checked:id==='lock',value:id==='speed'?'120':'0',disabled:id==='play',textContent:''};
let raf;class PreviewImage{set src(file){loadImage(path.resolve(root,file)).then(im=>{this.native=im;this.onload();}).catch(err=>this.onerror(err));}}
const s={document:{getElementById:id=>e[id]},Image:PreviewImage,Map,Set,Promise,Math,Number,Error,requestAnimationFrame:f=>raf=f};vm.createContext(s);vm.runInContext(html.match(/<\/script><script>([\s\S]*?)<\/script>/)[1],s);
const evalIn=code=>vm.runInContext(code,s),frame=()=>evalIn('frameAtDistance(distance)');
(async()=>{const deadline=Date.now()+10000;while(e.play.disabled){if(Date.now()>deadline)throw Error('load timeout');await new Promise(r=>setTimeout(r,10));}
assert.equal(d.cycle_px,144);assert.equal(d.images.length,54);
for(let f=0;f<54;f++){e.scrub.value=String(f*100+1);e.scrub.oninput();assert.equal(frame(),f);if([0,13,27,40,53].includes(f)){fs.writeFileSync(out+`/stage-${f}.png`,e.stage.native.toBuffer('image/png'));fs.writeFileSync(out+`/feet-${f}.png`,e.feet.native.toBuffer('image/png'));}}
e.next.onclick();assert.equal(frame(),0);e.prev.onclick();assert.equal(frame(),53);e.lock.checked=false;e.lock.onchange();const n=e.stage.native.getContext('2d');assert.deepEqual(n.getImageData(40,28,320,320).data,n.getImageData(440,28,320,320).data);e.lock.checked=true;e.mirror.checked=true;e.mirror.onchange();fs.writeFileSync(out+'/mirror.png',e.stage.native.toBuffer('image/png'));e.mirror.checked=false;
const trials=[];for(const hz of [30,60,120])for(const speed of [0,60,120,180]){e.reset.onclick();e.speed.value=String(speed);e.carry.checked=true;e.play.onclick();raf(0);for(let k=1;k<=hz*10;k++)raf(k*1000/hz);assert(Math.abs(evalIn('distance')-speed*10)<1e-7);assert(Math.abs(evalIn('carried')-800)<1e-7);const f=frame();trials.push({hz,speed,distance:evalIn('distance'),carried:evalIn('carried'),frame:f});e.play.onclick();const before=evalIn('distance');raf(20000);assert.equal(evalIn('distance'),before);}
// A long browser suspension is bounded; carriage must never create stride.
e.reset.onclick();e.speed.value='0';e.play.onclick();raf(0);raf(60000);assert.equal(evalIn('distance'),0);assert.equal(frame(),0);assert.equal(evalIn('carried'),8);e.play.onclick();
// Each source copied without raster modification.
const source='resources/characters/senko-160/walk-34-54-v2',m=JSON.parse(fs.readFileSync(source+'/senko.anim.json'));m.clips.walk_34_clock_preview.files.forEach((f,i)=>assert(fs.readFileSync(source+'/'+f).equals(fs.readFileSync(root+'/'+d.images[i]))));
fs.writeFileSync(out+'/audit.json',JSON.stringify({frames:54,cycle_px:d.cycle_px,tests:'scrub, step/wrap, unlocked equality, mirror, pause, carry excludes phase, suspend clamp, PNG byte identity',trials,renderer:'actual preview JS offline napi Canvas; not browser/native GPU'},null,2));console.log('PASS 54 frames, 12 cadence/speed trials, controls, carry isolation, source identity');
})().catch(e=>{console.error(e);process.exitCode=1;});

