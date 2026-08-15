#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"

out=$(node "$S/convergence.js" --sequence 18,11,6,4,3)
echo "$out" | grep -q '"verdict":"converging"' || { echo "T1 FAIL: 18,11,6,4,3 should be converging"; fail=1; }

out=$(node "$S/convergence.js" --sequence 18,16,19,14,21)
echo "$out" | grep -q '"verdict":"unstable"' || { echo "T2 FAIL: oscillation should be unstable"; fail=1; }
echo "$out" | grep -q '"action":"mutate"' || { echo "T3 FAIL: unstable should mutate"; fail=1; }

out=$(node "$S/convergence.js" --sequence 5,5,5,5)
echo "$out" | grep -q '"verdict":"flat"' || { echo "T4 FAIL: 5,5,5,5 should be flat"; fail=1; }

out=$(node "$S/convergence.js" --sequence 8,3,9)
echo "$out" | grep -q '"verdict":"regressed"' || { echo "T5 FAIL: 8,3,9 should be regressed"; fail=1; }

node "$S/convergence.js" --sequence 8,3,9 >/dev/null 2>&1
[ $? -eq 2 ] || { echo "T6 FAIL: regressed should exit 2 (rollback signal)"; fail=1; }

node "$S/loop-genome.js" record --class conv-test --strategy caller-patch --result fail --delta 0 --current-failures 5 --reason "same error" --hypothesis "h1" --cwd "$TMP" >/dev/null 2>&1
node "$S/loop-genome.js" record --class conv-test --strategy caller-patch --result fail --delta 0 --current-failures 4 --reason "same error" --hypothesis "h2" --cwd "$TMP" >/dev/null 2>&1
node "$S/loop-genome.js" record --class conv-test --strategy dep-inspect --result fail --delta 0 --current-failures 2 --reason "progress" --hypothesis "h3" --cwd "$TMP" >/dev/null 2>&1
out=$(node "$S/convergence.js" --class conv-test --cwd "$TMP")
echo "$out" | grep -q '"verdict":"converging"' || { echo "T7 FAIL: genome sequence 5,4,2 should be converging"; fail=1; }

out=$(node "$S/loop-fingerprint.js" --class conv-test --approach caller-patch --files src/index.js --error greeting-undefined --cwd "$TMP")
echo "$out" | grep -q '"action":"mutate"' || { echo "T8 FAIL: repeated fingerprint should block"; fail=1; }
node "$S/loop-fingerprint.js" --class conv-test --approach caller-patch --cwd "$TMP" >/dev/null 2>&1
[ $? -eq 1 ] || { echo "T9 FAIL: repeat should exit 1"; fail=1; }

out=$(node "$S/loop-fingerprint.js" --class conv-test --approach brand-new-family --cwd "$TMP")
echo "$out" | grep -q '"action":"continue"' || { echo "T10 FAIL: new family should be allowed"; fail=1; }

git -C "$TMP" init -q && git -C "$TMP" add -A && git -C "$TMP" commit -qm init
for i in 1 2 3 4 5; do printf 'line %s\n' "$i" >> "$TMP/big.txt"; done
git -C "$TMP" add -A >/dev/null
out=$(node "$S/entropy.js" --class conv-test --cwd "$TMP")
echo "$out" | grep -q '"entropy_warning"' || { echo "T11 FAIL: entropy should output warning field"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
