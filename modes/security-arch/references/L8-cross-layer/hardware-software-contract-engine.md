# Hardware–Software Contract Engine ⭐

## What

Finds the mismatches between what the HARDWARE promises and what the SOFTWARE assumes: hardware says "region A is protected, device B is isolated, boot state C is verified" — software assumes "A is always secret, B is always trustworthy, verified = authorized". The engine hunts every place the two stories disagree.

## Why

The deepest bugs come from correct layers with wrong assumptions BETWEEN them: the hardware protection exists, the software check exists, and the gap — the assumption that one implies the other — is where the compromise lives. These are the bugs no single-layer review can produce, because every layer is right.

## When

L8 — wherever hardware and software share a trust story: boot, TEEs, devices, drivers, confidential computing.

## The hunt (per HW-SW pair)

1. List the hardware's stated guarantees (from docs/specs/measurements).
2. List the software's assumptions about those guarantees (from code comments, design, behavior).
3. Diff them: every assumption without a matching guarantee — or guarantee not used — is a contract violation candidate.
4. Verify each candidate: can the assumption actually be violated given the hardware's real behavior? (The Exploitability Judge applies to contracts too.)

## Protocol

- Extract guarantees and assumptions from real artifacts (specs + code, not memory).
- Record the contract table: guarantee ↔ assumption ↔ match/mismatch.
- Mismatches are findings: "software assumes region A is secret; hardware provides read-protection only" — the missing write-protection is the gap.
- Fix direction: adjust the software's assumption (usually) or strengthen the hardware's guarantee (when the hardware is the weaker side).

## Evidence gates

- guarantee/assumption table per trust story
- mismatches verified (not just spotted)
- contract corrections recorded

## Anti-patterns

- Trusting the software's assumption without reading the hardware's guarantee (the assumption is the unverified half)
- "The hardware vendor handles it" — the contract is between THEIR guarantee and YOUR assumption; nobody else checks it
- Verifying the contract once and never after firmware updates (firmware changes the guarantees)

## Example

Software assumed "the secure element erases the key on tamper detection"; the hardware's guarantee was "the key becomes UNREADABLE until reset" — which, after reset, re-provisioned the key from the factory default the attacker also possessed. The contract mismatch (erase vs lock) meant the assumed protection never existed. The engine's diff found it — two correct layers, one wrong assumption between them, the exact bug class it exists to catch.
