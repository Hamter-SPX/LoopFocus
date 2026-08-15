# Distributed Trust Semantics

## What

The discipline of reasoning about security in systems with NO global truth: identity freshness, authorization freshness, cache consistency, revocation propagation, clock assumptions, replica trust, message ordering, partial failure, retry semantics, idempotency.

## Why

Distributed security bugs are not "if auth == false": they are the revocation that never reached the second region, the cached authorization that outlived the permission, the retry that double-executed the refund, the clock skew that accepted an expired token. Single-node reasoning cannot even SEE these — they live in the gaps between nodes.

## When

L8 — for any multi-node system: microservices, caches, queues, multi-region deployments.

## The checklist (per security-relevant operation)

| Property | The question |
|---|---|
| identity freshness | is the identity checked against a current source, or a cached copy? |
| authorization freshness | how long can an authz decision outlive the permission it encodes? |
| revocation propagation | if a right is revoked at T0, when does every node stop honoring it? (→ the Revocation Propagation Analyzer) |
| clock assumptions | what do token expiry and rate limits assume about clock agreement? |
| replica trust | do all replicas enforce the same checks, or does the stale replica accept? |
| message ordering | does the security decision depend on order that the channel does not guarantee? |
| partial failure | when a dependent node fails, do checks fail open or closed? |
| retry/idempotency | does the retry re-run the CHECK, or only the action? |

## Protocol

1. Pick each security-relevant operation (login, refund, access check).
2. Walk the checklist — each property gets a verdict with the mechanism named.
3. Flag every "the cache says so" and "the other node handles that" — those are the gaps.
4. The findings are the freshness/ordering/failure gaps; fixes are architectural (single source of truth, TTLs, idempotency keys, fail-closed defaults).

## Evidence gates

- per-operation checklist verdicts
- freshness/ordering mechanisms named
- gaps flagged with the node topology they live in

## Anti-patterns

- Reasoning about the system as one node (the single-node model is the blind spot itself)
- "Eventually consistent" as the answer to an authorization question (authz has no eventual)
- Checking retry for reliability but not for security (a retried refund is a security bug)

## Example

The admin revocation: revoked in region A's database; region B's services cached the token's validity for 30 minutes. The gap: a revoked admin kept acting in B for half an hour — and the single-node review of either region showed correct code. The checklist's revocation-propagation property caught what both reviews missed: the bug lived BETWEEN the nodes.
