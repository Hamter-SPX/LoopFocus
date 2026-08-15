#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"

out=$(node "$S/risk-score.js" --severity High --confidence Known)
echo "$out" | grep -q '"risk":"High/Known"' || { echo "T1 FAIL: two-axis score"; fail=1; }

out=$(node "$S/risk-score.js" --severity Critical --confidence Unknown)
echo "$out" | grep -q '"downgrade":"candidate"' || { echo "T2 FAIL: Unknown confidence must not report at full severity"; fail=1; }

out=$(node "$S/risk-score.js" --severity Critical --confidence Known --exploitability unverified)
echo "$out" | grep -q '"verdict":"HOLD"' || { echo "T3 FAIL: unverified exploitability must HOLD"; fail=1; }

printf 'CONST-001 Private user data must never cross tenant boundaries.\nCONST-002 No internet-facing component receives direct database credentials.\n' > "$TMP/.loopfocus/constitution.md"
printf 'CONST-001: comply | evidence: tenant schema enforced at data layer\nCONST-002: comply | evidence: secret manager lookup\n' > "$TMP/.loopfocus/proposal.md"
(cd "$TMP" && bash "$S/constitution-check.sh") >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T4 FAIL: complying proposal should pass"; fail=1; }

printf 'CONST-001: comply | evidence: ok\nCONST-002: violate | evidence: service gets raw DB creds\n' > "$TMP/.loopfocus/proposal.md"
(cd "$TMP" && bash "$S/constitution-check.sh") >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T5 FAIL: violating proposal must BLOCK"; fail=1; }

printf 'CONST-001: comply | evidence: ok\n' > "$TMP/.loopfocus/proposal.md"
(cd "$TMP" && bash "$S/constitution-check.sh") >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T6 FAIL: unaddressed CONST must fail"; fail=1; }

printf '{"title":"SQLi","evidence":"server.js:10 repro","attack_preconditions":"remote unauth","affected_boundary":"api->db","impact":"all user rows","confidence":"Known","contradicting_evidence":[],"verification_status":"reproduced"}' > "$TMP/finding.json"
node "$S/evidence-check.js" --file "$TMP/finding.json" >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T7 FAIL: complete finding should pass"; fail=1; }

printf '{"title":"SQLi","evidence":"server.js:10"}' > "$TMP/finding.json"
node "$S/evidence-check.js" --file "$TMP/finding.json" >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T8 FAIL: incomplete finding must fail"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
