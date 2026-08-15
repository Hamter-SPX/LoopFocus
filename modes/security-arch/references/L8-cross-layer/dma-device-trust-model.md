# DMA / Device Trust Model

## What

Peripherals — NICs, GPUs, storage controllers, accelerators — are modeled as ACTORS in the trust graph, not trusted by default. The model asks what each device can read, write, and reach.

## Why

Devices bypass the CPU's checks: a DMA-capable NIC reads main memory directly, a storage controller sees every block, a GPU accelerator processes sensitive data. Treating devices as passive furniture leaves the system's widest doors unmodeled — a malicious or compromised device is an attacker with hardware privileges.

## When

L8 — for servers with accelerators/smart NICs, and for any hardware design review (SecurityArch Hardware Design Mode).

## Protocol

1. Enumerate every DMA-capable or data-adjacent device with its bus attachment (which memory it can reach).
2. Per device: what can it read/write (DMA ranges), what does it process (data classes!), and what TRUSTS its output (a NIC's packets flow into the network stack).
3. Apply IOMMU/IO virtualization checks: are DMA ranges actually restricted, or does the device see everything?
4. Flag devices whose reach exceeds their function ("the GPU can DMA all of host memory") — the fix is range restriction (IOMMU domains), the finding is the unrestricted reach.
5. Devices enter the World Model as principals — they hold privileges too.

## Evidence gates

- device inventory with bus/DMA reach
- IOMMU restriction verified (configured, not assumed)
- over-reaching devices flagged

## Anti-patterns

- Modeling the NIC as infrastructure (it is a principal that reads every packet AND can DMA)
- "The GPU needs full access" without checking (GPU drivers need ranges, not everything)
- Skipping devices in cloud (the cloud's devices are virtualized, but their isolation is still a config question)

## Example

The inference GPU: DMA reach = all host memory (no IOMMU domain). Data flow: the GPU processed user PII batches. The model flagged the device's reach × data adjacency — the GPU (or its driver, or its firmware) could read credentials it had no business reading. Fix: IOMMU domain restricting the GPU to its working buffers. The device went from unmodeled furniture to a scoped principal.
