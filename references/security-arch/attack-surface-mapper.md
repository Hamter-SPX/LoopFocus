# Attack Surface Mapper

## What

Enumerates every way INTO the system: entry points, exposed APIs, file inputs, IPC channels, sockets, webhooks, CLI flags, environment variables, anything that accepts external influence.

## Why

You can only protect the surface you can name. The unnamed surface — the debug endpoint, the webhook, the file upload — is where attackers find the door nobody watches. Baseline audits repeatedly missed unauthenticated /debug endpoints until the mapper forced enumeration.

## When

After the Trust Boundary Mapper. The attack surface is the untrusted edge of the boundary map.

## The inventory (walk ALL)

| Surface class | Where to look |
|---|---|
| HTTP routes/endpoints | route tables, framework registration, any unauthenticated route |
| File inputs | uploads, imports, config files, attachments, archives |
| IPC / sockets | unix sockets, local ports, shared memory, message queues |
| Webhooks / callbacks | external posts INTO the system, signed or not |
| CLI / admin commands | flags, subcommands, environment variables |
| Third-party inputs | OAuth callbacks, payment callbacks, email parsing |

## Protocol

1. Enumerate per class — a class with zero findings is recorded as "none", not skipped.
2. For each entry point: who can reach it (auth? network? local?), what it accepts, what it does with the input.
3. Rank by exposure: unauthenticated + remote + high-privilege effect = top of the queue.
4. Feed the ranked list into the gates — each entry point is a candidate finding or a verified control.

## Evidence gates

- per-class coverage recorded (including the "none" entries)
- every entry point has reachability + input shape recorded
- unauthenticated remote entries are ranked and traced first

## Anti-patterns

- Enumerating only the main API routes (debug endpoints, static files, and webhooks count)
- Skipping local-only surfaces (local privilege escalation is still escalation)
- Ranking by code size instead of by exposure

## Example

The /debug endpoint (unauth, dumps process.env + DB config) was invisible in the route table's "main" section. The mapper's reachability pass caught it as unauthenticated + remote + high-privilege — F5 High — before any attacker did.
