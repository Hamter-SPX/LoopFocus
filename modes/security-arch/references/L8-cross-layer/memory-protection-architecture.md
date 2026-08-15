# Memory Protection Architecture

## What

Reasons about memory isolation at the architectural level: virtual memory boundaries, process isolation, executable/non-executable regions, protected memory, and memory OWNERSHIP — who may read/write which region.

## Why

Memory boundaries are the substrate of every isolation claim: two processes are "isolated" only if their memory actually is. Architecture-level memory reasoning catches the claims that code reviews assume — the shared memory region two services both map, the NX-disabled page holding executable data, the ownership confusion where one process reads another's buffer.

## When

L8 — for systems where isolation matters (multi-process, shared-memory, native extensions, embedded). Pairs with the Namespace/Isolation Model.

## The checks

| Claim | What to verify |
|---|---|
| process isolation | separate address spaces actually exist (no shared mappings without reason) |
| NX | executable regions are non-writable and vice versa where the platform supports it |
| protected regions | the platform's protection (guards, MPUs) is actually configured |
| ownership | each region has exactly one owner; cross-owner access is an explicit, verified edge |

## Protocol

1. From the architecture, enumerate the memory regions and their owners.
2. Verify the isolation mechanisms per platform (OS-level for apps, MPU/TEE for embedded).
3. Flag: shared regions without justification, writable-executable pages, ownership edges with no reason (Proof-Carrying applies — a shared-memory edge needs its proof block).
4. Findings are the unjustified sharing/executability — severity by what the region holds.

## Evidence gates

- region/ownership map recorded
- isolation mechanisms verified per platform
- unjustified sharing flagged

## Anti-patterns

- Assuming isolation because the OS "handles it" (shared mappings are chosen, not accidental)
- Reviewing memory only for embedded (server apps share memory too — IPC buffers, mmap'd files)
- Ignoring ownership edges (the edge IS the security question)

## Example

Two services shared an mmap'd buffer for IPC "for speed" — no ownership marking, both full read/write. The map flagged the edge (unjustified sharing of writable memory between trust domains). A compromise of either service gained the other's in-flight data. The fix (per-direction ring buffers with ownership + validation) converted a silent shared region into two verified one-way channels.
