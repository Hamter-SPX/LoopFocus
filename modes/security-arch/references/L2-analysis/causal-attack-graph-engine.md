# Causal Attack Graph Engine

## What

Models vulnerabilities not as isolated points but as causal chains: Entry → Identity → Permission → Service → Data → Impact. The engine builds the chains and ranks them by total risk.

## Why

An individual finding is a fact; a chain is a story that tells you what actually breaks and how. "SQL injection" is a point; "unauthenticated endpoint → user lookup → concat query → full table → credential in same DB → Crown Jewel compromise" is the chain that justifies the severity and orders the fixes. The highest-risk chain, not the loudest finding, drives remediation.

## When

L2, after the World Model and invariants exist. Every High/Critical finding is placed into at least one chain; findings that belong to no chain get re-examined (isolated findings are often mis-modeled).

## Protocol

1. From the World Model, identify attacker entries (untrusted zones).
2. For each entry, walk forward: what identity does it grant, what permissions follow, which services those permissions reach, what data those services hold, what impact touching that data has.
3. Record each complete chain (entry → ... → impact) with per-hop evidence.
4. Score chains: severity of impact × plausibility of each hop (verified hops raise the score).
5. Rank. The top chain is the first fix. The Fix Architecture Planner fixes the CHAIN's weakest shared hop, not each node separately.

## Evidence gates

- every High/Critical finding appears in a chain
- chain hops carry evidence or are labeled unverified
- the ranked chain list is the report's backbone

## Anti-patterns

- Findings reported as a flat list with no chains (a list hides the story)
- Chains built from assumption-hops as if verified
- Fixing the last hop (the impact) while the entry hop stays open

## Example

Chain: unauth /debug (entry) → process.env dump (permission bypass: no auth needed) → DB credential (data) → direct DB access (impact: Crown Jewel). Two findings (F4, F5) became ONE chain, and the fix (close /debug AND rotate the credential) was ordered by the chain, not by the findings' individual severities.
