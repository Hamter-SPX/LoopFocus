# Intent Anchor

## What

The user's true intent, stored separately from the prompt's wording. Before acting, restate the intent in your own words and check the work against it — not against the letters of the request.

## Why

Literal compliance with the wrong intent is the expensive kind of bug: the task is executed perfectly and uselessly. "Make the button faster" may mean "the page feels unresponsive" — different diagnoses, different fixes. The anchor pins what the user actually wants while the wording drifts.

## When

- Every LOCK (write the intent next to the goal)
- Whenever a new user message arrives mid-task (the anchor re-verifies, sometimes re-anchors)
- Before proposing alternatives ("what would make you say this worked?")

## Protocol

1. Extract intent from wording: what OUTCOME does the user want to be true?
2. Restate it: "You want <outcome> — is that right?" (for consequential work, confirm explicitly).
3. Write both in state.md: `intent: <outcome>` alongside `goal: <...>`.
4. Check every milestone against the intent, not the wording. A milestone that satisfies the wording but not the intent is drift.

## Evidence gates

- intent written at LOCK
- consequential restatements confirmed with the user (recorded in the ledger)

## Anti-patterns

- Executing the wording while the intent is ambiguous (ambiguity is a question, not a permission)
- Re-anchoring silently to whatever the current edit serves
- Confusing intent with implementation detail ("intent: use React" is wording, "intent: page renders within 100ms" is intent)

## Example

"Make the submit button faster" → intent anchor: "the user experiences the submission as responsive". Wording-based work: micro-optimizing the handler (nothing measurable). Intent-based work: found no perf problem, but a missing loading state made submission feel dead — the actual fix. The anchor turned an unverifiable task into the real one.
