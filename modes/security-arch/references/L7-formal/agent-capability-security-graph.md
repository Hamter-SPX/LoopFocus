# Agent Capability Security Graph ⭐

## What

Models AI agents as first-class principals with capabilities — filesystem.read/write, git, database.read/write, deployment, secrets, email, external APIs — and reasons about capability flow through the graph, including the part that matters most: TRANSITIVE capability.

## Why

The future codebase contains principals nobody's threat model covered: agents that read files, call tools, possess credentials, and can be invoked by other agents. An agent without a credential may still REACH it transitively — through a tool that calls a service that holds it. Classic privilege graphs miss this entirely; the capability graph is built for it.

## When

L7 — whenever agents/automation exist in or around the system. For agentic development tools, it is part of every audit; for traditional systems, it is the "future-proofing" pass that finds the automation the team forgot it added.

## The graph

```
Agent A
  ├─ filesystem.read / write
  ├─ git
  ├─ database.read / write
  ├─ deployment
  ├─ secrets
  ├─ email
  └─ external APIs
```

Edges: Agent → Tool → Service → Credential. Capabilities flow along edges; the question is not "what does A hold" but "what can A reach".

## Protocol

1. Enumerate agents (and any automation that acts like one) with their DIRECT capabilities.
2. Map their tools: what each tool can invoke, what it holds, what trusts it.
3. Run Transitive Capability Reasoning: from each agent, compute the closure of reachable capabilities (A → tool B → service C → credential D means A can, in principle, exercise D).
4. Compare the transitive closure against what the agent SHOULD reach (least-privilege by construction — the agent's scope is its closure, not its grant list).
5. Overreach is a finding: "agent can reach X via Y-Z chain" with the chain named — and the fix is breaking the chain (capability scoping at the tool or service), not trusting the agent.

## Evidence gates

- agents enumerated with direct capabilities
- transitive closures computed per agent
- overreach findings carry the full chain

## Anti-patterns

- Granting agents credentials "because the tool needs them" without computing what the tool reaches
- Scoping by intent ("the agent won't do that") instead of by reachability (the graph is about CAN, not WILL)
- Ignoring agent-to-agent edges (an agent invoking another agent inherits its closure)

## Example

Agent A (code-review bot) had read-only repo access — fine. But its tool B could run CI jobs, and the CI job C held the deployment credential D. Transitive closure: A → B → C → D — the review bot could deploy, via a chain nobody designed. The finding's fix: CI jobs triggered by agents run with restricted deployment contexts. The chain, once drawn, was undeniable — which is what the graph exists to produce.
