---
name: deploy
description: Validate JS syntax rồi commit + push index.html lên GitHub Pages
trigger: "khi user nói: /deploy, push đi, đẩy lên, publish"
---

# Skill: Deploy to GitHub Pages

## Bước 1 — Validate JS
```bash
node -e "
const fs = require('fs');
const html = fs.readFileSync('index.html','utf8');
const m = html.match(/<script>([\s\S]*?)<\/script>/g);
let ok = true;
m && m.forEach((s,i)=>{ const code = s.replace(/<\/?script>/g,''); try { new Function(code); } catch(e){ console.error('Block',i,':',e.message); ok=false; } });
console.log(ok ? 'JS OK' : 'ERRORS FOUND');
"
```

## Bước 2 — Commit
```bash
git add index.html
git commit -m "feat: <mô tả thay đổi>"
```

## Bước 3 — Push
```bash
git push origin main
```

## Sau khi push
- GitHub Pages tự deploy trong ~30 giây
- URL: https://ryanluga2931-bit.github.io/worldcup-2026/
