#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
VF="$S/loopfocus-verify.sh"
TMP=$(mktemp -d)
fail=0

(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -ne 0 ] || { echo "T1 FAIL: should fail without state"; fail=1; }

mkdir -p "$TMP/.loopfocus"
printf 'UNKNOWN: blocker X exists\n' > "$TMP/.loopfocus/state.md"
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -ne 0 ] || { echo "T2 FAIL: should fail with blockers"; fail=1; }

printf 'UNKNOWN: none\nNEXT: done\n' > "$TMP/.loopfocus/state.md"
printf 'hypothesis: fixed\nactual result: tests pass\n' > "$TMP/.loopfocus/ledger.md"
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -eq 0 ] || { echo "T3 FAIL: should pass with clean state"; fail=1; }

printf '## UNKNOWN\n- blocker evading regex\n' > "$TMP/.loopfocus/state.md"
(cd "$TMP" && "$VF" >/dev/null 2>&1)
[ $? -ne 0 ] || { echo "T4 FAIL: should fail on markdown-heading blocker evasion"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
