# Cross-Service Trust Analyzer

## What

For every service-to-service trust edge, asks: WHY does A trust B? What does B present that A accepts? And if B is compromised, can it impersonate C — or anyone else in the graph?

## Why

Microservice trust is usually implicit: shared tokens, unauthenticated internal endpoints, "only B calls this". The analyzer makes each edge's mechanism explicit and then asks the transitive question — B's compromise ripples through every edge that accepts B's claims. The answer is often "B can impersonate everyone", and the fix is per-edge identity, not blanket internal trust.

## When

Gates phase, on the Identity & Privilege Graph's service edges. Especially when the blast radius of any service is large.

## The per-edge questions

1. **Mechanism**: how does A authenticate B? (shared token? mTLS? network position? nothing?)
2. **Scope**: what can B claim to be? (its own identity, or ANY identity — shared tokens usually mean any)
3. **Impersonation**: if B is compromised, what identities/rights does B's credential grant? (the transitive question)
4. **Necessity**: does A actually need to trust B for this call, or is it convention? (Minimum-Trust input)

## Protocol

1. Enumerate every service-to-service edge with its auth mechanism (from the model).
2. Classify the mechanism: strong (per-service identity, verified), weak (shared/broad), none (network position only).
3. Per weak/none edge: run the impersonation question — what does B's compromise grant?
4. Edge verdicts recorded; weak edges with high impersonation reach are findings (severity by what the edge touches).
5. Fix direction: per-service identities with scoped claims — one edge at a time, each its own verified change.

## Evidence gates

- every service edge has a mechanism recorded
- impersonation reach computed per weak edge
- edge verdicts in the model

## Anti-patterns

- "Internal network, so it's fine" (the analyzer exists because internal is where the impersonation happens)
- One shared service token accepted by all (that's one identity for everyone — the impersonation reach is total)
- Verifying the mechanism without asking the impersonation question (the mechanism is half the story)

## Example

Edges: A→B used a shared internal token; B→C used the same token; C→D none (network only). If B compromised: B's token = A's token = full impersonation of A, plus direct reach to C and D. One edge's analysis exposed the whole chain's fragility — the fix (per-service identities) broke every impersonation path at once, which is why the analyzer ranks as a design-level tool.
