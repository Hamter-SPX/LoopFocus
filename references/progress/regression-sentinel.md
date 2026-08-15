# Regression Sentinel

## What

The per-loop guard that previously passing things stay passing. Progress in one area may not be purchased with collapse in another: 12 passing tests before, 9 after = net negative, whatever the new feature does.

## Why

The classic failure: the new feature's tests pass, the old tests broke, and the session reports success because the run it looked at was the new one. The sentinel makes the comparison explicit and mechanical every loop — the old numbers are the floor, not the furniture.

## When

- Every loop after an edit (the regression gate)
- Before claiming progress (a delta bought by regression is not progress — the signal encodes this: `new_regressions > 0 → rollback`)
- After merges or dependency upgrades (the floor re-measures)

## Protocol

1. Baseline the floor at LOCK: current passing counts into `.loopfocus/metrics` (test_count, plus any other tracked metrics).
2. After each edit: re-run the full tracked surface and compare. Fewer passing = regression.
3. Regression verdict → ROLLBACK to the last passing checkpoint, then re-hypothesize. Never "push through and fix it later" — a regression is the signal that the current approach breaks the floor.
4. The floor updates only when the change intentionally alters it (a removed test, a deleted feature) — and that update is a user-visible decision, not a quiet re-baseline.

## Evidence gates

- before/after counts per loop (the gate needs them)
- rollbacks triggered by regression, not by the new feature failing

## Machine check

```bash
bash scripts/gate-runner.sh   # regression gate: test_count vs .loopfocus/metrics
```

## Anti-patterns

- Re-running only the new tests and calling the suite green
- Quietly re-baselining the floor after a regression ("the old test was outdated") — deletion of expectations is a user decision
- Counting the new feature's pass as compensation for the old break (the sentinel doesn't trade)

## Example

E2E scenario: 12 tests passing at baseline; a loop's edit shipped a fix and broke 3 old tests → signal `new_regressions: 3` → rollback. The session restored the checkpoint, re-hypothesized at the shared dependency, and the final fix passed all 12 + the new one. The sentinel turned a subtle break into an immediate, mechanical stop.
