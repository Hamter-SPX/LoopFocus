# Auth/AuthZ Gate

## What

Verifies that authentication actually authenticates and authorization actually authorizes — identity checks and permission checks are examined separately, at every place they matter.

## Why

Auth and AuthZ failures are the highest-leverage findings in most systems, and they hide in different places: auth fails at the door (weak comparison, hardcoded secrets), AuthZ fails inside the house (IDOR, missing ownership checks). Checking them as one "access control" category lets one hide the other.

## When

Every route/resource in the attack surface inventory, plus service-to-service calls.

## Protocol

1. **Authentication side**: how is identity established? Check the mechanism (not the label): hardcoded secrets, loose comparison (`==` type juggling), missing signature verification, token lifetime, revocation.
2. **Authorization side**: after identity, is the permission actually checked at the resource? Ownership scoping, role checks on the object being accessed, no missing AuthZ on bulk/legacy routes.
3. Verify each by attempt where feasible (array coercion on `==`, forged token structure, another user's ID in the request).
4. Record per-endpoint verdicts: auth ok/weak, authz ok/weak, evidence.

## Evidence gates

- auth and authz verdicts recorded separately per endpoint
- weak verdicts carry a reproduction attempt
- service-to-service calls are covered, not just user routes

## Anti-patterns

- "It uses JWT" as an auth verdict (how is it verified? what trusts it?)
- Checking auth and skipping authz ("only admins can call this" — verified how?)
- Missing the type-juggling class (loose equality is a bug, not a style choice)

## Example

auth.js: `if (token == "admin123")` — auth gate findings: hardcoded credential (F3 High) + loose equality array bypass (F7 Medium, reproduced with `?token[]=admin123`). The authz side found the login handler handing the admin token to every user (F9). Two separate gates, four separate findings — one gate would have stopped at "the token check is weak".
