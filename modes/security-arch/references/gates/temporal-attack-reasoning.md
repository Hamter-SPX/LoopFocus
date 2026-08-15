# Temporal Attack Reasoning

## What

Analyzes vulnerabilities that exist only in SEQUENCES of events — races, time-of-check-time-of-use, state inconsistencies across a delay — the bug class no single line of code contains.

## Why

The nastiest bugs are invisible to line-by-line review: the check passes at T1, the state changes at T2, the action executes at T3 against a truth that no longer holds. Race conditions, TOCTOU, async ordering — each lives in the GAP between two correct lines. Temporal reasoning is the only lens that sees them.

## When

Gates phase — wherever checks and actions are separated in time: async handlers, file operations, session validation, transaction boundaries, anything with `check-then-act`.

## The attack patterns (walk each against the code)

| Pattern | Shape | Where to look |
|---|---|---|
| TOCTOU | check at T1, use at T2, attacker changes between | file ops, symlink checks, config reads |
| race | two flows mutate shared state without ordering | async handlers, counters, caches |
| stale-authz | authorization evaluated, then the object changes before use | session-validated actions with delayed execution |
| replay-in-window | an action valid at T1 is repeated after it should have expired | idempotency keys, tokens, callbacks |
| ordering-inversion | A must precede B, but the async runtime does not guarantee it | event-driven flows, sagas |

## Protocol

1. Enumerate the check-then-act sites (grep for validation followed by state use, async boundaries, shared mutable state).
2. Per site, ask the temporal question: what can change between the check and the act?
3. If a window exists and an attacker can act inside it → finding with the sequence (check → window → act) as evidence.
4. Fixes are ordering guarantees (locks, transactions, single-flight, re-check-at-use) — each verified with a race-regression test where feasible.
5. Feed the pattern list to the learning loop (temporal bugs repeat across projects with identical shapes).

## Evidence gates

- check-then-act sites enumerated
- windows identified with the attacker's opportunity named
- fixes re-check at use (not just at entry)

## Anti-patterns

- Reviewing lines instead of sequences (the two lines are each correct)
- Dismissing races as "unlikely" without computing the window (windows are often microseconds — and scripted)
- Fixing one race site while the pattern class survives (the class is the finding's real subject)

## Example

The session-refresh flow: token validated at request entry (T1), the handler awaited an external call (window), then used the session's role (T2). An attacker who got revoked during the await still executed with old rights. The fix (re-validate role at use) closed the window; the regression test held the await open while revoking, and the old code failed it every time.
