# Reversible First

## What

With two viable approaches and insufficient data, take the reversible one: the experiment over the migration, the temporary patch over the rewrite, the worktree branch over the in-place edit.

## Why

Autonomous agents are most dangerous at the moment they must choose under uncertainty — the default instinct is the decisive big move. Reversibility inverts the risk equation: a reversible move is cheap to undo, so it converts uncertainty from a hazard into a budget. Irreversible moves cost the same whether they were right or wrong.

## When

- Choosing between approaches with comparable evidence (if one has strong evidence, evidence wins, not reversibility)
- Information Gain Routing's tie-breaker
- Any L4/L5 candidate: the ladder to L5 must cross reversible territory first (see `commitment-levels.md`)

## Protocol

1. For each candidate: what does undo cost? (revert commit? redeploy? data migration back? irreversible data loss?)
2. Insufficient evidence + comparable paths → reversible path first.
3. The reversible path is run as an experiment (L2/L3): declared, bounded, with its removal plan stated upfront.
4. The irreversible path is earned: entered only after the reversible path's evidence supports it, with pre-mortem + checkpoint.

## Evidence gates

- the reversibility comparison recorded when choosing between approaches
- irreversible steps show their earned evidence (reversible predecessor ran)

## Anti-patterns

- Choosing the irreversible path "to save time" (undo time is where the savings evaporate)
- Treating a git commit as reversible when the change is data-destructive (revert restores code, not data)
- Reversible experiments left running without removal plans (an experiment nobody plans to end is a patch)

## Example

Session store fix: options were (a) move the whole session layer to Redis now, (b) add TTL + sweep to the in-memory store. Comparable evidence, (b) reversible → chosen. The TTL fix shipped in hours; the Redis migration became a separate, evidence-backed project later — and was simpler because the TTL design had already proven the boundary semantics.
