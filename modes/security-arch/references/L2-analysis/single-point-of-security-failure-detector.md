# Single-Point-of-Security-Failure Detector

## What

Finds the component whose compromise collapses the ENTIRE security model — the node where the Defense Dependency Graph and the Blast Radius both converge.

## Why

Every architecture has one (usually the IdP, the KMS, the admin token, or the auth middleware). Finding it matters more than any individual vulnerability, because it is the vulnerability of the whole model. Systems die at their single point, never at their strongest layer.

## When

L2, after the defense graph and blast radius are computed. Re-run after every architectural change — new designs create new single points.

## Protocol

1. From the defense graph: find nodes in the dependency closure of MOST defenses.
2. From the blast radius: find components whose compromise reaches Crown Jewel + most invariants.
3. The intersection = the single point(s). Usually one, sometimes two.
4. For each: record what depends on it, what falls with it, and whether a compromise path to it exists (attack path from an untrusted zone).
5. The response is architectural: split the point (separate keys, separate IdPs, separate privilege domains), or harden it beyond everything else — as a DELIBERATE decision, not an accident of the design.

## Evidence gates

- the single point named with its dependent surface
- attack path to it assessed (reachable from untrusted = Critical by construction)
- mitigation recorded as a decision (split or deliberate harden)

## Anti-patterns

- "Everything depends on the DB, that's normal" (normal is exactly what the detector flags — deliberate?)
- Splitting one single point while creating another (the new split's components become new candidates — re-run)
- Treating the single point as unavoidable without recording the acceptance (Decision Log)

## Example

The static admin token was the single point: it authenticated the admin endpoints, signed sessions, and was embedded in the client bundle. The detector named it; the fix split it into three separate mechanisms. The system went from "one token = everything" to three independent roots — the highest-leverage fix of the entire audit.
