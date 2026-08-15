# Kernel-to-User Invariant

## What

A class of invariants about WHERE code runs relative to the trust it holds: untrusted parsers must not live in privileged processes; network-facing decoding must not run with kernel-level authority. The invariant engine's OS-flavored rules.

## Why

The highest-severity bugs in OS-adjacent systems follow one shape: untrusted input meets privileged execution context. The parser in the privileged daemon, the decoder in the kernel driver, the image library in the root service — each is a full-system compromise waiting on one crafted input. The invariant class exists to make that shape checkable, not just lamentable.

## When

L8 — whenever privileged components handle untrusted data, and as standing design rules for new privileged code.

## The invariant set

```text
KI-1: untrusted parsers do not run in privileged processes
KI-2: network-facing decoding does not run with kernel-level authority
KI-3: a privileged process's attack surface is its syscall surface — minimize both
KI-4: data crossing into a privileged context is validated at the boundary of the privilege
```

## Protocol

1. Enumerate privileged components (root daemons, kernel modules, drivers, setuid paths).
2. Per component: does it touch untrusted input (network, files, device data)?
3. Where both are true, check the invariant: is the untrusted parsing done OUTSIDE the privilege (separate unprivileged process, sandboxed decoder)?
4. Violations are findings with the invariant named (KI-1 violated: the root daemon parses client XML in-process).
5. The fix is structural: split the parser into an unprivileged process with a narrow IPC contract.

## Evidence gates

- privileged components enumerated with their input surfaces
- per-invariant verdicts recorded
- violations named by invariant

## Anti-patterns

- "The parser is battle-tested" (battle-tested parsers in privileged processes are still the shape of the worst bugs)
- Splitting the parser but running the split process as root anyway (the privilege follows the process, not the role)
- Checking only daemons (kernel drivers parse network input — the same invariant applies)

## Example

The system service (root) parsed uploaded config files in-process, in a C parser with a history. KI-1 violated. Fix: the parser moved to an unprivileged helper process; the root service received only validated structures over a narrow socket. The invariant turned "we should be careful with that parser" into a structural rule with a check — and the next parser (the log decoder) was caught by the same invariant at design time.
