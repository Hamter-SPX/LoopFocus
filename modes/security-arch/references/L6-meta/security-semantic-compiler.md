# Security Semantic Compiler

## What

Translates the Security Architecture into machine-checkable rules for CI, policy engines, tests, and LoopFocus gates — the architecture's security properties become executable checks.

## Why

An architecture lives in documents until its properties become checks. The compiler is the bridge: "no unauthenticated route" becomes a CI assertion; "no credential in code" becomes a gate; "every user-data route scopes by owner" becomes a test template. Compilation is what makes the Secure-by-Construction constraints actually enforce themselves.

## When

L6 — after the architecture's constraints and invariants are defined. Output consumed by CI, gate-runner configs, and the immune system's baseline.

## The compilation targets

| Architecture property | Compiled artifact |
|---|---|
| "no unauthenticated routes" | CI check: route table must show auth middleware per route |
| "no credential literals in code" | sast rule (already in the curated set) |
| "all DB access via helper" | lint/CI rule banning string SQL |
| "user-data routes scope by owner" | test template + review checklist |
| "auth failures must close" | failure-safe test pattern per control |
| invariants | invariant proof runs in the gate chain |

## Protocol

1. Collect the architecture's security properties (invariants, constraints, policies).
2. Compile each into its enforcement: pick the mechanism (CI step, lint rule, gate, test), write the check.
3. Wire the checks into the pipeline — a compiled rule that runs nowhere is uncompiled.
4. Record the mapping (property ↔ check) — it is auditable, and the conformance gate verifies the mapping is intact.
5. Re-compile when the architecture changes (the semantic diff triggers recompilation of affected properties).

## Evidence gates

- property ↔ check mapping recorded
- every property has a running check (none uncompiled)
- conformance verifies the mapping

## Anti-patterns

- Properties that stay in the docs with no check (uncompiled properties are decorative)
- Compiling only the easy checks and leaving the hard properties to "review" (review is the fallback, not the plan)
- A check that exists in CI but has been disabled (disabled checks are silent removals — the mapping catches them)

## Example

Three properties compiled: (1) no-unauth-routes → CI route-table assertion; (2) no-string-SQL → lint rule; (3) owner-scoped queries → test template. Six months later a PR added a route before the middleware — the CI assertion failed at build time, before any human saw the PR. The compiler had turned the audit's biggest finding class into a merge-blocker.
