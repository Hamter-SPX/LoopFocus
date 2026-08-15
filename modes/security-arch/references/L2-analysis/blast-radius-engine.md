# Blast-Radius Engine

## What

Measures the impact radius of compromising each component: what it can reach, what depends on it, what stops working or falls with it. Output: the Crown Jewel map and the components whose compromise is catastrophic.

## Why

Risk is impact × likelihood, and impact is a graph property, not a label. A logging service may sound harmless while holding the keys to everything (every service sends it secrets). The engine converts "which component matters" from intuition into reachability — and drives both fix priority and recovery planning.

## When

L2, on the World Model. Also re-run by the counterfactual engine for "what if X is compromised" questions.

## Protocol

1. Per component: compute the compromise fan-out — what data it holds, what privileges it has, what trusts it, what it can invoke.
2. Compute the reverse fan-in: who depends on it (if it dies or lies, what else breaks?).
3. Blast radius = union of fan-out and fan-in, weighted by data classification.
4. Rank components by radius. The top ranks are the Crown Jewels (nomination from data-classification-engine must agree with the radius — disagreement is itself a finding: "the team protects the wrong thing").
5. The Defense Coverage Map and Recovery Analyzer consume this ranking.

## Evidence gates

- per-component radius computed from the model, not opinion
- Crown Jewel nomination cross-checked against radius ranking
- disagreements between assumed and computed criticality recorded

## Anti-patterns

- Ranking by name ("the DB is obviously critical") without computing who can reach it
- Ignoring the fan-in side (a component that everything trusts IS the blast)
- Computing radius once and never after architecture changes (radius changes with every edge)

## Example

Fan-out: the auth service held the token signing key → radius covered every authenticated surface. Fan-in: every service verified tokens with it → its failure was total. Radius ranking put auth at #1 even though its code was "small" — and the finding "no key rotation path" (Medium by itself) became the top-priority fix because the radius said so.
