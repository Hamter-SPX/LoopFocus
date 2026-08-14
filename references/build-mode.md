# M4 — Build Mode

Trigger words: build, feature, add, implement new, create. Announced on entry.

## Mode contract

- May: design, canvas, predictive analysis, implement slices, run gates.
- Must not: start code before design (Canvas + Predictive) and a DoD graph exist; expand scope without user approval.
- Gates that produce evidence: entry, context, plan, mutation, change-radius, build, static, test, regression, artifact, completion.
- Closes when: DoD chain complete, all gates pass, verify script passes, SkillFocus findings reported.

## The M4 sequence

### 1. LOCK with Intent Anchor

Restate the requirement in your own words. Write the intent separately from the wording — what does the user actually need this feature to DO? Lock goal + invariants + profile.

### 2. Design before code

- **Canvas**: the architecture of the feature — boxes, edges, data flow, where it plugs in. `references/canvas.md`.
- **Predictive**: the risk map of the touched area — which existing code the feature stresses, which future bugs are likely, with confidence levels. `references/predictive-analysis.md`.
- **DoD graph** into `.loopfocus/dod.md`: `feature works → tests pass → no regression → verify → done`, each node with its evidence command.

### 3. Smallest coherent slice first

Implement the thinnest slice that exercises the full path (entry → logic → output), verify it, then widen. Never half-build five pieces in parallel — each slice is one loop with measurable delta.

### 4. Write → verify loop

Every slice: hypothesis entry (what this slice proves) → code → build/static/test gates → normalize the signal → update state.md → commit (rollback point).

### 5. No scope creep

New ideas found while building go to the SkillFocus report list, not into the code. The user approves additions explicitly. A "small improvement" that touches the design contract is a change to the goal — re-lock it with the user.

## Anti-patterns

- Writing the DoD graph after the feature is done
- Implementing before the Canvas shows where the change plugs in
- Five unverified slices in flight at once (no attribution, no rollback points)
- Folding "helpful extras" into the feature silently
- Skipping the predictive pass because "it's a small feature" — small features break surprising callers most often
