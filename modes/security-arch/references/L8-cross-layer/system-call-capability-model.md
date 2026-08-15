# System Call Capability Model

## What

Moves the question from "does this process run as root?" to "which capabilities does this process ACTUALLY need?" — and computes the authority gap between the two.

## Why

"Runs as root" is binary and uninformative; a root process that needs two capabilities carries dozens of unused authorities. The capability model names the actual requirements (which syscalls, which resources) and makes the excess measurable — turning "don't run as root" from advice into a computation.

## When

L8 — for every process in the containment review. Pairs with the CPU Privilege Model (which layer) and feeds the Least-Privilege Optimizer (which scope).

## Protocol

1. Per process: trace its actual syscall usage (strace, seccomp logs, code review).
2. Name the capability set the function requires: file reads here, network binds there, no raw sockets anywhere.
3. Compare against what it HAS (root = all, or the granted capability set).
4. The gap = unused authority = the finding ("the web server holds CAP_SYS_ADMIN it never uses").
5. The reduction (seccomp profile, capability dropping, non-root user) is the fix — each reduction its own verified change.

## Evidence gates

- syscall/capability usage traced per process
- granted-vs-required gap computed
- reductions recorded per process

## Anti-patterns

- "It's root but it's internal" (internal root is still root)
- Estimating usage instead of tracing (the trace is the evidence — UNKNOWN usage means no reduction yet)
- Capability dropping without testing the reduced process (reductions break things subtly)

## Example

The image-processing worker: traced usage showed file I/O + network send — but it held the full root set including CAP_SYS_MODULE. Gap: dozens of unused authorities including the most dangerous one. The seccomp + capability profile cut it to two capabilities — and the worker's compromise surface shrank from "everything" to "its files and its socket". The trace, not the advice, made the case.
