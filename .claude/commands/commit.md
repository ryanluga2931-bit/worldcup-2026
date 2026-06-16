# /commit — Tạo commit chuẩn cho WC2026

Khi user dùng `/commit`, thực hiện:

1. Chạy `git diff HEAD` để xem thay đổi
2. Validate JS syntax
3. Tạo commit message theo format:

## Format commit message
```
<type>: <mô tả ngắn tiếng Anh>

- <chi tiết thay đổi 1>
- <chi tiết thay đổi 2>

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

## Types
- `feat` — tính năng mới
- `fix` — sửa bug
- `ui` — thay đổi giao diện
- `data` — cập nhật dữ liệu đội bóng
- `perf` — cải thiện hiệu năng
- `refactor` — tái cấu trúc code

## Lưu ý
- Message tiếng Anh
- Ngắn gọn, mô tả đúng thay đổi
- Luôn push sau commit: `git push origin main`
