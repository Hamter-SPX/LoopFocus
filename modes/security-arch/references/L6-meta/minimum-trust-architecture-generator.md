# Minimum-Trust Architecture Generator

## What

Proposes architectural alternatives that reduce the NUMBER of trust assumptions to the minimum — every trust edge must be necessary, explicit, and verifiable, or the generator proposes removing it.

## Why

Trust is the liability side of architecture: every trust edge is a potential compromise path. The generator attacks the liability directly — an architecture with 6 trust assumptions is strictly safer than the same system with 40, whatever the individual edge quality. It is the structural version of least privilege: least TRUST.

## When

L6/L7 — after the trust edges are mapped and the Trust Entropy Score computed. The Synthesizer uses it as the scoring principle for candidate architectures.

## Protocol

1. Take every trust edge in the model with its reason.
2. Classify: necessary (removing it breaks a required function), convenience (it exists because it was easy), legacy (nobody knows why).
3. Generate the minimum-trust variant: remove/replace convenience and legacy edges — service-to-service calls become explicit contracts, shared credentials become per-principal identities, implicit network trust becomes explicit allowlists.
4. Score both variants (entropy + blast radius + function coverage); the proposal must preserve all required functions.
5. Present as an option with the trust-delta (which edges die) — the user approves the migration; the generator never silently removes trust.

## Evidence gates

- every edge classified (necessary/convenience/legacy)
- the variant preserves required functions (checked, not assumed)
- trust-delta stated per proposal

## Anti-patterns

- Generating the variant and shipping it without approval (trust changes are user-owned decisions)
- Keeping legacy edges because "it works" (working is not a security reason)
- Proposing minimum-trust as theory without the concrete edge list (the list is the deliverable)

## Example

Trust census: 23 edges, of which 9 convenience (services sharing one DB role) and 4 legacy (the old admin token's remaining uses). The generated variant: per-service DB identities, token retired — 10 edges total, all necessary + explicit. Entropy 41 → 9, blast radius of any single service compromise roughly halved. The proposal shipped as a migration plan, with each edge removal its own verified change.
