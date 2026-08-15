# Incident Back-Propagation

## What

After a real incident, the engine works BACKWARD: which architecture assumption, gate, or reasoning step SHOULD have caught this but missed — and then updates SecurityArch's own rules so the class is caught next time.

## Why

Incidents are the most expensive teacher, and most teams waste the lesson on a postmortem that names blame instead of gaps. Back-propagation converts the incident into rule updates: the missed assumption becomes a registry entry, the missed gate becomes a new check, the missed evidence becomes a new required field. The system gets smarter after every failure — that is the point of calling it learning.

## When

After any incident or near-miss, as its own recorded session (mode: debug within SecurityArch).

## Protocol

1. Reconstruct the incident against the model AT THE TIME (the Time Machine supplies the pre-incident state).
2. For each step of the attack: which existing system should have caught it? (invariant? gate? assumption? judge?) Why did it miss?
3. Classify the misses: blind spot (no system covered it), stale (a system existed but was outdated), ignored (a system flagged and it was dismissed — dismissals get special scrutiny).
4. Update the rules: new invariant, new gate pattern, new assumption object, or a new required evidence field — each update recorded with the incident that forced it.
5. The update goes into the Security Learning Loop's policy — it applies to every future audit, not just this project.

## Evidence gates

- miss classification recorded per attack step
- rule updates trace to the incident that forced them
- dismissals re-examined (an ignored warning is a process finding)

## Anti-patterns

- Postmortems that end at "human error" (the engine asks which SYSTEM allowed the error to matter)
- Updating rules for the specific incident without generalizing the class (the class is the lesson)
- Never re-running old audits against new rules (old verdicts may fail new checks — that's the point)

## Example

Incident: forged webhook fulfilled phantom orders. Back-propagation: the webhook authenticity assumption had no registry entry (blind spot); the shared-secret pattern was in the Input/Output Gate's rules but only for user input, not machine-to-machine callbacks (stale scope). Updates: assumption object created, the gate's scope widened to all inbound machine messages. The next audit — of a different project — caught the same class in one pass.
