# /ship — Validate + commit + push nhanh

Khi user dùng `/ship`, thực hiện tuần tự:

1. **Validate JS**
```bash
node -e "const fs=require('fs');const h=fs.readFileSync('index.html','utf8');const m=h.match(/<script>([\s\S]*?)<\/script>/g);let ok=true;m&&m.forEach((s,i)=>{const c=s.replace(/<\/?script>/g,'');try{new Function(c);}catch(e){console.error(i,e.message);ok=false;}});console.log(ok?'✅ JS OK':'❌ ERROR');"
```

2. **Nếu OK** — commit và push:
```bash
git add index.html
git commit -m "chore: ship latest changes"
git push origin main
```

3. **Báo URL**: https://ryanluga2931-bit.github.io/worldcup-2026/

Nếu JS lỗi → dừng lại, báo lỗi cho user, KHÔNG push.
