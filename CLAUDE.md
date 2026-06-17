# World Cup 2026 — CLAUDE.md

## Dự án là gì
Single-file app (`index.html`) host trên GitHub Pages tại `ryanluga2931-bit.github.io/worldcup-2026/`  
Repo: `https://github.com/ryanluga2931-bit/worldcup-2026.git`  
Mục đích: Theo dõi kết quả World Cup 2026 live, kèo, dự đoán AI — **tâm huyết, muốn thật đặc sắc**.

---

## Data source
- **ESPN API**: `https://site.api.espn.com/apis/site/v2/sports/soccer/fifa.world`
- Scoreboard: `/scoreboard?limit=50&dates=YYYYMMDD` — **1 ngày 1 request**, không dùng date range
- Fetch luôn dùng `cache:'no-store'` + `&_=Date.now()` để bypass cache (fix stale score)
- Retry 3 lần khi HTTP non-ok (429, 503...) với backoff 1.5s

**Live statuses:** `STATUS_FIRST_HALF`, `STATUS_SECOND_HALF`, `STATUS_IN_PROGRESS`, `STATUS_HALFTIME`, `STATUS_EXTRA_TIME`, `STATUS_OVERTIME`, `STATUS_SHOOTOUT`  
**Done statuses:** `STATUS_FINAL`, `STATUS_FULL_TIME`, `STATUS_FULL_PEN`

---

## Refresh logic
- Có live match + vừa có bàn thắng → refresh **5s**
- Có live match bình thường → **10s**
- Không có live → **60s**
- `_isLoading` guard chống concurrent fetch
- `visibilitychange` pause/resume khi tab ẩn

---

## AI Prediction Engine
- **xG**: `hXG = max(0.3, (h.a*0.5 + (10-a.d)*0.5)/10 * 3.2)`, away dùng `*2.7`
- **Dự đoán tỷ số**: `Math.floor(xG)` — Poisson mode (không dùng `Math.round`)
- **Handicap**: dựa trên `pHome - pAway` (predicted score diff) + xG margin
- **Odds O/U**: dùng Poisson CDF theo ouLine thực tế (không fixed formula)
- **H2H**: xorshift PRNG seeded từ `nameHash(homeN + '##' + awayN)` — varied per year
- **over25**: proper Poisson `1 - e^-λ*(1 + λ + λ²/2)` (không phải exponential gần đúng)
- **next10**: `1 - e^(-λ*10/90)` Poisson rate
- **1x2 odds**: có house edge 5.5% — `100/(pct*0.945)` (như bookmaker thật)
- **isUpset**: `hW < 58 && hW > 44 && (h.r - a.r) > 60` — fires khi moderately favored vs significantly weaker

---

## UI/UX Rules
- **Không dùng `backdrop-filter:blur`** trên match cards — quá chậm trên iPhone 20+ cards
- **`will-change`** chỉ trên animated elements, không phải toàn bộ card
- **No-flicker refresh**: save/restore AI panel open state trước/sau `innerHTML` replace
- Live clock dùng `liveClockData` + `setInterval 1s` tick giữa các API call
- Stoppage time hiển thị `90'+x` thay vì `91:30`
- Skeleton chỉ hiện lần đầu (`_firstLoad`), không flicker mỗi refresh

---

## Card features (hiện tại)
Mỗi match card có:
1. **Team area**: predicted winner highlight xanh + 👑 crown icon
2. **AI Pick chip** (trên card face, không cần mở panel): đội thắng · kèo · tài/xỉu · độ tin
3. **Quick verdict**: 1 câu nhận định hiển thị ngay dưới chip
4. **Odds table** (kqbd.mobi style): Kèo chấp / Tài xỉu / 1x2
5. **Live stats**: circular donuts (tấn công/nguy hiểm/kiểm soát), shots bar, action zone pitch, stat rows
6. **AI panel** (toggle): tỷ số dự đoán, win%, xG, ⚡ bàn trước HT, key players, H2H 5 trận, form circles, nhận định

---

## Bugs đã fix (không làm lại)
- `absDiff` undefined trong `calcAsianOdds` → crash toàn app → đổi thành `absXGDiff`
- `Array(NaN)` từ `parseInt(null)` khi yellow/red card stats null
- `fetchWithRetry` không retry HTTP non-ok
- Error handler wipe scores cũ (giờ chỉ show toast ở `last-update`)
- Handicap hiện `-0` → fix decoupled từ win%
- Tab schedule/groups dùng `includes('spinner')` → đổi sang `dataset.loaded`
- Ticker hiện `0-0` cho trận chưa đấu
- H2H 5 năm giống nhau → fix xorshift PRNG
- Results tab AI panel close on refresh → fix save/restore openPanels
- Schedule tab countdown timer wiped every 10s → fix clearAllCountdowns chỉ trong renderSchedule
- `isUpset` condition contradictory → never fired → fix thresholds
- Goal time in banner hiện seconds thay vì minutes → fix `/60`
- Ticker blank gap khi no-live → fix repeat innerHTML
- Schedule tab hiện completed matches → filter chỉ STATUS_SCHEDULED
- Tab title không update khi goal → thêm `⚽ GOAAAAL!` flash
- AI comment không aware live score → pass homeScore/awayScore to aiComment
- Momentum bar không animate → dùng data-m + setTimeout pattern

---

## Design inspiration
- **bet365**: circular donut stats, shots bar, pitch action zones
- **kqbd.mobi/du-doan-bong-da**: AI pick chip format, kèo chấp display, quick verdict style

---

## User preferences
- Trang phải **liên tục cải thiện** — tìm bug và fix, nâng độ đặc sắc
- Sau mỗi fix phải **push GitHub ngay**
- Validate JS syntax với `node -e "new Function(...)"` trước khi commit
- User **không dùng terminal** — mọi thứ qua Claude
- Commit message tiếng Anh, ngắn gọn, mô tả đúng thay đổi
- **Sau mỗi lần nâng cấp: recheck toàn bộ — tìm dead variables, CSS conflicts, undefined refs, cascade issues — fix đến khi sạch hoàn toàn trước khi push**

## Agent rules — bắt buộc

### Khi dùng multi-agent để audit/fix
1. **Luôn có 1 agent verify live data** — fetch ESPN API thực tế, so sánh team names với DB, không chỉ đọc code
2. **Luôn có 1 agent check UI consistency** — các giá trị hiển thị cùng nhau phải nhất quán: pick + kèo + tỷ số + odds phải kể cùng 1 câu chuyện. Nếu predicted 1-1 thì không được recommend Kèo -1.5
3. **Không chấp nhận agent chỉ đọc code rồi báo "OK"** — phải trace data flow từ input (ESPN name, ELO) → compute (predict, calcAsianOdds) → output (rendered HTML chip) và verify từng bước

### Consistency rules cho prediction display
- `pickLabel` (🏆 / 🤝) phải match `pHome vs pAway`, không dùng win%
- `keoLabel` trong AI chip phải derive từ `pHome - pAway`, không dùng `hcDisplay` độc lập
- `hcLabel` trong odds table (kèo thị trường) dùng ELO-based là đúng — đây là market line, không phải AI pick
- Nếu `pHome == pAway` → chip hiện `🤝 Hòa` + `Kèo 0`, dù ELO gap lớn đến đâu
- ESPN team name → `getTS()` lookup phải luôn trả về đúng team, không fallback 1620. Verify bằng cách fetch ESPN API thực tế và check từng tên
