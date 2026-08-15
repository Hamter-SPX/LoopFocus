# Risk Scoring

## What

Every finding gets a two-axis score: severity (Critical / High / Medium / Low / Info) from exploitability, and confidence (Known / Likely / Unknown) from verification depth. The pair, not the name, is the risk.

## Why

Two failure modes plague security reports: fear-scoring (everything is Critical, so nothing is) and confidence-less scoring (a guess and a reproduction wear the same badge). The two-axis score kills both: severity stays honest because confidence carries the doubt.

## When

Every finding, at report time — and the score is written next to the finding, never in a summary table alone.

## The axes

| Axis | Levels | Decides |
|---|---|---|
| **Severity** | Critical / High / Medium / Low / Info | exploitability: remote? unauth? what does success grant? |
| **Confidence** | Known / Likely / Unknown | verification depth: reproduced? pattern match? speculation? |

## Scoring rules

1. Severity is decided by exploitability, not by the bug's name. A remote unauth SQLi is Critical; the same SQLi behind admin-only auth is High.
2. Confidence is decided by verification: reproduced by attempt = Known; strong pattern + partial evidence = Likely; not yet verifiable = Unknown — and an Unknown never reports at full severity (it is a candidate, routed to the Exploitability Judge).
3. The two axes multiply in the report order: Critical/Known first, Info/Unknown last.
4. Scores can change mid-audit as verification deepens — the log records the change with the new evidence.

## Evidence gates

- every finding carries both axes
- Known requires the reproduction or tool output that earned it
- report ordering follows severity-then-confidence

## Anti-patterns

- Fear-scoring: Critical for "best practice" violations (Info/Low exist for hygiene)
- A Known badge on a pattern match
- Scores assigned before verification and never revisited

## Example

The `==` token comparison: first scored Medium/Likely (pattern: loose equality is dangerous). After the reproduction attempt (`?token[]=admin123` → granted) it became Medium/**Known** with the reproduction attached — same severity, materially different risk, and the report order changed accordingly.
