# Physical-to-Logical Trust Bridge

## What

Keeps two questions separate: "is this the right MACHINE?" (physical/attestation) and "is this PROCESS authorized?" (logical/authz). The bridge checks that hardware attestation is never used as a substitute for authorization.

## Why

The most dangerous conflation in hardware security: a machine that passes attestation is then treated as if ITS SOFTWARE is authorized to do anything. But attestation proves the machine is itself — not that the process running on it should access the data. When attestation substitutes for authz, any compromised-but-still-measured process inherits everything the machine's identity grants.

## When

L8 — wherever attestation gates access (secure services, device fleets, confidential computing).

## The bridge check per access decision

```text
attestation says:  this machine is the authorized machine  (physical truth)
authz must answer: this PROCESS on this machine may do X   (logical truth)
```

## Protocol

1. For each attestation-gated access: what does the attestation actually prove (machine identity, boot state)?
2. What authorization exists ON TOP of it (process identity, user, scope)?
3. Flag every access where attestation alone grants rights — the missing logical layer is the finding.
4. The fix: bind the logical identity to the physical one (attested process identity, per-process scopes), never assume one implies the other.

## Evidence gates

- attestation-gated accesses enumerated
- per-access separation recorded (physical vs logical proof)
- attestation-as-authz flagged

## Anti-patterns

- "The device is attested, so it's trusted" as the complete access story
- Binding rights to the machine instead of the workload (machines run many workloads)
- Attestation results treated as permanent (attestation is a moment; authorization is continuous)

## Example

The attested CI runner: attestation proved the runner booted the expected image — so the pipeline granted it the deployment credential. The bridge flagged: the machine is attested, but which PROCESS on it gets the credential? The runner ran third-party PR jobs on the same host. Fix: per-job attested identities with scoped credentials. Attestation stayed meaningful; it just stopped being used as the whole authorization.
