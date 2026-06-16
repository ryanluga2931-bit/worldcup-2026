---
name: production-harden
description: Production hardening — API resilience, caching, retry, fallback UI, error boundaries, state consistency
trigger: "/production-harden, hardening, chuẩn bị production, ổn định hơn"
---

Prepare this football live score app for production-scale usage.

Improve:
- API resilience (ESPN + Odds API)
- caching strategies
- retry handling with exponential backoff
- fallback UI when API fails
- defensive coding (null checks, type guards)
- error boundaries
- loading states
- rendering stability during rapid updates
- state consistency across refreshes
- realtime synchronization

Goal:
The app should remain stable during massive World Cup traffic spikes — millions of concurrent users watching Brazil vs Argentina final.

Specific scenarios to harden:
1. ESPN API returns 429 (rate limit) mid-match
2. Network drops during live update
3. Tab goes to background for 10 minutes
4. User switches tabs rapidly
5. ESPN returns malformed/empty JSON
6. Odds API key expires mid-session
7. Mobile phone locks screen during live match
