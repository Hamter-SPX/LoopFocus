# State & Memory

Context loss is normal, not an emergency. These disciplines make the work survive it.

## Checkpoint Brain

Every milestone writes `.loopfocus/state.md`:

```text
goal: <locked>
DONE:    <finished>
PROVEN:  <verified, with evidence paths>
UNKNOWN: <still open>  (must end with: UNKNOWN: none)
NEXT:    <next action> (must end with: NEXT: none|done)
```

Plus: commit small and often — git history is a rollback ladder. A new agent or fresh context reads state.md FIRST, before doing anything.

## Recovery Capsule

The capsule is the minimum a fresh agent needs to continue without redoing work: state.md + ledger.md + genome.json + gates.conf + the last commit hash. Nothing more is needed to resume. Keep it small enough to read in one pass. The capsule lives in `.loopfocus/` (per repo) or `~/.loopfocus/` (global).

## Branch-and-Recover

Competing approaches run as branches — git worktrees:

```bash
node scripts/git-state.js worktree-new attempt-b
```

Attempt A, B, C each in an isolated worktree; results are compared against the same evidence bar; the winner is brought back, the losers are removed. A broken branch is discarded by returning to its checkpoint — no progress elsewhere is touched. The genome records which family won for the problem class.

## Handoff Protocol

Handing work to another agent, skill, model, or human is a package, not a prompt:

1. locked goal + invariants (state.md),
2. constraint hierarchy (hard constraints first),
3. attempts so far and their fingerprints (genome),
4. failures and their evidence (ledger + failure memory),
5. current evidence paths (test reports, logs, screenshots),
6. what is being asked of the receiver.

A short prompt with none of this transfers the context-loss problem to someone else.

## Failure Memory

Failures are knowledge. Every failed attempt is in the genome with its reason. Before starting a task, query the failure memory for the problem class: what failed, why, and which families are banned. The memory prevents both re-invention and repetition. A failure nobody reads is a failure that will happen again.

## Loop Genome

The evolution history per problem class:

```
attempt 1: Hypothesis A      → fail: reason X
attempt 2: A + modification  → fail: same X   → family A banned
attempt 3: Hypothesis B      → partial +32%
attempt 4: B.2               → +18%
attempt 5: B.3               → goal reached
```

Next time the problem class appears, the winner family starts first. The genome auto-bans a strategy after 2 fails / 0 successes — the machine arm of Loop Mutation. Query before starting; record after every attempt.

## Decision Ledger (persistence side)

Important decisions live in the genome/ledger with their reasons — architecture picks, strategy families, scope rulings. Reversals require a new recorded reason. See `references/reasoning-discipline.md`.

## Anti-patterns

- State file written at the END only (it must be the trail, not the tombstone)
- Handing off with "look at the conversation history"
- Deleting a failed worktree without recording why it failed
- Starting a new task without querying the genome for its problem class
- A state file that says UNKNOWN: none while a known blocker sits in the chat log
