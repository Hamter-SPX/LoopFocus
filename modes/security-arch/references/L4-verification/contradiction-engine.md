# Contradiction Engine

## What

When two pieces of evidence disagree, the engine does NOT pick the convenient one: it creates a contradiction case, blocks decisions that depend on either side, and forces additional evidence until the contradiction resolves.

## Why

Contradictions are the highest-value signals in an audit — they usually mean one piece of evidence is stale, one is misread, or the model is wrong somewhere. Picking a side silently bakes whichever error survives into every downstream verdict. The engine converts "pick one" into "resolve it", which is how audits stop lying to themselves.

## When

Any time evidence conflicts: config vs runtime, doc vs code, test vs behavior, one layer's verdict vs another's.

## Protocol

1. Detect explicitly: name both evidence sources and the contradiction (uncertainty class: Contradictory).
2. Create the contradiction case: both claims, both sources, what each would imply.
3. Block: no verdict may depend on either side until resolution (a blocked verdict is recorded as BLOCKED, not guessed).
4. Hunt the discriminator: what single observation would settle it? (Information Gain Routing applies — cheapest discriminating evidence first.)
5. Resolve: the winning side gets the evidence trail; the losing side is marked stale/refuted with the reason; the case closes with the resolution recorded.

## Evidence gates

- contradictions logged as cases with both sources named
- blocked verdicts recorded as BLOCKED (not silently decided)
- resolutions carry the discriminating evidence

## Anti-patterns

- Choosing the side that agrees with the current plan (that's not resolution, that's shopping)
- Resolving by authority ("the senior engineer wrote the comment")
- Leaving the contradiction open while work proceeds on a silent assumption

## Example

README claimed API v2; code and tests said v3; the team had been "supporting both". The contradiction case revealed the v2 branch was dead code shipping to production with its own authz gaps. Resolution: v2 removed, README marked stale, and the "supporting both" assumption (which had silently doubled the attack surface) entered the Assumption Registry as refuted.
