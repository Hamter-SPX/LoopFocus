# Progress Delta

## What

A loop's worth, measured as the numeric change it produced — not the activity it performed. Delta is the currency the Progress Gate, Convergence Engine, and No-Progress Tax all spend.

## Why

Every loop-control system in LoopFocus consumes one number. If that number can be fudged ("significant progress", "close now"), the whole discipline collapses into narration. Delta makes the number mechanical.

## When

Every MEASURE. Produced by the Signal Normalizer from before/after counts on a stable metric.

## What counts as delta

| Metric | Before | After |
|---|---|---|
| failing tests | 14 | 3 |
| compile errors | 8 | 0 |
| affected files in the diff | 12 | 4 |
| confirmed hypotheses (information gain) | 1 | 2 |

Information gain is the exception that pays for a flat loop: a refuted hypothesis is a real answer (the space of possible causes shrank). A loop with no delta and no gain is NO_PROGRESS.

## What never counts

- commands run, files read, prose written
- "understanding improved" without a changed hypothesis
- a test that passed and was already passing

## Protocol

1. Before the loop: record the before-counts (State Integrity).
2. After OBSERVE: normalize the signal → delta is computed, not estimated.
3. Record delta in the genome attempt (`--delta <n>`).
4. Flat streak → the tax. Negative delta → regression path (rollback, not continue).

## Evidence gates

- before/after counts recorded per loop (the signal needs them)
- deltas in the genome match the signals in the ledger

## Machine check

```bash
node scripts/normalize-signal.js --previous-failures 17 --current-failures 3 --attempt 12
# {"delta":"+14", "progress":true, ...}
```

## Anti-patterns

- Comparing different metrics across loops (unit failures vs lint warnings)
- Claiming "delta" from one metric while another silently regressed (that's what Regression Sentinel catches)
- Rounding a +0.5 delta up to "progress"
