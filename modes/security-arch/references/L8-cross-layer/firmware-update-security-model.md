# Firmware Update Security Model

## What

Treats the firmware update path as a security invariant: update authority, signing authority, rollback protection, recovery path, and revocation — each a checkable property of the architecture.

## Why

The update path is the firmware's most powerful door: whoever can push an update owns the device forever. Its security properties (who may sign, can old versions be forced back, what happens when an update fails) decide whether the door is locked or standing open. Modeled as invariants, these properties get checked like any other — instead of being assumed.

## When

L8 — every device/host with updatable firmware.

## The invariants

```text
INV-U1: only the designated signing authority can publish updates
INV-U2: the device rejects unsigned or incorrectly-signed updates
INV-U3: the device cannot be downgraded below the last-known-good security version (anti-rollback)
INV-U4: a failed update leaves a bootable, recoverable state (A/B, recovery image)
INV-U5: a compromised signing key can be revoked, and revocation propagates to devices
```

## Protocol

1. Extract the real update flow (authority, signing, verification on device, rollback counters, recovery).
2. Check each invariant against the flow — a missing anti-rollback counter, an update path without signature verification, a recovery image that was never tested.
3. Violations are findings with the invariant named (INV-U3 violated: no anti-rollback — old vulnerable firmware can be reinstalled).
4. The model feeds the canary system (update-path invariants are prime canary candidates).

## Evidence gates

- update flow extracted from real artifacts
- per-invariant verdicts recorded
- violations named by invariant

## Anti-patterns

- "Updates are signed" as the complete model (signing is INV-U2 of five)
- No recovery story (a bricked device is a security event too — it stops getting updates)
- Anti-rollback checked in the code but not in the update SERVER's policy (both sides must enforce)

## Example

The device verified update signatures ✓ (INV-U2) but had no anti-rollback counter ✗ (INV-U3) — an attacker with an old (signed, vulnerable) firmware image could reinstall it and resurrect the patched bug. The finding came from checking the INVARIANT LIST, not from scanning — the signature check looked fine, and the missing counter was the whole story.
