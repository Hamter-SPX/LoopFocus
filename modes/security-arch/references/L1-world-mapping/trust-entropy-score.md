# Trust Entropy Score

## What

A numeric measure of how chaotically the system trusts: every implicit trust assumption adds entropy; every explicit, verified trust edge reduces it. High entropy = the system trusts things for no recorded reason.

## Why

Trust is the attack surface of architecture. A system with many implicit trusts is one surprise away from compromise — the entropy score makes "we trust too much, too vaguely" into a measurable, comparable number instead of a vibe.

## When

L1 after mapping (baseline), then every re-map. The score trends over time — a rising score after a change is a semantic-diff alarm.

## Scoring (per trust edge)

| Edge type | Entropy contribution |
|---|---|
| explicit + code-verified reason | -1 |
| explicit + assumption-registry entry | 0 |
| implicit ("internal, obviously") | +2 |
| implicit + cross-zone (untrusted→trusted) | +5 |

Score = sum over all edges; normalized per component count so systems of different sizes compare.

## Protocol

1. From the World Model's trust edges, score each by the table.
2. Report: total score, per-component breakdown, and the top entropy contributors (the edges to fix first).
3. Track in `.loopfocus/metrics` — entropy is a trend, not a snapshot.
4. Minimum-Trust Architecture Generator consumes this: its proposals must lower the score.

## Evidence gates

- every trust edge scored with its reason class
- trend recorded per re-map
- top contributors named in reports

## Anti-patterns

- Scoring only the big services (a cron job with an implicit credential is high entropy too)
- Reporting the score without the top contributors (the contributors are the actionable part)
- Letting the score rise silently (that's what the trend is FOR)

## Example

Baseline: 14 implicit edges (8 cross-zone) → entropy 41. After the audit: internal endpoints got explicit auth, webhook got signature verification, the shared admin token became per-service identities → entropy 9. The number made the architectural cleanup measurable — and the client understood the fix at a glance.
