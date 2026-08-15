# Architecture Mapper

## What

The first pass of SecurityArch: a complete map of what the system actually IS — components, services, APIs, databases, auth mechanisms, network topology, and dependencies. Built from code and config, never from READMEs or memory.

## Why

Threat modeling on a wrong map is fanfiction with risk ratings. The mapper forces the map to match reality before any analysis builds on it. Every later system (trust boundaries, attack surface, data flow) reads from this map — a wrong box here poisons every downstream verdict.

## When

First step of SecurityArch, before any gate runs.

## Protocol

1. Enumerate components: services, modules, workers, cron jobs — from code structure and run configs.
2. Map the APIs: routes, handlers, what they expose (paths, methods, inputs).
3. Map data stores: databases, caches, queues, files — who reads/writes each.
4. Map auth: where authentication happens, what it issues, what trusts it.
5. Map network: ports, protocols, ingress/egress, inter-service links.
6. Map dependencies: libraries, runtimes, and their versions (the supply chain surface).
7. Draw it — `loopfocus canvas --modules ... --edges ...` — with every edge labeled by what travels on it.
8. Verify every box against code you have actually read. Unread boxes are marked UNKNOWN and enter the next exploration round.

## Evidence gates

- every component has a file:line anchor
- unread areas are labeled UNKNOWN, not guessed
- the canvas exists before any threat verdict

## Anti-patterns

- Mapping from the README (docs drift — the code is the truth)
- Omitting the "boring" pieces (cron jobs, webhooks, file uploads are where attackers land)
- A map with boxes and no labeled edges (that's a list of names, not an architecture)

## Example

Mapping a checkout app: components (web app, API, worker, DB, cache), APIs (POST /checkout, GET /api/cart), stores (users table, session cache), auth (token in header, checked in middleware), network (TLS at proxy, DB on private network), deps (express 4.16 — the version that later became F6 High). The map made the dependency risk visible before the audit even started.
