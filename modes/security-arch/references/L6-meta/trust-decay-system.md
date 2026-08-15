# Trust Decay System

## What

Confidence in evidence and assumptions decays over time: a verification from last year is not a verification today, and an architecture change invalidates its dependents immediately. The system tracks ages and forces re-proof when trust expires.

## Why

Old green is the cheapest lie in security: "we verified the backup restoration" (14 months ago), "the dependency was audited" (before the upgrade). Decay makes time an explicit property — evidence carries a freshness window, and expired evidence cannot support current verdicts.

## When

Continuously, on every evidence artifact and assumption object. The evidence-freshness gate and the assumption registry's expirations are its instruments.

## Protocol

1. Every evidence artifact records its verification date + a freshness window (evidence about stable structures decays slower; runtime/behavioral evidence decays fast).
2. Every assumption object has an expiration (from the registry).
3. On any architecture change: relevant evidence and assumptions decay to zero immediately (the change invalidates them — Evidence Freshness).
4. Expired trust must be re-proven before use; a verdict built on expired evidence is a finding about the process.
5. Decay is a policy with parameters (what decays how fast) — recorded, adjustable by the user, never silently skipped.

## Evidence gates

- evidence carries dates + windows
- expired trust blocked from verdicts until re-proven
- decay policy itself recorded

## Anti-patterns

- "We tested that" without the date (undated evidence is treated as expired)
- Decaying everything equally fast (stable facts vs runtime behavior — different windows)
- Re-proving by re-reading the old report (re-proof means re-running the check)

## Example

The restore drill: verified 14 months ago → decayed to zero under the recovery analyzer's window (drills expire after 6 months). The verdict "backups are tested" could not stand; the re-proof (one drill) restored it as fresh evidence. Decay converted a comfortable lie into a 1-hour re-verification.
