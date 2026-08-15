# Proof Coverage Score

## What

A number that says how much of the architecture is PROVEN versus assumed: per component and per invariant, what percentage of the security model rests on verified evidence rather than assumption.

## Why

"Secure" without a coverage number is marketing; with it, it is engineering. The score exposes the soft parts: an architecture that is 90% proven at the edges but 100% assumed at the core has a score that says so. Teams then know exactly where the next verification effort belongs — the score is the map of the unproven.

## When

L6 — computed at the end of each audit pass, tracked across audits (the score should rise over time as assumptions get verified).

## Protocol

1. Inventory the security-relevant claims: invariants, trust edges, gate verdicts, defense statements.
2. Classify each: proven (evidence + reproduction), partially proven (some evidence), assumed (registry entry only).
3. Score = proven / total, weighted by criticality (Crown Jewel claims weigh more — an assumed claim on the core hurts the score more than one at the edge).
4. Report the score with the breakdown: which claims are assumed, and what verifying each would take.
5. The exit gate includes a minimum score context: low score is not a failure, but it must be STATED — an exit report that hides its proof coverage hides the risk.

## Evidence gates

- claim inventory with classifications
- weighted score with per-class breakdown
- assumed claims listed with verification costs

## Anti-patterns

- Scoring by file coverage or line counts (the score is about claims, not lines)
- Reporting "high confidence" as a substitute for the score (confidence is per-finding; coverage is per-system)
- Letting the score rise by deleting claims (shrinking the inventory is not verifying it)

## Example

Post-audit score: 68% weighted — 61 of 90 claims proven, with the assumed 29 concentrated in: backup encryption (assumed, never inspected), webhook authenticity (assumed), admin-token scope (assumed). The breakdown turned the audit's three quietest risks into the next sprint's verification list — and the score's honesty was worth more than any "high confidence" paragraph.
