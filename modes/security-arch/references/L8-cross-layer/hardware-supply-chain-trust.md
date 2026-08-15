# Hardware Supply-Chain Trust

## What

Pulls hardware provenance into the SAME dependency graph as software: firmware images, FPGA bitstreams, board components, secure elements — each a node with origin, integrity, and manufacturing provenance.

## Why

Software supply chains get all the attention while the hardware chain — the thing software runs ON — goes unaudited. A firmware backdoor or a substituted component undermines every software defense above it. The hardware chain is the root of the trust tree; when it is untrusted, nothing built on it is trustworthy.

## When

L8 — for device products and for hosting/cloud hardware trust questions. The Supply-Chain Provenance Engine's hardware sibling.

## The nodes and their questions

| Node | Provenance question |
|---|---|
| firmware image | signed by whom? verifiable against the silicon root? |
| FPGA bitstream | encrypted/authenticated? who holds the key? |
| board components | sourced from whom? substitution-resistant (physical verification)? |
| secure element | provisioned by whom? can its identity be cloned? |
| manufacturing | does the produced device match the design (measured, attested)? |

## Protocol

1. Enumerate hardware nodes with their origins (vendor, fab, provisioning party).
2. Per node: verify integrity mechanisms (signatures, encryption, physical checks) and who holds the corresponding keys.
3. Draw the edges into the Dependency Trust Graph (hardware → firmware → OS → app).
4. Flag undocumented or unverifiable provenance on nodes whose compromise cascades (firmware is the classic — it sees everything).
5. Record provenance in the World Model with the same evidence bar as software nodes.

## Evidence gates

- hardware nodes enumerated with origins
- integrity mechanisms + key holders recorded
- unverifiable high-cascade nodes flagged

## Anti-patterns

- Auditing the software chain while the firmware chain is trusted by default (the firmware is the FIRST software)
- "Our vendor handles security" without the vendor's provenance (the vendor's chain is your chain)
- Treating manufacturing as outside the trust model (the produced device IS the trust model's root)

## Example

The device's firmware updates were signed by a key generated in the vendor's build system — whose CI credentials had no protection against insider modification. The provenance walk: firmware node → signing key → build CI → (undocumented). Finding: the root signing path's provenance was unverifiable — the highest-cascade node in the product had the weakest chain. Fix: hardware-backed signing (HSM in a separate access domain) — the chain's root finally had a verifiable origin.
