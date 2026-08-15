# Defense Coverage Map

## What

Every attack path is paired with its defense story across FOUR columns: prevention, detection, containment, recovery. A path with empty columns is a path with nothing between it and disaster.

## Why

Security is a chain of four distinct jobs, and teams optimize one column (usually prevention) while the others stay empty. The map makes the emptiness visible per path: a prevented path with no detection is fine until prevention fails; an unprevented path with strong detection is a managed risk. The map is the honest picture of what actually stands between each attack and the worst outcome.

## When

L5, after the attack paths and defenses exist. Re-built after every defense change.

## The four columns per path

| Column | Question | Example |
|---|---|---|
| Prevention | what stops the attack from succeeding? | parameterized queries |
| Detection | what notices if it happens anyway? | WAF + query anomaly alerts |
| Containment | what limits the damage once inside? | least-privilege DB role, network segmentation |
| Recovery | what restores the system after? | tested backups + credential rotation runbook |

## Protocol

1. Take each modeled attack path (Causal Attack Graph output).
2. Fill the four columns with the SPECIFIC controls that exist for THAT path (a generic "we have a firewall" fills nothing — controls must match the path's mechanism).
3. Score coverage per column: present+verified / present+unverified / absent.
4. Absent or unverified columns are findings per path — severity by the path's impact (an unprevented, undetected, uncontained Crown Jewel path is Critical by construction).
5. The map ships in the report — it is the system's defense posture in one artifact.

## Evidence gates

- four columns filled per path with specific controls
- control presence verified (not "we probably have...")
- empty columns recorded as findings

## Anti-patterns

- One global "defense in depth" paragraph instead of a per-path map (depth is per-path or it is decoration)
- Filling detection with "we have logs" (logs are the raw material; detection is the rule that fires)
- Recovery left empty because "we'd figure it out" (recovery is engineered, not improvised)

## Example

The SQLi path's map: prevention absent (concat queries), detection partial (query logs exist, no anomaly rule), containment weak (app DB role had write to everything), recovery untested (no restore drill). Four columns, all weak — the map justified the fix order better than any single severity: close prevention first (the helper), then detection rules, then the role scope, then a recovery drill. Each fix was a column, not an arbitrary "hardening".
