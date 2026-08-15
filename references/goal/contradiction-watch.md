# Contradiction Watch

## What

A live check that the current action does not contradict an earlier requirement or locked constraint. The moment an edit is about to violate "never change the API contract", the watch blocks it — before the diff exists.

## Why

Long tasks accumulate requirements faster than context retains them. Round 8 genuinely does not remember the round-2 constraint, and the edit goes through "in good faith". The watch replaces memory with a mechanical comparison: current action vs the locked record, every time.

## When

- Before every EXECUTE on tasks longer than a few loops
- After replanning (replans are where old constraints silently drop)
- When a new constraint arrives mid-task (check it against existing work immediately — both directions)

## Protocol

1. Keep the constraint record current: hard constraints from LOCK, user messages re-stated as constraints, decisions that imply constraints.
2. Before each edit: scan the record for any entry the edit would violate.
3. Contradiction found → block. Resolve by hierarchy (Constraint Hierarchy): bend a Soft with a recorded reason, ask on Preference, escalate on Hard-vs-Hard.
4. Record the near-miss: a contradiction caught is a process win, and it updates the record for the next check.

## Evidence gates

- near-misses recorded in the ledger (contradiction watch entries)
- edits that follow constraints show it (the diff respects the record)

## Anti-patterns

- Relying on memory for constraints ("I'd never change that")
- Checking only at the end (the violation is a diff by then, with sunk cost attached)
- Resolving a caught contradiction by re-interpreting the constraint ("they probably meant…") — interpretation is the user's, not the agent's

## Example

Round 2 locks: "hard: do not change the API contract". Round 8, mid-refactor, the plan reaches for the contract to simplify internals. The watch fires: "action: modify API contract — contradicts LOCK constraint #1". Blocked. The simplification reworked to keep the contract, with the constraint's owner never needing to say it twice.
