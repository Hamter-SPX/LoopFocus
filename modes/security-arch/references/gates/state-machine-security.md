# State Machine Security

## What

Analyzes systems with multi-state entities — REGISTERED → VERIFIED → ACTIVE → SUSPENDED — and checks the TRANSITIONS themselves: are there invalid paths, skipped verifications, wrong-direction transitions?

## Why

State machines encode the system's promises ("you cannot be ACTIVE without VERIFIED"), and the dangerous bugs are transition bugs: a skipped state, a reachable reverse edge, a transition gated by a check that lives in the UI instead of the backend. Scanning the states' code finds nothing; checking the transition GRAPH finds everything.

## When

Gates phase — for any entity with lifecycle states (users, orders, payments, devices, firmware, onboarding). The Architecture Model Checker consumes this map.

## Protocol

1. Extract the REAL state machine from code/config: states + transitions + the guards on each transition (the docs' machine and the code's machine often differ — the code is truth).
2. Draw it (canvas — transitions are edges, guards are edge labels).
3. Check per transition: is the guard enforced where the transition happens (backend, not UI convention)? Are reverse transitions gated (SUSPENDED → ACTIVE needs what?)? Are skips possible (REGISTERED → ACTIVE directly)?
4. Enumerate the illegal paths: any path that reaches a state without its prerequisites.
5. Illegal paths are findings with the sequence as evidence (which doubles as the regression test — the Model Checker verifies exhaustively).

## Evidence gates

- transition graph extracted from code (not docs)
- guards located in the enforcement layer (backend)
- illegal paths recorded with sequences

## Anti-patterns

- Trusting the documented state machine without reading the code's (docs show the intended machine)
- Guards that live in the UI ("the button only shows when...") — UI is not enforcement
- Checking happy-path transitions only (the illegal paths are the finding class)

## Example

The user entity: REGISTERED → VERIFIED (email link) → ACTIVE, ACTIVE → SUSPENDED (admin), SUSPENDED → ACTIVE (admin). Extraction found: the SUSPENDED → ACTIVE endpoint checked only the caller's session — not admin role. Illegal path: a suspended user reactivates themselves by calling the endpoint directly. The guard lived in the admin UI's button visibility; the backend never checked. Finding + regression test (suspended user token → reactivation must 403) from one graph walk.
