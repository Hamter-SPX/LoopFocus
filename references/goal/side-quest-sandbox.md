# Side-Quest Sandbox

## What

Permission to leave the main goal temporarily — to hunt a root cause outside its surface — under an explicit contract: declared purpose, loop/time budget, mandatory return.

## Why

Root causes do not respect scope: the login hang lives in the session layer, the refund bug lives in a shared util. Without the sandbox, agents either abandon the hunt (shallow fixes) or leave scope permanently (drift). The sandbox legalizes the temporary exit and outlaws the permanent one.

## When

- The evidence points outside the goal's surface
- A blocked-by edge needs investigation (Dependency Awareness pairs here)
- An experiment needs isolation (worktree / container)

## The contract (written in the ledger)

```text
side-quest: <the question being answered>
budget: <N loops or M minutes>
returns-to: <main goal>
status: open | done | terminated
```

## Rules

1. Declared BEFORE the exit. Undeclared exits are drift (see `anti-drift-engine.md`).
2. Budget is hard: every loop inside consumes it; over budget without progress → terminate and return (Focus Budget).
3. The quest answers its question — it does not fix what it finds. Findings return to the main goal for the Fix Policy to handle.
4. Return is mandatory and recorded. A side quest that becomes the new goal silently is the drift the sandbox exists to prevent.

## Evidence gates

- contract written at entry
- budget accounting visible (loops spent per quest)
- return recorded

## Anti-patterns

- Declaring every tangent a side quest (wish lists are not investigations)
- A quest that keeps finding "one more thing" (budget died; the findings go to the report)
- Returning without recording what the quest learned (the learnings are the quest's product)

## Example

Login hang: the hang traced into the session store's unbounded map. Side quest: "does the leak cause the hang or co-occur?" budget 3 loops, returns-to: login hang. Answer: co-occurs. The leak finding returned to the main goal → Fix Policy → user approved the fix → done as Required-by-approval. The sandbox kept both truths: the hang got fixed, and the leak was handled with permission instead of by drift.
