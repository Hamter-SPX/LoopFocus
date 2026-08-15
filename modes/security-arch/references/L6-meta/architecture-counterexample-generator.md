# Architecture Counterexample Generator

## What

Every time SecurityArch wants to declare something "safe", the generator must first TRY to construct a counterexample — a concrete configuration, sequence, or input that breaks the claim. Only claims that survive counterexample attempts may carry confidence.

## Why

"Safe" is the most dangerous word in security, and the instinct to say it is strongest right before the report deadline. The generator institutionalizes the falsification attempt: a claim without a counterexample attempt is unverified by definition. This is the Recursive Falsification Loop's single-step engine — and it is what separates SecurityArch from auditors who bless their own work.

## When

Every "safe/secure/held" declaration, before it enters any verdict, exit condition, or report.

## The counterexample construction (per claim)

1. Restate the claim precisely ("no path from untrusted input to the DB credential").
2. Enumerate the claim's assumptions (the load-bearing ones from the registry).
3. Try to break each: what configuration, what input, what sequence, what failure would falsify the claim?
4. If a counterexample exists → the claim is BROKEN (the counterexample IS the finding, with its own evidence).
5. If none found → the claim is "held against [the counterexamples tried]" — recorded with the list, never bare "held".

## Evidence gates

- counterexample attempts recorded per safety claim
- broken claims convert to findings (the counterexample is the evidence)
- held claims list the counterexamples that were tried

## Anti-patterns

- Declaring safe without attempting any counterexample (the attempt is the requirement)
- Constructing strawman counterexamples the claim was designed to survive (try the ones it wasn't)
- "Held" without the tried-list (a claim with no record of the attempt is an assertion)

## Example

Claim: "the rate limiter protects /login". Counterexample attempt: distributed requests from many IPs → the per-IP limiter is bypassed by a botnet → counterexample exists → claim broken, finding written. The limiter's protection had been assumed for years; one falsification attempt ended it. The fix (per-account + per-IP limits) survived the next round's counterexamples — and was then, and only then, recorded as held.
