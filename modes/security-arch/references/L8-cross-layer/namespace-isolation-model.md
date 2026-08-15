# Namespace / Isolation Model

## What

Verifies that the isolation boundaries the system CLAIMS — container, process, user, network, mount — are REAL boundaries (kernel-enforced) and not logical conventions (agreements in config).

## Why

Isolation is the backbone of multi-tenant and containerized security, and most claims are softer than they sound: containers share the kernel, mount namespaces have their escapes, user namespaces have their own history, network namespaces can be misconfigured into one flat space. The model checks what the boundary actually enforces, not what the YAML says.

## When

L8 — for containerized deployments, multi-tenant hosts, sandboxed runtimes.

## Per-boundary check

| Boundary | The real question |
|---|---|
| container | which namespaces are actually unshared? what kernel surface is shared anyway? |
| user | is the UID mapping real (user namespace) or a label on the same root? |
| network | is the namespace actually isolated, or just firewalled (same stack, filtered)? |
| mount | are the mount points actually private, or shared with the host? |
| process | does the container see the host's processes, or its own PID space? |

## Protocol

1. Enumerate the claimed boundaries per workload (from the deployment configs).
2. Verify each against the runtime reality (namespaces in use, mappings, actual sharing — the Runtime Drift Detector cross-checks).
3. Classify: enforced (kernel-level), convention (config-level agreement), claimed-but-absent.
4. Convention/absent boundaries on security-relevant separations are findings — the boundary is where the claim is, not where the config says.

## Evidence gates

- claimed boundaries enumerated
- runtime verification per boundary
- convention-level boundaries flagged on security-relevant separations

## Anti-patterns

- "It's in a container, so it's isolated" (containers isolate specific namespaces, not everything)
- Checking the config and not the runtime (the config is the claim; the runtime is the truth)
- One strong boundary (network) standing in for all of them (mounts and users matter equally)

## Example

The "isolated" tenant container: network namespace real ✓, PID namespace real ✓, user mapping — root inside the container mapped to root OUTSIDE ✗, mount namespace partially shared with the host ✗. Two real boundaries, two conventions. The model's verdict: "isolation for network, not for privilege or filesystem" — which reframed the tenant's threat model honestly, and the fixes (user namespaces + private mounts) followed the verdict.
