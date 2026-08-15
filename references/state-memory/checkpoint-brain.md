# Checkpoint Brain

## What

Every milestone writes the four-part state: DONE / PROVEN / UNKNOWN / NEXT — plus small frequent commits. A new agent or fresh context resumes from this file, not from scratch.

## Why

Context loss is the environment, not the exception. The checkpoint brain is the insurance policy: the state file is the memory that survives compaction, crashes, and handoffs. Baseline testing (RED 2026-08-15, S3) proved the cost of its absence: the second agent re-diagnosed and re-implemented work the first had finished.

## When

- At every milestone: lock, root cause found, fix landed, gate passed, completion
- Before any risky/structural edit (checkpoint gate requires it)
- Before the context grows past what one pass can hold (distill, then checkpoint)

## Format

```text
goal: <locked>
DONE:    <finished>
PROVEN:  <verified, with evidence paths>
UNKNOWN: <still open>    (ends with: UNKNOWN: none)
NEXT:    <next action>   (ends with: NEXT: none|done)
```

## Rules

1. Written incrementally — the trail, not the tombstone. A state file written only at the end certifies nothing about the journey.
2. The verify script parses UNKNOWN:/NEXT: — the format is a machine contract, not a diary.
3. Commits are checkpoints too: small and often, each a rollback point the branch can return to.
4. PROVEN entries carry evidence paths — a claim without its artifact is a guess.

## Evidence gates

- state.md exists before the first edit (entry gate)
- milestone updates visible in the file history (git log on .loopfocus/state.md)

## Machine check

```bash
bash scripts/loopfocus-verify.sh   # parses UNKNOWN:/NEXT:
```

## Anti-patterns

- "I'll write the state at the end" (that's a report, not a checkpoint)
- PROVEN entries without evidence paths
- State written in prose that the machine checks cannot parse (the S4 GREEN agent caught this exact evasion and self-rejected)
