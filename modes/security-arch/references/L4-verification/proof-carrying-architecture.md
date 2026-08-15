# Proof-Carrying Architecture

## What

Every significant architecture decision must CARRY its justification with it: the reason it exists, the invariant it upholds, and the evidence that it does not exceed its authority. "Service X can access the DB" is not a statement — it is a claim that must arrive with its proof.

## Why

Architecture reviews read decisions long after their authors are gone; an unexplained decision becomes an implicit trust nobody can audit. Proof-carrying makes every decision self-auditing: the reason is attached, the invariant is stated, the evidence is checkable — so later reviews verify the proof instead of re-deriving the intent.

## When

Every decision in the World Model that grants trust, privilege, or access. The Fix Architecture Planner attaches proofs to every proposed change.

## The proof structure (attached to each decision)

```text
DECISION: the worker service may read the orders table
REASON:    order processing requires it
INVARIANT: the worker cannot write to users or credentials
EVIDENCE:  IAM policy statement (config:line) grants orders:Read only;
           code path worker→db has no write call (grep result)
```

## Protocol

1. Every trust/privilege/access edge in the model gets its proof block.
2. The evidence must be checkable by a later reader (config anchor, grep result, test name) — "we designed it that way" is not evidence.
3. Un-provable decisions are flagged: an edge with no proof is a finding candidate (the edge may be right, but it is unauditable).
4. Changes to a decision update its proof (a widened role requires a widened proof — and the semantic diff catches the widening).

## Evidence gates

- trust/privilege edges carry proof blocks
- evidence is checkable (anchors, not prose)
- un-provable edges flagged as findings

## Anti-patterns

- "Best practice" as the reason (the proof must explain THIS decision, not the genre)
- Proofs written once and never updated (stale proofs lie)
- Flagging un-provable edges and then proceeding anyway without recording the acceptance

## Example

The worker's DB access carried: reason = order processing, invariant = read-only on orders, evidence = the IAM statement. The audit verified the proof in minutes. A sibling decision ("web service may access the DB directly") had no proof — flagged, examined, and found to hold credentials it had no reason to hold. The proof system made the difference visible in one pass.
