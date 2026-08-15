# Goal Decomposition Guard

## What

The guard against task-tree fetishism: decomposition exists to complete the goal, not to become the work. Every node classifies as Necessary / Helpful / Optional / Noise — and Noise gets deleted.

## Why

Agents over-decompose: the tree grows until managing the tree is the task. Forty tracked subtasks for a two-hour fix is not diligence — it is procrastination with boxes. The guard keeps decomposition a tool of the goal: if deleting a node changes nothing about completion, the node was Noise.

## When

- Plan time (before the tree is built — and again after, as an audit)
- Whenever a tree node has spawned sub-nodes that outnumber its work
- At loop boundaries (a growing tree with flat delta is the entropy signal wearing a planner's mask)

## The classification

| Class | Meaning | Fate |
|---|---|---|
| Necessary | goal cannot complete without it | keep, do |
| Helpful | makes completion cheaper/safer | keep if cheap |
| Optional | nice, unrelated | SkillFocus report |
| Noise | neither helps nor reports | delete |

## Rules

1. The YAGNI principle at agent level: every node must carry a goal-link or be deleted. "Good to track" is not a goal-link.
2. A node whose work is entirely "tracking another node" is Noise by definition.
3. The tree is audited at the same cadence as the ledger — a tree that never shrinks is evidence of drift, recorded as such.

## Evidence gates

- the decomposition audit visible (classification recorded at plan time)
- deleted nodes recorded (what was deleted and why — a deletion is a decision)

## Anti-patterns

- A tree with 30 nodes for a task whose cause is one line
- Nodes that exist to be checked off (completion theater)
- Decomposing instead of doing when the goal is already clear (see Effort Elasticity: light tasks, light plans)

## Example

Refund bug plan (RED S2, no skill): "1. Understand window logic, 2. Review constants, 3. Check day math, 4. Consider grace periods…" — twelve investigative nodes, three reworded attempts. With the guard: Necessary = [reproduce, find cause, fix, verify]. The tree shrank to four nodes and the loops went to the dependency inspection instead of the tree.
