# No-Progress Tax

## What

Every loop that produces no measurable progress pays a compounding logical cost. The cost is not punishment — it is forced change: the more an agent fails without moving, the more different its next attempt must be.

## Why

Cheap models spam retries; expensive models sink cost. Both behaviors come from the same loophole: nothing charges for a flat loop. The tax closes the loophole by making repetition structurally expensive — after two flat loops, the cheap retry is no longer available, and after three, the lazy assumption ("the code near the failure must be wrong") is forcibly re-examined.

## When

Triggered by the Progress Gate: loop ends with delta ≈ 0 AND no information gain (a question answered that changes the hypothesis). Information gain counts as progress — a refuted hypothesis is a paid loop.

## The tax table

| Consecutive no-progress loops | Compulsion |
|---|---|
| 1 | State the loop explicitly; run the drift check (does this action still serve the locked goal?) |
| 2 | Strategy family banned (genome auto-ban). Hypothesis reset forced — write a NEW hypothesis, discard the old framing. |
| 3+ | Reasoning depth +1 level (L1→L3→L5). Hidden dependency inspection mandatory — read every module in the failing path. Pre-mortem required before the next attempt. |
| 5 | Escalate. Five taxed loops means the problem is mis-scoped or mis-hypothesized at a level the agent cannot see. |

## Protocol

1. After MEASURE: normalize the signal. `progress: false` increments the tax counter in `.loopfocus/metrics` (`no_progress_streak=N`).
2. Apply the current streak's compulsion BEFORE planning the next loop.
3. A loop with delta or information gain resets the counter to 0.
4. Record each taxed loop in the ledger: what stayed flat, why the next attempt differs.

## Evidence gates

- streak counter visible in metrics
- each taxed loop's compulsion actually applied (visible in the next attempt's difference)

## Machine check

```bash
grep -E '^no_progress_streak=' .loopfocus/metrics
```

## Anti-patterns

- Taxing a converging loop (failures dropping = progress, streak resets)
- Paying the tax in prose ("I will think differently") while the next attempt is a reworded retry
- Escalating at streak 2 because escalation feels safer than the forced pre-mortem

## Example

Streak 2, refund bug: family "boundary-math" banned → hypothesis reset forced. The reset produced "the caller does not do timezone math — inspect the shared util", which found the root cause. Without the tax, that hypothesis appears on attempt 5 or never.
