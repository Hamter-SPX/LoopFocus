# Supply-Chain Provenance Engine

## What

For every artifact the system trusts — package, image, binary, CI action, config — answers: where did it come from, what did it pass through, who built it, and how much should we trust it?

## Why

Advisory databases tell you a dependency HAS a vulnerability; provenance tells you whether the artifact itself is what it claims to be. A signed artifact from a verified source is a different trust object than an unsigned one from an unknown registry — and the difference is invisible to version checks. The engine adds the origin dimension that makes supply-chain risk computable.

## When

L5, on the Dependency Trust Graph's nodes. Consumed by the Hardware Supply-Chain Trust system for firmware/bits (L8).

## The provenance questions per node

1. **Origin**: which registry/source? Is the source itself trustworthy (maintainer history, security record)?
2. **Integrity**: is the artifact signed/pinned (lockfile, checksum, signature)? Could it change silently?
3. **Build path**: who built it, on what, from what commit? (Reproducible builds turn this from mystery into checkable fact.)
4. **Transit**: what did it pass through (CI systems, mirrors) that could have modified it?
5. **Attestation**: is there a provenance record (SLSA-style, signed attestation) — or is the trust based on "it was always like this"?

## Protocol

1. Per node, answer the five questions with evidence where available.
2. Score provenance: attested+verified / pinned+partial / undocumented.
3. Undocumented provenance on a node with high reachability (from the trust graph) = finding — the artifact is trusted more than its evidence supports.
4. Findings enter the standard loop; fixes are usually pinning, signing, or source replacement — each its own verified change.
5. Provenance records join the World Model (they are part of the model's trust edges).

## Evidence gates

- five questions answered per significant node
- provenance scores recorded (not vibes)
- undocumented provenance on high-reachability nodes flagged

## Anti-patterns

- Trusting "it's a popular package" as provenance (popularity is marketing, not evidence)
- Checking provenance only for top-level deps (transitives carry the same risk class)
- Recording provenance once and never re-checking (sources change hands, registries get compromised)

## Example

The CI runner image: origin = a community-maintained registry (moderate trust); integrity = unpinned `latest` tag (silent-changeable); build path = undocumented; transit = public runners; attestation = none. High reachability (it ran every build, could inject into every artifact). Verdict: undocumented provenance on the highest-reachability node → the top supply-chain finding, fixed by pinning + moving to a controlled build image. No advisory database would ever flag it.
