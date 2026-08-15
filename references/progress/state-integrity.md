# State Integrity

## What

Continuous awareness of the workspace state between loops — not just at the end. The numbers move every loop, and the agent navigates by them: tests 98/100 and 3 modified files before; 91/100 and 14 after → regression alarm → do not continue blindly.

## Why

The final verification cannot be the first time the numbers are seen — by then the damage is baked. State Integrity is the dashboard: a regression that takes three loops to notice costs three loops of compounding; the same regression noticed at the loop it happened costs one rollback.

## When

- Every loop boundary (MEASURE feeds the dashboard)
- Before and after every edit that touches shared surfaces
- At any point the agent would otherwise estimate the workspace state from memory

## The dashboard (state.md + git-state.js)

```text
tests: 91/100 (was 98)
modified files: 14 (was 3)
known issues: X (unchanged)
```

`node scripts/git-state.js` supplies the machine half: changed files, commits, diff stat. The ledger supplies the history: the previous loop's numbers, so the delta is visible.

## Protocol

1. Record before-numbers at the loop start (the signal needs them anyway).
2. After OBSERVE: record after-numbers. The comparison IS the navigation: delta > 0 → continue; flat → tax; negative → regression path.
3. Modified-file count climbing while progress is flat is the Solution Entropy signal — State Integrity feeds it.
4. Never navigate from memory: "I think the suite was green" is not a state, it is a guess (and guesses go through the Uncertainty Map, not into decisions).

## Evidence gates

- before/after numbers recorded per loop
- regression alarms trigger the rollback path, not "continue and see"

## Machine check

```bash
node scripts/git-state.js
```

## Anti-patterns

- Checking state only at completion time
- Trusting the editor's "no unsaved changes" as the whole state (the dashboard includes tests, issues, metrics)
- Ignoring a growing modified-file count because "the fix is almost done"
