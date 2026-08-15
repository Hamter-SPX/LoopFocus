# Loop Genome

## What

The evolution history of solutions per problem class: every attempt, its strategy family, its result, its delta, its reason — plus the auto-ban and the winner. The genome is queried at LOCK and written at every MEASURE.

## Why

Agents start problems from zero every time — the same problem, a new context, the same three wasted loops. The genome is the cross-session memory that ends the restart: the winner family starts first, the banned families stay banned, and the problem class recognizes itself by name.

## When

- LOCK: query the class (or the nearest similar one)
- After every attempt: record
- Handoffs and recoveries: the genome is part of the capsule

## Storage

`.loopfocus/genome.json` (per repo) or `~/.loopfocus/genome.json` (global). Schema: `schemas/genome.schema.json`.

```json
{
  "refund-window": {
    "attempts": [ {"n":1,"strategy":"boundary-constant","result":"fail","delta":0,"reason":"...","hypothesis":"..."} ],
    "strategies": { "boundary-constant": {"fails":2,"successes":0,"banned":true} },
    "winner": "dependency-inspection"
  }
}
```

## Rules

1. Problem classes are named by symptom domain (refund-window, greeting-undefined, login-hang) — stable enough to re-query, specific enough to be useful.
2. Auto-ban: 2 fails / 0 successes. The ban is mechanical and permanent for the class (new evidence can lift it — a recorded reason, per the Decision Ledger's reopen-if).
3. Winner = most successes. A partial counts as information, not as success.
4. Query results shape the first hypothesis: "this class was won by dependency-inspection before" is a legitimate starting hypothesis — still written into the ledger and tested, not believed.

## Evidence gates

- query at LOCK recorded
- every attempt recorded with reason + delta
- bans respected in later loops (verifiable in the ladder's rung choice)

## Machine check

```bash
node scripts/loop-genome.js record --class <cls> --strategy <s> --result <r> --delta <n> --reason "..." --hypothesis "..."
node scripts/loop-genome.js query --class <cls>
node scripts/loop-genome.js summary
```

## Anti-patterns

- Recording only failures (winners are the memory's most valuable entries)
- Class names too broad ("bug") or too narrow ("the-tuesday-issue")
- Querying and then ignoring the winner (the query is a shortcut, not a mandatory path — but ignoring it needs a recorded reason)
