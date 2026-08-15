# SecurityArch Hardware Design Mode

## What

A specialized sub-mode for designing/auditing HARDWARE itself: CPU, SoC, FPGA, memory controller, bus, I/O, secure element, firmware, board-level trust — producing the hardware security maps and governance, without becoming an attack manual.

## Why

The user's roadmap includes hardware, and hardware security has its own objects (clock/reset domains, memory access graphs, debug paths, boot ROMs) that software-only analysis cannot express. The sub-mode speaks the hardware vocabulary while keeping SecurityArch's discipline: maps, invariants, evidence, judges.

## When

Triggered for hardware design review, SoC architecture, FPGA security, firmware architecture, board design.

## The deliverables (walked in order)

| Map | What it captures |
|---|---|
| Asset Map | what the hardware protects (keys, firmware, data paths) |
| Privilege Domains | CPU privilege levels, secure/normal world, bus masters |
| Hardware Trust Boundaries | which blocks trust which, at the gate level |
| Clock/Reset Domains | which domains can be independently reset (fault containment's hardware form) |
| Memory Access Graph | who can read/write which region (bus masters → memories) |
| Device Authority Graph | which devices hold DMA/bus-master rights |
| Boot Trust Chain | ROM → stages, with verification per stage (Firmware Trust Chain) |
| Firmware Authority | who can sign/update, rollback protection |
| Debug Interface Policy | **the governance crown**: debug/test paths exist ONLY for their lifecycle phase (manufacturing, development) — gated, logged, and provably closed in production |

## Debug Interface Governance (the hard rule)

Debug interfaces are the hardware's most dangerous doors: JTAG, test pads, firmware backdoors. The policy requires, per interface: which lifecycle phase it serves, how it is gated (fuses, authentication), and EVIDENCE that production units have it closed. An open debug path on a production device is a Critical finding by construction — no exploitation demo required.

## Evidence gates

- all nine deliverables recorded per design
- debug interfaces gated with lifecycle evidence
- claims anchored to the design artifacts

## Anti-patterns

- Skipping the debug governance "because it's standard practice" (standard practice is where the backdoors are)
- Hardware review without the memory access graph (the graph IS the hardware's privilege model)
- Producing the maps but never checking them against the firmware's assumptions (the HW-SW Contract Engine runs on exactly this)

## Example

Design review: the SoC's debug port was "disabled by default in production fuses" — the policy check asked for evidence: the fuse map showed the debug-enable fuse was set in the SAME batch as production units. Finding: the governance claim and the fuse reality disagreed (HW-SW contract mismatch, hardware flavor). The fix (fuse split between dev and prod batches) came from the policy's evidence demand, not from a vulnerability report.
