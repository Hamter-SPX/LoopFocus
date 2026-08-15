# Evidence Provenance Graph

## What

Every finding's evidence is traced to its ORIGIN — which file, config, runtime observation, or test produced it — and the graph tracks whether that evidence is still valid today.

## Why

Evidence ages and chains: a finding built on a config snapshot is only as good as that snapshot's currency; a finding built on a test is only as good as the test's existence. The provenance graph makes the evidence's ancestry visible and its staleness computable — when the source changes, every dependent finding is flagged for re-verification automatically.

## When

L6 — maintained alongside the Evidence Ledger. Every evidence item gets provenance at creation; the graph updates on every change that touches a source.

## Protocol

1. Every evidence item records its source type + anchor: file:line, config path, runtime observation (when/where), test name+result.
2. Draw the edges: evidence → the findings it supports; source → the evidence derived from it.
3. On any change to a source (file edit, config update, test removal): the graph marks its dependent evidence STALE.
4. Stale evidence cannot support a current verdict — re-verify or retire the finding (the re-verify loop consumes the stale list).
5. The graph ships in the audit record — it is the audit's own audit trail.

## Evidence gates

- provenance recorded per evidence item
- source changes propagate staleness to dependents
- stale evidence blocked from verdicts until re-verified

## Anti-patterns

- Evidence cited without its source (an anchor-less quote is a rumor)
- Re-verifying findings manually when the graph already knows what went stale (the graph IS the stale list)
- Letting evidence stay marked valid across the change that invalidated it

## Example

Finding F11's evidence came from `server.js:14` (the query without owner filter). When the parameterized-helper refactor rewrote that line, the provenance graph marked F11's evidence STALE instantly — and the re-verify pass re-ran the ownership check against the new code instead of trusting the old citation. The graph turned a would-be-stale verdict into a scheduled re-check.
