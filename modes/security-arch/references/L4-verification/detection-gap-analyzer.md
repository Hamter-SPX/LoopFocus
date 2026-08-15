# Detection Gap Analyzer

## What

For every attack path the model contains, asks: if this actually happened, would the system NOTICE? Paths with no detection signal are flagged as the Invisible Attack Surface.

## Why

Prevention fails eventually; detection is what limits the damage. A system that cannot see its own compromise is a system where attackers work undisturbed — and most audits never ask the question, because prevention findings are easier to write. The analyzer makes invisibility a first-class finding class.

## When

L4, after the attack paths are modeled (Causal Attack Graph). Re-run after every defense change (defenses change the detection story too).

## Protocol

1. For each modeled attack path: name the signal it WOULD produce (auth failure logs, unusual query patterns, egress anomalies, config changes).
2. Check whether that signal is actually collected AND routed somewhere a human/alerting sees it (collected-but-unrouted is the subtle variant of invisible).
3. Classify per path: DETECTED (signal collected + routed + alertable), COLLECTED-ONLY (logs exist, nobody watches), INVISIBLE (no signal exists).
4. INVISIBLE and COLLECTED-ONLY paths are findings — severity by the path's impact (an invisible Crown Jewel path is Critical regardless of how unlikely).
5. Feed the gaps to the Defense Coverage Map (detection is one of its four columns).

## Evidence gates

- per-path signal analysis recorded
- routing verified (alert config, on-call path, dashboard), not assumed
- invisible paths ranked by path impact

## Anti-patterns

- "We have logs" as the detection verdict (logs nobody routes are memory, not detection)
- Skipping the analysis for "unlikely" paths (invisibility is exactly what makes them likely to be exploited long)
- Detection checks done once and never after defense changes

## Example

The /debug endpoint dump: path impact High, signal analysis: access logging existed BUT the endpoint was excluded from the log pipeline (a "debug" exception), and the egress of process.env produced no anomaly rule. Verdict: COLLECTED-ONLY — the endpoint's access logs existed but nobody watched, and the data exfiltration itself was INVISIBLE. Two detection gaps on one path, both findings, both fixed by routing + an egress rule.
