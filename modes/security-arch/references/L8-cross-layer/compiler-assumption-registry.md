# Compiler Assumption Registry

## What

Records the assumptions the compiler/language make that security reasoning depends on: memory model, undefined behavior handling, FFI boundaries, ABI assumptions, unsafe boundaries — each an assumption object with evidence.

## Why

Security reasoning about code silently inherits the compiler's world: UB means "anything can happen" (including security checks being optimized away), FFI boundaries drop the language's guarantees, ABI mismatches corrupt memory. When these assumptions are unexamined, the analysis proves things about a language the binary does not actually run.

## When

L8 — for mixed-language systems, systems with unsafe code, and any review that reasons "this code cannot do X" (the cannot often rests on a compiler assumption).

## The registry entries

| Assumption | The question |
|---|---|
| memory model | does the reasoning assume no UB exists? (UB invalidates everything) |
| UB handling | is the code UB-free — proven how (sanitizers? audits?)? |
| FFI boundary | which language guarantees survive the crossing, which do not? |
| ABI | do the caller and callee agree on layout (structs, enums, calling convention)? |
| unsafe boundary | what does "unsafe" here actually permit, and what proves the safety comments? |

## Protocol

1. For each security-relevant claim ("this cannot overflow", "this pointer is valid"), find the compiler/language assumption it rests on.
2. Register the assumption with its evidence (sanitizer run, audit, type-system guarantee) or mark it unverified.
3. Unverified assumptions become findings-adjacent: the claim that rests on them is downgraded until the assumption is proven.
4. Re-check on compiler upgrades (optimizations change UB behavior — a new compiler can invalidate old assumptions).

## Evidence gates

- load-bearing compiler assumptions registered
- claims downgraded on unverified assumptions
- re-check on toolchain changes

## Anti-patterns

- Reasoning about the source as if the binary runs it directly (the compiler is a transforming adversary of your assumptions)
- "Undefined behavior doesn't matter here" (UB is exactly where it matters — the optimizer acts on it)
- Registering assumptions once and ignoring toolchain upgrades (each upgrade re-rolls the UB dice)

## Example

The auth check relied on "this integer cannot overflow" — resting on the assumption of no UB. The registry flagged it unverified; a UBSan run found a signed overflow in a length calculation. The claim, the check, and the fix (bounds-correct arithmetic) all followed from registering the assumption instead of inheriting it silently.
