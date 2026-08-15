# Formal Invariant Compiler

## What

Translates human-language security rules ("Only project owners may delete projects") into formal invariants that can be checked against architecture, code, and tests.

## Why

Rules stated in prose are unenforceable: "only owners may delete" sounds clear until you must verify it, and then every reader interprets it differently. The compiler fixes the ambiguity at the source — the invariant gets subjects, objects, operations, and the check that proves it — so verification becomes mechanical instead of interpretive.

## When

L6/L7 — every CONST and every team rule enters through the compiler before it can guide analysis.

## The compilation output (per rule)

```text
INV-001
statement: Only project owners may delete projects
formal:    delete(project) ⇒ principal ∈ project.owners
check:     [architecture] the delete route resolves project.owners before acting
           [code]         the handler verifies ownership on the target object
           [tests]        a test where a non-owner delete attempt is rejected
status:    verified | violated (path) | unverifiable (missing check)
```

## Protocol

1. Collect the rules (CONSTs + team security rules).
2. Compile each into subject/operation/object form with an explicit implication (⇒) — the act of compiling exposes ambiguous rules ("who counts as an owner?" must be answered).
3. Derive the three checks: architecture-level (does the model allow it?), code-level (does the handler enforce it?), test-level (is it pinned?).
4. Run the checks; a rule with a missing check is unverifiable — which is itself a finding (an unverifiable invariant is a wish).
5. The compiled invariants feed the Invariant Proof Engine and the Model Checker.

## Evidence gates

- every rule compiled into formal form
- all three checks derived per invariant
- unverifiable invariants flagged, not silently assumed

## Anti-patterns

- Keeping rules in prose because "everyone knows what it means" (the compiler exists because they don't)
- Compiling only the easy rules (the ambiguous ones are the ones that matter)
- A compiled invariant with no test-level check (untested invariants are advisory)

## Example

"Only project owners may delete projects" compiled to: delete(project) ⇒ principal ∈ project.owners. The code check found the handler checked `role == 'admin'` — not membership in project.owners. The formal form caught the semantic gap (admins ≠ owners) that the prose rule had hidden for years. The invariant was violated BY DESIGN, and the formal check is what finally saw it.
