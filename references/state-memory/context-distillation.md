# Context Distillation

## What

When context grows large, distill it into the pinned "Current Truth" — a four-line block that replaces re-reading history — instead of summarizing everything.

## Why

Long tasks drown the goal in their own history: the loop remembers 40 steps ago better than the objective. Distillation restores the hierarchy: the four lines that matter stay pinned, the noise stays in the files. A summary that keeps everything distills nothing — the discipline is compression with judgment, not transcription.

## When

- When the context feels long (the subjective threshold: you are re-reading to remember the goal)
- Before checkpoints (the distilled truth becomes the state file's header)
- At handoffs (the receiver gets the distillation, not the transcript)

## The Current Truth block (pinned in state.md)

```text
MISSION:        <one line — what we are doing>
MUST PRESERVE:  <the invariants, short>
CURRENT BLOCKER: <the one thing in the way>
NEXT PROOF:     <the next discriminating test>
```

## Rules

1. Four lines, forced brevity. A fifth line means the distillation failed.
2. CURRENT BLOCKER is singular — one thing. Two blockers is a plan problem (Critical Path Engine), not a distillation problem.
3. NEXT PROOF is actionable — the very next discriminating action, not "keep working".
4. Distill at checkpoints; re-read the block at every loop start. The block is the anti-forgetting device.

## Evidence gates

- the block present and current in state.md
- loops start from the block (the first action matches NEXT PROOF or an explanation why not)

## Anti-patterns

- Distilling by writing longer prose (the block is four lines)
- A MISSION line that drifted from the locked goal (distillation re-states the goal, never re-writes it)
- Distilling so rarely the block is itself stale (stale truth is worse than none)
