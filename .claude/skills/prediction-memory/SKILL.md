---
name: prediction-memory
description: Prediction memory system — store predictions, track accuracy, learn from mistakes, dynamic weight adjustment
trigger: "/prediction-memory, AI học từ sai lầm, feedback loop, tracking accuracy"
---

Build a continuous-learning football prediction memory system using localStorage.

Architecture:
- `wc2026_predictions` — stores all predictions + actual results + analysis
- `wc2026_accuracy` — rolling accuracy stats (7-day, 30-day)

Workflow:
1. Before match → `savePrediction(mid, homeN, awayN, p)` — store prediction
2. After match ends → `updatePredictionResult(mid, actualH, actualA)` — compare
3. Generate post-match analysis → why prediction failed/succeeded
4. Update accuracy stats
5. Adjust future confidence based on recent performance

Track:
- prediction accuracy %
- exact score accuracy
- correct winner %
- draw prediction weakness
- upset detection rate
- confidence calibration (predicted 80% confidence but only 50% hit rate?)

Dynamic weights:
- Recent wrong streak → reduce confidence
- Recent correct streak → boost confidence slightly
- If draws consistently wrong → increase draw probability

The AI should become MORE HONEST over time, not fake accuracy.
