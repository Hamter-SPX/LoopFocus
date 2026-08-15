# Anti-Drift Engine

## What

The live monitor that catches the session drifting away from the locked goal and pulls it back. Drift signature: the current work serves a goal that was never locked and is not a declared side quest.

## Why

Drift is not malice — it is unexamined momentum. Fixing login slides into "while I'm here, the UI is inconsistent" and four hours later the session is a redesign with a broken login. Baseline testing (RED 2026-08-15, S1) showed it happens even to careful agents under time pressure. The engine exists because momentum beats memory.

## When

Continuous, with a hard check at every MEASURE and before every non-trivial action (pairs with the mutation gate).

## Detection

| Signal | Verdict |
|---|---|
| current edit's goal-link cites the locked goal | aligned |
| cites a declared side quest, within its budget | aligned |
| cites a goal never locked, not declared | **drift** |
| "while I'm here" / "quick fix" / "improvement" as the link | **drift candidate — check now** |

## Protocol

1. Drift detected → stop the edit. Do not finish "just this one change" (that's how drift continues).
2. State the drift in the ledger: what was being done, what goal it serves, why that goal is not the locked one.
3. Two paths: (a) declare it as a side quest with a budget and a return, or (b) park it as a SkillFocus report item and return to the goal.
4. Return to the locked goal and record the return.

## Evidence gates

- drift events in the ledger with the chosen path (side quest / parked / returned)
- the next loop's work demonstrably serves the locked goal again

## Anti-patterns

- Treating drift as harmless because the work was "useful anyway" (usefulness is not alignment)
- Declaring every tangent a side quest (the side quest machinery exists for root-cause hunts, not for wish lists)
- Detecting drift and finishing the current edit first — the edit IS the drift

## Example

S1 GREEN: after the login fix, "10 minutes left, keep working" — the agent's session-leak fix passed the drift check because the user had just authorized continued work; the button-color fix went through the Fix Policy ask. S1 RED (no skill): the same extras were done silently — exactly the drift the engine exists to catch.
