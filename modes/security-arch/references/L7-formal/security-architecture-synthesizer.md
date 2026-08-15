# Security Architecture Synthesizer

## What

Instead of only critiquing the architecture the team brought, SecurityArch GENERATES its own candidates — Architecture A/B/C — each scored on Security, Complexity, and Cost, with the explanation of why each earned its scores.

## Why

Critique leaves the team with the same design minus its flaws; synthesis offers designs the team never considered. The scored candidates make the tradeoff visible and choosable: the team sees what 97-security costs in complexity, and what 92-security buys in simplicity. Choices made against scored alternatives are decisions; choices made against nothing are accidents.

## When

L7 — after the analysis layers exist (the Synthesizer's inputs are the maps, invariants, and findings). Used when the audit says "this architecture is broken structurally" or when a new system is being designed under SecurityArch.

## The synthesis process

1. Extract the requirements and the hard constraints (Constitution + invariants — candidates that violate them are not generated at all).
2. Generate 2-3 genuinely different candidates (different trust models, different isolation strategies, different data flows — not one design with tweaks).
3. Score each: Security (invariant strength, entropy, blast radii), Complexity (moving parts, operational burden), Cost (build + run).
4. Explain each score: why B's security is 97 (its trust edges are explicit), why A's complexity is 63 (fewer services).
5. Present with the Decision Reversibility and the migration path per candidate.

## Evidence gates

- candidates differ structurally (checkable: different trust edges, not different names)
- scores trace to their reasons (a score without the explanation is a number with no meaning)
- hard constraints filtered at generation, not at scoring

## Anti-patterns

- Generating variants of the team's design and calling them candidates (synthesis means new structures)
- Scoring security by vibe ("B feels safer") — the score comes from the model's metrics
- One candidate ("the only viable architecture") — where there is one, there are three; the generation is the job

## Example

Candidates for the checkout system: A — monolith with internal authz (Security 92, Complexity 63, Cost 45); B — services with explicit per-service identities (97, 78, 52); C — services with a shared hardened authz layer (95, 51, 48). The explanations showed B's extra security came from trust-edge explicitness while C traded 2 points for much lower complexity. The team chose C — and the choice was recorded WITH the tradeoff, which is what made it a decision instead of a default.
