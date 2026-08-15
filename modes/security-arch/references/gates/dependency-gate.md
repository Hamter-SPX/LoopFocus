# Dependency / Supply-chain Gate

## What

Audits the whole dependency surface: lockfile integrity, known advisories, unpinned versions, lifecycle scripts, remote sources, and the maintainer risk of every package the build pulls.

## Why

Most real-world breaches in modern apps arrive through dependencies, and most audits check only `npm audit`'s severity list. The gate goes further: a clean advisory list with an unpinned, scripted dependency from an unknown source is still an open supply chain.

## When

Machine pass at every audit (the project's audit tool), deep pass on the dependency tree when advisories or unusual sources appear.

## Protocol

1. **Advisory scan**: run the stack's audit tool; read the REACHABLE advisories (a CVE in a tree the app never imports matters less — and more, if the tree can be reached via a gadget).
2. **Lockfile integrity**: is the lockfile committed? Does it match the manifest? (`npm ci` vs `npm install` drift.)
3. **Pinning**: are versions exact or range-pinned? Ranges drift silently — the "known good" build from last month is not reproducible.
4. **Lifecycle scripts**: any install/postinstall scripts? What do they run? (The single most dangerous supply-chain surface.)
5. **Sources**: any dependency from an unusual registry/git URL? Maintainer history for critical deps?
6. Every departure from the safe pattern is a finding — severity by reachability.

## Evidence gates

- audit tool output attached as evidence
- lockfile and pinning verdicts recorded
- lifecycle scripts and unusual sources checked, not assumed

## Anti-patterns

- "npm audit says 0" as the whole verdict
- Upgrading everything as one giant diff (one dep, one verification — Fix Policy applies)
- Ignoring a transitive CVE because "we don't import it directly" without checking the reachable path

## Example

express 4.16.0 pulled 7 advisories, the worst reachable through `req.query` parsing (qs prototype pollution) on an endpoint that parses user input — High, not Low, because the gate checked reachability instead of counting the advisory's generic score. The fix (4.22.x, non-major) was verified as its own change, not bundled with the SQL fixes.
