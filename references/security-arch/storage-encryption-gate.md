# Storage / Encryption Gate

## What

Audits every data store and every encryption use: what is stored, where, encrypted or not — at rest, in transit, and in backups — and who holds the keys.

## Why

Encryption claims fail in specific, boring ways: encrypted at rest but the backup is plaintext; encrypted in transit but logged before encryption; AES-256 with the key in the same repo. The gate checks the whole storage chain, because a chain with one weak link stores plaintext in disguise.

## When

After the Data Flow Security trace (it identifies the storage hops) and the Architecture Mapper (it identifies the stores).

## Protocol

1. Enumerate stores: DBs, caches, files, backups, logs-as-storage, client-side storage (cookies/localStorage).
2. Per store: what classes of data land there (from the data flow trace), is it encrypted at rest, and who can read the ciphertext AND the keys?
3. Key management: where do keys live, who can rotate them, is there a separation between data location and key location (same repo/same host = no protection)?
4. Backups and replicas: a store's encryption must extend to its copies — a plaintext backup is a plaintext breach waiting.
5. Per-store verdicts recorded; unencrypted sensitive data is a finding with the store named.

## Evidence gates

- per-store encryption + key-location verdicts
- backups/replicas covered, not just the primary store
- key-management paths recorded (rotation is part of the verdict)

## Anti-patterns

- "Encrypted at rest" without naming the algorithm, the mode, and the key's location
- Checking the primary DB and forgetting backups, caches, and logs
- Treating client-side storage as safe because "only the user can read it" (any XSS reads it too)

## Example

Sessions in an in-memory Map (no encryption, no expiry) + user table with plaintext passwords compared in SQL. The gate's verdicts: session store — unencrypted but short-lived by design (weak: no expiry existed until fixed); password storage — plaintext comparison (F8 Medium, because the SQLi finding already guaranteed exfiltration; the gate graded the compounding, not the headline).
