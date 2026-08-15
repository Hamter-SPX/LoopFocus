# Re-Verify Loop

## What

After an architecture-level security fix, the entire audit re-runs against the CHANGED system: the mappers re-map, the gates re-check, the invariants re-verify. A design change invalidates the design's audit.

## Why

Security fixes move the architecture, and the old findings were written against the old architecture. A parameterized helper changes the data flow; a new auth model changes the privilege graph; a closed endpoint changes the attack surface. Verifying only "the fix works" leaves every other verdict stale — Evidence Freshness applies to security verdicts too.

## When

After every design-level fix (Fix Architecture Planner output), and as a full pass before the Security Exit Gate.

## Protocol

1. Re-run the mappers affected by the change (a query-helper change re-runs the data flow and attack surface; an auth-model change re-runs the privilege graph and trust boundaries).
2. Re-check every gate whose surface the change touched — and the invariants, all of them (the engine re-verifies everything, not just the touched area, because design changes ripple).
3. Compare new verdicts against the Security Decision Log: accepted risks may have changed shape; reopen-if conditions may have triggered.
4. New findings enter the loop normally (score → judge → plan). The loop ends when a full pass produces no new findings AND the invariants hold.

## Evidence gates

- the re-verify pass is a recorded round (ledger entry: what changed, what re-ran, what changed verdict)
- old verdicts explicitly re-validated or invalidated (stale verdicts are named, not inherited)
- exit requires a clean full pass, not a spot check

## Anti-patterns

- Verifying the fix and declaring the audit done (the fix is one node of a graph)
- Re-checking only "related" gates (design changes ripple — full pass)
- Carrying old verdicts forward without re-reading the changed code

## Example

After the parameterized-helper fix: data flow re-trace showed the injection class closed at the source; attack surface re-map confirmed no new entry points; the invariants re-verified green; one new finding appeared (the helper's error path now returns raw SQL in errors — a new output-side leak born from the fix itself). The loop caught the fix's own child finding — exactly what a one-shot verification would have missed.
