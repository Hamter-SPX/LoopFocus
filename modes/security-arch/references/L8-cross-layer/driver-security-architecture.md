# Driver Security Architecture

## What

Audits drivers as the privileged components they are: which drivers hold high authority, which are attack-facing (reachable by untrusted input), and whether those two sets overlap.

## Why

Drivers are the kernel's attack surface with the kernel's privileges: a network driver parses attacker-shaped packets with ring-0 authority. The overlap between "high privilege" and "attack-facing" is the system's most dangerous region — and most reviews never intersect the two sets. The architecture does exactly that intersection.

## When

L8 — hosts with third-party drivers, device products, and any kernel-adjacent surface.

## Protocol

1. Enumerate drivers with their authority: memory access, DMA, device control, kernel hooks.
2. Classify each by input source: attack-facing (network, USB, files from untrusted), internal (trusted hardware paths).
3. Compute the intersection: attack-facing + high-authority drivers — these are the priority findings.
4. Per finding: the mitigation (userspace driver, IOMMU scoping, input validation hardening, vendor update policy).
5. Record the driver map in the Kernel Trust Graph (drivers are its most privileged nodes).

## Evidence gates

- driver inventory with authority + input classification
- the dangerous intersection computed
- mitigations named per overlapping driver

## Anti-patterns

- Reviewing drivers only when a CVE appears (the intersection is computable NOW)
- "The vendor handles driver security" (the vendor's driver runs in YOUR kernel)
- Missing virtual drivers (hypervisor paravirt drivers are drivers too)

## Example

Driver census: NIC driver (network input = attack-facing, DMA + kernel = high authority) → intersection hit. GPU driver (internal input, high authority) → no hit. USB serial driver (attack-facing via physical port, moderate authority) → hit. Two intersection drivers named; the NIC driver's mitigations (IOMMU domain + input validation hardening) became the top host-hardening items — prioritized by the intersection, not by CVEs.
