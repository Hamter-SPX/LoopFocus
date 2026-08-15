# Configuration Security Reasoner

## What

Reads the security posture of configuration surfaces — Docker, Kubernetes, IAM, reverse proxy, cloud config, CI/CD, environment, file permissions — with the same rigor the code gets. Code-only audits miss half the system.

## Why

Modern systems live in their configs as much as their code: a K8s service bound to 0.0.0.0, an IAM role with `*:*`, a proxy missing a TLS hop — each is a full finding that no source file contains. The reasoner closes the gap between "the code is secure" and "the deployed system is secure".

## When

L1, in parallel with the architecture mapper. Every config surface the repository contains is walked.

## The surfaces (walk ALL present)

| Surface | What to check |
|---|---|
| Docker | published ports, running as root, secrets in ENV, host mounts |
| Kubernetes | service exposure, RBAC, network policies, privileged containers, secrets management |
| IAM/cloud | wildcard permissions, unused roles, cross-account trusts |
| Reverse proxy | TLS termination, header config, exposed admin paths |
| Cloud config | storage ACLs, logging of secrets, default credentials |
| CI/CD | secret handling in pipelines, who can push, artifact signing |
| env files | committed .env, secrets in image env, drift between environments |
| permissions | world-readable keys, over-broad file modes |

## Protocol

1. Inventory the config files that exist (the inventory itself is a finding — configs nobody listed are configs nobody reviewed).
2. Per surface, check the risky patterns (table above) with file:line anchors.
3. Config findings join the finding pool with the same evidence bar as code findings — a K8s misconfig is a first-class finding, not a footnote.
4. Re-reason after every infra change (configs drift faster than code).

## Evidence gates

- config inventory recorded (including "none present" per surface)
- findings carry file:line anchors
- infra changes trigger re-reason (semantic-diff consumes this)

## Anti-patterns

- "It's just dev config" without checking what dev config ships to production
- Reviewing docker-compose but not the cloud IAM (the IAM holds the kingdom)
- Checking the code's secrets handling but not the pipeline's (the pipeline sees the secrets first)

## Example

The DB "on a private network" claim died in the docker-compose ports section (5432 published to the host bridge). The code audit could never find that — the config reasoner did, with the exact line.
