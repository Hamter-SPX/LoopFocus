# Security Consistency Model

## What

Defines the consistency requirements of SECURITY state separately from database consistency: which security facts must be strongly consistent, which may lag, and what the lag is allowed to cost.

## Why

Database consistency is about data correctness; security consistency is about the DAMAGE WINDOW: a lagging order count is annoying, a lagging revocation is a breach. Conflating the two makes teams either demand strong consistency everywhere (impossible) or accept lag everywhere (dangerous). The security consistency model splits the state by its risk.

## When

L8 — alongside the Distributed Trust Semantics pass, for every distributed security state.

## The classes

| Consistency class | Security state | Requirement |
|---|---|---|
| STRONG | revocations of high-privilege rights, key invalidations | synchronous — no lag accepted |
| BOUNDED | session expiries, rate-limit counters | lag allowed up to a named bound |
| EVENTUAL-OK | audit logs, non-security metadata | lag fine |

## Protocol

1. Enumerate the security state in the system (tokens, keys, permissions, expiries, counters).
2. Classify each per the table — the classification is a decision with a reason (why is this state STRONG? what damage does its lag cause?).
3. Verify the mechanism matches the class: STRONG state on an eventually-consistent store is a finding (the mechanism cannot deliver the requirement).
4. Record the model — it is the contract the Distributed Trust Semantics checklist and the Revocation Analyzer enforce against.

## Evidence gates

- security state enumerated and classified
- mechanism-class mismatches flagged
- the model recorded as a contract

## Anti-patterns

- Classifying everything STRONG "to be safe" (impossible requirements get ignored entirely)
- Classifying revocations EVENTUAL-OK "because the store is eventually consistent" (the store does not decide the security requirement — the risk does)
- One model for all projects (consistency classes follow the damage, which differs per system)

## Example

Classification: admin-token revocation → STRONG (its 24h lag was the standing emergency); session expiry → BOUNDED (30min); audit append → EVENTUAL-OK. The mismatch finding: the revocation lived in an eventually-consistent store while classified STRONG — the classification made the architecture's unsuitability undeniable, and the fix (dedicated revocation store with push) followed the model instead of another round of "the cache is stale, shrug".
