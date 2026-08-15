# Handoff Protocol

## What

Handing work to another agent, skill, model, or human is a package of six things — never a bare prompt. The package transfers the work; a bare prompt transfers the problem.

## Why

Every handoff is a context reset by choice. Sending a short prompt to the next agent re-creates the S3 failure voluntarily: the receiver re-diagnoses, re-walks dead paths, re-makes decisions. The package makes the receiver start where the sender stopped.

## When

- Any transition: agent → agent, session → session, agent → human, human → agent
- Subagent dispatch (implementer, reviewer, auditor)
- Escalations (S6 packages the evidence; escalation without the package is abandonment)

## The six-part package

1. **locked goal + invariants** — from state.md
2. **constraint hierarchy** — hard constraints first
3. **attempts and fingerprints** — from the genome
4. **failures and evidence** — from the ledger + failure memory, with artifact paths
5. **current evidence paths** — test reports, logs, screenshots, gate outputs
6. **what is being asked of the receiver** — the specific request, not "continue this"

## Rules

1. The package is written (file), not summarized in prose — a summary is a lossy handoff.
2. The receiver's first act is the Recovery Flow: read the capsule, cross-check against reality, resume at NEXT.
3. Handing off with "see the conversation history" is a handoff failure — the history is not the package.

## Evidence gates

- package files referenced in the handoff message
- receiver's resume entry in the ledger

## Anti-patterns

- "Continue the work" as the entire handoff
- Omitting the failures (the receiver needs the dead paths more than the successes)
- Handing off mid-loop without the loop's fingerprint (the receiver re-enters a banned family)
