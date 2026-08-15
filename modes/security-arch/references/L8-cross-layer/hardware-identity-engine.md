# Hardware Identity Engine

## What

Connects every identity class — device identity, machine identity, secure element identity, service identity — into ONE identity graph with the same IAM discipline software identities get.

## Why

Hardware identities are the root of the identity chain, and most systems treat them as an afterthought: a device ID that any process can read, a machine identity that grants service rights, a secure-element key with no binding to its owner. The engine brings hardware identities into the same graph as users and services — so impersonation and escalation through the hardware layer become visible like any other edge.

## When

L8 — for device fleets, cloud machine identities, and anything where "the machine proves it is itself".

## Protocol

1. Enumerate identity anchors: device certs, machine identities (cloud), secure element keys, firmware IDs.
2. Per anchor: what it authenticates AS, what rights attach to it, and — critically — what can STEAL or BORROW it (any process on the device? only the secure element?).
3. Draw the edges into the main identity graph (hardware identity → service identity → permissions).
4. Flag: anchors readable by unprivileged processes, anchors granting more than the device's function, anchors with no binding to their usage.
5. The Physical-to-Logical Trust Bridge consumes this (device identity ≠ process authorization).

## Evidence gates

- anchors enumerated with their binding (who can use them)
- edges drawn into the main identity graph
- over-granting anchors flagged

## Anti-patterns

- Treating the device cert as infrastructure, not identity (it authenticates something)
- Ignoring who can READ the anchor (an anchor any process can use is a shared credential)
- Missing the service-identity edges (cloud machine identities grant IAM roles — that's the whole story)

## Example

The device fleet's identity certs lived in a file readable by every process on the device. The graph showed the edge: any-compromised-process → device-cert → service access. The fix (cert in the secure element, key use only via its API) moved the anchor to where only it could use it. The identity graph made the over-sharing visible in one edge — the same discipline software identities always got, finally applied to hardware.
