# Digital Twin Security Simulator

## What

A second copy of the architecture model — the "twin" — where failures and compromises are experimented on freely, without touching the production model or the real system.

## Why

You cannot safely answer "what if we turn off MFA everywhere?" on the real model — experiments pollute the model, and mistakes corrupt the audit. The twin absorbs all experimentation: the production model stays clean as the reference; the twin gets burned, mutated, compromised, and rebuilt.

## When

L3, for every counterfactual world and every architecture mutation. The twin is the sandbox those engines run inside.

## Protocol

1. Clone the verified World Model into `.loopfocus/twin/` (the twin is a working copy, versioned separately).
2. Run the counterfactual worlds and mutation tests ONLY on the twin.
3. Record twin experiments + outcomes (the experiment log is itself evidence: what was tried, what broke).
4. When the twin yields a design change: apply to the production model deliberately, with the experiment's evidence attached (Proof-Carrying).
5. Reset the twin after each experiment family — a dirty twin contaminates the next experiment.

## Evidence gates

- experiments run on the twin, production model untouched by experiments
- experiment log maintained (tried / outcome)
- design changes cite their twin experiment

## Anti-patterns

- Experimenting on the production model "just once" (the contamination is permanent)
- Keeping twin results but losing the experiment that produced them (the experiment IS the evidence)
- Forgetting to reset the twin between experiments (dirty twins produce confounded results)

## Example

"What if the DB is read-only?" ran on the twin: checkout flow breaks (expected), admin audit trail breaks (unexpected — the trail assumed writes), and, critically, the fail-open path surfaced. The twin experiment produced two findings and zero risk to the live model. The production model was updated only with the evidence attached.
