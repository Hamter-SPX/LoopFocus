#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"

(cd "$TMP" && bash "$S/security-exit.sh") >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T1 FAIL: no ledger should fail"; fail=1; }

printf 'trust boundary: untrusted/semi/trusted zones mapped\nattack surface: entry points listed\ndata flow: credentials traced\privilege: graph drawn\nthreat model: STRIDE walk done\ninvariants: verified\ninjection: checked none\nauthentication: token check weak\nsecrets: db.js hardcoded\ndependency: npm audit run\ntransport: tls at proxy\n' > "$TMP/.loopfocus/ledger.md"
(cd "$TMP" && bash "$S/security-exit.sh") >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T2 FAIL: partial ledger should fail"; fail=1; }

cat >> "$TMP/.loopfocus/ledger.md" << 'EOF'
data exposure: /debug dumps env
business logic: login gives admin token
sast: run, 2 critical dispositioned
decisions: accepted /api/health risk with reopen-if
re-verify: clean pass after last fix
user asked: fix selections recorded
EOF
out=$(cd "$TMP" && bash "$S/security-exit.sh")
echo "$out" | grep -q '"verdict":"PASS"' || { echo "T3 FAIL: complete ledger should pass"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
