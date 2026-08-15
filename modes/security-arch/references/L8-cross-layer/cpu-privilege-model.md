# CPU Privilege Model

## What

Builds the representation of privilege layers — user / kernel / hypervisor / secure world — and checks which components hold which authority, beyond what application-level permissions show.

## Why

Application permission reviews stop at "what can this service's role do" and miss the layer below: the process running as root, the driver in kernel space, the container sharing the host kernel. Privilege-layer analysis catches the authority that app-level checks structurally cannot see — a root-running container is a kernel compromise waiting, whatever its IAM role says.

## When

L8 — for any system where process/container/VM privilege is part of the posture. Pairs with System Call Capability Model (what a process NEEDS vs what its layer gives).

## Protocol

1. Map the execution layers present: secure world (TEE), hypervisor, kernel, user-space (containers/processes).
2. Per component: which layer does it run in, and what does that layer GRANT beyond the component's own permissions? (kernel = everything; root user-space = near-everything)
3. Flag layer-overshoot: components whose layer grants far more than their function needs ("the web server container runs as root").
4. The findings are the overshoots — severity by the layer's power × the component's attack exposure (a root process on an internet-facing port is Critical by construction).
5. Feed the System Call Capability Model for the reduction proposals.

## Evidence gates

- execution layers mapped
- per-component layer + grant recorded
- overshoots flagged with the layer's excess named

## Anti-patterns

- Reviewing IAM without the execution layer (the layer is the bigger grant)
- "Running as root in the container is fine, the container isolates" (the container kernel is shared — the layer is the kernel)
- Mapping layers from the docs (the runtime config shows the real layers — Runtime Drift Detector cross-checks)

## Example

Three components ran as root in containers: the web server (internet-facing — Critical), a worker (internal — High), a cron job (internal — Medium). The layer map exposed all three; the fix (non-root users, dropped capabilities per component) reduced the kernel-exposure surface from three doors to zero — an app-level permission review would have shown three "healthy" services.
