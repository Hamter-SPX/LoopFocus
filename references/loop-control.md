# Loop Control

The brakes. These disciplines prevent the failure modes observed in baseline testing: reworded retries, oscillation between two breakages, flat loops that look busy, and solution explosions.

## Loop Strategy Ladder

A failed approach moves you DOWN the ladder. A reworded retry of the same rung is never allowed.

```
S1 Direct Fix
    ↓ fail
S2 Root-cause Trace
    ↓ fail
S3 Reproduce Minimal Case
    ↓ fail
S4 Search/Inspect Dependencies
    ↓ fail
S5 Alternative Implementation
    ↓ fail
S6 Escalate
```

Rules:
- The first two failures in the same strategy family consume the family's quota (Loop Mutation + Loop Genome auto-ban after 2 fails / 0 successes).
- A new rung requires a new hypothesis recorded in the ledger first.
- Escalating is a correct outcome, not a defeat. Escalate with: goal, attempts, failures, evidence paths, and what is needed.

## No-Progress Tax

Every flat loop has a logical cost. The cost compounds:

| Consecutive no-progress loops | Compulsion |
|---|---|
| 1 | state the loop explicitly; check drift |
| 2 | strategy family banned (genome auto-ban); hypothesis reset forced |
| 3+ | reasoning depth +1 level; hidden dependency inspection mandatory; pre-mortem before next attempt |

The tax exists so that failing repeatedly forces different thinking — it is structurally impossible to spam retries.

## Stuck Detector

Distinguish "hard work" from "stuck loop". Stuck when the loop shows the SAME:

- error message/class,
- diff (same files, same shape),
- test failure set,
- reasoning ("maybe if I…" rewordings).

Two identical fingerprints = stuck, not hard. Hard work changes fingerprints every loop. Stuck → MUTATE, hard → CONTINUE (deeper depth).

## Loop Fingerprint

Each attempt gets a fingerprint: `files touched + error class + approach + result`. Compare before executing: a new attempt whose fingerprint is near-identical to a failed one is a retry — blocked by the repeat gate.

## Convergence Engine

Progress is a sequence, not a single number. Track the unresolved-issue count across loops:

- `18 → 11 → 6 → 4 → 3` — converging. Keep the strategy even if status is still FAIL.
- `18 → 16 → 19 → 14 → 21` — unstable. Change strategy NOW, not later.

The normalized signal encodes this: failures dropping + no new regressions = `progress: true` even while `status: fail`.

## Oscillation Detector

```
A PASS / B FAIL → A FAIL / B PASS → A PASS / B FAIL …
```

Fixing A breaks B; fixing B breaks A. This is a shared root cause wearing two masks. When two loops show the swap pattern: stop editing symptoms, draw the dependency edge between A and B (Canvas), and hunt the shared cause. The oscillation gate blocks the third symptom edit.

## Solution Entropy

Signal: files/concepts/dependencies touched per loop keeps growing while the problem persists. Complexity ↑ + progress flat = the solution is exploding.

Response: entropy warning → simplify → return to the last stable checkpoint → re-hypothesize at L5 depth. Entropy is why Minimum Intervention is a gate, not a style preference.

## Progress Delta

Measure each loop's actual improvement, not its activity:

- test failures count before/after,
- compile error count before/after,
- affected-file count before/after,
- information gain (a question answered) counts only when it changes the hypothesis.

Delta ≈ 0 for multiple loops = NO_PROGRESS → the tax applies. Delta is recorded in the ledger and genome, never estimated from memory.

## Anti-patterns

- "The third time is the charm" — no. New rung or stop.
- Changing two variables in one attempt so nothing is attributable
- Declaring convergence from one green test while the matrix still shows WebKit failing
- Keeping a strategy that passes locally but fails CI repeatedly (CI reliability says investigate the difference, not re-run)
- Confusing activity (edits, commands) with progress (measured delta)
