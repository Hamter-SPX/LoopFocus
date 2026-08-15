# Unknown-Unknown Hunter

## What

Hunts the risks nobody's checklist mentions: instead of starting from CWE/OWASP categories, it asks "which assumptions might nobody have thought COULD be wrong?" and generates fresh hypotheses from the system's own shape.

## Why

Checklists find yesterday's bugs. The unknown-unknowns — the novel composition, the unusual trust, the assumption so deep it was never written down — are where real breaches live. The Hunter treats the checklist as the floor, not the ceiling: covered categories first, then the hunt for what the categories cannot see.

## When

L3, after the mappers and the checklist pass are complete. The hunt feeds the Hypothesis Engine.

## The hunt questions (asked against the World Model)

1. What does this system do that NO other system does? (Novelty breeds unmapped risk.)
2. Which assumption has no owner? (Un-owned assumptions are un-checked assumptions.)
3. Which two features, composed, do something neither was designed for?
4. Which component behaves differently under load, failure, or time? (Temporal + failure behavior are the classic blind spots.)
5. What would a smart attacker be DELIGHTED to learn exists? (The delight test.)

## Protocol

1. Walk the hunt questions against the model — each produces candidate hypotheses, not findings.
2. Route candidates to the Hypothesis Engine (observation → hypothesis → evidence search → confirm/reject).
3. Confirmed unknowns become findings with the checklist category they transcend noted ("novel composition — not covered by any category").
4. Rejected candidates are logged too (the Decision Log records what was hunted and cleared — an audit trail of negative results).

## Evidence gates

- hunt questions recorded with their candidate hypotheses
- confirmed unknowns traced to evidence, not intuition
- rejected hunts logged as negative results

## Anti-patterns

- Declaring the hunt done because the checklist is complete
- Promoting a hunt hypothesis to a finding without the evidence round
- Hunting only exotic compositions and skipping the boring novel bits (the delight test is usually boring)

## Example

The delight test: "an attacker would be delighted that /debug dumps process.env — and that the login endpoint returns the admin token to everyone". Neither is a CWE headline; both were the system's real unknown-unknowns. The Hunter found them because it asked the questions, not because a scanner knew the pattern.
