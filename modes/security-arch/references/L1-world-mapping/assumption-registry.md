# Assumption Registry

## What

Every security-relevant assumption is stored as an object with owner, confidence, expiration, and evidence. When an assumption expires or is refuted, its dependents are re-reviewed automatically.

## Why

Security architectures stand on assumptions ("internal network is trusted", "this dependency never changes", "admins are human"). Assumptions fail silently — the registry makes them visible, owned, and time-boxed, so the failure is caught by review instead of by incident.

## When

L1 (seed it during mapping — the trust edges' reasons ARE assumptions) and maintained every loop (refutations trigger walk-backs, like the LoopFocus assumption-registry but security-weighted).

## The object

```text
A1: internal network is trusted | owner: platform team | confidence: Likely
  | evidence: no external ingress configured | expires: 2026-09-16 | used-by: network-exposure verdict, trust edges web→db
```

## Protocol

1. During mapping, every trust edge's "why" becomes an assumption object if it is not code-verified.
2. Give each an owner (who owns the truth of it), confidence (Known/Likely/Unknown), an expiration (when it must be re-verified), and the evidence behind it.
3. Expired assumption → re-review its dependents before trusting any of them again (Trust Decay System consumes this).
4. Refuted assumption → walk-back: every verdict that used it is re-opened (security-semantic-diff and re-verify-loop consume this).
5. The registry lives in the World Model — it is part of the model, not a side list.

## Evidence gates

- every unverified trust edge has an assumption object
- expirations are dated, not "forever"
- refutations trigger recorded walk-backs

## Anti-patterns

- Assumptions recorded as prose in the report instead of objects (prose has no expiration)
- "Forever" expirations (an assumption that never needs re-checking is a belief)
- Walk-backs skipped because "the change was small" (the refutation is the signal, not the size)

## Example

A3: "the webhook sender is always the payment provider" — Likely, evidence: URL kept private. Later, the webhook URL leaked into a client bundle → assumption refuted → walk-back reopened every verdict that trusted payment-callback authenticity (which included the order-fulfillment flow). The registry turned one leak into a complete dependent-surface review.
