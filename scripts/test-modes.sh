#!/usr/bin/env bash
set -u
S=/Users/jirawat/Projects/SkillHub/LoopFocus/scripts
TMP=$(mktemp -d)
fail=0

out=$(node "$S/mode.js" resolve "help me fix the login bug")
echo "$out" | grep -q '"mode":"debug"' || { echo "T1 FAIL: fix bug should resolve to debug"; fail=1; }

out=$(node "$S/mode.js" resolve "security audit please")
echo "$out" | grep -q '"mode":"security"' || { echo "T2 FAIL: audit should resolve to security"; fail=1; }

out=$(node "$S/mode.js" resolve "build a new feature for checkout")
echo "$out" | grep -q '"mode":"build"' || { echo "T3 FAIL: feature should resolve to build"; fail=1; }

out=$(node "$S/mode.js" resolve "how does this router work?")
echo "$out" | grep -q '"mode":"analyze"' || { echo "T4 FAIL: question should resolve to analyze"; fail=1; }

node "$S/mode.js" show debug | grep -q '"closes_when"' || { echo "T5 FAIL: show should print full contract"; fail=1; }

mkdir -p "$TMP/.loopfocus"
printf '{"mode":"debug","goal_locked":true,"gates_ran":["entry","context","mutation","build","test","regression","progress","repeat","completion"],"recheck_pass":true}' > "$TMP/.loopfocus/mode-state.json"
(cd "$TMP" && node "$S/mode.js" check debug) | grep -q '"verdict":"PASS"' || { echo "T6 FAIL: complete state should pass check"; fail=1; }

printf '{"mode":"debug","goal_locked":false,"gates_ran":[],"recheck_pass":false}' > "$TMP/.loopfocus/mode-state.json"
(cd "$TMP" && node "$S/mode.js" check debug) | grep -q '"verdict":"FAIL"' || { echo "T7 FAIL: incomplete state should fail check"; fail=1; }

(cd "$TMP" && bash "$S/state-init.sh") >/dev/null 2>&1 || { echo "T8 FAIL: state-init should succeed"; fail=1; }
[ -f "$TMP/.loopfocus/state.md" ] || { echo "T9 FAIL: state-init should create state.md"; fail=1; }
[ -f "$TMP/.loopfocus/profile" ] || { echo "T10 FAIL: state-init should create profile"; fail=1; }

(cd "$TMP" && bash "$S/handoff.sh" "fix the remaining bug") >/dev/null 2>&1 || { echo "T11 FAIL: handoff should succeed"; fail=1; }
grep -q "fix the remaining bug" "$TMP/.loopfocus/handoff.md" || { echo "T12 FAIL: handoff should include the request"; fail=1; }
grep -q "Locked goal" "$TMP/.loopfocus/handoff.md" || { echo "T13 FAIL: handoff should include goal section"; fail=1; }

bash "$S/loopfocus" help | grep -q "genome" || { echo "T14 FAIL: CLI help should list commands"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
