# Rules: ESPN API

Áp dụng khi làm việc với ESPN data hoặc `loadScores()` function.

## Endpoints
```
Scoreboard: https://site.api.espn.com/apis/site/v2/sports/soccer/fifa.world/scoreboard
  ?limit=50&dates=YYYYMMDD&_={timestamp}

Summary:    https://site.api.espn.com/apis/site/v2/sports/soccer/fifa.world/summary
  ?event={eventId}
```

## Luôn dùng
- `cache: 'no-store'` + `&_=Date.now()` để bypass cache
- Retry 3 lần với backoff 1.5s khi HTTP non-ok (429, 503)
- **1 ngày 1 request** cho scoreboard — không dùng date range

## Status codes quan trọng
- Live: `STATUS_FIRST_HALF`, `STATUS_SECOND_HALF`, `STATUS_IN_PROGRESS`, `STATUS_HALFTIME`, `STATUS_EXTRA_TIME`, `STATUS_OVERTIME`, `STATUS_SHOOTOUT`
- Done: `STATUS_FINAL`, `STATUS_FULL_TIME`, `STATUS_FULL_PEN`
- Scheduled: `STATUS_SCHEDULED`

## Không làm
- Không fetch nhiều ngày cùng lúc
- Không bỏ retry logic
- Không cache response ESPN
