# Convergence Engine

## What

The judge of whether loops are actually approaching the goal. It watches the unresolved-issue count as a sequence, not as a single value — the *direction* of the sequence decides strategy, not the current color of the test run.

## Why

The naive loop is "run test → red → change something → rerun". A converging fix can be red for many loops (17 failures → 3) while a wandering fix can look green-ish (1 new test passes, 2 old ones broke). The engine kills both errors: it forbids mutating a converging strategy and forbids continuing a diverging one.

## When

Every MEASURE. The normalized signal already carries the fields; the engine is the interpretation layer.

## Interpretation

| Sequence of unresolved issues | Verdict | Action |
|---|---|---|
| 18 → 11 → 6 → 4 → 3 | converging | CONTINUE — keep the strategy even while status is FAIL |
| 18 → 16 → 19 → 14 → 21 | unstable | MUTATE immediately — do not wait for red |
| 5 → 5 → 5 → 5 | flat | No-Progress Tax applies (see `no-progress-tax.md`) |
| 8 → 3 → 9 | regressed | ROLLBACK to the checkpoint before the regression |

## Rules

1. Convergence is measured on the SAME metric across loops (same test suite, same environment). Mixing metrics (unit tests one loop, lint the next) measures nothing.
2. Failures dropping + no new regressions + fresh evidence = `progress: true` even while `status: fail`. The engine never mutates a converging strategy.
3. Three loops of instability = strategy change is mandatory, not optional.
4. A single green run is not convergence. The sequence must show direction before the verdict.

## Evidence gates

- same-metric sequences recorded in the genome (each attempt has its delta)
- convergence verdicts cited in reports with the sequence, not the last number

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# attempts list shows the delta sequence: +0, +0, +1, … — read the direction
```

## Anti-patterns

- Declaring convergence from one green test while the matrix still shows a failing browser
- Comparing test counts between different suites ("integration vs unit — about the same")
- Keeping a strategy whose local loop converges while CI diverges (CI Reliability investigates the gap, not the code)
