#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0

out=$(node "$S/analysis-router.js" "ทำไม AI server ช้าลงหลังเปลี่ยน model")
echo "$out" | grep -q 'software' || { echo "T1 FAIL: should include software"; fail=1; }
echo "$out" | grep -q 'hardware' || { echo "T2 FAIL: should include hardware"; fail=1; }
echo "$out" | grep -q 'performance' || { echo "T3 FAIL: should include performance"; fail=1; }
echo "$out" | grep -q 'temporal' || { echo "T4 FAIL: should include temporal"; fail=1; }
echo "$out" | grep -q 'causal' || { echo "T5 FAIL: should include causal"; fail=1; }

out=$(node "$S/analysis-router.js" "hello world")
echo "$out" | grep -q '"level": "L0"' || { echo "T6 FAIL: simple input should be L0"; fail=1; }

printf 'FACT: server.js:10 uses string concat\nINFERENCE: likely injection path\nASSUMPTION: admin token is safe\nHYPOTHESIS: rate limit bypassable\nUNKNOWN: backup encryption status\nCONTRADICTION: README v2 vs code v3\n' > "$TMP/claims.txt"
node "$S/epistemic-check.js" --file "$TMP/claims.txt" >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T7 FAIL: valid classes should pass"; fail=1; }

printf 'server.js:10 uses concat\n' > "$TMP/claims.txt"
node "$S/epistemic-check.js" --file "$TMP/claims.txt" >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T8 FAIL: untagged claim must fail"; fail=1; }

printf '{"conclusion":"use B","evidence_count":5,"assumption_count":1,"disagreement_count":0,"stability":0.9}' > "$TMP/concl.json"
out=$(node "$S/conclusion-score.js" --file "$TMP/concl.json")
echo "$out" | grep -q '"verdict": "RELIABLE"' || { echo "T9 FAIL: strong conclusion should be reliable"; fail=1; }

printf '{"conclusion":"use B","evidence_count":1,"assumption_count":6,"disagreement_count":3,"stability":0.3}' > "$TMP/concl.json"
out=$(node "$S/conclusion-score.js" --file "$TMP/concl.json")
echo "$out" | grep -q '"verdict": "WEAK"' || { echo "T10 FAIL: weak conclusion should be weak"; fail=1; }

printf 'context: AI server slow after model change\nquestions:\n- what changed in the serving stack?\n- is the GPU thermal throttling?\n- what color is the rack?\n- is inference latency CPU or memory bound?\n' > "$TMP/questions.txt"
out=$(node "$S/question-engine.js" --file "$TMP/questions.txt")
echo "$out" | grep -q 'what color' | head -1 | grep -q 'last' && { echo "T11 FAIL: trivial question should rank last"; fail=1; }
echo "$out" | grep -q '"ranked"' || { echo "T12 FAIL: should output ranking"; fail=1; }

printf '{"assumptions":[{"name":"internal network trusted","conclusions":["c1","c2"]},{"name":"clock synced","conclusions":["c3"]}]}' > "$TMP/model.json"
out=$(node "$S/counterfactual-runner.js" --file "$TMP/model.json")
echo "$out" | grep -q '"dependent_conclusions": 2' || { echo "T13 FAIL: flip A1 should flag 2 conclusions"; fail=1; }

bash "$S/mesh-run.sh" "why is the system slow" software hardware > "$TMP/mesh.txt" 2>&1
grep -qi 'blind' "$TMP/mesh.txt" || { echo "T14 FAIL: mesh should require blind round 1"; fail=1; }
grep -q 'software' "$TMP/mesh.txt" || { echo "T15 FAIL: mesh should dispatch analysts"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
