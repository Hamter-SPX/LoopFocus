# Security Control Attack Surface

## What

Audits the DEFENSE systems themselves — auth service, policy engine, secret manager, WAF, monitoring — because a security control is a component like any other, and usually the highest-value target in the system.

## Why

Controls are where the crown jewels point: the secret manager holds every key, the auth service signs every session, the policy engine decides every access. Compromise one control and the whole security model inherits the damage. Audits that treat controls as trusted instruments are auditing the doors while ignoring who holds the master key.

## When

L6 — after the controls are enumerated (Defense Dependency Graph output). Each control gets the same rigor as the application surface.

## Protocol

1. Enumerate every security control as an attackable component: its inputs (who can call it), its secrets (what it holds), its dependencies (what it trusts), its failure mode (does it fail open?).
2. Run the standard gates on the control itself: Input/Output Gate on its API, Secrets Gate on what it stores, Failure-Safe Gate on its error paths, Dependency Gate on its stack.
3. Ask the control-specific questions: can an attacker distinguish "the control said no" from "the control was down"? Does the control's own admin path have the controls it enforces for others? (A policy engine with no authz on its own console is the classic find.)
4. Findings enter the standard loop — a control vulnerability is a Critical-by-construction candidate (its blast radius IS the security model).

## Evidence gates

- every control enumerated with its own surface
- control-specific questions asked (admin paths, failure behavior)
- control findings scored by the security-model blast radius

## Anti-patterns

- Trusting controls by role ("the WAF is a security tool, skip it")
- Missing the control's ADMIN surface (the console that manages the policy is the juiciest target)
- Treating a control's failure as unthinkable (Failure-Safe Gate applies hardest to controls)

## Example

The policy engine's admin console: enumerated as a control surface, it had auth via the SAME shared admin token (F9) — the control that enforced authorization for the system had the system's weakest authorization for itself. The finding ("the authorizer is the least-authorized-checked component") became the audit's emblem: controls are components first, authorities second.
