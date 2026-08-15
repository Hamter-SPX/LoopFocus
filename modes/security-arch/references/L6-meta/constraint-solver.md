# Constraint Solver

## What

When Security, Performance, Cost, UX, and Availability requirements conflict, the solver finds the architecture(s) that satisfy the most constraints — and states which constraints lose and why.

## Why

Security does not live alone: the most secure architecture is usually unshippable, and the shippable one is chosen by whoever argues loudest. The solver makes the tradeoff explicit — candidates are scored against ALL constraints, and the chosen architecture carries the record of what it sacrificed. That record is the difference between a deliberate tradeoff and a silent security downgrade.

## When

L6/L7 — whenever the Synthesizer produces candidates, and whenever a constraint conflict blocks a fix.

## Protocol

1. Collect the constraints per axis (security invariants, perf budgets, cost caps, UX requirements, availability targets) — each as a checkable statement.
2. Enumerate candidate architectures (from the Synthesizer or the team).
3. Score each candidate per axis: satisfies / partially / violates — with the violation named.
4. The winner maximizes satisfied constraints, with security invariants as HARD (a candidate that violates an invariant is eliminated, not scored down — Constitution and invariants are not negotiable axes).
5. Record the tradeoff: the decision log entry names what was sacrificed for the chosen architecture (the sacrifice must be an explicit user-approved entry, not a silent consequence).

## Evidence gates

- all axes represented by checkable statements
- hard constraints (invariants/constitution) never scored down — eliminated
- tradeoffs recorded with the sacrifice named

## Anti-patterns

- Scoring security as "one of the axes" when it is the hard floor (eliminate, don't average)
- Presenting one candidate ("the only option") — a solver with one input is a rubber stamp
- Recording the win without the sacrifice (the sacrifice is the audit trail)

## Example

Conflict: the secure design required a secrets service (cost ↑, availability ↓), the cheap design shared a token (security ↓). Solver: candidates A (secrets service), B (shared token), C (per-service env keys). A satisfied all but cost; C satisfied security + cost with modest ops overhead; B eliminated (violated CONST-002). Winner: C, with the recorded tradeoff "env-key rotation burden accepted over secrets-service cost". Security held; the cost went to ops instead of risk.
