# TEE Architecture Reasoner

## What

Decides where confidential workloads BELONG: normal world, trusted execution environment, or isolated VM — and names the true boundary each option provides.

## Why

"Put it in the TEE" is often the wrong answer (or a meaningless one — a TEE with its secrets in normal-world memory protects nothing). The reasoner forces the placement question to be answered by the workload's actual requirements: what is secret, what attacks must it survive, what does the host need to see — and then matches the workload to the right isolation class.

## When

L8 — whenever a confidential workload (keys, ML models, user data processing) is being placed.

## The placement decision

| Workload requirement | Fits |
|---|---|
| secret from the host OS only | isolated VM (confidential VM) |
| secret from the host AND hypervisor | TEE (enclave) |
| high performance, secret only from other tenants | normal world + strong authz |
| attestable to a remote party | TEE/confidential VM with attestation |

## Protocol

1. State the workload's secret set and its threat model (what must it be hidden from?).
2. Check each candidate placement's REAL boundary (what can still see it there — a TEE still shares DRAM with the host for most data).
3. Match placement to requirements; mismatches are findings ("enclave holds the key but the key was provisioned in normal world — the enclave's boundary is already crossed").
4. Record the placement decision with its boundary statement (Proof-Carrying — the placement IS a trust decision).

## Evidence gates

- secret set + threat model stated before placement
- candidate boundaries named (what each does NOT hide)
- placement decision recorded with the boundary

## Anti-patterns

- "Use the TEE" as a default without the threat model (TEEs hide specific things from specific layers)
- Ignoring provisioning (a secret provisioned outside the TEE was never inside it)
- Assuming the TEE hides everything from the OS (attestation and I/O still cross the boundary)

## Example

The ML inference workload: model weights (Secret). Requirements: hidden from the host operator. Placement: confidential VM (weights encrypted in transit, VM attested) — chosen over a TEE because the host-hypervisor threat was absent and the VM gave the needed boundary at a fraction of the porting cost. The decision recorded: "boundary = host operator; hypervisor remains trusted; acceptable per threat model" — a reasoned placement, not a reflexive one.
