# Auto-Replan

## What

When reality contradicts the plan, do not force the plan and do not abandon the goal. Replan only the affected portion; the locked goal stays locked.

## Why

Plans go stale in two ways: new evidence invalidates assumptions, or new blockers change the graph. The two wrong responses are symmetric: forcing the old plan (walking into known-false assumptions) and dumping the whole plan (losing the goal with the route). Auto-Replan is the third response: surgical update.

## When

- Evidence refutes a plan assumption (assumption walk-back triggers it)
- A new blocker lands (the critical path re-routes)
- The user changes a constraint mid-task (replan around the change)

## Protocol

1. Identify exactly what contradicts the plan: one assumption, one edge, one constraint.
2. Replan the affected portion only: new edges, new order, new tasks for the changed region. The untouched portions keep their plan.
3. Record the replan in the decision ledger: what changed, why, what stayed.
4. Re-check the goal: a replan that cannot be made while keeping the locked goal is a goal-change proposal for the user, not a replan.

## Evidence gates

- replans recorded with the contradicting evidence
- the locked goal survives the replan (or the user approved a goal change)

## Anti-patterns

- Force-fitting the old plan "since we committed to it" (the plan is a tool, not a promise)
- Replanning everything because one edge changed (the untouched parts' evidence still holds)
- Replanning as a way to silently widen scope (scope changes go through the user)

## Example

Feature plan assumed the checkout API returned JSON; mid-build the API proves to return form-encoded. Replan: only the parsing layer's plan updated (new parser, new tests), the rest of the plan untouched. The alternative — re-planning the whole feature — would have discarded verified work for a one-node change.
