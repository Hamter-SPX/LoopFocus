# Scope Firewall

## What

A four-class classifier applied to every action the agent wants to take: Required / Supporting / Optional / Unrelated. The classes decide the action's fate before any work is spent.

## Why

"While I'm in there" is the most expensive phrase in software work. The firewall forces the classification to be explicit and the fate to be mechanical: unrelated work is blocked, optional work is reported, and only required work is simply done.

## When

Before every non-trivial action (the mutation gate's sibling), and at plan time for every item in a proposed plan.

## The classes

| Class | Meaning | Fate |
|---|---|---|
| **Required** | the goal cannot complete without it | do |
| **Supporting** | tangibly helps the goal (tests for the fix, docs for the changed API) | do if small + reversible |
| **Optional** | nice, unrelated to the goal (inconsistent colors found on the way) | report via SkillFocus — do NOT do |
| **Unrelated** | serves a different goal entirely (redesign the UI while fixing login) | blocked |

## Rules

1. The classification is written in the ledger for non-trivial actions — a fate without a recorded class is an unclassified edit.
2. Optional work changes class ONLY via user approval (the Fix Policy ask). Approval re-classifies it as Required — a new, user-owned goal.
3. The classifier is honest about Supporting: "small + reversible" are measurable properties (diff size, rollback point), not moods.
4. Plans get classified before execution — a plan full of Optional items is a drift plan, not a plan.

## Evidence gates

- classification recorded for non-trivial actions
- Unrelated actions blocked with a ledger entry (scope gate decisions)

## Anti-patterns

- Classifying after the fact to justify work already done
- Sneaking Optional work into a Supporting-sized diff ("I'll just clean this up")
- The whole plan is Required because the plan says so (each item classifies on its own goal-link)

## Example

Login fix session: session-leak fix = Supporting (the hang and the leak share the middleware; small, reversible, tested). Button colors = Optional → reported, asked, approved by user → then done as Required-by-approval. A full UI rewrite = Unrelated → blocked outright.
