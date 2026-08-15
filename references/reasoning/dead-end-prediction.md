# Dead-End Prediction

## What

Before starting a long or expensive path, estimate: does this path have a credible route to the goal, or is it a well-formed dead end? Flag the estimate; refuse well-formed dead ends before the budget is spent.

## Why

Some paths cannot succeed regardless of effort — success requires violating a locked invariant, or the change cannot be verified by any available instrument, or the goal as stated is unreachable. Walking a dead end spends the same loops as a real path, plus the recovery cost. The prediction exists to catch these BEFORE the first step.

## When

- Before S5 alternative implementations (the rung where rewrites live)
- Before any approach whose verification would need a tool the project does not have
- Whenever a constraint collision appears (Constraint Hierarchy) — a path that requires bending a Hard constraint is a dead end

## Dead-end signatures

1. **Unverifiable** — no discriminating test or measurement can ever show success (e.g., "make it faster" with no profiler, no baseline).
2. **Invariant-breaking** — success requires changing something locked as Hard (API contract, data compatibility).
3. **Bootstrap paradox** — the path's first step depends on the path's last output.
4. **Non-discriminating** — the path produces the same result whether the hypothesis is true or false.

## Protocol

1. Write the route to goal in one line: "X succeeds when Y is observable by Z."
2. Check the signatures against that line.
3. Dead end found → stop, record the signature in the ledger, escalate with the specific reason (a dead end with a reason is a finding, not a surrender).
4. Viable but long → proceed, with the pre-mortem attached.

## Evidence gates

- route-to-goal line written before starting
- dead-end verdicts cite the signature (unverifiable / invariant / paradox / non-discriminating)

## Anti-patterns

- Walking the path "a little" to see if it works (dead ends are known before walking — that's the point)
- Confusing "hard" with "dead" — hard paths have routes; dead ones do not
- Declaring a dead end from difficulty instead of structure (laziness wears this mask)

## Example

S4 baseline scenario: "make the submit button faster" with no profiler, no baseline, no measurement anywhere in the repo. Dead-end signature 1 (unverifiable). Correct behavior: zero code changes, escalate with "no baseline exists — any change I make cannot be shown to help". The alternative — tweaking code and announcing done — is fictional progress, and the skill blocks it by name.
