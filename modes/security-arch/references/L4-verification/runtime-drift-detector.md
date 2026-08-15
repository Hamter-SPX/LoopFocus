# Runtime Drift Detector

## What

Compares the DESIGNED architecture (the World Model) against the RUNTIME reality (what is actually deployed and running) — and reports every drift between them.

## Why

Designs and deployments diverge silently: the model says "DB on private network", the runtime shows the port published; the model says "auth required", the runtime has an unauth route someone added last week. The model is only as good as its correspondence to reality — the drift detector maintains the correspondence by catching every divergence.

## When

Continuously where runtime access exists (configs, orchestrator state, live endpoints); at minimum once per audit via config/deploy artifacts.

## Protocol

1. Extract the runtime picture: actual container configs, orchestrator state (kubectl/ECS), live route tables, running IAM roles — whatever the environment exposes.
2. Diff against the World Model: components present-but-unmodeled, model components absent-from-runtime, edges that differ (exposure, privilege, trust).
3. Classify drift: model-stale (runtime is truth — update the model), runtime-drift (model is truth — the deployment deviated, finding), ambiguous (investigate — Contradiction Engine).
4. Every drift is a finding candidate: a system that drifts from its security model is a system being secured by a fiction.

## Evidence gates

- runtime picture collected from real artifacts, not recollection
- drifts classified and recorded per direction
- model updated on model-stale drift (the model is a living document)

## Anti-patterns

- Auditing the model while the deployment drifts ("the design is secure" is not "the system is secure")
- Updating the model to match drift WITHOUT judging whether the drift is safe (model-stale ≠ drift-okay)
- One drift check at the start of the audit only (drift happens DURING audits too)

## Example

Model: "no service publishes a DB port". Runtime (docker inspect): 5432 published on the host bridge. Drift: runtime-drift, finding with the exact port mapping. If the team had instead updated the model to say "the port is published", the drift would have been absorbed — the detector's classification rule (judge the drift before accepting it) prevented the whitewash.
