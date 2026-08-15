# Objective Compression

## What

For tasks with large requirement sets, compress the objective into the pinned four-line block: MISSION / MUST PRESERVE / CURRENT BLOCKER / NEXT PROOF — and pin it in context permanently.

## Why

The 100-requirement task loses to its own requirements: the agent forgets the objective while servicing the list. Compression restores the hierarchy of the work — the four lines that define success sit above everything else, and the long list stays where it belongs: in the files, consulted when relevant, never held in working memory.

## When

- Large/long tasks at LOCK
- Whenever the requirement surface grows beyond one screen (the subjective threshold: requirements you cannot all recall are requirements that need compressing)
- M4 Build Mode (the DoD graph and the block are siblings: the block says what, the graph says how-we-know)

## The block

```text
MISSION:        Ship authentication migration.
MUST PRESERVE:  existing users, API compatibility, no forced logout
CURRENT BLOCKER: token refresh mismatch
NEXT PROOF:     refresh succeeds against the migrated backend
```

## Rules

1. Every loop starts by re-reading the block. The block is the anti-forgetting device; skipping the read defeats it.
2. MUST PRESERVE is the compressed Constraint Hierarchy's Hard tier — everything the user would veto losing, in one line.
3. The block updates only when the goal or blockers change (re-lock rules apply — goal changes are user decisions; blocker changes are observations).
4. The full requirement list remains the source of truth; the block is its index, never its replacement. Block and list can disagree — and when they do, the Context Conflict Resolver runs.

## Evidence gates

- block present at LOCK for large tasks
- loop starts reference the block (visible in ledger entries)

## Anti-patterns

- Compressing by truncating (losing MUST PRESERVE items to fit the line)
- A block that never changes across a long task (blockers move; a static block is stale truth)
- Consulting only the block and never the full list when implementing details
