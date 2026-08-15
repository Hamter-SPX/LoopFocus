# Golden Path

One honest task walked end-to-end through every gate, on a real simulated repo — the shortest complete demonstration of what LoopFocus does. This mirrors the live E2E verification (2026-08-15, `fv-final` session) that the skill passed.

## The task

Fix a failing test in an npm project. Truth: the root cause is an export-key typo in a dependency — invisible from the failing test's diff.

## Step 0 — Mode + init

```bash
loopfocus mode resolve "fix the failing test"   # → debug
loopfocus init && loopfocus discover            # .loopfocus/ + gates.conf
```

## Step 1 — LOCK (Goal Lock + Invariant Guard)

`.loopfocus/state.md`:

```text
goal: make `npm test` pass by fixing the ROOT CAUSE
invariants:
  - test file must NOT be modified (it encodes the contract)
  - minimal intervention
profile: NORMAL
```

## Step 2 — EXPLORE + reproduce (evidence before hypothesis)

`npm test` → FAIL: `TypeError: greet is not a function` (baseline: 0 pass / 1 fail). Evidence saved: `loopfocus artifact save result.log --attempt 0 --source local:test`.

## Step 3 — Attempt 1 (S1 Direct Fix, hypothesis ledgered first)

Hypothesis H1: caller-side destructuring problem. Edit `index.js` (property access instead). Result: identical failure.

```bash
loopfocus signal --source local:test --status fail --previous-failures 1 --current-failures 1 --attempt 1
# {"delta":"+0", "progress":false, "next_action":"mutate"}
loopfocus genome record --class greeting-undefined --strategy caller-patch --result fail --delta 0 --reason "same error"
```

## Step 4 — Attempt 2 (repeat → blocked → mutate)

Fingerprint check blocks the reworded retry:

```bash
loopfocus fingerprint --class greeting-undefined --approach caller-patch --error greeting-undefined
# {"verdict":"repeat-blocked", "action":"mutate"}
loopfocus converge --class greeting-undefined   # {"verdict":"flat","action":"tax"}
```

Genome auto-ban: `caller-patch` has 2 fails / 0 successes → banned. Ladder advances to S4 (inspect dependencies).

## Step 5 — Root cause (S4 wins)

Reading `lib/greeting-utils.js` reveals `module.exports = { greeting: greet }` — wrong key. One-line fix. `npm test` → PASS (1/1).

```bash
loopfocus signal --source local:test --status pass --previous-failures 1 --current-failures 0 --attempt 3
# {"delta":"+1", "progress":true, "next_action":"continue"}
loopfocus genome record --class greeting-undefined --strategy dependency-inspection --result success --delta 1 --reason "export key fixed"
```

## Step 6 — Gates + regression sentinel

```bash
loopfocus fast       # build PASS, static PASS, test PASS
loopfocus gates      # entry/build/static/test/regression/evidence-freshness/checkpoint/completion: PASS
```

## Step 7 — Re-check + verify + genome winner

```bash
loopfocus self-audit --claims claims.txt   # claims bound to evidence
loopfocus verify                        # {"gate":"completion","status":"PASS",...,"ready_to_finish"}
loopfocus genome query --class greeting-undefined
# winner strategy: dependency-inspection | banned: caller-patch
```

## Step 8 — SkillFocus + handoff

Points noticed but NOT silently fixed (reported for user decision): dependency ships no tests, `formatPrice(NaN)` returns `"NaN"`, negative rounding unverified. Completion report follows the 10-item contract; integration options presented — merge/push/discard are the user's.

## What the golden path proves

- 0 reworded retries (fingerprint + genome ban)
- root cause found by the ladder, not by luck
- every claim bound to a signal or an artifact
- the next agent on `greeting-undefined` starts from the winner, not from zero
