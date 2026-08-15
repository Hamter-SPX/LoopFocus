# Uncertainty Map

## What

A live classification of every belief the task depends on: Known / Likely / Unknown / Contradictory. The map decides what may be acted on and what must first become a hypothesis.

## Why

The worst bugs are planted by guesses dressed as facts. The map is the dress code: nothing enters the code without its level declared, and only Known may act as fact. The honesty device that keeps Predictive Analysis and every report credible is this map.

## When

- At LOCK (map the initial beliefs)
- After every OBSERVE that changes one (beliefs move levels)
- Before any edit that depends on a belief above its level

## The classes

| Class | Meaning | May act on? |
|---|---|---|
| **Known** | verified by evidence I have seen (file:line, test output, tool run) | yes, as fact |
| **Likely** | pattern match, partial evidence | only inside an experiment (L2/L3) |
| **Unknown** | no evidence yet | no — becomes a hypothesis first |
| **Contradictory** | two sources disagree | no — run the Context Conflict Resolver |

## Rules

1. Levels are claims too: "Known" cites its evidence ("Known — server.js:10 concat into SQL, reproduced"). A Known without a pointer is a Likely wearing a costume.
2. Movement is event-driven: new evidence moves a belief up or down immediately (Confidence Decay handles refutation).
3. Contradictory is its own class — resolving it is a task, not an opinion.
4. The map is written (ledger section), not held in memory — it is part of the recovery capsule.

## Evidence gates

- every load-bearing belief in the ledger has a level + evidence pointer
- no edit depends on an Unknown without a hypothesis entry explaining the risk

## Anti-patterns

- A map where nothing is ever Unknown (the honest maps are the useful ones)
- Upgrading a Likely to Known because the deadline is close
- Acting on a Contradictory by picking the source that agrees with the current plan

## Example

Predictive analysis on the /reset-password feature: "new route will copy the SQL-concat pattern — Known (every existing route does, server.js:10,20)". "Reset tokens will reuse the loose == comparison — Likely (pattern present, implementer's choice unknown)". "SMTP credentials will leak via /debug — Known (the endpoint dumps process.env, verified)". The Knowns became required pre-mortem preventions; the Likely became a watch item — each treated exactly as its level allows.
