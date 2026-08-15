# Pre-Mortem Loop

## What

Before a big or expensive round, ask: "If this approach fails, where will it fail?" — then add one prevention per predicted failure point BEFORE starting.

## Why

Retrospectives are cheap because nothing changes afterward. Pre-mortems invert the timing: the failure is imagined while it is still preventable. A prediction that would have been "obvious in hindsight" is exactly the thing to write down now.

## When

Mandatory before:
- L5 structural changes
- S5 alternative implementations (expensive rework)
- any attempt with a No-Progress Tax streak ≥ 3
- worktree-branch experiments that cost real time (Branch-and-Recover)

## Protocol

1. Name the approach and its success definition (one line).
2. Write the top 3 predicted failure points, each specific: "the migration will break X because Y" — not "something might go wrong".
3. For each: add one prevention — a test, a boundary check, a smaller first slice, a rollback point, a watch metric.
4. Record pre-mortem in the ledger before the first edit of the round.
5. If a predicted failure occurs anyway, the prevention is the difference between a caught failure and a discovered disaster.

## Evidence gates

- pre-mortem entry in the ledger before the round
- each predicted failure has a named prevention

## Anti-patterns

- Writing the pre-mortem after the failure ("I knew this could happen")
- Generic predictions (they carry no prevention and prove nothing)
- A pre-mortem that predicts failures but adds no preventions (that's a mood, not a loop)

## Example

M4 feature pre-mortem: "This new /reset-password route will fail at (1) SQL concat pattern copied from existing routes, (2) no rate limit, (3) token replay." Preventions: (1) parameterized query + regression test with a quote payload, (2) rate-limit test, (3) crypto-random token with expiry + replay test. The feature shipped with the three most likely bugs already pinned by tests — Predictive Analysis supplied the failure points, the pre-mortem turned them into guards.
