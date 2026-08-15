# Revocation Propagation Analyzer

## What

For every revocable right, computes the answer to one question: if I revoke at T0, what is the LONGEST time before every component stops honoring it? — and names every component that lags.

## Why

Revocation is the emergency brake, and its latency is the damage window: a token revoked at T0 but honored until T0+30min is a backdoor with a 30-minute warranty. Most systems have never measured their propagation time — the analyzer makes the number explicit, per right, with the laggards named.

## When

L8 — for credentials, sessions, API keys, permissions, and any distributed authorization state.

## Protocol

1. Enumerate the revocable rights and their enforcement points (every node/cache/service that honors them).
2. Per right, trace the propagation path: where does revocation originate, how does it reach each enforcement point (push? polling? TTL?), and what is the worst-case delay per point?
3. Compute the propagation time = the maximum across enforcement points, under worst-case conditions (queue delays, failed pushes, cache TTLs).
4. The result: a table of right → propagation time → laggard components. Rights whose window exceeds their risk tolerance are findings (a Crown Jewel credential with a 24h propagation window is Critical).
5. Fixes: push-based revocation, shorter TTLs, offline-token checks, or split rights so the dangerous ones propagate fast.

## Evidence gates

- enforcement points enumerated per right
- worst-case delays computed (not average-case)
- propagation windows compared against risk tolerance

## Anti-patterns

- "Revocation works" without the propagation number (the number IS the property)
- Measuring average-case delay (the attacker waits for the worst case)
- Computing once and never after topology changes (new caches = new laggards)

## Example

Measured: admin tokens — TTL 24h, no push → worst-case window ~24h ✗. Session tokens — 30min TTL → ~30min window (borderline). API keys for the payment service — cached with 1h TTL ✗ for its blast radius. The table made the fix order obvious: push-revocation for admin tokens first (the 24h window on the highest right was the standing emergency). The analyzer converted "we can revoke things" into the only question that matters: how FAST.
