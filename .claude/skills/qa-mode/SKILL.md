---
name: qa-mode
description: Senior QA mode — test stability, long sessions, Safari, API outages, edge cases
trigger: "/qa-mode, QA, kiểm tra kỹ, test toàn bộ"
---

Act as a senior QA engineer preparing this sports app for the FIFA World Cup.

Test scenarios:
- realtime update stability (90 min live match)
- long-running sessions (3+ hours, multiple matches)
- slow mobile devices (iPhone 8, old Android)
- Safari compatibility (iOS 15, 16, 17, 18)
- API outages (ESPN down for 2 min)
- malformed data (null scores, missing teams)
- rapid live score changes (goal every minute)
- orientation changes (portrait ↔ landscape)
- tab switching (background/foreground)
- offline/online recovery
- midnight rollover (23:55 → 00:05)
- PWA-style save to homescreen

Find every instability, glitch, and hidden edge case.
Then fix them professionally with specific code changes.
Rate each issue: BLOCKER / CRITICAL / MAJOR / MINOR
