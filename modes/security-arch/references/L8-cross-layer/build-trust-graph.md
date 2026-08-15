# Build Trust Graph

## What

Maps the full path from source to deployed binary: Source → Compiler → IR → Optimizer → Linker → Binary → Loader → Runtime — and answers which binary came from which source, flags, and dependencies, and which step could have changed the result.

## Why

The binary is what runs, and the source is what gets reviewed — the path between them is where tampering and reproducibility failures hide. A reviewed source compiled by an untrusted toolchain, with unreproducible flags, through a compromised linker step, deploys something nobody actually reviewed. The graph makes every transformation step a node with provenance.

## When

L8 — for any deployment where the binary's origin matters (supply-chain audits, CI integrity, reproducible-build initiatives).

## Protocol

1. Trace the actual build path: source versions, compiler + version, flags, dependencies at build time, link inputs, signing.
2. Per step, record provenance: where the tool came from, whether the step is reproducible (same inputs → same output).
3. Check integrity gates: are artifacts signed after build? is the build environment itself trusted (its own provenance)?
4. Flag: unreproducible steps, unsigned artifacts, toolchain nodes without provenance.
5. The graph joins the Dependency Trust Graph (build tools are dependencies with write power).

## Evidence gates

- build path traced step by step
- per-step provenance + reproducibility recorded
- unsigned/unreproducible steps flagged

## Anti-patterns

- "The source was reviewed" as the binary's security story (the path between is the audit's subject)
- Trusting the build environment without its own provenance (the builder is a dependency)
- Reproducibility treated as a nice-to-have (an unreproducible build is an unauditable claim)

## Example

The deployed binary: source reviewed ✓, compiler from a pinned toolchain ✓, but the build ran on a shared CI runner with unreproducible flags ✗ and the artifact was unsigned ✗. The graph flagged the last two steps — the binary's identity could not be tied back to the reviewed source with evidence. Fix: deterministic flags + artifact signing. The graph turned "we review our code" into "we can PROVE what we reviewed is what shipped".
