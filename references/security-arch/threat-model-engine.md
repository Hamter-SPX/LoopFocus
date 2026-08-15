# Threat Model Engine

## What

The core differentiator of SecurityArch: analysis of threats AGAINST THE ARCHITECTURE — what an attacker would do, through which path, to reach what asset — instead of a flat scan of bug patterns.

## Why

Bug scans find instances; threat models find classes. The SQL injection scanner finds one concatenation; the threat model shows that EVERY route sharing the DB helper is the same class of threat, and that the real prize is the credential in db.config, not the users table. Fixes then target the design, not the sample.

## When

After the four mappers (Architecture, Trust Boundary, Attack Surface, Data Flow). The engine consumes their output.

## Protocol

1. Identify assets: what would an attacker want? (credentials, PII, funds, control).
2. Enumerate threat actors: anonymous internet, authenticated user, malicious third-party, insider.
3. Per actor: STRIDE-style walk — Spoofing, Tampering, Repudiation, Information disclosure, DoS, Elevation — against the mapped architecture.
4. Per threat: the path (entry → boundary crossing → asset), the control that should stop it, and whether that control exists.
5. Score each threat (Risk Scoring) and route: missing control = finding; weak control = verify with Exploitability Judge; control exists = record the defense.
6. The model is a document (canvas + ledger), not a chat summary — it survives the session.

## Evidence gates

- assets, actors, and per-actor threats recorded
- each threat has a named path and a named control (or its absence)
- the model exists in the ledger before fixes are proposed

## Anti-patterns

- "Threat model" that is a bug list with extra headers
- Modeling only the anonymous attacker (the authenticated user is the bigger surface)
- Threats without paths ("data could be leaked" — through what?)

## Example

Threat: authenticated user reads another user's order. Path: /api/user?name= → SQL helper (string concat) → users table. Control: none (concat) + none (no per-user scoping). Two missing controls on one path = F1 Critical + F11 Medium as one design finding: the shared query helper needs parameterization AND ownership scoping — a design fix, not two patches.
