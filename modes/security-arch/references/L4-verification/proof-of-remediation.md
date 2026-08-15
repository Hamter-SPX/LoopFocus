# Proof of Remediation

## What

"Fixed" is a claim that must be proven twice: the original attack path is actually cut (not just patched cosmetically), AND no new path opened in its place.

## Why

Remediation theater is the audit's last trap: the fix lands, the repro test passes, and the pattern survives elsewhere, or the fix itself opens a sibling path. The proof closes both exits — the path is dead by demonstration, and the model shows no replacement path. Without it, "fixed" ages into "was never really fixed".

## When

Every remediation, before the Re-Verify Loop closes it and before the Exit Gate counts it.

## The two-part proof

1. **Path cut**: re-run the original reproduction — it must now FAIL to exploit (the repro from the Evidence Ledger becomes the proof's negative test). A fix that survives the repro but changes nothing about the root cause fails here.
2. **No new path**: re-run the semantic diff + the invariant proof on the fixed model — the fix must not have introduced NEW_TRUST, WIDER_PRIVILEGE, or a new violation path (the fix's own child findings are the classic surprise).

## Protocol

1. Before fixing: the attack path is in the ledger with its repro.
2. Fix (via the Fix Architecture Planner for design-level findings).
3. Prove cut: the repro fails; the regression test pins it (and the mutation tester confirms the test catches the class).
4. Prove no-new-path: semantic diff + invariant re-proof on the post-fix model.
5. Record the proof with both halves — a remediation with one half is not remediated.

## Evidence gates

- original repro now fails (demonstrated, not asserted)
- post-fix model re-checked for new paths
- proof recorded per finding

## Anti-patterns

- "The test passes" as the whole proof (half the proof — the repro test is the cut half)
- Fixing the instance while the class survives (the mutation tester catches the class; the proof must cite it)
- Skipping the no-new-path check because the fix "was small" (small fixes open paths too)

## Example

The parameterized-helper fix: repro failed (path cut ✓). No-new-path check re-ran the semantic diff — and found the helper's new error path echoed raw SQL into responses (a new exposure born from the fix). The proof caught the child finding, the fix completed, and the second proof round passed clean. Remediation theater avoided by exactly this second look.
