# Security Invariant Proof Engine

## What

For every invariant ("User A must never read User B's private data"), the engine actively searches for a way the invariant CAN be violated — from the architecture, the code, or the config — and reports the violation path if it exists.

## Why

Stating invariants is comfort; trying to break them is security. The proof engine inverts the invariant check: instead of asking "is the invariant currently satisfied?" (which passes by default), it asks "find me a path that violates it" — and only paths that cannot be found earn the invariant its "held" status.

## When

L4, after the Invariant Engine states the invariants. Re-run after every architectural change (each change can open a new violation path).

## Protocol

1. Take each invariant in its falsifiable form (the Formal Invariant Compiler's output).
2. Enumerate violation strategies: reach the resource without the required identity; gain the identity without the requirement; confuse the policy; race the check; inherit the capability transitively.
3. For each strategy, search the model for a concrete path (who can reach what through which edges).
4. A found path = the invariant is VIOLATED (a finding with the path attached — invariants are the highest-severity findings by definition).
5. No path found = "held against strategies [list]" — recorded with the strategies that were tried, not just "held".

## Evidence gates

- violation strategies enumerated per invariant
- violation paths recorded with their edges
- "held" verdicts list the strategies that were tried

## Anti-patterns

- Declaring an invariant held without trying to break it (untried = unproven)
- Proving the happy path ("the check exists") instead of hunting the bypass
- Treating one held round as permanent (re-run after every change)

## Example

Invariant: "unauthenticated users cannot read user data". Strategy: reach /api/user without auth — path found: the route registered BEFORE the auth middleware → invariant violated with the exact registration-order path. The proof engine produced the finding the happy-path check (which saw "auth middleware exists") would never have found.
