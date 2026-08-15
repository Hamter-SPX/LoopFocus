# Security Debt Graph

## What

Security debt is stored as a GRAPH, not a TODO list: each debt node links to the risks it roots and the fixes it blocks. The graph shows which debt is structural (many risks depend on it) versus cosmetic.

## Why

A TODO list treats "rotate the hardcoded token" and "remove the unused CSP bypass" as equals. The graph exposes the real structure: one debt node (the shared query helper) may be the root of fourteen findings, while another is a leaf nobody will ever hit. Debt graphs make remediation order obvious and make "we'll fix it later" honest about what "later" costs.

## When

L2 (after findings exist), maintained through the Decision Log (deferred findings become debt nodes).

## Protocol

1. Every accepted/deferred risk becomes a node with: what it is, what it roots (findings that exist BECAUSE of it), what it blocks (fixes that cannot land until it is resolved).
2. Draw the edges: debt → rooted findings, debt → blocked fixes.
3. Rank nodes by out-degree (how much depends on them) × severity of dependents.
4. The top node is the "debt you must kill first" — reported as the structural fix target for the Fix Architecture Planner.
5. Rebuild the graph every re-map; debt that grew new dependents has gotten worse even if the code did not change.

## Evidence gates

- every deferred/accepted risk is a node
- rooted-findings and blocked-fixes edges recorded
- ranking recomputed per re-map

## Anti-patterns

- Debt as a flat list ("10 security TODOs") with no structure
- Deferring a root node as if it were a leaf (the graph's whole point is to prevent this)
- Never revisiting accepted debt (Decision Log reopen-if conditions consume the graph)

## Example

Debt node: "auth model issues a static admin token". Rooted: F3 (hardcoded), F7 (== bypass), F9 (every user gets admin). Blocked: the multi-judge recommended fix (real sessions). Ranking put it at #1 — killing one debt node resolved three findings and unblocked the session-migration fix. A TODO list would have scheduled them in three different sprints.
