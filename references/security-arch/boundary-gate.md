# Boundary Gate

## What

Checks every crossing between trust zones: at each boundary edge, is the right validation/serialization/authorization actually present — in code, verified, not assumed?

## Why

Boundaries are where untrusted influence becomes trusted action. A single unvalidated crossing invalidates the entire trusted zone behind it. The gate audits crossings one by one, because one missed edge is one attacker path.

## When

After the Trust Boundary Mapper, for every crossing edge it produced — and re-checked after any change that touches an edge.

## Protocol

1. For each crossing: name the data direction and what must happen at the edge (validate? deserialize? authenticate? authorize? rate-limit?).
2. Verify in code: does the control exist at THIS edge (not "somewhere in the framework")? A control on a sibling route is not a control on this one.
3. Classify: control present + verified → pass; present but unverified → UNKNOWN (test it); absent → finding (severity by what crosses).
4. Record per-edge verdicts in the ledger — the boundary table is part of the audit deliverable.

## Evidence gates

- per-edge verdicts recorded for every mapped crossing
- "present" means verified in code, with a file:line
- absent controls become findings, not notes

## Anti-patterns

- Assuming the framework "handles it" without locating the handler
- Checking only the user-facing boundaries (service-to-service edges are crossings too)
- One verified edge standing in for its siblings

## Example

Cart API crossing: semi-trusted (authenticated user) → trusted (DB). Required at the edge: ownership scoping. Code check: none — the query returned rows by name with no owner filter. Absent control at a boundary crossing = F11. The gate converted "the API seems fine" into a per-edge contract.
