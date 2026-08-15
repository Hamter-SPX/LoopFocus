# IPC Security Reasoner

## What

Analyzes every inter-process channel — sockets, pipes, shared memory, message buses, RPC, Binder/XPC — asking: who can send messages to whom, and is the sender's IDENTITY preserved across each hop?

## Why

IPC is the internal network, and its security properties decide the system's: a message bus where any process can impersonate the system service, a socket where the peer's identity is not verified, an RPC that drops the caller's identity at the hop. Identity loss across IPC is how local escalations chain into system-wide ones.

## When

L8 — for systems with multiple processes/services on one host (desktop, mobile, daemon architectures).

## Per-channel checks

| Channel | Question |
|---|---|
| sockets/pipes | is the peer authenticated? is the sender's identity verified or assumed from the connection? |
| shared memory | is the region's ownership enforced, and is the data validated as untrusted at the reader? |
| message buses (DBus/Binder) | can a process register AS another service name? are privileged interfaces callable by anyone? |
| RPC frameworks | does the callee re-check the caller's identity, or trust a forwarded claim? |
| cross-hop identity | does the original caller's identity survive service A → B relay, or become "the relay"? |

## Protocol

1. Enumerate the IPC channels from the architecture (they are usually invisible in code review — the map makes them visible).
2. Per channel: verify peer authentication + identity preservation (the two properties).
3. Flag channels where identity is assumed or dropped — severity by what the channel reaches.
4. The fix: authenticated channels with explicit identity, and identity propagation for relays.

## Evidence gates

- IPC channel inventory
- per-channel auth + identity-preservation verdicts
- identity-drop hops flagged

## Anti-patterns

- "It's local IPC, the local machine is trusted" (the local machine is where the attacker starts)
- Checking the channel's encryption but not its identity (encryption hides content, not the sender's claim)
- Missing the relay hops (A → B → C where C trusts B's word — B's identity is not the caller's)

## Example

The DBus session bus: the settings daemon registered as `org.system.settings`, but ANY process could register the same name first (no owner verification) and impersonate it to every client. The reasoner flagged the channel (identity assumed from the name, not verified). Fix: bus policy restricting the name to the verified daemon. One channel, one rule, the impersonation class died.
