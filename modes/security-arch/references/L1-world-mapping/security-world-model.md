# Security World Model

## What

The internal representation of the ENTIRE system as one connected world: Users, Agents, Services, APIs, Data, Secrets, Roles, Networks, Dependencies, Devices, Trust, Privileges, Policies, Invariants — every security question is answered by reasoning over this world, never by reading files one at a time.

## Why

File-by-file reading produces file-by-file findings and misses everything that exists BETWEEN files: the trust between two services, the capability an agent inherits transitively, the invariant that crosses six layers. The World Model is the difference between "I found 3 bugs" and "I understand the system". It is the substrate every other SecurityArch system reads from — L1 builds it, L2-L8 reason on it.

## When

First pass of SecurityArch, immediately after recon. Every later system consumes the model; nothing consumes raw files directly.

## The entities (all recorded with anchors)

| Entity | What it captures |
|---|---|
| Users | human principals, roles, what they can reach |
| Agents | AI/automation principals + their capabilities (see agent-capability-security-graph) |
| Services | components, endpoints, what they call, what calls them |
| APIs | routes, methods, inputs, auth requirements |
| Data | classes (Public/Internal/Sensitive/Secret/Crown Jewel) + locations |
| Secrets | values, holders, lifecycle state |
| Roles | permission bundles, who holds them |
| Networks | zones, reachability, encryption per hop |
| Dependencies | libraries, services, build steps, provenance |
| Devices | machine identities, attestation state |
| Trust | every trust edge: who trusts whom, on what assumption |
| Privileges | every capability edge: who can do what |
| Policies | the rules that SHOULD govern (IAM, RBAC, network) |
| Invariants | the rules that MUST hold |

## Protocol

1. Recon the repository (L1 mappers produce the raw maps).
2. Assemble the world: entities + their edges, every edge labeled with what flows on it and WHY it exists (the reason is part of the model — a trust edge without a recorded reason is a finding candidate).
3. Store it: `.loopfocus/world-model.md` (structured, machine-skimmable) — the model is a deliverable, not scratch notes.
4. Verify: every entity has a code/config anchor; unverified entities are marked UNKNOWN.
5. From now on, answer every question FROM the model, and update the model when evidence changes it.

## Evidence gates

- world model file exists and is current (updated at every re-map)
- every trust/privilege edge has a recorded reason
- unverified entities labeled UNKNOWN

## Anti-patterns

- "The world model is in my head" (context loss = model loss)
- A model with entities but no edges (the edges ARE the security model)
- Building it once and never updating (stale models produce stale verdicts)

## Example

Checkout app world: users (role: buyer/admin), services (web, api, worker), data (orders=Sensitive, credentials=Secret), trust edge: web→api "token in header, verified by middleware" (reason recorded), privilege edge: admin→delete-order (reason: role check). The later authz finding (every login gets the admin token) was visible in the model as a privilege edge with a broken reason — the model made it findable.
