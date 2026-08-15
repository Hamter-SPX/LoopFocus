# Epistemic Risk Engine

## What

Separates SecurityArch's own knowledge states rigorously: known / estimated / no-evidence / contradictory — and treats each differently in every verdict, report, and exit condition.

## Why

Security hallucination is epistemic sloppiness: a guess reported with the confidence of a fact. The engine is the guardrail on SecurityArch's own reasoning — it classifies every belief before any use, so "I think this is exploitable" can never masquerade as "this is exploitable". It is Confidence Calibration's machinery, applied everywhere.

## When

Continuously — every belief that enters the pipeline gets an epistemic class at birth and keeps it until evidence changes it.

## The classes

| Class | Meaning | Allowed in verdicts? |
|---|---|---|
| Known | verified by reproduction or tool output | yes, as fact |
| Estimated | pattern + partial evidence (Likely) | yes, labeled, never at full severity |
| No-evidence | speculation (Unknown) | only as a hypothesis/candidate |
| Contradictory | two sources disagree | no — Contradiction Engine first |

## Protocol

1. Tag every belief at creation (ledger entries carry the tag).
2. Enforce per use: verdicts may only rest on Known; Estimated adds uncertainty labels; No-evidence cannot support a verdict at all.
3. Contradictory blocks everything downstream until resolved.
4. The exit gate reads the epistemic map — a report whose Criticals rest on No-evidence does not exit.

## Evidence gates

- beliefs tagged at birth
- verdict support traces to Known evidence
- exit conditions respect the epistemic classes

## Anti-patterns

- Upgrading a belief silently as it gets repeated ("we've said it so often it must be true")
- Letting urgency blur the classes (the incident's urgency is why the classes matter most)
- An epistemic map nobody reads (tags must be enforced at use, not decoration)

## Example

"WebKit-only failure is a rendering bug, not security" — tagged No-evidence by the discoverer. Under time pressure, the team wanted to ship the fix anyway. The engine blocked: the belief could not support the shipping verdict. The evidence round (one WebKit repro) upgraded it to Known in 20 minutes — and the verdict shipped on evidence instead of momentum.
