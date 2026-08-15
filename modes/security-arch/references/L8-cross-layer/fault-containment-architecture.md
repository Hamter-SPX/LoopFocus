# Fault Containment Architecture

## What

Measures how well the system limits the blast of a MISBEHAVING subsystem — a faulty CPU core, a wild device, a crashing driver — so one fault does not become a system-wide failure (or a security event).

## Why

Faults and attacks share a shape: a component doing the wrong thing. Containment is what decides whether a faulty NIC driver crashes the kernel (and everything with it) or loses only its own domain. In security terms, containment is the difference between "one compromised driver" and "the whole host". Designs that skip containment are one fault away from total compromise.

## When

L8 — for OS/hypervisor level review and hardware design mode.

## Protocol

1. Enumerate the failure domains: what can each subsystem take down with it (driver → kernel → all processes? service → its dependents? device → the bus?).
2. Check the containment mechanisms: driver isolation (userspace drivers, microkernel-ish boundaries), device isolation (IOMMU), service isolation (per-service blast radius from the Blast-Radius Engine).
3. Flag uncontained domains: any subsystem whose fault radius includes security-relevant components.
4. The finding is the missing containment; the fix is the boundary (move the driver out of the kernel, isolate the device, split the service).

## Evidence gates

- failure domains enumerated per subsystem
- containment mechanisms verified (present + enforced)
- uncontained security-relevant radii flagged

## Anti-patterns

- Treating fault containment as a reliability topic (a crashing driver that crashes the kernel is a security finding too)
- Assuming the hypervisor contains everything (containment is configured, not automatic)
- Measuring containment only for hardware (software subsystems have fault radii too)

## Example

The storage driver ran in the kernel with DMA to all memory — its fault radius was the whole host, including the attestation service. Containment flags: driver isolation absent (kernel), device isolation weak (DMA unrestricted). The fix (userspace driver + IOMMU domain) shrunk the radius to the driver's own process — a faulty or malicious driver could no longer take the host, or the keys, with it.
