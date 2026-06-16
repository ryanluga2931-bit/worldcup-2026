---
name: update-teams
description: Cập nhật ELO rating và form cho các đội tuyển trong teamStats
trigger: "khi user nói: /update-teams, cập nhật đội, update ELO, update form"
---

# Skill: Update Team Data

## Mục tiêu
Cập nhật object `teamStats` trong index.html với dữ liệu mới nhất.

## Format teamStats
```js
'Germany':   {r:1710, a:8.5, d:8.0, f:'WWWWW'},
// r = ELO rating (worldfootball.net hoặc eloratings.net)
// a = attack  (1-10, dựa trên goals scored trung bình)
// d = defense (1-10, dựa trên goals conceded trung bình)  
// f = form 5 trận gần nhất (W/D/L, mới nhất ở cuối)
```

## Quy trình
1. Dùng agent `researcher` để lấy data mới
2. Tìm dòng `const teamStats` trong index.html (khoảng line 700+)
3. Cập nhật các đội cần thiết
4. Validate + push

## Lưu ý
- Chỉ sửa các đội đang thi đấu tại WC2026
- Form lấy từ 5 trận chính thức gần nhất (không tính giao hữu)
- ELO thay đổi sau mỗi trận — nên cập nhật thường xuyên
