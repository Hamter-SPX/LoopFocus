# Dependency Awareness

## What

When goal A is blocked by B, write the edge down and work on B explicitly — as a declared side quest with a budget — instead of looping A and hoping.

## Why

Blocked-by relationships are invisible in the code but dominant in the schedule. An agent that does not model them loops the blocked node (wasting loops) or sneaks past the block (breaking scope). The edge written down converts "why isn't this working" into "this is blocked; here is the path".

## When

- When a loop's failure traces to an external/upstream cause (a dependency's bug, a missing service, a locked decision)
- When two task items secretly depend on each other (order matters and the order is not in the plan)

## Protocol

1. Record the edge in state.md: `A blocked-by B | evidence: <what showed the block>`.
2. Declare B as a side quest with a budget (see `state-machine.md` — Side-Quest Sandbox) or escalate if B is outside the agent's reach.
3. Work B until the block clears or the budget dies (Focus Budget). Budget died → escalate with the edge drawn.
4. Block cleared → return to A, record the return. Never loop A while the edge exists.

## Evidence gates

- blocked-by edges recorded with evidence
- no loops on a blocked node (visible in the ledger: A's loops stop after the edge is recorded)

## Anti-patterns

- "Maybe it will unblock itself" loops (that's the exact waste the edge exists to prevent)
- Working around the block instead of through it (a bypass that hides the edge breaks the next person)
- Forgetting to return to A after B clears (the side quest's return is part of its declaration)

## Example

Checkout bug: "fix the form" was blocked by "the cart API returns null when the basket is empty" — the form handler crashed on the null. Edge recorded, the null-handling fixed as the declared side quest, then the form fix resumed. Without the edge, the session loops the form handler while the crash sits in the cart path.
