import { execFileSync } from 'node:child_process';
import { readFileSync, writeFileSync } from 'node:fs';
import { createRequire } from 'node:module';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = dirname(fileURLToPath(import.meta.url));
const require = createRequire(import.meta.url);
const cli = join(dirname(require.resolve('markmap-cli/package.json')), 'bin', 'cli.js');
const maps = [
  ['companion', 'NGƯỜI BẠN DESKTOP', 'Kế hoạch đã thống nhất · Windows · Rust'],
  ['architecture', 'BONGOCAT / BẢN ĐỒ AI', '23 module · mã nguồn · tài liệu · phối hợp'],
];
for (const [name, title, subtitle] of maps) {
  const output = join(root, `${name}.html`);
  execFileSync(process.execPath, [cli, '--offline', '--no-open', '--output', output, join(root, `${name}.md`)], {
    cwd: root, stdio: 'inherit',
  });
  let html = readFileSync(output, 'utf8');
  // Keep the renderer output and inline assets untouched; add a small local shell.
  html = html.replace('</head>', `<title>${title}</title><style>
  :root{color-scheme:light} body{margin:0;background:#f8fafc;color:#172b4d;font-family:'Segoe UI',Arial,sans-serif}
  #mindmap{position:absolute!important;top:112px!important;left:0!important;width:100%!important;height:calc(100vh - 148px)!important}
  .map-header{position:absolute;inset:0 0 auto;padding:22px 32px;display:flex;align-items:center;justify-content:space-between;gap:18px;border-bottom:1px solid #e2e8f0;background:white}
  .eyebrow{font-size:11px;letter-spacing:2px;color:#64748b;font-weight:700}.map-header h1{margin:5px 0;font-size:23px;letter-spacing:-.5px}.subtitle{font-size:12px;color:#64748b}
  .map-nav{display:flex;gap:9px;flex-wrap:wrap}.map-nav a,.map-nav button{font:12px 'Segoe UI',Arial,sans-serif;text-decoration:none;padding:9px 13px;color:#334155;border:1px solid #dbe3ed;border-radius:8px;background:white;cursor:pointer}.map-nav a.active{color:white;background:#2563eb;border-color:#2563eb}
  .map-footer{position:absolute;bottom:0;left:0;right:0;padding:10px 32px;border-top:1px solid #e2e8f0;background:white;color:#64748b;font-size:12px}
  .markmap{font:15px 'Segoe UI',Arial,sans-serif}.markmap a{color:#1d4ed8}.markmap-toolbar{bottom:54px!important}
  @media(max-width:700px){.map-header{padding:12px 16px;align-items:flex-start}.map-header h1{font-size:17px}.map-nav{max-width:170px}.map-nav a{padding:6px}.subtitle{max-width:210px}}
  </style></head>`);
  html = html.replace(/<body([^>]*)>/, `<body$1><header class="map-header"><div><div class="eyebrow">DESKBUDDY LAB / PROJECT ATLAS</div><h1>${title}</h1><div class="subtitle">${subtitle}</div></div><nav class="map-nav"><a class="${name === 'companion' ? 'active' : ''}" href="companion.html">Ý tưởng &amp; kế hoạch</a><a class="${name === 'architecture' ? 'active' : ''}" href="architecture.html">Kiến trúc &amp; mã</a><button onclick="window.mm?.fit()">Vừa màn hình</button><a href="${name}.md">Nguồn Markdown</a></nav></header><footer class="map-footer">Bấm vòng tròn để mở/thu nhánh · Kéo để di chuyển · Cuộn để phóng to · Markmap MIT · Offline</footer>`);
  html = html.replace('</body>', `<script>window.addEventListener('load',async()=>{await document.fonts.ready;requestAnimationFrame(()=>window.mm?.fit());});</script></body>`);
  writeFileSync(output, html);
  console.log(`Built ${name}.html (offline)`);
}
