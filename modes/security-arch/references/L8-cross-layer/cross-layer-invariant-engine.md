# Cross-Layer Invariant Engine ⭐

## What

Proves invariants that span EVERY layer at once: "Secret X is reachable only by workload Y, on a machine that passed attestation, in isolation domain Z" — checked hop by hop, where missing even ONE hop means the invariant is unproven.

## Why

The deepest security claims are conjunctions across layers, and each layer's check is someone else's job: hardware proves the machine, the OS proves the process, IAM proves the service, the policy proves the data access. Nobody checks the WHOLE conjunction — so a claim that holds in five layers can silently die in the sixth. The engine makes the conjunction the unit of proof.

## When

L8 — for Crown Jewel invariants: the statements the system's security actually rests on.

## The hop chain (the invariant's proof template)

```text
Hardware identity      →  is the machine the right machine?
Boot integrity         →  did the right software boot?
OS identity            →  is the running OS the attested one?
Workload identity      →  is this process the workload it claims?
Process isolation      →  is the workload actually isolated (domain Z)?
Service IAM            →  does the service identity hold the right grants?
Secret policy          →  does the policy bind Secret X to exactly this path?
Application access     →  does the code path enforce the policy at use?
```

## Protocol

1. State the invariant in its full cross-layer form (who/what/where/through-what).
2. Walk each hop and collect its evidence — one hop with no evidence (or a violation) and the invariant's verdict is UNPROVEN or VIOLATED, regardless of the other hops.
3. Record per-hop verdicts; the conjunction is the proof.
4. Re-prove after any change to any hop's layer (a container config change re-opens the isolation hop).

## Evidence gates

- per-hop evidence recorded for each invariant
- conjunction verdicts (all hops required)
- re-proof on layer changes

## Anti-patterns

- Proving the first and last hops and assuming the middle (the middle is where the chains break)
- One hop's strength compensating for another's absence (conjunctions don't average)
- Cross-layer invariants stated as wishes without hop structure (no hops, no proof)

## Example

Invariant: "the signing key is usable only by the signing workload in the attested CI". Hops: hardware ✓ (TPM attestation), boot ✓, OS ✓, workload ✓ (attested identity), isolation ✓ (dedicated VM), IAM ✗ — the key policy granted access to the whole runner pool, not the single workload. Six hops, one fail → invariant VIOLATED. The fix (policy bound to the attested workload identity) re-ran the chain to full PASS — and the conjunction had caught what any single-layer review would have called "mostly fine".
