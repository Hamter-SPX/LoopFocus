# Privilege Graph

## What

A graph of who/what holds which rights — principals (users, roles, services, tokens) and the capabilities they can exercise — plus the escalation edges that connect a low right to a higher one.

## Why

Privilege bugs are graph bugs: an escalation is a path from a low node to a high node that the designers never drew. Enumerating rights as a graph makes the path visible, while a list of "roles" hides exactly the edges that matter.

## When

After the Architecture Mapper (it supplies the components) and the Data Flow (it supplies what the rights protect).

## Protocol

1. Enumerate principals: user roles, service accounts, internal services, anonymous.
2. Enumerate capabilities: what each principal can read/write/invoke (routes, tables, files, admin actions).
3. Draw the edges: principal → capability. Canvas it — graphs beat tables here.
4. Hunt the escalation edges: anonymous → user (signup bypass), user → admin (IDOR on role field), service → other service (shared credentials), token → broader scope (missing audience check).
5. For each escalation path found: attempt it (Exploitability Judge) — an escalation that reproduces is a finding with a path, not a suspicion.

## Evidence gates

- principals and capabilities enumerated with anchors
- escalation paths recorded with their attempt results
- the graph exists as a canvas (part of the threat model deliverable)

## Anti-patterns

- Listing roles without their capabilities (a role name is not a right)
- Ignoring service-to-service edges (the attacker escalates through services too)
- Treating "admin checks the role field" as a control without checking who can write the role field

## Example

Checkout app: every login issued the static admin token to ANY valid user (server.js:25) — the graph showed user → admin as a direct edge with no gate on it. The graph made F9 (business logic privilege escalation) structurally obvious instead of a lucky find.
