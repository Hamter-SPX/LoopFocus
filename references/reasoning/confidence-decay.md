# Confidence Decay

## What

Confidence is a property of evidence, not of conviction. A hypothesis that fails a test loses confidence automatically — and the loss is permanent until new evidence arrives.

## Why

Sunk-cost loyalty is the subtlest failure mode: an agent that thought of an idea first defends it longest. Confidence Decay removes the defense mechanically: the belief's score follows the evidence, not the believer.

## When

After every OBSERVE that touches a hypothesis (refute, partial support, confirmation), and before every report that cites one.

## The scale

| Evidence state | Confidence |
|---|---|
| refuted by a discriminating test | 0 — discard, ladder down |
| untested | Likely at most, never Known |
| confirmed by ONE test | Likely-strong (write it as "confirmed by test X", not "known") |
| confirmed by TWO independent measurements | Known |

## Rules

1. Decay is automatic and one-directional per evidence event. "I still feel it's right" is not a re-raise.
2. A refuted hypothesis may return ONLY carrying new evidence that explains both the old refutation and the new support (the fingerprint gate applies).
3. Reports must use the level words exactly: Known / Likely / Unknown. "Probably", "should", "must be" without a level are claims in disguise.

## Evidence gates

- every cited belief in the report carries its level
- refuted hypotheses visible as refuted in the ledger (not silently rewritten into "almost")

## Anti-patterns

- "The test was wrong" without a discriminating test that proves it
- Re-raising confidence because a different agent agreed (agreement is not measurement)
- Labeling a pattern-match as Known because "it fits perfectly"

## Example

Refund bug: H1 "off-by-one in the window constant" — refuted by attempt 1 (widening made it worse). Confidence 0. The agent's instinct: "some kind of boundary problem". The discipline forced the level down and the ladder to S4, where the timezone cause was found. Loyalty to "boundary problem" would have produced attempts 2-5 in the same family.
