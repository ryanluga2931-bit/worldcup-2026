#!/bin/bash
# Cấp 6 — Hook CHẶN: tự validate JS syntax của index.html sau mỗi Edit/Write.
# Nếu JS lỗi -> block (Claude không được commit/push cho tới khi fix).
# Đọc hook input JSON từ stdin và chuyển thẳng cho validator node.
node "$(dirname "$0")/validate-js.cjs"
