#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0

mkdir -p "$TMP/proj" && cd "$TMP/proj" || exit 1
printf '{\n  "name": "deep-test",\n  "scripts": { "test": "node --test" }\n}\n' > package.json
mkdir -p src test

printf 'function add(a, b) { return a + b; }\nmodule.exports = { add };\n' > src/math.js
printf 'const { add } = require("../src/math.js");\nconst assert = require("assert");\nconst { test } = require("node:test");\n\ntest("add works", () => { assert.strictEqual(add(2, 3), 5); });\n' > test/math.test.js

out=$(bash "$S/mutation-test.sh" 2>&1)
echo "$out" | grep -q 'mutation_score\|killed' || { echo "T1 FAIL: mutation-test should report score"; fail=1; }

out=$(bash "$S/coverage.sh" 2>&1)
echo "$out" | grep -qE 'coverage|SKIP|PASS' || { echo "T2 FAIL: coverage should report something"; fail=1; }

printf 'const sql = "SELECT * FROM users WHERE name = \x27" + input + "\x27";\nconst e = eval(userCode);\nconst secret = "sk_live_1234567890abcdef";\n' > src/vuln.js
out=$(bash "$S/sast.sh" 2>&1)
echo "$out" | grep -qi 'sql\|injection' || { echo "T3 FAIL: sast should flag SQL concat"; fail=1; }
echo "$out" | grep -qi 'eval' || { echo "T4 FAIL: sast should flag eval"; fail=1; }
echo "$out" | grep -qi 'secret\|key' || { echo "T5 FAIL: sast should flag hardcoded secret"; fail=1; }

out=$(bash "$S/fuzz-check.sh" 2>&1)
echo "$out" | grep -qE 'fuzz|SKIP' || { echo "T6 FAIL: fuzz-check should report or SKIP"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
