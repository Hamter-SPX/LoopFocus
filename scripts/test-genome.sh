#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
GEN="$S/loop-genome.js"
TMP=$(mktemp -d)
mkdir -p "$TMP/.loopfocus"
fail=0

node "$GEN" record --class refund-window --strategy boundary-constant --result fail --delta 0 --reason "test still fails" --hypothesis "off-by-one in window" --cwd "$TMP" >/dev/null 2>&1 || { echo "T1 FAIL: record should succeed"; fail=1; }

node "$GEN" record --class refund-window --strategy dependency-inspect --result success --delta 1 --reason "found tz bug" --hypothesis "bug in shared util" --cwd "$TMP" >/dev/null 2>&1 || { echo "T2 FAIL: record should succeed"; fail=1; }

out=$(node "$GEN" query --class refund-window --cwd "$TMP" 2>&1)
echo "$out" | grep -q 'dependency-inspect' || { echo "T3 FAIL: query should return winner strategy"; fail=1; }
echo "$out" | grep -q 'banned' || { echo "T4 FAIL: query should list banned strategies"; fail=1; }

out=$(node "$GEN" query --class nonexistent-class --cwd "$TMP" 2>&1)
echo "$out" | grep -q 'no past records' || { echo "T5 FAIL: query on unknown class should say no records"; fail=1; }

node "$GEN" record --class refund-window --strategy boundary-constant --result fail --delta 0 --reason "same fail" --hypothesis "retry" --cwd "$TMP" >/dev/null 2>&1 || { echo "T6 FAIL: record should succeed"; fail=1; }
out=$(node "$GEN" query --class refund-window --cwd "$TMP" 2>&1)
echo "$out" | grep -q 'boundary-constant' || { echo "T7 FAIL: query should include failed strategies"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
