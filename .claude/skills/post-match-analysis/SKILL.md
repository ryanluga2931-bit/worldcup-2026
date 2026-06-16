---
name: post-match-analysis
description: Generate professional AI post-match analysis after each finished match — prediction vs actual, why failed/succeeded
trigger: "/post-match, phân tích sau trận, tại sao AI sai"
---

After each finished match, generate a professional AI post-match analysis.

Analyze:
- prediction vs actual result
- why the prediction succeeded or failed
- key turning points (unexpected goals, red cards)
- xG overperformance/underperformance
- tactical differences from model assumptions
- momentum shifts not captured by ELO/form

Then:
- calculate prediction accuracy level (exact_score / close_winner / correct_winner / wrong)
- assign reason code for failure
- log into prediction memory (localStorage wc2026_predictions)
- suggest weight adjustment for future predictions

Style: professional football analytics — Opta / Sofascore AI insights tone
