# Device Lifecycle Security

## What

Walks the device's entire life — manufacture → provisioning → enrollment → operation → repair → decommission — and verifies that identity and secrets are managed correctly at EVERY phase, not just during operation.

## Why

Lifecycle leaks are the leaks nobody audits: a secret baked at manufacturing that survives decommission, an identity provisioned at the factory that never gets rotated, a repair path that resets security state, a decommissioned device that still holds valid credentials. Each phase is a door, and the walk checks them all.

## When

L8 — device fleets and hardware products. The Temporal Trust Engine's hardware sibling (lifecycle = time at the device level).

## Per-phase checks

| Phase | Question |
|---|---|
| manufacture | what identity/secret is born here, and is it secret from the factory itself? |
| provisioning | is per-device identity provisioned (not shared across devices)? |
| enrollment | does enrollment verify the device AND the owner? |
| operation | are updates, revocation, and monitoring active through life? |
| repair | does repair reset security state properly (keys rotated, trust re-established)? |
| decommission | is the device's identity revoked and its secrets destroyed — with proof? |

## Protocol

1. Walk the phases in order against the real processes (docs + evidence, not assumptions).
2. Per phase: check identity/secret handling; a phase with shared secrets, unrevoked identities, or unverified resets is a finding with the phase named.
3. Pay special attention to the END: decommissioned devices with live credentials are the quietest backdoors.
4. The lifecycle record joins the World Model (device identities carry their phase).

## Evidence gates

- per-phase verdicts recorded
- end-of-life revocation verified (not assumed)
- findings named by phase

## Anti-patterns

- Auditing only the operation phase (the other five hold the surprises)
- Shared provisioning keys ("we'll rotate later" — later is decommission)
- Repair paths that reset security without re-verification (a repair is a re-enrollment)

## Example

Decommission walk: the retired devices' identities were "revoked" in the admin console but the devices themselves were wiped with a factory reset that re-provisioned them with the SAME shared key — which still worked. The finding (phase: decommission; revocation was cosmetic) closed with real per-device key destruction and proof-of-revocation logs. The walk found it because it went to the end of the life — where most audits never go.
