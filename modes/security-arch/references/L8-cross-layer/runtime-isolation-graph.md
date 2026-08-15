# Runtime Isolation Graph

## What

Maps every runtime in the system — VMs, WASM, sandboxes, plugin runtimes, JavaScript engines, Python interpreters, native extensions — as isolation domains with the escapes and shared surfaces between them.

## Why

Modern systems run a stack of runtimes, each with its own isolation story: WASM inside a JS engine inside a browser inside a sandbox. Each layer's isolation has known shapes and known weaknesses, and the COMPOSED isolation is what actually protects — or fails to. The graph makes the stack explicit, so a claim ("the plugin can't reach the filesystem") can be checked against the real layers.

## When

L8 — for anything with embedded runtimes: plugins, WASM modules, scripting engines, extensions.

## Protocol

1. Enumerate the runtime stack per execution context (which runtimes nest inside which).
2. Per runtime: what isolation does it provide (memory, filesystem, network, capabilities) and what are its known escape classes (engine bugs, API gaps)?
3. Draw the composed graph: outer runtime → inner runtime, with the shared surfaces (host bindings, syscalls, capabilities exposed downward).
4. Flag: layers whose isolation is assumed rather than verified; capabilities exposed to inner runtimes that the outer layer does not actually enforce.
5. The graph feeds the Agent Capability Graph (agents often run inside these runtimes).

## Evidence gates

- runtime stacks enumerated per context
- per-layer isolation + escape classes recorded
- assumed-isolation layers flagged

## Anti-patterns

- "WASM is sandboxed" without the host-bindings audit (the sandbox is as strong as its exits)
- Counting runtimes instead of composing them (the composition is the security object)
- Forgetting the native extensions (they run OUTSIDE the engine's isolation, inside the process)

## Example

The plugin system: plugins ran as WASM inside a JS host — good isolation, except the host exposed a `host.readFile(path)` binding without path validation, and the JS engine itself ran in a process with full user privileges. The graph showed the chain: WASM → host binding (validated? NO) → engine → user space (full). The plugin's "sandbox" ended at the first unvalidated binding — and the graph is what made the ending visible.
