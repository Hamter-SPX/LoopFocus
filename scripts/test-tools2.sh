#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0

out=$(node "$S/canvas.js" --modules auth session db --edges "auth->session" "session->db")
echo "$out" | grep -q 'mermaid' || { echo "T1 FAIL: canvas mermaid output"; fail=1; }
out=$(node "$S/canvas.js" --modules auth db --edges "auth->db" --format ascii)
echo "$out" | grep -q 'auth --> db' || { echo "T2 FAIL: canvas ascii edges"; fail=1; }

mkdir -p "$TMP/.loopfocus"
printf 'test output\n' > "$TMP/result.log"
(cd "$TMP" && bash "$S/artifact.sh" save result.log --attempt 3 --source local:test) >/dev/null 2>&1
[ -f "$TMP/.loopfocus/evidence/attempt-3-local:test.log" ] || { echo "T3 FAIL: artifact naming"; fail=1; }

printf 'the fix is complete | /nonexistent/evidence.log\n' > "$TMP/claims.txt"
(cd "$TMP" && node "$S/self-audit.js" --claims claims.txt) >/dev/null 2>&1
[ $? -eq 1 ] || { echo "T4 FAIL: unbound claim should fail recheck"; fail=1; }
printf 'tests pass 14/14 | result.log\n' > "$TMP/claims.txt"
(cd "$TMP" && node "$S/self-audit.js" --claims claims.txt) >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T5 FAIL: bound claim should pass recheck"; fail=1; }

mkdir -p "$TMP/.loopfocus"
printf 'goal: fix login\ninvariants:\n  - keep api\nUNKNOWN: none\nNEXT: done\n' > "$TMP/.loopfocus/state.md"
printf 'actual result: x\n' > "$TMP/.loopfocus/ledger.md"
printf 'LIGHT\n' > "$TMP/.loopfocus/profile"
(cd "$TMP" && bash "$S/state-check.sh") >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T6 FAIL: valid state should pass"; fail=1; }
printf 'goal: fix login\nUNKNOWN: blocker\nNEXT: fix it\n' > "$TMP/.loopfocus/state.md"
(cd "$TMP" && bash "$S/state-check.sh") >/dev/null 2>&1
[ $? -eq 1 ] || { echo "T7 FAIL: blockers should fail state-check"; fail=1; }

(cd "$TMP" && bash "$S/distill.sh") >/dev/null 2>&1
grep -q '^MISSION:        fix login$' "$TMP/.loopfocus/current-truth.md" || { echo "T8 FAIL: distill mission"; fail=1; }

mkdir -p "$TMP/ci-proj" && cd "$TMP/ci-proj" || exit 1
git init -q
printf '{"src/auth/*":["auth.test.js"],"src/db/*":["db.test.js"]}' > "$TMP/ci-proj/test-map.json"
mkdir -p src/auth src/db && printf 'x\n' > src/auth/change.js
out=$(node "$S/adaptive-ci.js" --changed src/auth/change.js --map test-map.json --cwd "$TMP/ci-proj")
echo "$out" | grep -q 'auth.test.js' || { echo "T9 FAIL: adaptive-ci affected tests"; fail=1; }
echo "$out" | grep -q 'fast-checks' || { echo "T10 FAIL: adaptive-ci stages"; fail=1; }

node "$S/otel-observe.js" --url http://127.0.0.1:1/ --metric latency >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T11 FAIL: otel unavailable should exit 0 with SKIP note"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
