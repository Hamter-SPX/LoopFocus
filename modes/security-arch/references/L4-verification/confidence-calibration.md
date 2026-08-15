# Confidence Calibration

## What

The discipline of knowing when SecurityArch does NOT know — and saying so. Calibration means the confidence labels match reality: Known findings stand up, Likely findings admit their doubt, and Unknown stays Unknown instead of becoming a hallucinated finding.

## Why

A security report's value is the reliability of its labels. An auditor that calls everything Known trains the team to distrust everything; one that hides its unknowns is dangerous in the opposite direction. Calibration is the meta-skill that keeps every other verdict honest — it is the difference between an assistant and a fortune teller.

## When

Every confidence label assigned anywhere in the pipeline. Re-calibrated after evidence events (a Likely that reproduced becomes Known; a Known that failed a re-check becomes Likely).

## Protocol

1. Assign confidence strictly by verification depth: Known = reproduced or tool-verified; Likely = pattern + partial evidence; Unknown = speculation.
2. Never let pressure upgrade a label (deadlines do not produce evidence).
3. Track calibration: after remediation or re-audit, compare what was labeled Known against what held up. Systematic overconfidence = the calibration is broken — the reasoning policy adjusts (Security Learning Loop).
4. State ignorance precisely: "I do not know whether X is exploitable because <missing environment>" — a named unknown is a deliverable, not a failure.

## Evidence gates

- label upgrades trace to new evidence events
- calibration tracked across audits (Known→held-up ratio recorded)
- named unknowns present where they exist (an audit with zero unknowns is suspicious)

## Anti-patterns

- "Probably" rendered as "Known" in the report
- Hiding unknowns to look thorough (the unknowns are where the next breach is)
- Never tracking calibration (you cannot improve what you do not measure)

## Example

Audit A labeled the "shared admin token" finding Known (reproduced) — held up. Audit A also labeled "the rate limiter is bypassable" Likely; re-check in Audit B showed the proxy config actually limited per-IP — the Likely was right to hedge. The calibration record (1 Known held, 1 Likely correctly hedged) kept both labels credible for Audit C.
