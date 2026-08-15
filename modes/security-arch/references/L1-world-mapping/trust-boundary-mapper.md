# Trust Boundary Mapper

## What

Zones the system into trusted / semi-trusted / untrusted regions, and marks every edge that crosses a zone. Trust boundaries are where the security analysis happens — everything else is interior detail.

## Why

Security work scattered evenly across a system is diluted; concentrated at boundaries it is decisive. Most real vulnerabilities are boundary-crossing failures: untrusted data entering a trusted zone without validation, or trusted behavior reachable from outside.

## When

Immediately after the Architecture Mapper. Every downstream gate (Boundary Gate, Auth/AuthZ Gate, Input/Output Gate) reads the zones.

## Protocol

1. Classify each mapped component:
   - **Untrusted**: anything an attacker can reach directly (browser, client, public API surface, external webhooks).
   - **Semi-trusted**: authenticated users, third-party integrations, other tenants.
   - **Trusted**: internal services, the database layer, secrets storage.
2. Mark every edge that crosses a zone with its direction and what travels on it.
3. For each crossing: name the validation/serialization/authorization that should happen AT the boundary. Missing controls at a crossing = a finding candidate.
4. Record the zones on the canvas — they are part of the architecture map, not a separate diagram.

## Evidence gates

- every component has a zone label
- every zone-crossing edge is labeled with direction + payload
- crossings without controls are recorded as finding candidates

## Anti-patterns

- Declaring everything trusted because "it's internal" (the attacker is usually already inside one zone)
- Zoning by physical host instead of by what can be influenced (a public endpoint on the DB host is still untrusted)
- Missing the semi-trusted tier (authenticated users are not friends — they are the threat model's largest surface)

## Example

Checkout app: browser = untrusted; authenticated API = semi-trusted; DB + worker = trusted. The map showed /api/cart (semi-trusted) reading straight from the DB with no per-user scoping — a crossing with a missing control, which became finding F11 (IDOR-ish) instead of hiding in "the API is fine".
