// Builds a PDF edition of the Code Examples help (HTML Help is deprecated). Reads the CHM's table of contents
// (exampl.hhc) for the topic order, joins the topics into one HTML book (each topic on its own page, links
// between topics turned into links within the book), and prints it with headless Edge. Headings become PDF
// bookmarks (--generate-pdf-document-outline), and pdfnames.js gives each topic named destinations: its
// topic-<file> id and the window names of the index, which f_open_help opens. Run by build_help.ps1.
// Usage: node build_pdf.js <help source dir> <output pdf> <work dir>
const fs = require('fs'), path = require('path'), { execFileSync } = require('child_process');
const [src, outPdf, work] = process.argv.slice(2).map(p => path.resolve(p));
const EDGE = 'C:\\Program Files (x86)\\Microsoft\\Edge\\Application\\msedge.exe';
const fileUrl = p => 'file:///' + p.replace(/\\/g, '/');

// Topics in contents order: the root page, then its children
const hhc = fs.readFileSync(path.join(src, 'exampl.hhc'), 'latin1');
const topics = [...hhc.matchAll(/<param name="Name" value="([^"]*)">\s*<param name="Local" value="([^"]*)">/g)]
  .map(m => ({ title: m[1].replace(/&amp;/g, '&'), file: m[2] }));
if (topics.length < 100) throw new Error('only ' + topics.length + ' topics in the contents');
const idOf = file => 'topic-' + path.basename(file, '.html');
const known = new Set(topics.map(t => path.basename(t.file)));

const sections = topics.map((t, i) => {
  const html = fs.readFileSync(path.join(src, t.file), 'latin1');
  let body = (html.match(/<body[^>]*>([\s\S]*)<\/body>/i) || [])[1];
  if (!body) throw new Error('no body in ' + t.file);
  body = body
    .replace(/src="\.\.\/image\/([^"]+)"/g, (m, f) => `src="${fileUrl(path.join(src, 'doc', 'image', f))}"`)
    .replace(/href="([^"#:]+\.html)(#[^"]*)?"/g, (m, f) => known.has(path.basename(f)) ? `href="#${idOf(f)}"` : m);
  return `<section id="${idOf(t.file)}" class="topic${i === 0 ? ' first' : ''}">${body}</section>`;
});

const css = fs.readFileSync(path.join(src, 'styles', 'examples.css'), 'latin1');
const today = new Date().toISOString().slice(0, 10);
const toc = topics.map((t, i) => `<li class="${i === 0 ? 'lead' : ''}"><a href="#${idOf(t.file)}">${t.title.replace(/&/g, '&amp;')}</a></li>`).join('\n');
const book = `<!doctype html><html><head><meta charset="windows-1252"><title>PowerBuilder Code Examples Help</title>
<style>${css}</style>
<style>
  @page { size: Letter; margin: 0.8in 0.75in; }
  body { font-family: "Segoe UI", Arial, sans-serif; font-size: 10.5pt; color: #222; background: #fff; }
  .topic { break-before: page; }
  .cover { text-align: center; padding-top: 2.4in; }
  .cover h1 { font-size: 30pt; margin: 0 0 12pt; border: 0; }
  .cover p { font-size: 12pt; color: #555; }
  .toc { break-before: page; }
  .toc ol { columns: 2; column-gap: 0.4in; padding-left: 1.2em; font-size: 9.5pt; }
  .toc li { break-inside: avoid; margin: 0 0 2pt; }
  .toc li.lead { font-weight: 600; }
  .toc a { color: #1a5fb4; text-decoration: none; }
  h1 img { vertical-align: middle; margin-right: 8px; }
  table { border-collapse: collapse; }
  th, td { border: 1px solid #bbb; padding: 2pt 6pt; }
  pre, code { font-family: Consolas, "Courier New", monospace; }
</style></head><body>
<div class="cover"><h1>PowerBuilder Code Examples</h1><p>Help for the Code Examples application</p><p>${topics.length} topics &middot; generated ${today} from the HTML Help (exampl.chm) sources</p></div>
<div class="toc"><h1>Contents</h1><ol>${toc}</ol></div>
${sections.join('\n')}
</body></html>`;

fs.mkdirSync(work, { recursive: true });
const htmlFile = path.join(work, 'help_book.html');
fs.writeFileSync(htmlFile, book, 'latin1');
const edgePdf = path.join(work, 'help_book.pdf');
if (fs.existsSync(edgePdf)) fs.unlinkSync(edgePdf);
execFileSync(EDGE, ['--headless=new', '--disable-gpu', '--no-pdf-header-footer', '--generate-pdf-document-outline',
  `--user-data-dir=${path.join(work, 'edge-profile')}`, `--print-to-pdf=${edgePdf}`, fileUrl(htmlFile)], { stdio: 'ignore', timeout: 120000 });
for (let t = 0, last = -1; ; t++) {
  const size = fs.existsSync(edgePdf) ? fs.statSync(edgePdf).size : -1;
  if (size > 0 && size === last) break;
  if (t > 60) throw new Error('no PDF from Edge');
  last = size; execFileSync('cmd', ['/c', 'ping -n 2 127.0.0.1 >nul']);
}

// Named destinations: Edge writes one for each topic (topic-<file>, the targets of the contents' links), and
// each keyword of the index (exampl.hhk: the window names that f_open_help passes, in lower case) becomes
// another name for its topic, so that the application opens exampl.pdf#nameddest=<window>
const hhk = fs.readFileSync(path.join(src, 'exampl.hhk'), 'latin1');
const aliases = {};
for (const m of hhk.matchAll(/<param name="Name" value="([^"]*)">\s*<param name="Local" value="([^"]*)">/g)) {
  const name = m[1].toLowerCase().replace(/[^a-z0-9_.-]/g, '');
  if (name && !(name in aliases) && known.has(path.basename(m[2]))) aliases[name] = idOf(m[2]);
}
const aliasFile = path.join(work, 'aliases.json');
fs.writeFileSync(aliasFile, JSON.stringify(aliases, null, 2));
if (fs.existsSync(outPdf)) fs.unlinkSync(outPdf);
execFileSync(process.execPath, [path.join(__dirname, 'pdfnames.js'), edgePdf, outPdf, '-', aliasFile], { stdio: 'inherit' });
console.log(`${outPdf}: ${topics.length} topics, ${Object.keys(aliases).length} window names, ${fs.statSync(outPdf).size} bytes`);
