# Multi-Hop Reasoning

## What

Reasons across component boundaries so that 3-4 individually non-Critical points can be recognized as one Critical chain. The engine connects findings that live in different services, layers, or teams.

## Why

The most dangerous vulnerabilities are distributed: each hop looks benign in its own review ("it's just an internal endpoint", "it's just a log line", "it's just a shared token"). No single reviewer sees the whole path. Multi-hop reasoning is the system that does — it is the difference between three Mediums nobody fixes and one Critical everybody understands.

## When

L2, after per-component findings exist. Every time findings look "small", the engine asks what they can reach in combination.

## Protocol

1. Collect all non-Critical findings + suspicious-but-not-finding observations.
2. For each, ask: what does this grant, access, or reveal that ANOTHER component trusts?
3. Chain them across components: A's leak + B's trust + C's privilege = a path.
4. Re-score the chain (Causal Attack Graph): if the combination reaches a Sensitive+ asset, the chain is Critical even though each hop is Medium/Low.
5. Record the chain as its own finding — a multi-hop chain is a first-class finding with its own fix (often: break the trust at the chaining hop).

## Evidence gates

- suspicious observations are pooled, not discarded as "too small"
- combined chains re-scored as their own findings
- chain fixes recorded (breaking the chain at the weakest trust hop)

## Anti-patterns

- Discarding Low findings as noise (Lows are chain material)
- Reviewing each service in isolation and never combining
- Fixing one hop and declaring the chain handled (the chain survives one hop)

## Example

Three Mediums: (1) error endpoint echoes a stack trace with an internal hostname, (2) the hostname resolves on the internal network, (3) an internal metadata endpoint trusts any internal caller. Individually: minor. Chained: unauthenticated SSRF into the metadata service = Critical. The engine built the chain and the fix targeted the chaining hop (the echo), not the metadata service.
