# Shadow Security Evaluation

## What

A new architecture is evaluated IN PARALLEL with the old one — same findings, same gates, same invariants — and the security postures compared, BEFORE anything is switched. The answer is "is this better or worse than what we have", not "is this good".

## Why

Teams judge new architectures in the abstract and discover the regression in production. Shadow evaluation grounds the judgment: the new design's posture is measured against the CURRENT system's measured posture, so "better" and "worse" are comparisons, not impressions. It also catches the subtle regressions that look like improvements (simpler ops, wider trust).

## When

L6 — any migration, replacement, or major refactor. The twin (Digital Twin Simulator) hosts the new architecture; the production model hosts the old.

## Protocol

1. Baseline the current architecture's posture: findings, entropy score, blast radii, proof coverage.
2. Run the SAME pipeline on the new architecture (twin): same invariants, same counterfactuals, same gates.
3. Diff the postures, axis by axis: what the new design fixes, what it regresses, what it trades.
4. A regression in any security axis blocks the switch until resolved or explicitly accepted (Decision Log with reopen-if).
5. The shadow evaluation report IS the migration's security evidence — switch decisions cite it.

## Evidence gates

- both architectures evaluated with the same instrument set
- per-axis posture diff recorded
- regressions blocked or accepted-with-record

## Anti-patterns

- Approving the new design because it is "modern" (the shadow run measures what modern costs)
- Comparing by finding count alone (axes matter: a design with fewer findings but a worse entropy score is a worse trade)
- Skipping the shadow run because the migration is "infrastructure-only" (infrastructure carries the trust edges)

## Example

The auth migration (static token → signed sessions): shadow run showed the new design fixed 3 findings but widened the trust entropy (sessions now trusted a new signing service — a new single point candidate). The posture diff caught the trade BEFORE the switch, the signing service got its own hardening pass, and the migration shipped with the regression resolved — instead of discovering the new single point in an incident.
