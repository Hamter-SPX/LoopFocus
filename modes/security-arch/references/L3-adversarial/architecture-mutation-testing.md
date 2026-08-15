# Architecture Mutation Testing

## What

Deliberately breaks the architecture MODEL — disables an auth check, flips a trust assumption, marks a dependency compromised — and verifies that SecurityArch's own reasoning detects the mutation.

## Why

A security analyzer is itself a system, and untested analyzers fail silently: the missed finding, the blessed design, the stale model. Mutation testing is the analyzer's test suite — it proves the detection machinery actually detects, not just that it produces reports. The same discipline LoopFocus applies to code tests, applied to security reasoning.

## When

L3, on every completed World Model and on every "safe" verdict before it is reported. The Recursive Challenge uses it as its falsification instrument.

## The mutation set

| Mutation | What it breaks | Detection expected from |
|---|---|---|
| remove an auth check from the model | trust boundary contract | Boundary Gate + Invariant Engine |
| flip a trust edge (trusted ↔ untrusted) | zone integrity | Trust Boundary Mapper re-pass |
| mark a dependency compromised | supply-chain posture | Dependency Trust Graph + Provenance |
| grant a principal one extra capability | least-privilege posture | Privilege Graph + Capability Reasoning |
| delete an invariant | the constitution of the model | Invariant Engine — must scream |

## Protocol

1. Take the verified model (the "control").
2. Apply mutations one at a time; run the analysis pipeline on each.
3. Detection verdict: the mutated model must produce a finding that names the mutation. Silent pass = the analysis has a blind spot → that blind spot is itself a finding.
4. Fix blind spots (add the missing check), then re-run the mutation — until the mutations are all detected.
5. Record mutation results in the ledger (the analyzer's own evidence).

## Evidence gates

- mutation set run against the current model
- every mutation detected OR the blind spot recorded and fixed
- mutation results in the ledger

## Anti-patterns

- Trusting the analyzer because "it found things before" (mutation testing exists because yesterday's detection ≠ today's)
- Mutating only the easy parts (the mutations that pass silently are the findings)
- Skipping the blind-spot fix because "it's just a test" (a blind spot is a missed real finding waiting)

## Example

Mutation: "auth middleware removed from /api/user in the model". Expected: Boundary Gate fails. Actual: the gate checked only the endpoints LISTED in the attack surface — which was built before the mutation. Blind spot found: the gate trusted the stale surface list. Fix: gates re-derive from the model. The mutation test caught the analyzer's own staleness bug before a real architecture change exploited it.
