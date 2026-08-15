# Compositional Security Proof

## What

Proves security at the COMPOSITION level: service A safe + service B safe does NOT imply A+B safe. The proof examines the interface between them — what they exchange, what they trust about each other — and proves (or disproves) the composed system's invariants.

## Why

The most common false confidence in architecture: each service passed its own review, so the system is assumed safe. Composition is where the real bugs live — the contract mismatch, the implicit trust, the property that survives each side but dies at the boundary. Compositional proof treats the boundary as a component with its own security properties.

## When

L3/L4, whenever two or more verified-safe components are connected (new integration, new call path, new data flow).

## Protocol

1. Take the individually verified components with their stated properties (A: "validates all input"; B: "trusts its callers").
2. State the composed invariant that must hold across the boundary ("malformed data never reaches B's logic").
3. Check: does A's property actually deliver B's assumption? (A validates — but does it validate B's SHAPE? B trusts callers — does A count as a trusted caller?)
4. Prove or break: compose the evidence from both sides; a gap between A's guarantee and B's assumption = a composition finding.
5. Record the composition proof with the boundary's contract stated explicitly (the contract becomes an invariant).

## Evidence gates

- component properties stated before composition
- the boundary contract written down (it is the proof's subject)
- gaps between guarantee and assumption recorded as findings

## Anti-patterns

- "Both passed their audits" as a composition verdict
- Proving the happy-path composition only (failure modes compose too — fail-open on one side × trusting caller on the other = open door)
- Composition proofs without naming the boundary contract

## Example

A = payment gateway (verified: rejects malformed callbacks). B = order service (verified: enforces its own authz). Composed: B trusts ANY callback that the gateway forwards. But A forwards callbacks with a shared webhook secret that ships in the client bundle → an attacker can forge a callback that A will accept as authentic → B fulfills a phantom order. A safe + B safe = broken composition. The proof named the boundary contract ("callback authenticity") and the gap (the shared secret's exposure) — a finding no individual audit could produce.
