# Security Semantic Diff

## What

When code, config, or infra changes, the answer is not "what lines changed" but "how did the SECURITY MODEL change": a new trust boundary appeared, a privilege widened, an exposure opened, an invariant's precondition shifted.

## Why

Line diffs hide security meaning: the same one-line change can be cosmetic or can silently grant a role to a service. The semantic diff translates changes into model-level statements — which is what the Architecture Immune System and the Re-Verify Loop both consume. It turns "we merged a PR" into "the security model changed in these N ways".

## When

Every change that touches code/config/infra during an audit or afterward (the immune system runs it continuously).

## Protocol

1. Diff the World Model, not the files: compare trust edges, privilege edges, zones, exposure surfaces before vs after the change.
2. Classify each model delta: NEW_TRUST (a new "who trusts whom"), WIDER_PRIVILEGE, NEW_EXPOSURE, INVARIANT_RISK (an invariant's preconditions changed), NEUTRAL.
3. For security-relevant deltas: name the change, its introducing commit, and which gates/invariants must re-run because of it.
4. Feed the delta list to: the Re-Verify Loop (re-check), the Time Machine (record the introduction), and the user (if the delta needs a decision).

## Evidence gates

- model deltas classified per change
- security-relevant deltas trigger gate re-runs (not optional)
- introductions recorded (which change, which delta)

## Anti-patterns

- Reviewing PRs by line diff only ("looks fine" with no model impact stated)
- Classifying a privilege change as NEUTRAL because the tests pass (tests do not see privilege)
- Missing config/infra diffs (the semantic diff covers them, not just code)

## Example

The "diagnostics helper" PR added a route — line diff: 40 added lines. Semantic diff: NEW_EXPOSURE (unauthenticated endpoint) + WIDER_PRIVILEGE (dumps process.env) + INVARIANT_RISK (credential non-exposure). Three model deltas from one PR — the immune system's alarm went off on the semantics, not the lines.
