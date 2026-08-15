# Information Gain Routing

## What

When the cause is unknown, choose the action that yields the most NEW information, not the action that looks like the most work. Rank candidates by discrimination per cost; run the cheapest discriminating action first.

## Why

Agents under uncertainty default to visible work: the big refactor, the long investigation, the thorough rewrite. Visible work feels productive and produces nothing discriminating. The router inverts the default: every action is priced by how much it shrinks the hypothesis space.

## When

- Uncertainty Map shows two or more live hypotheses
- Choosing between two viable plans (pairs with Reversible First)
- After a flat loop: the tax requires information gain — the router finds it

## Ranking

For each candidate action ask two questions:

1. **Discrimination** — does the result distinguish between my top hypotheses? (A result both hypotheses predict = zero information.)
2. **Cost** — loops, time, risk.

Rank by discrimination/cost. Run the top. A one-line grep that splits the hypothesis space in half beats a two-hour investigation that confirms what both hypotheses already predict.

## Rules

1. When all live hypotheses agree on a prediction, test the shared prediction only if it is load-bearing (otherwise it is busywork).
2. The cheapest discriminating action that is currently runnable wins over the most thorough action that needs setup.
3. Information gain is progress: a refuted hypothesis pays the loop (see `no-progress-tax.md`).

## Evidence gates

- the ranking written in the ledger when two hypotheses are alive
- the chosen action's result actually changed the Uncertainty Map (hypothesis set shrank)

## Anti-patterns

- "Let me just look at the whole codebase first" (low discrimination per cost — route instead)
- Confusing thoroughness with information (reading everything reads nothing discriminately)
- Running the expensive discriminating action when a cheap one exists and the difference is only precision

## Example

Two live hypotheses: timezone math in the shared util vs boundary constant in the service. Cheapest discriminating action: one isolated probe of the util (seconds, no edits) — result 31 → util confirmed, service hypothesis dead. The expensive alternative (rewriting the service's window logic) would have taken the same result and spent ten times the cost to learn it.
