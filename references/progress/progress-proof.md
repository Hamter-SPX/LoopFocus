# Progress Proof

## What

The rule that binds the word "progress" to evidence. Claims without measurements are rejected on sight; only counts, outputs, and confirmed hypotheses count.

## Why

"Making good progress" is the most repeated falsehood in agent sessions — it is unfalsifiable, so it survives any inspection, and it feels true while the loop is dead. The rule makes progress claims falsifiable by construction: no number, no claim.

## When

- Every report, status line, or completion claim
- Every MEASURE state (the signal carries the numbers; the rule enforces they exist)
- When tempted to say "close" — close is a claim; the number either exists or it does not

## What counts as proof

- failing tests 14 → 3 (both numbers, same suite)
- compile errors 8 → 0
- affected files shrinking in the diff
- a hypothesis refuted or confirmed by a discriminating test (information gain)

## What never counts

- commands run, files read, edits made
- "understanding" without a changed hypothesis
- feelings of closeness, smoothness of the loop, effort

## Protocol

1. Progress statements cite the measurement inline: "tests 14→3 (suite X, commit Y)".
2. No measurement → the statement becomes a hypothesis or disappears.
3. Reports separate activity ("what I did") from progress ("what changed") — the two sections are different things.

## Evidence gates

- every progress claim in a report carries numbers or a confirmed/refuted hypothesis
- activity never substitutes for progress in the completion report

## Anti-patterns

- "Significant progress" as a complete sentence
- One metric improving while another silently regresses (that's the Regression Sentinel's catch, not proof of progress)
- Citing a green run as progress when it was already green before the loop
