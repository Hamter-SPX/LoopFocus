# Definition-of-Done Graph

## What

The completion conditions written as a chain that must be true IN ORDER: `feature works → tests pass → no regression → verify → done`. Not a checklist of tasks — a graph of truths. Incomplete chain = not done.

## Why

A task list measures activity; a DoD graph measures completion. The difference is the order: "tests pass" before "no regression" is meaningless — regression is the test of the tests. The chain encodes the logic of done, so no step can be skipped by enthusiasm or exhaustion.

## When

- M4 Build Mode: mandatory, written into `.loopfocus/dod.md` at LOCK
- Bug fixes: inline in state.md (the chain may be short, never absent)
- Any task the user or agent might be tempted to declare "finished"

## Format

```text
feature works    ← <command that proves the required behavior>
tests pass       ← <test command>
no regression    ← <regression check / gate-runner>
verify           ← bash scripts/loopfocus-verify.sh
done             ← all above true + user questions answered
```

## Rules

1. Written at the START (it guides the work; written at the end it only justifies it).
2. Every node has its evidence command. A node without a command is a wish.
3. Nodes are checked in order. A later node green with an earlier node red is a lying chain — the earlier node's failure invalidates the later evidence (a test that "passes" while the feature does not work is testing the wrong thing).
4. "Done" includes the user-facing obligations: questions asked, decisions surfaced. A technically complete chain with an unasked user decision is still not done.

## Evidence gates

- chain exists at LOCK with commands per node
- final report walks the chain node by node with results

## Machine check

```bash
bash scripts/gate-runner.sh        # machine nodes: test, regression, completion
bash scripts/loopfocus-verify.sh   # the verify node
```

## Anti-patterns

- Writing the chain after the feature to justify it
- "No regression" checked by re-running only the new tests
- Declaring done while a node's command was never run (SKIP ≠ PASS)
