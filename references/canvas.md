# Canvas

Architecture is drawn before it is changed. A canvas is the shared picture of structure — current, proposed, or impact view.

## When to draw

- Before a feature (where does it plug in? what does it touch?)
- Before a structural change (what breaks if X moves?)
- When explaining a bug's mechanism (the dependency path of the fault)
- When two fixes oscillate (draw the A↔B edge — the shared root cause usually appears)

## How to draw

1. **In chat**: Mermaid or ASCII. Boxes = modules/files/state; edges = data flow or dependency; every edge labeled with what travels on it (not "uses" — "sends token", "reads session").
2. **Mark the change**: where the edit goes, what touches it, what must not break (invariants from Goal Lock).
3. **On approval**: save as `docs/loopfocus-canvas-<topic>.md` and commit. The file is evidence, like a test.

## Rules

- Never draw boxes for files you have not read. A canvas built from assumptions is hallucination with arrows.
- One canvas answers one question. The "how does this feature plug in" canvas and the "what breaks" canvas are different pictures.
- The canvas must let a reader answer: what does this unit do, how do I use it, what does it depend on? If the picture cannot answer those, the structure — or the drawing — is wrong.
- Re-draw when reality contradicts the canvas; do not stretch the old picture. A stale canvas is worse than none.

## Anti-patterns

- Drawing the architecture from the README instead of the code
- Decorated boxes with no edge labels (a picture of names, not of flow)
- Skipping the canvas because "I can hold it in my head" — the canvas is for the user, the reviewer, and the future agent, not for you
- Saving a canvas nobody approved, then acting on it
