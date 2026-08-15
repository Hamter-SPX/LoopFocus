# Silicon-to-Service Attestation Chain

## What

Builds the full chain: hardware measurement → boot state → OS state → workload identity → service authorization — and finds every place where trust JUMPS without evidence (a layer trusts the next with no proof).

## Why

Attestation is only as continuous as its chain: a measured boot that ends at the OS, with no link from OS to workload to service, protects the first two layers and leaves the rest assumed. The chain makes every handoff explicit — and each unproven jump is where real compromises hide.

## When

L8 — for confidential computing, device fleets, and attested CI. The End-to-End Trust Proof's hardware half.

## The chain walk

```text
hardware measurement (what booted)
  → boot state (what loaded)
    → OS state (what is running)
      → workload identity (which service/process claims to run)
        → service authorization (what that identity may do)
```

## Protocol

1. Walk each hop: what evidence links this layer to the next? (measured boot log → attested OS → attested workload identity → bound credentials.)
2. Per hop, classify: evidenced (the link exists and is verified), assumed (the link is conventional — "the OS is the OS because it booted"), absent.
3. Assumed/absent hops are findings — each is a place where a compromise at one layer silently inherits the next's trust.
4. The chain joins the World Model; the Trust Proof cites it hop by hop.

## Evidence gates

- per-hop link evidence classified
- assumed hops flagged
- the chain recorded as a model artifact

## Anti-patterns

- "Secure boot covers it" when the chain stops at the OS (boot is hop 1 of 5)
- Workload identity from a process name (names are claims, not evidence)
- One attested layer standing in for the whole chain

## Example

Chain walk: measurement ✓ (TPM log), boot ✓ (policy enforced), OS state ✓ (attested), workload identity ✗ (services identified by port number — an assumed hop), authorization ✓. The assumed hop meant any process on the host could claim the workload's port and inherit its rights. Fix: attested workload identities (per-service certificates bound to the measurement). One hop, and the chain went from "mostly attested" to continuous.
