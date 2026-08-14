# Predictive Analysis

Before a feature lands or a coupled area changes, predict where the bugs will come from. Evidence-based forecasting — not astrology.

## The pass

### 1. Touch map

Which modules does the change touch, and which depend on them? Search callers (`grep`/`rg` for imports/usages). The touch map is the canvas's risk overlay.

### 2. Risk factors — each with evidence

| Factor | Evidence question |
|---|---|
| coupling | how many callers depend on the touched code? |
| complexity | long functions? deep branching? tangled state? |
| churn | recent git history of the file (frequently edited = unstable) |
| missing tests | which touched paths have no coverage? |
| concurrency | shared mutable state? async boundaries? |
| data flow | what inputs flow into the change, and who shapes them? |

### 3. Confidence levels — the core honesty device

| Level | Meaning | Allowed claim |
|---|---|---|
| Known | verified by reading the actual code | "will break because … (file:line)" |
| Likely | pattern + partial evidence | "likely to break — pattern X, evidence Y" |
| Unknown | insufficient evidence | "unknown — here is what would settle it" |

Never present Likely as Known. The report's credibility is the ratio between these columns.

### 4. Output

Risk list per module + one prevention per risk (a test, a boundary check, a contract pin, a watch item) + the confidence level. Recorded in the ledger so post-feature bugs can be compared against the predictions — the comparison is what makes the next prediction better.

## Use in M4

The predictive pass runs BEFORE the first code edit. It feeds: the DoD graph (predicted risks become required tests), the pre-mortem (top predicted failures), and the adaptive CI impact detection (which suites to run first).

## Anti-patterns

- Predicting "this will be a problem" without pointing at the code
- A confidence column that never says Unknown
- Predicting only Critical-scale catastrophes (small, likely bugs matter more)
- Not comparing predictions to what actually broke afterward
