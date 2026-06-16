---
name: fix-bug
description: Tìm và fix bug trong index.html, validate rồi push
trigger: "khi user báo bug, lỗi, không hiển thị, crash"
---

# Skill: Fix Bug

## Quy trình
1. **Đọc file** — Read index.html tìm vùng liên quan
2. **Reproduce** — Xác định điều kiện gây bug
3. **Fix** — Sửa minimal, không refactor ngoài phạm vi
4. **Validate** — Chạy JS syntax check
5. **Push** — Commit với message mô tả bug fix

## Các bug hay gặp (đã fix, KHÔNG làm lại)
Xem danh sách trong CLAUDE.md section "Bugs đã fix"

## Commit format cho bug fix
```
fix: <mô tả bug ngắn gọn>

- Root cause: ...
- Fix: ...
```

## Validate command
```bash
node -e "const fs=require('fs'); const h=fs.readFileSync('index.html','utf8'); const m=h.match(/<script>([\s\S]*?)<\/script>/g); let ok=true; m&&m.forEach((s,i)=>{const c=s.replace(/<\/?script>/g,''); try{new Function(c);}catch(e){console.error(i,e.message);ok=false;}}); console.log(ok?'OK':'ERROR');"
```
