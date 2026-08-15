# Loop Fingerprint

## What

Each attempt gets a compact identity: `files touched + error class + approach + result`. Before executing a new attempt, its expected fingerprint is compared against failed ones. A near-identical match is a retry — blocked.

## Why

Agents reword their way around rules: the Repeat Gate says "no retrying the failed approach", so the next attempt is "the same approach, but now with a config flag". The fingerprint catches what the wording hides — identity of action, not identity of prose.

## When

Before every EXECUTE (the fingerprint is computed from the planned action), and recorded after OBSERVE (with the actual result).

## Fingerprint shape

```text
fingerprint: files=<touched> error=<failure-class> approach=<strategy-family> result=<fail|partial|success>
```

- **files** — the edit's target set, not every file read
- **error** — the stable failure class (normalize-signal's `failure_class`), not the exact message
- **approach** — the strategy family name (the genome's `strategy` field)

## Protocol

1. Before executing: write the planned fingerprint in the ledger.
2. Compare against failed attempts in the genome (same problem class).
3. Match on 2 of 3 fields (files+approach, or error+approach) → repeat gate BLOCKS; a genuinely new hypothesis or new evidence must exist to proceed.
4. After observing: record the actual fingerprint; near-duplicate of a previous failure strengthens the ban.

## Evidence gates

- planned + actual fingerprints in the ledger for every non-trivial attempt
- blocked retries visible as gate decisions (repeat gate entries)

## Machine check

```bash
node scripts/loop-genome.js query --class <problem-class>
# attempts list: strategy + reason per attempt — compare before re-executing
```

## Anti-patterns

- Fingerprinting by error message text (messages change wording; the class does not)
- Declaring a retry "new" because the variable names changed
- Computing the fingerprint after the attempt succeeded (it exists to block BEFORE)

## Example

Attempt 1: `files=index.js error=greeting-undefined approach=caller-patch → fail`.
Attempt 2 planned: `files=index.js error=greeting-undefined approach=caller-patch` — match on all three → blocked before execution. The blocked retry became the S4 dependency inspection that found the export typo.
