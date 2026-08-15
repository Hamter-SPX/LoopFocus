# Constraint Hierarchy

## What

Constraints are not equal. They rank: Hard > Soft > Preference > Assumption. When constraints collide, the higher tier wins — and the loser is recorded, not forgotten.

## Why

Collisions are where agents improvise. "The user wants X but the deadline wants Y" resolves into an unrecorded compromise that satisfies neither and explains nothing. The hierarchy makes the resolution order mechanical and the compromise auditable.

## When

- At LOCK (sort the constraints into tiers)
- Every time two constraints collide during work
- Before any edit that would bend any constraint

## The tiers

| Tier | What it holds | Bend rules |
|---|---|---|
| **Hard** | user requirements, safety, API contracts, invariants | never bend; if impossible → escalate (dead-end signature 2) |
| **Soft** | stated preferences, style, deadlines, conventions | bend only with a recorded reason |
| **Preference** | user taste, unstated likes | ask the user |
| **Assumption** | our own guesses | testable; weakest — yield to any higher tier |

## Protocol

1. Collision → identify both constraints' tiers.
2. Higher tier wins by default. Lower tier bends, and the bending is recorded in the decision ledger (what bent, why, what it cost).
3. Two constraints in the SAME tier → it is not a tier problem, it is an ambiguity problem → ask the user (or test, for Assumptions).
4. Hard vs Hard → escalate. A project where two hard constraints collide has a spec bug, not an implementation challenge.

## Evidence gates

- constraints tiered at LOCK (state.md)
- every bend recorded with reason and cost

## Anti-patterns

- Re-tiering constraints during the collision to make them compatible (the hierarchy exists to stop this)
- Bending a Hard constraint and calling it "pragmatic" (pragmatism is a Soft-tier argument)
- Forgetting the bend after the collision — the record is what keeps the next loop honest

## Example

Migration task: Hard "no forced logout for existing users" vs Soft "ship this sprint". The Soft deadline bent — recorded: "deadline extended by one sprint; existing sessions preserved via dual-token rollout". A session that re-tiered the no-forced-logout as Soft would have produced exactly the bug the user locked against.
