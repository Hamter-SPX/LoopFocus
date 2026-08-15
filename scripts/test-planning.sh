#!/usr/bin/env bash
set -u
S=/Users/jirawat/Projects/SkillHub/LoopFocus/scripts
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"
cd "$TMP" || exit 1

printf 'feature works ← echo ok\ntests pass ← echo ok\nno regression ← echo ok\nverify ← echo ok\ndone ← echo ok\n' > .loopfocus/dod.md
out=$(bash "$S/dod.sh" 2>&1)
echo "$out" | grep -q '"node":"verify","status":"PASS"' || { echo "T1 FAIL: dod should walk all nodes"; fail=1; }

printf 'feature works ← false\ntests pass ← echo ok\n' > .loopfocus/dod.md
out=$(bash "$S/dod.sh" 2>&1)
echo "$out" | grep -q '"node":"tests pass","status":"BLOCKED"' || { echo "T2 FAIL: later nodes should BLOCK after a fail"; fail=1; }
bash "$S/dod.sh" >/dev/null 2>&1
[ $? -eq 1 ] || { echo "T3 FAIL: failed chain should exit 1"; fail=1; }

printf 'feature works\n' > .loopfocus/dod.md
out=$(bash "$S/dod.sh" 2>&1)
echo "$out" | grep -q 'UNVERIFIED' || { echo "T4 FAIL: node without command should be UNVERIFIED"; fail=1; }

printf '{"tasks":[{"id":"a"},{"id":"b","depends":["a"]},{"id":"c","depends":["a"]},{"id":"d","depends":["b"]}]}' > "$TMP/graph.json"
out=$(node "$S/critical-path.js" "$TMP/graph.json")
echo "$out" | grep -q '"critical_path_length": 3' || { echo "T5 FAIL: path a→b→d length 3"; fail=1; }
echo "$out" | grep -q '"critical_path": \[$' && echo "$out" | grep -A1 '"critical_path"' | grep -q '"d"' || { echo "T6 FAIL: d should be critical"; fail=1; }

mkdir -p "$TMP/proj" && cd "$TMP/proj" || exit 1
git init -q
mkdir -p src
printf 'const { util } = require("./util");\nconsole.log(util);\n' > src/app.js
printf 'module.exports = { util: 1 };\n' > src/util.js
git add -A && git commit -qm init
out=$(node "$S/predictive.js" --target src/util.js --cwd "$TMP/proj")
echo "$out" | grep -q '"callers": 1' || { echo "T7 FAIL: util.js should have 1 caller"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
