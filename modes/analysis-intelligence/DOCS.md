# Analysis Intelligence — Docs

The complete operating documentation for the analysis-intelligence mode of LoopFocus.

## Trigger

analyze, explain, what, why, how does, understand, อธิบาย, คืออะไร — or explicitly `loopfocus mode show analysis-intelligence`.

## Contract

- **May**: read everything, run read-only tools, build models, reason, recommend, produce Action Plans.
- **Must not**: edit files (analysis is read-only — recommendations go to the user or LoopFocus); present inference as fact; answer while evidence is missing without naming the gap.
- **Closes when**: the pipeline completes — model built, hypotheses challenged, judge verdict recorded, conclusion carries confidence + sensitivity map, Action Plan with success/failure criteria delivered.

## The pipeline (mandatory order)

```
Input / Problem
→ Context Reconstruction
→ World Model
→ Facts / Assumptions / Unknowns (epistemic tagging)
→ Dependency + Causal Graph
→ Hypothesis Generation
→ Evidence Search
→ Counterfactual Challenge
→ Contradiction Resolution
→ Impact Simulation
→ Independent Judge
→ Conclusion + Confidence
```

## The 6 epistemic classes (tag every claim)

| Class | Meaning | Usage |
|---|---|---|
| FACT | evidence-backed | may act as premise |
| INFERENCE | derived from facts | state the derivation path |
| ASSUMPTION | believed, unproven | name it + owner + age |
| HYPOTHESIS | proposed, awaiting falsification | state what would kill it |
| UNKNOWN | admitted ignorance | name the discriminating question |
| CONTRADICTION | evidence conflict | resolve before use — never pick a side silently |

## Recursive Analysis Loop

```
Understand → Model → Analyze → Challenge
→ Find missing information → Update model → Re-analyze → Converge
```

Converge when information gain flattens (Stopping Intelligence) — not when the clock ends.

## Router

The Analysis Intent Router detects: domain, problem type, complexity, evidence quality, uncertainty, required depth, time horizon, cross-domain dependencies — then composes engines dynamically (a slow-AI-server question gets Software + Hardware + Performance + Temporal + Causal). Mid-analysis evidence changes trigger Adaptive Analysis Routing (re-compose). Escalation: L0 Quick → L1 Structured → L2 Deep → L3 Multi-Hypothesis → L4 Cross-Domain → L5 Adversarial → L6 Recursive → L7 Research-Grade.

## Analysis Mesh

For complex problems: Master dispatches independent analysts (Software/Hardware/Data) — each BLIND to the others' conclusions in round 1 (no anchoring) — then Causal Synthesizer combines, Adversarial Judge challenges, conclusion emerges.

## Layer reference index

| Layer | Path | Systems |
|---|---|---|
| L1 Understanding & Structure | `references/L1-understanding/` | 35 |
| L2 Causal Intelligence | `references/L2-causal/` | 21 |
| L3 Evidence & Epistemics | `references/L3-evidence/` | 50 |
| L4 Adversarial & Self-Challenge | `references/L4-adversarial/` | 28 |
| L5 Systems & Dynamics | `references/L5-systems/` | 26 |
| L6 Decision Intelligence | `references/L6-decision/` | 51 |
| L7 Prediction & Uncertainty | `references/L7-prediction/` | 20 |
| L8 Formal & Scientific | `references/L8-formal/` | 40 |
| L9 Discovery & Meta | `references/L9-discovery/` | 16 |

Total: 287 systems. Load the file for the layer you are working in — never all of them.

## Machine tools

```bash
loopfocus analysis-router "<problem>"      # intent detection + engine composition + level
loopfocus epistemic-check <file>           # every claim must carry its class
loopfocus conclusion-score <file>          # reliability score + sensitivity map
loopfocus question-engine <context>        # the question whose answer changes the most
loopfocus mesh-run <problem> <analysts>    # blind round-1 analyst dispatch
loopfocus counterfactual-runner <model>    # assumption stress testing
```

(Planned — implemented in Phase 2 with TDD.)

## Internal analysis modes (14)

Software · Hardware · Data · Research · Document · Decision · Strategy · System · Causal · Temporal · Predictive · Comparative · Diagnostic · Optimization Intelligence — the Router composes these per problem.

## Completion report

The standard LoopFocus 10-item contract, plus Analysis-specific items:
- the world model summary (what the problem IS)
- epistemic class counts (how much of the answer is FACT vs ASSUMPTION vs UNKNOWN)
- the hypothesis table (alive / killed / with what evidence)
- the judge's verdict (separate from the analyst)
- conclusion + confidence + sensitivity map (which assumption moves the answer most)
- the Action Plan for LoopFocus with success/failure criteria
