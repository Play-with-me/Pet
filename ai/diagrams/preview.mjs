import { createServer } from 'node:http';
import { readFile, stat } from 'node:fs/promises';
import { dirname, extname, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const blocked = new Set(['.git', 'node_modules', '.venv', 'target']);
const types = { '.html': 'text/html; charset=utf-8', '.png': 'image/png', '.json': 'application/json; charset=utf-8' };
const server = createServer(async (request, response) => {
  try {
    const url = new URL(request.url, 'http://127.0.0.1');
    const route = decodeURIComponent(url.pathname === '/' ? '/ai/diagrams/companion.html' : url.pathname);
    const segments = route.split(/[\\/]+/).filter(Boolean);
    const path = resolve(root, ...segments);
    if (!path.startsWith(root + sep) || segments.some(s => blocked.has(s) || s.startsWith('.env'))) {
      response.writeHead(403).end('Forbidden'); return;
    }
    if (!(await stat(path)).isFile()) { response.writeHead(404).end('Open this directory in your editor.'); return; }
    response.writeHead(200, { 'Content-Type': types[extname(path)] || 'text/plain; charset=utf-8', 'Cache-Control': 'no-store' });
    response.end(await readFile(path));
  } catch { response.writeHead(404).end('Not found'); }
});
server.listen(0, '127.0.0.1', () => console.log(`Preview: http://127.0.0.1:${server.address().port}/ai/diagrams/companion.html`));
