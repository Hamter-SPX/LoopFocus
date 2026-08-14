# Recovery Flow

**Why:** after context loss or a crash, the natural reflex is to redo — the expensive mistake. This flow makes resuming cheaper than restarting.

**When:** context reset, agent crash, picking up someone else's half-done work, returning to a task after a long gap.

## Steps

1. **READ BEFORE ACTING** — `.loopfocus/state.md` first: goal, DONE, PROVEN, UNKNOWN, NEXT. Then ledger (attempts, failures), genome (banned strategies, winner), gates.conf, `git log` (checkpoints).
2. **Cross-check state against reality** — is the state file true? `git status`, run the last evidence command, spot-check the claimed fixes exist. Trust but verify: a state file is a claim too.
3. **Restore the capsule** — if state is missing/stale: rebuild what is recoverable from git log + artifacts, and record the reconstruction.
4. **RESUME at NEXT** — continue from the recorded next action. Do not re-diagnose what PROVEN covers.
5. **Handoff-aware resume** — if the previous agent left for a reason (budget, escalation), read that reason before continuing. Respect it unless new evidence refutes it.
6. **Record the resume** — ledger entry: `resumed from checkpoint <hash> | verified: <what was re-checked>`.

## Evidence gates

- state.md read before the first action
- at least one cross-check of the recorded state against the real workspace
- resume entry in the ledger

## Anti-patterns

- Starting from the prompt alone because "reading files takes time"
- Trusting the state file without checking it against the repo
- Redoing PROVEN work "to be sure"
- Continuing past a recorded escalation without new evidence
