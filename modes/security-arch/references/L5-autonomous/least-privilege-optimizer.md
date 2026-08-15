# Least-Privilege Optimizer

## What

Reads the privilege graph and computes which permissions are NOT necessary for any real function — then proposes the smallest scope each principal actually needs.

## Why

Permissions accumulate by convenience: the service gets `*:*` "for now", the role inherits the default policy, the token carries every scope ever requested. The optimizer reverses the accumulation — not by guessing, but by tracing actual usage: a permission with no usage evidence is a candidate for removal, whatever its original justification.

## When

L5, after the privilege graph and identity graph exist. Re-run after feature changes (usage shifts).

## Protocol

1. Per principal: list granted permissions (from IAM, roles, scopes, code checks).
2. Trace actual usage: which permissions does each principal's real code paths exercise? (grep the call sites, read the flows, check logs where available).
3. Classify per permission: USED (usage evidence exists), UNUSED (no usage found — removal candidate), UNKNOWN (cannot verify — flag, do not assume).
4. Compute the minimal scope: USED permissions + explicitly justified exceptions.
5. Propose the scope reduction as a policy with blast radius (what breaks if wrong — usage tracing can be incomplete; the optimizer is a proposal, the user approves).

## Evidence gates

- usage evidence per permission (or UNKNOWN stated)
- minimal scope proposals carry blast-radius notes
- reductions are proposals, not silent changes

## Anti-patterns

- "Removing permissions is risky, keep them" as the default (the optimizer exists to name what is actually used)
- Guessing usage instead of tracing it (UNKNOWN is the honest third option)
- Applying the optimizer's output without the user's approval (scope changes are user-owned decisions)

## Example

The worker service held DynamoDB full access; usage tracing showed it only ever read from one orders table. Proposed scope: `orders:Read` on that table only. The blast radius (if the trace missed a write somewhere) was checked with the team in one question — and the service's compromise radius shrank from "the whole store" to "one table's reads". That is the optimizer's real product: a smaller blast radius.
