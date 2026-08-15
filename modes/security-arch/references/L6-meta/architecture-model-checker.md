# Architecture Model Checker

## What

Builds a state model of the system's security-relevant behavior and exhaustively checks whether any state or path violates a formal invariant.

## Why

Manual review samples paths; a model checker enumerates them. For stateful security logic (order states, auth flows, verification ladders), the dangerous bug is the unvisited combination — the state sequence nobody tried. The checker finds violations by exhaustion, not by inspection, which is the only way to catch "invalid transition" bugs before attackers find them.

## When

L6, on compiled invariants (Formal Invariant Compiler output), for any component with stateful behavior (auth, billing, onboarding, firmware updates).

## Protocol

1. From the code/config, extract the states and transitions (draw them — State Machine Security supplies the map).
2. Encode the formal invariants as properties ("no path reaches ACTIVE without passing VERIFIED", "no transition from SUSPENDED to ACTIVE without admin action").
3. Walk the transition graph exhaustively (by hand for small graphs, scripted for larger ones): does any path reach a state that violates a property?
4. A violating path is a finding with the exact state sequence (the sequence is the evidence — it doubles as the regression test).
5. Re-run after any state-machine change (the checker is cheap; the bug class is expensive).

## Evidence gates

- transition graph extracted from code, not documentation
- properties checked exhaustively, not sampled
- violating paths recorded as sequence evidence

## Anti-patterns

- Checking the "interesting" states only (exhaustion is the point)
- Extracting transitions from the docs instead of the code (docs describe the happy path)
- Trusting a clean check forever (re-run on every state-machine change)

## Example

The onboarding flow: REGISTERED → VERIFIED → ACTIVE, with SUSPENDED reachable from ACTIVE. Exhaustive walk found: VERIFIED → SUSPENDED existed in the admin API, and SUSPENDED → ACTIVE required only the user's own token (the admin action was a UI convention, not a check). Path found: user self-suspends via one endpoint, self-reactivates via another, skipping nothing but bypassing a suspension. The checker's sequence (VERIFIED→SUSPENDED→ACTIVE with user token only) became the finding AND the regression test.
