# Identity & Privilege Graph

## What

The expanded privilege graph that separates EVERY kind of principal — human, service, agent, token, API key, role — and maps each one's rights and the relationships between them.

## Why

The classic privilege graph treats "users and roles" as the whole identity universe. Modern systems have at least six kinds of principals, and the worst escalations travel BETWEEN kinds: an API key impersonating a service, an agent wielding a human's session, a token with a scope its owner never had. The separation makes cross-kind escalation visible instead of invisible.

## When

L1, right after the World Model's entity pass. Consumed by the privilege-graph, cross-service-trust-analyzer, and agent-capability-security-graph.

## The principal taxonomy

| Kind | Identity anchor | Typical rights |
|---|---|---|
| human | username / session | end-user actions |
| service | service account / mTLS identity | internal calls, data access |
| agent | agent identity / capability grant | tools, APIs, delegated actions |
| token | JWT / opaque token + scope | whatever the token carries |
| API key | the key itself | whatever the key gates |
| role | role bundle | whatever the bundle grants |

## Protocol

1. Enumerate every principal of every kind — the taxonomy is a completeness checklist, not a suggestion.
2. Per principal: rights, how identity is proven, what IMPERSONATES it (token impersonates user; agent impersonates user — impersonation edges are first-class).
3. Draw the graph: principal → capability, plus impersonation and delegation edges.
4. Hunt the cross-kind escalations: token with broader scope than its owner, agent using human credentials, API key accepted where a user session should be required.
5. Feed Transitive Capability Reasoning (agent-capability-security-graph) from this graph.

## Evidence gates

- all six principal kinds enumerated (empty kinds recorded as none)
- impersonation/delegation edges drawn
- cross-kind escalations recorded with attempts (Exploitability Judge)

## Anti-patterns

- Modeling only humans and roles (services and agents hold the real keys)
- Treating a token as its holder without checking scope differences
- Missing the delegation edges (the agent DOES things on the user's behalf — that edge is the attack surface)

## Example

Checkout app: the login endpoint issued the SAME admin token to every user — a delegation edge (login → user → admin token) that no privilege review would catch as a "user permission". The identity graph drew the edge and labeled it "delegation: any authenticated user" — which is the finding, structurally stated.
