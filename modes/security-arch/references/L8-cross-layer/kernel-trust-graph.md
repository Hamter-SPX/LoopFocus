# Kernel Trust Graph

## What

Makes kernel-space actors first-class security objects: drivers, syscall boundaries, kernel extensions, privileged daemons, and the IPC between them — each with privileges, callers, and blast radius.

## Why

Kernel space is where the real authority lives, and most audits treat it as a black box ("the kernel is the kernel"). The graph opens the box: a driver with full memory access, a privileged daemon every userland process can message, a syscall boundary that is the ONLY line between untrusted code and everything. These are the system's highest-value edges — and they are modelable like any others.

## When

L8 — for hosts, containers (which share the kernel), and any security posture that depends on kernel integrity.

## Protocol

1. Enumerate kernel-space actors: drivers, modules, privileged daemons, kernel extensions.
2. Per actor: privileges (memory, devices, syscall authority), who can invoke it (callers), what it touches (blast radius).
3. Draw the edges: userland → syscall boundary → kernel services; drivers ↔ devices; daemons ↔ processes.
4. Flag the dangerous edges: unprivileged processes reaching privileged daemons, drivers with more access than their function, modules from unverified sources.
5. The graph joins the World Model — kernel actors are principals with the highest weight.

## Evidence gates

- kernel actors enumerated with privileges
- call-reach edges drawn
- dangerous edges flagged

## Anti-patterns

- "Kernel = trusted" as a modeling shortcut (the kernel's ACTORS have edges; model them)
- Missing the privileged daemons (they run as root and talk to everyone — first-class attack surface)
- Skipping the syscall boundary (it is the single most important edge in the system)

## Example

The privileged metrics daemon: root, reachable by every process via a unix socket, with a parsing bug in its message handler. The graph drew the edge (any-process → root-daemon → full memory) — the classic kernel-adjacent escalation path that userland-only reviews never see. Fix: daemon re-scoped (non-root, filtered callers, safer parser). One graph edge summarized the entire risk.
