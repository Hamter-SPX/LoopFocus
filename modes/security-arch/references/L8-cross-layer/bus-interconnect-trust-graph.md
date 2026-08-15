# Bus & Interconnect Trust Graph

## What

Maps the internal communication fabric — PCIe, SoC interconnects, internal buses, shared memory channels — as security boundaries, with every bus edge labeled by what travels on it and who can listen.

## Why

Interconnects are the invisible network inside the machine: PCIe carries everything between devices, SoC interconnects join every block, and shared-memory channels pass data between trust domains. Security models stop at the network edge and miss the machine-internal network — which is exactly where a compromised device can eavesdrop, inject, or reach across domains.

## When

L8 — for hardware design reviews (Hardware Design Mode) and for server-class threat models where device-to-device trust matters.

## Protocol

1. Enumerate the interconnect topology: which devices/blocks sit on which bus, what shares what channel.
2. Per bus edge: label the data classes that travel on it and the endpoints that can observe it.
3. Check isolation: are sensitive flows on shared channels without protection (encryption, virtualization, or dedicated channels)? (PCIe virtualization, SoC firewall configs.)
4. Flag shared-channel sensitive flows — the finding is the exposure, the fix is channel isolation or encryption.
5. The graph joins the World Model: buses are trust edges with hardware weight.

## Evidence gates

- interconnect topology mapped
- per-edge data classes + observers labeled
- unprotected sensitive flows flagged

## Anti-patterns

- Treating the PCIe bus as trustworthy plumbing (every device on it is an observer)
- Mapping only the main bus and missing the side channels (management buses carry secrets too)
- Assuming SoC-internal means protected (internal = reachable by any compromised block)

## Example

The NIC and the storage controller shared the PCIe fabric with the TPM's SPI channel crossing the same switch — the map showed the management-bus traffic (including boot measurements) visible to any compromised fabric device. Fix: fabric partitioning (separate IOMMU/ACS domains). The finding came from drawing the bus graph — a review that stopped at "the network is encrypted" would never have seen the machine's internal network at all.
