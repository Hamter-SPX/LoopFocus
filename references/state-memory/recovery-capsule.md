# Recovery Capsule

## What

The minimum a fresh agent needs to continue without redoing work: state.md + ledger.md + genome.json + gates.conf + the last commit hash. Small enough to read in one pass, complete enough to resume.

## Why

After a crash, the replacement agent's behavior is binary: read the capsule and resume, or read nothing and restart. The capsule wins the binary by being findable, small, and self-explanatory — everything else is the failure S3 RED demonstrated.

## Where

`.loopfocus/` inside the repo (per-project) or `~/.loopfocus/` (global). The repo location survives workspace changes; the global location survives repo absence.

## The capsule contents

| File | Answers |
|---|---|
| state.md | what was the goal, what is done, proven, unknown, next |
| ledger.md | what was tried, why, what actually happened |
| genome.json | which strategies failed/banned/won for this problem class |
| gates.conf | what the project's tool commands are |
| last commit hash | where the rollback ladder lives |

## Rules

1. Kept current incrementally (the capsule is written by the Checkpoint Brain, not assembled at the end).
2. Machine-readable where machines read it (UNKNOWN:/NEXT: formats, genome schema).
3. A recovery that finds the capsule stale (older than the workspace state) rebuilds it from git log + artifacts and records the reconstruction — then continues.

## Evidence gates

- capsule files present and current (evidence-freshness gate covers the state side)
- a resumed agent's first ledger entry: `resumed from checkpoint <hash> | verified: <cross-checks>`

## Anti-patterns

- A capsule that requires the conversation history to understand ("see above")
- Capsule files written in formats the machines cannot parse
- Building the capsule during the crash (it must exist before the crash — that's the point)
