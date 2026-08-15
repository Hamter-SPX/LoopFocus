# Authorization Path Analyzer

## What

Traces the COMPLETE authorization path for every protected resource: request → auth → policy → ownership → resource → response — and verifies each hop actually performs its job. Big systems fail authz exactly here: one missing hop, usually ownership.

## Why

Authz bugs are the most common security flaw in large systems, and they hide in the path's middle hops: the request is authenticated, the policy exists, and yet the resource is returned to the wrong caller because OWNERSHIP was never checked against the object. Point checks ("is there a role check?") miss this; path analysis cannot — it walks every hop.

## When

Gates phase, per protected resource type (not per endpoint — the path is per resource, and endpoints sharing a path share the verdict).

## The path walk

| Hop | Question | Common failure |
|---|---|---|
| request | is identity established (auth)? | missing/weak auth |
| auth | is the identity REAL (verified)? | loose comparison, forged token |
| policy | does a policy bind this principal to this action? | policy exists but doesn't apply here |
| ownership | does the principal own/relate to THIS object? | **the classic miss** — checked on the class, not the instance |
| resource | is the object the policy refers to actually the object returned? | ID confusion, unvalidated references |
| response | does the response contain only what the caller may see? | over-fetch, unencoded fields |

## Protocol

1. Pick a protected resource type (orders, files, accounts).
2. Walk the six hops in the actual code path — each hop verified with file:line, not assumed.
3. A hop that is missing or weak = a finding on that path (the path is the finding's location — "ownership hop missing on orders").
4. Paths shared across endpoints are recorded once with their endpoint list (fix the path, fix them all).
5. Re-walk after any auth/authz change (paths break silently).

## Evidence gates

- six-hop walk recorded per resource type
- each hop has a code anchor
- missing hops named (usually ownership)

## Anti-patterns

- Checking only the auth hop and calling the path verified (auth is hop 1 of 6)
- Assuming the policy hop "must be there" without locating it
- Walking one endpoint and blessing its siblings (paths are per resource, but the walk must list which endpoints share it — and check one more)

## Example

Orders path walk: request ✓ (session), auth ✓ (token verified), policy ✓ (role check: user), ownership ✗ — the query filtered by name, not by session owner, resource ✓, response ✓ (no over-fetch). The missing ownership hop was the IDOR — found by walking, not by scanning, and fixed at the path (data-layer owner filter) so all order endpoints inherited the fix.
