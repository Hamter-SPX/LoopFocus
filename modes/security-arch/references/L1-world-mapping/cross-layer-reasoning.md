# Cross-Layer Reasoning

## What

Reasons across ALL layers simultaneously — Application → OS → Container → Cloud IAM → Network → CI/CD → Secrets — because a security question never lives in one layer.

## Why

Single-layer analysis produces single-layer confidence: the app checks out, so the verdict is green — while the IAM role grants `*:*` and the container runs privileged. The real answer to "is this system secure" is the conjunction across layers, and conjunctions fail at their weakest member. Cross-layer reasoning makes every verdict a conjunction.

## When

Every major verdict (invariants, exit gate, trust proofs). The individual layers still get their own passes — this system combines them.

## Protocol

1. Take the question ("can an attacker read user data?").
2. Walk it down the layers: app route (exposed?) → OS/container (what privilege does the process have?) → cloud IAM (what can the role do?) → network (who can reach it?) → CI/CD (who can change the deployment?) → secrets (who holds the DB key?).
3. Record per-layer verdicts; the question's verdict is ALL of them — one layer's fail is the question's fail.
4. The Cross-Layer Invariant Engine formalizes the recurring ones; this system does the ad-hoc questions.

## Evidence gates

- per-layer verdicts recorded for each major question
- verdicts are conjunctions (a single-layer green is never the final answer)

## Anti-patterns

- "The app is secure" without the layer walk (that's a single-layer verdict wearing a general one)
- Layers checked in isolation and never combined
- Assuming the cloud defaults are fine because the app code is good (defaults are the finding, usually)

## Example

"Can an attacker read user data?" — app: no auth on /debug (fail at layer 1). Even without that: container runs as root with host network (fail), IAM role has DynamoDB:* (fail), CI lets anyone push to prod branch (fail). Four independent fails — the cross-layer conjunction made the risk posture obvious while any single-layer audit would have shown "mostly fine".
