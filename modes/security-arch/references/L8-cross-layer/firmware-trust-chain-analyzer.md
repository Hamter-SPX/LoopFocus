# Firmware Trust Chain Analyzer

## What

Analyzes the boot chain's architectural relationship: ROM → bootloader → firmware → OS → hypervisor — at each stage asking WHY the stage trusts the previous one and HOW that trust is transferred.

## Why

The boot chain is the original trust chain: every later security property inherits from it. A weak transfer at any stage makes everything above it vulnerable regardless of the OS's own quality. The analyzer treats each stage transition as a trust boundary crossing — the same discipline as service boundaries, applied to boot.

## When

L8 — for devices, hosts, and anything with a measurable boot path. The Hardware Root-of-Trust Model supplies the anchors; this analyzer walks the transfers.

## Per-transition questions

| Transition | Question |
|---|---|
| ROM → bootloader | does ROM verify the bootloader's signature? (ROM is the immutable anchor) |
| bootloader → firmware | is firmware measured/verified before execution? |
| firmware → OS | does firmware verify the OS image, or hand control blindly? |
| OS → hypervisor | does the OS attest the hypervisor's integrity (measured launch)? |

## Protocol

1. Extract each stage's actual verification behavior (from firmware docs, config, or measured logs — never assume).
2. Classify per transition: verified (signature/measurement + enforcement), measured-only (logged, not enforced), blind (no verification).
3. Blind or measured-only transitions are findings — the chain's integrity ends where verification ends.
4. Record the chain in the World Model with per-transition verdicts; the End-to-End Trust Proof starts from this chain.

## Evidence gates

- per-transition verification behavior extracted from real artifacts
- chain verdicts recorded (verified/measured-only/blind per transition)
- chain breaks flagged as findings

## Anti-patterns

- "Secure Boot is on" as the whole chain verdict (Secure Boot covers one transition)
- Extracting the chain from marketing docs instead of measured behavior
- Ignoring the firmware update path when analyzing the chain (updates are the chain's weakest door)

## Example

Chain walk: ROM→bootloader verified ✓; bootloader→firmware verified ✓; firmware→OS measured-only ✗ (the measurement existed but nothing enforced it). The finding: the OS could be replaced without detection — every software-layer security claim above it was conditional. Fix: enforcement policy at the transition. One transition, one fix, the whole chain upgraded.
