# Policy Synthesis Engine

## What

After analysis, SecurityArch does not just report problems — it SYNTHESIZES policy proposals suited to the architecture: least-privilege policies, isolation rules, authz boundaries, data-access rules. The output is candidate policy the team can adopt, not a list of complaints.

## Why

Findings without prescriptions leave the team to design fixes with the same blind spots that caused the findings. The synthesis engine converts the audit's conclusions into actionable, architecture-matched policy — written in the system's own vocabulary (IAM statements, network rules, code-level authz checks), so adoption is mechanical rather than interpretive.

## When

L5, after the attack paths and findings are complete. The synthesized policies feed the Fix Architecture Planner and the user's decision list.

## The synthesis inputs → outputs

| Input (from analysis) | Output (policy proposal) |
|---|---|
| privilege graph + least-privilege analysis | per-principal permission sets (minimal scopes) |
| trust boundaries | isolation rules per zone crossing |
| attack paths | blocking rules (network, authz, input) per path |
| data classification | data-access rules per class |
| failure-safe verdicts | fail-closed defaults for each control |

## Protocol

1. Group findings by their shared mechanism (the design-level causes).
2. Per group, draft the policy in the system's native form: an IAM statement, a network rule, a middleware check, a data-access rule.
3. Each policy carries: what it forbids, what it permits, which findings it resolves, and its blast radius (what might break when adopted).
4. Constitution check: the policy must not violate a CONST — and it must not silently change one (constitution-check runs on every proposal).
5. Proposals go to the user as options (the user owns policy adoption; SecurityArch owns the synthesis).

## Evidence gates

- policies trace to the findings they resolve
- blast radius stated per policy
- constitution check run per proposal

## Anti-patterns

- Proposing "improve security" as a policy (policies must be checkable rules)
- Synthesizing only technical rules and missing the data-access ones (data policy is the part that sticks)
- One giant policy document (per-mechanism policies are adoptable; monoliths are shelved)

## Example

From the audit: three routes with SQL concat + one missing ownership check. Synthesized policies: (1) "all DB access through the parameterized helper — direct string queries are build-blocked" (resolves the injection class), (2) "all user-data routes must filter by session owner at the data layer" (resolves the IDOR class). Both written as adoptable rules with blast-radius notes — the team merged them as policy, not as a reading assignment.
