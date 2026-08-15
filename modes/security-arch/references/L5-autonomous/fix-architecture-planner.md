# Fix Architecture Planner

## What

When the findings point at a DESIGN-level problem, the planner produces a design-level fix — with a canvas, a radius, and a migration path — instead of letting the agent mop up code patches that leave the design broken.

## Why

The most expensive security mistake is patch-level response to design-level findings: parameterize THIS query, fix THIS comparison — and the pattern survives in the other 14 places, because the design (the shared helper, the auth model) still manufactures the bug. Design findings need design fixes; code patches on design bugs are security theater.

## When

Whenever the Threat Model Engine or two+ findings share one structural cause. The trigger: "this fix will not hold" — same class, multiple instances.

## Protocol

1. Classify the finding: instance-level (this line) or design-level (this pattern's shared mechanism)? Two+ instances of one class = design-level by definition.
2. For design-level: canvas the shared mechanism and its instances (the fix surface, not the bug surface).
3. Design the fix at the mechanism: the parameterized query HELPER replacing the concat HELPER; the ownership check in the DATA LAYER instead of per-route. One design change kills the class.
4. Compute the radius (Change Radius Control applies) and the migration path: what moves when the mechanism changes, what must be re-verified (Re-Verify Loop feeds here).
5. The plan is a deliverable (canvas + radius + migration + DoD chain) — user-approved before implementation, like any structural change.

## Evidence gates

- design-level classification recorded with the shared mechanism named
- fix plan includes radius + migration + verification path
- instance-level fixes on design bugs are rejected with the reason

## Anti-patterns

- Patching two instances and calling the class fixed
- Designing a fix without the canvas (an unseen mechanism cannot be fixed deliberately)
- Skipping the user approval because "it's a security fix, obviously needed" — the user owns the migration risk

## Example

The SQL-concat class: three routes shared the concat pattern. Patch-level response: fix the three queries. Planned response: the shared query helper becomes parameterized-by-construction (concat removed from the API) + ownership scoping at the data layer. One design change, five findings (F1, F2 + the three uninstantiated instances) killed at their manufacturing point.
