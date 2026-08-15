# Network Exposure Gate

## What

Audits what the network actually exposes: open ports, exposed services, ingress rules, inter-service traffic, and the encryption state of every hop.

## Why

The network layer is where "internal" assumptions die: the DB bound to 0.0.0.0, the debug port open to the VPC, the management API without TLS. Application-level fixes cannot compensate for a network-level door — and vice versa, so the gate exists as its own pass.

## When

After the Architecture Mapper (it supplies the topology); machine-assisted by configs (docker-compose ports, k8s services, proxy configs, firewall rules).

## Protocol

1. Enumerate exposed surfaces: published ports, public endpoints, load balancer targets, service-to-service listeners.
2. For each: who can reach it (internet / subnet / localhost), is the traffic encrypted in transit, and is authentication required at the listener?
3. Check the "internal" claims: a service labeled internal that is actually reachable from another zone is a finding — verify with an actual connection attempt where possible.
4. Check egress too: what the system calls out to (webhooks, package registries, telemetry) — supply-chain egress is network exposure in the other direction.
5. Per-surface verdicts recorded with reachability evidence.

## Evidence gates

- per-surface reachability + encryption verdicts
- "internal" claims verified by attempt or config evidence
- egress destinations enumerated

## Anti-patterns

- Trusting the word "internal" in a config without checking who can reach it
- Checking only ingress (egress exfiltrates too)
- "TLS at the proxy" as the verdict without checking the proxy-to-backend hop

## Example

Topology said "DB on private network". Config check: the DB container published 5432 to the host bridge, reachable from the web container AND from the host — the "private" claim was a config-level assumption, and the gate turned it into a Medium finding with a one-line remediation (bind to the internal network only).
