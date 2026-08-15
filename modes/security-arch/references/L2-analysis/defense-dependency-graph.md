# Defense Dependency Graph

## What

Maps which defenses depend on which other defenses: MFA depends on the identity provider; rate limiting depends on the proxy; encryption depends on key management. The graph answers: if defense X falls, what still stands?

## Why

Layered defense is only as layered as its dependencies are independent. Six defenses that all call the same IdP are one defense with six decorations. The graph exposes the real depth — and the single shared dependency that silently makes the layers a single point of failure.

## When

L2, after the gates identified the defenses. Consumed by defense-independence-analyzer and single-point-of-security-failure-detector.

## Protocol

1. Enumerate every defense the gates found (auth, MFA, rate limit, encryption, monitoring, network rules...).
2. Draw edges: defense → what it depends on (MFA → IdP, monitoring → log pipeline, encryption → KMS).
3. Compute the dependency closure per defense: what must hold for it to work.
4. Identify shared dependencies: two or more "independent" defenses sharing one root.
5. Report the true depth per layer: N defenses → M independent roots. N >> M = the layering is decorative.

## Evidence gates

- defense inventory with dependency edges
- shared-root analysis recorded
- true-depth numbers per layer in the report

## Anti-patterns

- Counting defenses instead of counting independent roots
- Assuming MFA and OAuth are independent (they usually share the IdP)
- Missing the monitoring dependency (detection is a defense; it depends on the log pipeline)

## Example

The "defense in depth" story: MFA, session tokens, and admin audit logging — all three authenticated against the same IdP with the same admin token (F9). Three named defenses, one root. The graph showed the true depth as 1, which is why the IdP/token redesign ranked above all three individual fixes.
