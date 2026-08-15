# Defense Independence Analyzer

## What

Verifies whether defense layers are TRULY independent — or secretly share one root cause, making the "layers" one defense wearing costumes.

## Why

Defense-in-depth is a claim about independence: two checks that both call the same IdP are one check that runs twice. The analyzer traces each defense to its roots and counts how many DISTINCT roots actually stand between the attacker and the asset. The number that matters is roots, not layers.

## When

L6, on the Defense Dependency Graph. Re-run after any defense change.

## Protocol

1. Take the defense graph's dependency closures.
2. Cluster defenses by shared root: all defenses whose closure contains the same critical dependency form one cluster.
3. Compute the true depth per asset: number of distinct clusters between attacker and asset.
4. True depth of 1 = the asset is one failure away from exposure, whatever the layer count says.
5. Report per asset: named layers, shared roots, true depth. Depth 1 on a Crown Jewel is a Critical finding.

## Evidence gates

- dependency closures computed per defense
- shared roots named (which component is the common ancestor)
- true-depth numbers per asset in the report

## Anti-patterns

- Counting defense layers as depth (the analyzer exists because that count lies)
- Ignoring shared OPERATIONAL roots (two cloud services on one account share the account's compromise)
- Declaring independence because the codebases differ (independence is about failure correlation, not code)

## Example

Six "layers" on the admin path: MFA, session check, IP allowlist, audit log, alerting, rate limit. Root analysis: MFA + session + IP all resolved through the same auth gateway; audit + alerting through one log pipeline; rate limit through one proxy. Six layers, three roots — and the auth gateway's compromise silently carried the first three. The analyzer's true-depth report (3, not 6) reframed the hardening budget toward splitting the auth gateway's dependencies.
