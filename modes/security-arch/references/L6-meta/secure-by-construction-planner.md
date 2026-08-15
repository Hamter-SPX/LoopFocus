# Secure-by-Construction Planner

## What

Security constraints are defined BEFORE implementation begins — what "cannot be built from the start" — so the code that ships cannot contain the forbidden patterns, instead of auditing them out afterward.

## Why

Finding a bug after the build costs 10x fixing it at design time, and security patterns are the most design-time-friendly of all: "no string-built SQL", "no credential in code", "no unauthenticated route" are enforceable at construction with tools and templates. The planner moves security from the audit phase to the blueprint phase — where it is cheapest and strongest.

## When

L6/L7 — before any new implementation. The Security Semantic Compiler turns the constraints into the build-time enforcement.

## Protocol

1. From the Constitution + invariants + audit history, derive the construction constraints ("what this codebase may not contain").
2. Make each constraint enforceable at build time: a lint rule, a CI check, a template/helper that makes the unsafe pattern unavailable, a review checklist item.
3. The constraints ship WITH the scaffold: new code inherits the safe patterns by default (the parameterized helper is the only DB API; the auth middleware is the only route entry).
4. Record the constraint set — it is part of the architecture's contract, and semantic-diffs check changes against it.
5. Post-build audits then verify CONFORMANCE to the constraints rather than hunting the patterns anew.

## Evidence gates

- constraint set written before implementation
- each constraint has a build-time enforcement mechanism
- new code conformance checked against the set

## Anti-patterns

- "We'll catch it in review" as the enforcement mechanism (review is detection, construction is prevention)
- Constraints that only exist in prose (unenforced constraints are wishes)
- Writing the constraints after the build and calling it secure-by-construction (that's an audit with a fancier name)

## Example

The parameterized-helper became a construction constraint: "all DB access via db.query(); direct string SQL is a build error". The constraint shipped as a lint rule + the helper as the only imported API. The next feature (reset-password) was built under the constraint and arrived injection-free BY CONSTRUCTION — the class that had produced F1, F2, and three more candidates could no longer be written.
