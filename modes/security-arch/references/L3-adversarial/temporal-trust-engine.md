# Temporal Trust Engine

## What

Reasons about trust as a function of TIME: a permission that is correct today may be wrong in 30 days. Temporary roles, stale tokens, old keys, forgotten service accounts — the engine finds trust that outlives its justification.

## Why

Security reviews snapshot the system at T0 and bless it forever. But trust expires in the real world: the contractor's role outlives the contract, the old API key survives the migration, the service account for a decommissioned service still has IAM rights. Temporal reasoning is the only layer that catches these — no static scan sees a future expiry.

## When

L3/L4 — on every credential, role, and trust edge in the World Model. Re-run at every audit and at every assumption expiration.

## Protocol

1. For every principal, credential, and role: record WHEN it was granted, by whom, and whether it has an expiry or revocation date.
2. Compute the drift: items with no expiry, items whose justification has expired (the service was decommissioned, the person left), items with expiries nobody watches.
3. For each drift candidate: check current usage evidence — is the credential still used? By what? A stale-but-unused credential is a finding (it is a valid key nobody owns).
4. Findings: "trust with no expiry", "trust whose justification expired", "expiry with no watcher" — each with the item named.
5. Feed revocation hygiene into the Decision Log (rotation schedules are security decisions).

## Evidence gates

- grant metadata recorded per principal/credential
- expiry-lessness flagged as a finding, not assumed fine
- usage evidence checked before declaring something stale-but-harmless

## Anti-patterns

- Reviewing credentials for strength only, never for age
- "It has no expiry because we trust them" (that's the finding)
- Declaring a credential unused without checking logs (unused ≠ harmless — it's an orphan key)

## Example

The old admin API key from the 2025 migration: no expiry, no owner, still valid, and the audit log showed it unused for 8 months. The engine flagged it — an orphan key with full rights is a breach waiting for the person who finds it. The fix (revoke + establish rotation policy) cost minutes; the alternative was an unmonitored backdoor.
