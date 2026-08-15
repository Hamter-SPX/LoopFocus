# Adaptive Gate Intelligence

## What

Security gates do not use fixed thresholds: the required evidence depth adapts to asset criticality, evidence quality, blast radius, confidence, and change context. A config tweak on a public surface gets more scrutiny than one on an internal utility — automatically.

## Why

Fixed thresholds are wrong at both ends: they over-review trivial changes (burning attention) and under-review quiet but critical ones (a one-line role widening looks the same as a one-line comment fix). Adaptive gating spends scrutiny where risk lives — the same principle as Effort Elasticity, applied to security review intensity.

## When

L6 — the gate chain's intensity is computed per change, not per gate definition. The semantic diff's delta classification feeds the adaptation.

## The adaptation factors

| Factor | Effect on gate intensity |
|---|---|
| asset criticality (data class of what's touched) | Crown Jewel → mandatory deep gates |
| change class (NEW_TRUST / WIDER_PRIVILEGE / NEW_EXPOSURE / NEUTRAL) | security-relevant classes → full gate chain |
| evidence quality | weak evidence → stricter judges |
| blast radius of the touched component | high radius → counterfactual + quorum |
| confidence of the change's justification | low → hypothesis round required |
| change context (emergency patch vs planned) | emergency → gates run AFTER, but run they must |

## Protocol

1. Each change enters with its semantic-diff classification + touched-asset classes.
2. The gate intensity is computed: which gates run, at what strictness, which judges review.
3. The computation is recorded (why this change got this scrutiny) — adaptive is not arbitrary.
4. Emergency changes may defer but never skip: the gates run post-merge, and failures trigger immediate remediation.
5. The adaptation policy itself is audited (are the adaptations catching what they should? — the Learning Loop consumes the record).

## Evidence gates

- per-change gate intensity recorded with reasons
- security-relevant classes never get light treatment (the adaptation floor)
- deferred gates actually run post-merge

## Anti-patterns

- Adaptivity used to lighten security gates "because we trust this dev" (trust is not a factor)
- An adaptation policy with no floor (every policy needs its non-negotiable minimum)
- Recording the adaptation but never auditing whether it worked

## Example

Two changes, same day: (A) a neutral refactor of an internal utility → light gates, standard review. (B) a one-line IAM change on the Crown Jewel service → deep gates + counterfactual + multi-judge, despite being "smaller" than A. The adaptive computation looked at the semantic class and the asset — and spent the scrutiny where the risk was, which is the entire point.
