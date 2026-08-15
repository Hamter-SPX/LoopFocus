# Architectural Counterfactual Search

## What

Searches alternative worlds systematically: What if Redis is compromised? Auth unavailable? An internal service hostile? One admin credential leaks? Tenant isolation fails? — then reports which invariants hold and which fall in each world.

## Why

Designs are judged by their counterfactuals, and most teams stop at the first two what-ifs. The search makes the exploration exhaustive over the key components — every load-bearing component gets its world, every world gets its invariant verdict. The worlds where everything falls are the architecture's real weaknesses, found in a sandbox instead of an incident.

## When

L7 — the recursive loop's simulation step (Digital Twin hosts it), and as a standing stress test before any "safe" declaration.

## Protocol

1. Enumerate the worlds from the model's components: each key service/data store/credential in three modes — compromised, unavailable, hostile.
2. Per world: walk the model (twin), check each invariant — hold / partial / fall.
3. Cluster the falls: worlds that break the SAME invariants reveal the shared dependency (the single point of failure in counterfactual form).
4. Report: world map with invariant verdicts, and the worst worlds ranked first.
5. The worst worlds become the hardening agenda — the counterexample engine then attempts each as a concrete path.

## Evidence gates

- worlds enumerated from the actual components (not a generic list)
- per-world invariant verdicts recorded
- worst worlds feed the hardening agenda

## Anti-patterns

- Testing only "attacker arrives" worlds (unavailability and hostility are worlds too — and they break different things)
- A world search with no invariant verdicts (a narrative is not a verdict)
- Running the same worlds after a fix that changed nothing about them

## Example

Worlds run: Redis compromised (sessions leaked, but token scoping held — partial), Auth unavailable (everything degraded — and one fail-open path found), tenant isolation fails (Crown Jewel reachable — full fall). The tenant-isolation world's collapse promoted isolation testing from a nice-to-have to the audit's top hardening item — a priority no bug-scan would ever produce.
