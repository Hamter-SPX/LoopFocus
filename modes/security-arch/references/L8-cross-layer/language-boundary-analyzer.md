# Language Boundary Analyzer

## What

Analyzes the FFI boundaries between languages — Rust + C + Swift + Kotlin + anything custom — because security properties are per-language and die at the crossing unless deliberately carried over.

## Why

Each language guarantees something different (memory safety, immutability, ownership), and a call across the boundary inherits NEITHER side's guarantees by default: a Rust guarantee does not survive into C, and C's freedom poisons what returns to Rust. Mixed-language systems are the norm; the analyzer treats each boundary as a security edge with its own contract.

## When

L8 — for any multi-language codebase, especially systems with unsafe/FFI layers (mobile apps, systems software, native extensions).

## Protocol

1. Enumerate every FFI boundary: which language, which direction, what crosses (pointers, strings, structs, callbacks).
2. Per boundary: state the contract — what each side promises (lifetimes, validity, thread-safety, ownership).
3. Check the crossing: is the caller's promise valid on the callee's terms? (a Rust reference's aliasing rules vs C's free pointers; a Swift array's length vs C's raw buffer.)
4. Flag boundaries where properties are dropped or contracts mismatch — these are the mixed-language bug factories.
5. The boundary contracts join the Assumption Registry (each is an assumption the reasoning depends on).

## Evidence gates

- boundary inventory with directions + payloads
- per-boundary contracts stated
- property-drop mismatches flagged

## Anti-patterns

- "The Rust side is safe" without checking what the C side does to its references (the boundary is two-sided)
- Missing the callback direction (C calling back into Swift/Rust drops properties just as surely)
- Assuming the language boundary is a thin wrapper (it is the thickest edge in the system)

## Example

The Rust core exposed `fn validate(data: &[u8])` to a C caller — the C side passed a buffer whose length was computed differently (wchar count vs byte count). The Rust slice's length guarantee was silently violated by the boundary's contract mismatch. The analyzer's boundary contract ("length in bytes, agreed by both sides") exposed the mismatch and the fix (explicit length field, checked at the boundary). One boundary, one contract, one class of memory bugs closed.
