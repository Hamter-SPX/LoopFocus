# Counterfactual Check

## What

Before changing X because you believe X is the cause, ask: "If X were NOT the cause, what would we observe instead?" Then check which world the current evidence matches.

## Why

Confirmation bias is cheap to run and expensive to undo. The counterfactual question is the cheapest discriminator available: it costs one sentence and often kills a wrong fix before the edit. It converts "X fits the symptom" (which nearly anything fits) into "the evidence distinguishes X from not-X" (which almost nothing survives).

## When

- Before every L4/L5 edit
- Whenever two hypotheses are alive and the chosen one "just feels right"
- Before an expensive or irreversible change (pairs with `pre-mortem-loop.md`)

## Protocol

1. State the claim: "X is the cause."
2. Derive the shadow: "If X is NOT the cause, we would observe …" (be specific: which test result, which log line, which behavior would differ)
3. Look for the shadow's observable in the current evidence.
4. Shadow present → X is not supported → do not change X yet; find the discriminating observation.
5. Neither world distinguishable yet → the Information Gain Router picks the cheapest discriminating action.

## Evidence gates

- the shadow observation written in the ledger before the edit
- a discriminating result exists (one world's prediction matched, the other's refuted)

## Anti-patterns

- Deriving a shadow so weak it matches any evidence ("if X is not the cause, something else is")
- Checking the counterfactual AFTER the edit (that's a post-hoc story)
- Skipping the check because "the fix is obvious" — obvious is exactly where bias lives

## Example

Float rounding bug: claim "the call-site rounding is wrong." Shadow: "if the call site is not the cause, editing it changes nothing." One edit later: output identical (`'1.00'`) — shadow confirmed, X refuted, no further investment in the call site. The counterfactual cost one loop; confirmation bias would have cost five.
