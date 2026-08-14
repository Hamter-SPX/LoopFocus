#!/usr/bin/env bash
set -u
GR=/Users/jirawat/Projects/SkillHub/LoopFocus/scripts/gate-runner.sh
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"

setup_basic() {
  printf 'goal: fix login hang\nUNKNOWN: none\nNEXT: done\n' > "$TMP/.loopfocus/state.md"
  printf 'hypothesis: x\nactual result: y\n' > "$TMP/.loopfocus/ledger.md"
  touch "$TMP/.loopfocus/metrics" 2>/dev/null || printf 'test_count=0\n' > "$TMP/.loopfocus/metrics"
}

out=$(setup_basic; cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"entry","status":"PASS"' || { echo "T1 FAIL: entry gate should PASS"; fail=1; }

printf 'goal: fix login hang\nUNKNOWN: blocker X\n' > "$TMP/.loopfocus/state.md"
out=$(cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"completion","status":"FAIL"' || { echo "T2 FAIL: completion should FAIL with blockers"; fail=1; }

setup_basic
printf 'test_cmd=echo ok\n' > "$TMP/.loopfocus/gates.conf"
printf 'LIGHT\n' > "$TMP/.loopfocus/profile"
out=$(cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"test","status":"PASS"' || { echo "T3 FAIL: LIGHT profile should run test gate"; fail=1; }
echo "$out" | grep -q '"gate":"static"' && { echo "T4 FAIL: LIGHT profile should NOT run static gate"; fail=1; }

setup_basic
printf 'LIGHT\n' > "$TMP/.loopfocus/profile"
printf 'test_count=5\n' > "$TMP/.loopfocus/metrics"
printf 'test_cmd=echo ok\n' > "$TMP/.loopfocus/gates.conf"
out=$(cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"regression"' && { echo "T5 FAIL: LIGHT should not run regression"; fail=1; }

setup_basic
printf 'NORMAL\n' > "$TMP/.loopfocus/profile"
printf 'test_count=5\n' > "$TMP/.loopfocus/metrics"
printf 'test_cmd=echo ok\n' > "$TMP/.loopfocus/gates.conf"
out=$(cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"regression"' || { echo "T6 FAIL: NORMAL should run regression"; fail=1; }

printf 'UNKNOWN: none\nNEXT: done\n' > "$TMP/.loopfocus/state.md"
rm -f "$TMP/.loopfocus/ledger.md"
out=$(cd "$TMP" && "$GR" 2>&1)
echo "$out" | grep -q '"gate":"completion","status":"FAIL"' || { echo "T7 FAIL: completion should FAIL without ledger"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
