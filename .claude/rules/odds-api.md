# Rules: The Odds API

Áp dụng khi làm việc với `fetchMarketOdds()` hoặc `_marketOdds`.

## Endpoint
```
https://api.the-odds-api.com/v4/sports/{sportKey}/odds/
  ?apiKey={key}&regions=uk,eu,us&markets=h2h,totals,spreads&oddsFormat=decimal
```

## Quan trọng
- API key lưu trong `localStorage` key: `wc2026_odds_api_key` — KHÔNG hardcode vào code
- Dùng `_wcSportKeyCache` để cache sport key, tránh tốn credit
- Refresh mỗi 2 giờ: `setInterval(fetchMarketOdds, 2*60*60*1000)`
- Luôn `encodeURIComponent(key)` khi dùng trong URL

## Team name normalization
Dùng `_normTeam()` + `_TEAM_NORM_MAP` để match tên đội giữa ESPN và Odds API.
NFD decompose để bỏ dấu tiếng Việt/đặc biệt.

## Display format
- 1x2: decimal odds (giữ nguyên)  
- Kèo chấp + Tài/Xỉu: Malay odds = decimal - 1 (signed: âm = đội cho chấp)
- Handicap line: VN quarter format (0.75 → "½-1", 1.25 → "1-1½")
