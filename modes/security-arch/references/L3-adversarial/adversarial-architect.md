# Adversarial Architect

## What

A second persona that exists to BREAK the security architect's conclusions: it attacks the architectural assumptions, hunts the weak boundaries, and forces repairs — in a loop until the design survives the attack.

```
Security Architect → proposed secure design
        ↓
Adversarial Architect → find assumptions / weak boundaries
        ↓
Security Architect → repair
        ↓
repeat
```

## Why

The architect who designs a defense is the worst person to judge it — the same assumptions that shaped the design will bless it. The adversarial persona is the institutionalized second opinion: it does not need to run exploits, it attacks the ASSUMPTIONS the design stands on. Designs that survive this loop earn their confidence; designs that don't, get repaired before any attacker sees them.

## When

Every design-level verdict (L4-L7), especially before "safe" is ever said. The Recursive Challenge runs it on each repaired design.

## The attack brief (what the persona attacks)

1. **Assumptions** — every registry entry: which one, if false, collapses the design?
2. **Boundaries** — every trust crossing: which one was drawn by convenience, not necessity?
3. **Transitive paths** — which capability chain reaches further than the design's author believed?
4. **Failure modes** — which failure branch opens instead of closes?
5. **Secondary effects** — which repair creates a new hole elsewhere?

## Protocol

1. Security Architect writes the design + its stated invariants.
2. Adversarial Architect writes the attack: assumption-by-assumption, boundary-by-boundary, with "what would convince me this fails".
3. Verdict per attack point: held / partially held / broken.
4. Broken points → Security Architect repairs → round 2.
5. The loop ends when an attack round produces no broken points (held points are recorded WITH their evidence — "held against X because Y").

## Evidence gates

- attack rounds recorded with per-point verdicts
- repairs trace to the attack points that forced them
- "held" verdicts carry reasons, not assertions

## Anti-patterns

- The same persona arguing both sides (the separation IS the mechanism)
- Attacks that stop at "this looks weak" without naming which assumption it breaks
- Declaring the design survived while one attack point remains "partially held" (partially = broken until repaired)

## Example

Design: "webhook authenticity via a shared static secret". Attack: "the secret ships in the client bundle → assumption 'secret stays server-side' is false → forged webhooks". Broken. Repair: per-endpoint signatures with rotation. Round 2 attack: "signature verification skips on timeout?" — held (fail-closed verified). The loop produced a defense that survived the second opinion.
