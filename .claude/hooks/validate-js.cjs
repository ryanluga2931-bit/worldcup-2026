#!/usr/bin/env node
// PostToolUse hook: validate JS syntax của index.html sau Edit/Write.
// Nếu có SyntaxError -> trả {decision:"block"} để Claude BẮT BUỘC fix trước khi commit/push.
// Đọc hook input JSON qua stdin (cơ chế chuẩn của Claude Code).
const fs = require('fs');

let input = '';
try { input = fs.readFileSync(0, 'utf8'); } catch (e) {}
let data = {};
try { data = JSON.parse(input || '{}'); } catch (e) {}

const tool = data.tool_name || '';
const file =
  (data.tool_input && data.tool_input.file_path) ||
  (data.tool_response && data.tool_response.filePath) ||
  '';

// Chỉ quan tâm Edit/Write/MultiEdit tác động index.html
if (!['Edit', 'Write', 'MultiEdit'].includes(tool)) process.exit(0);
if (!/index\.html$/.test(file)) process.exit(0);

let html;
try { html = fs.readFileSync(file, 'utf8'); }
catch (e) { process.exit(0); } // đọc không được thì không chặn

const blocks = html.match(/<script>[\s\S]*?<\/script>/g) || [];
const errors = [];
blocks.forEach((s, i) => {
  const code = s.replace(/<\/?script>/g, '');
  try { new Function(code); }
  catch (e) { errors.push('  • <script> block #' + (i + 1) + ': ' + e.message); }
});

if (errors.length) {
  const reason =
    '🚫 index.html có LỖI CÚ PHÁP JS — KHÔNG được commit/push cho tới khi fix:\n' +
    errors.join('\n');
  process.stdout.write(JSON.stringify({ decision: 'block', reason }));
}
process.exit(0);
