# Side-Channel Risk Model

## What

Flags, at the ARCHITECTURE level, which components share CPU, cache, memory, timing, or power resources with sensitive data too closely — without becoming an attack manual.

## Why

Side channels are the security property of SHARING: two tenants on one CPU share caches, two processes share branch predictors, two users share timing. The model identifies the risky sharings architecturally — so designs can reduce them (isolation, padding, partitioning) — instead of waiting for a researcher to demonstrate the leak. It flags the risk class, not the exploit.

## When

L8 — for multi-tenant systems, confidential computing, crypto-heavy workloads, and hardware design review.

## The sharing axes to check

| Shared resource | Risk when | Architectural mitigation |
|---|---|---|
| CPU cores (SMT) | secrets and attacker workloads share a physical core | core pinning, SMT off for sensitive workloads |
| cache hierarchy | cross-tenant cache contention observable | cache partitioning, per-tenant isolation |
| memory bandwidth | timing of secret-dependent access observable | bandwidth throttling normalization |
| power/thermal | activity correlated with secret processing | workload masking |
| interrupts/timers | secret-dependent timing observable | constant-time design, timer isolation |

## Protocol

1. Map the co-tenancy: which sensitive workloads share which physical resources with which attacker-reachable workloads.
2. Per axis, flag the sharings where the sensitive workload's behavior is secret-dependent (crypto, token handling, key comparisons — the classic cases).
3. Severity by the secret's class + the co-tenant's reachability (a public tenant sharing cache with the key service is the worst case).
4. The response is architectural (partitioning, pinning, constant-time requirements) — recorded per flag.

## Evidence gates

- co-tenancy map per physical resource
- secret-dependent workloads identified
- risky sharings flagged with mitigations

## Anti-patterns

- "We're patched against Spectre-class" as the whole answer (side channels are a family, not a CVE list)
- Flagging only crypto code (token comparisons and parsers leak too)
- Confusing the flag with the exploit (the model flags the sharing; researchers exploit it — the fix is the sharing)

## Example

The key-management service shared a physical core (SMT) with tenant-run jobs, and its token comparison was secret-dependent. Two flags from the map: SMT sharing (mitigation: core pinning) + non-constant-time comparison (mitigation: constant-time compare). Both were architectural fixes — no CVE existed, and the model's job was to keep it that way.
