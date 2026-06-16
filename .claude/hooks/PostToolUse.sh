#!/bin/bash
# Tự động validate JS sau khi Edit/Write index.html

# Chỉ chạy khi file index.html bị thay đổi
if [[ "$CLAUDE_TOOL_NAME" == "Edit" || "$CLAUDE_TOOL_NAME" == "Write" ]]; then
  if [[ "$CLAUDE_FILE_PATH" == *"index.html"* ]]; then
    node -e "
const fs = require('fs');
try {
  const html = fs.readFileSync('index.html','utf8');
  const m = html.match(/<script>([\s\S]*?)<\/script>/g);
  let ok = true;
  m && m.forEach((s,i) => {
    const code = s.replace(/<\/?script>/g,'');
    try { new Function(code); } catch(e) {
      console.error('⚠️ JS Error block ' + i + ':', e.message);
      ok = false;
    }
  });
  if(ok) console.log('✅ index.html JS syntax OK');
} catch(e) {
  console.error('❌ Cannot read index.html:', e.message);
}
" 2>&1
  fi
fi
