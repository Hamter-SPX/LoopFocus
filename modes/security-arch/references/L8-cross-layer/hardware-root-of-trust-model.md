# Hardware Root-of-Trust Model

## What

Maps the hardware trust anchors — TPM, Secure Enclave, HSM, Secure Boot, Measured Boot, attestation — and traces where the SOFTWARE chain actually anchors its trust into hardware (or fails to).

## Why

Every software trust chain rests on something; without hardware anchoring, it rests on the first compromised piece of software. The model verifies the anchor exists, is used, and is used CORRECTLY — a system with a TPM that never measures anything has a hardware anchor in name only.

## When

L8 — for systems where the question "how do we know the software that booted is the software we built" matters: production hosts, mobile apps, devices, CI runners.

## Protocol

1. Inventory the hardware anchors present (per device class).
2. Trace the boot/measurement chain: what measures what, where the measurements go, who verifies them (Silicon-to-Service Attestation Chain consumes this).
3. Check USAGE: an anchor present but unused, or used without verification, is a finding ("TPM exists; no measured boot policy").
4. Identify the trust boundary the anchor protects: what does the anchor's compromise cost? (An HSM holding the root key is the crown jewel of hardware.)
5. Record the anchor map in the World Model — hardware anchors are trust edges with extra weight.

## Evidence gates

- anchors inventoried per device class
- measurement chain traced with verification points
- unused anchors flagged (presence ≠ protection)

## Anti-patterns

- "We have a TPM" as the verdict without the measurement chain
- Anchoring trust in software while hardware anchors sit idle (the software anchor is the weaker one)
- Modeling hardware anchors without the attack on them (an HSM is a component with an attack surface too — Security Control Attack Surface applies)

## Example

The CI runner fleet: Secure Boot enabled (anchor present) but the measured-boot policy logged to nowhere and nothing verified the log. Verdict: anchor unused. The fix (remote attestation of runner state before jobs run) anchored the pipeline's trust in hardware for the first time — the difference between "secure boot is on" and "we can prove what booted".
