# Focus Budget

## What

Every investigation, side quest, or branch carries a hard budget of loops or effort. Over budget without progress → terminate the branch and return to the main goal.

## Why

Investigations have no natural ending — every answer raises two questions. The budget supplies the ending: when the spend runs out, the branch closes regardless of curiosity. Without it, the side quest outlives the goal it was born to serve (the most common drift shape).

## When

- At every side-quest declaration (the contract includes the budget)
- Worktree-branch experiments (Branch-and-Recover branches each carry one)
- Any investigation the agent itself judges "might take a while" — the judgment becomes a number

## Protocol

1. Set the budget at declaration: loops or minutes, sized to the question (a cause-hunt gets more than a format check).
2. Count every loop against it. Budget accounting lives in the ledger (visible, not remembered).
3. Over budget with progress → ONE extension is allowed, with a recorded reason, at most once per quest.
4. Over budget without progress → terminate: record what was learned (even "nothing" is a result), return to the main goal, report the open question as UNKNOWN.

## Evidence gates

- budgets declared and accounted in the ledger
- terminations recorded with their learnings

## Anti-patterns

- "One more loop" extensions without a progress-based reason
- Budgets so generous they never bind (a budget that cannot run out is decoration)
- Terminating and discarding the learnings (the learnings are the branch's value)

## Example

Session-leak side quest: budget 3 loops. Loop 1: confirmed the map is unbounded. Loop 2: traced why no expiry exists. Loop 3: proposed TTL+sweep. Progress each loop → quest closed at budget with a complete answer. A sibling quest ("why was the sweep removed in 2023") burned 3 flat loops → terminated, question recorded as UNKNOWN, returned to the main goal on time.
