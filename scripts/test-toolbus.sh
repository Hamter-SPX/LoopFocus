#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0

mkdir -p "$TMP/proj" && cd "$TMP/proj" || exit 1

printf '{"scripts":{"test":"node --test","lint":"eslint ."},"devDependencies":{"eslint":"^9"}}\n' > package.json
mkdir -p .github/workflows
printf 'name: CI\non: [push]\njobs:\n  test:\n    runs-on: ubuntu-latest\n    steps: []\n' > .github/workflows/ci.yml

bash "$S/tool-discovery.sh" >/dev/null 2>&1 || { echo "T1 FAIL: tool-discovery should succeed"; fail=1; }
[ -f .loopfocus/gates.conf ] || { echo "T2 FAIL: gates.conf should be created"; fail=1; }
grep -q '^test_cmd=node --test$' .loopfocus/gates.conf || { echo "T3 FAIL: test_cmd should be detected"; fail=1; }
grep -q '^has_ci=github$' .loopfocus/gates.conf || { echo "T4 FAIL: CI should be detected"; fail=1; }

printf 'PASS ok\nFAIL no\n' > /tmp/fake-test-output.txt
out=$(node "$S/normalize-signal.js" --source local:test --status fail --previous-failures 17 --current-failures 3 --failure-class webkit-nav --new-regressions 0 --evidence-fresh true --attempt 12)
echo "$out" | grep -q '"delta":"+14"' || { echo "T5 FAIL: delta should be +14"; fail=1; }
echo "$out" | grep -q '"progress":true' || { echo "T6 FAIL: progress should be true when failures drop"; fail=1; }

out=$(node "$S/normalize-signal.js" --source local:test --status fail --previous-failures 3 --current-failures 3 --attempt 12)
echo "$out" | grep -q '"progress":false' || { echo "T7 FAIL: flat failure count should be no progress"; fail=1; }

printf '#!/usr/bin/env bash\necho "build ok"\n' > /tmp/fake-build.sh
printf '#!/usr/bin/env bash\necho "lint ok"\n' > /tmp/fake-lint.sh
printf '#!/usr/bin/env bash\necho "tests ok"\n' > /tmp/fake-test.sh
chmod +x /tmp/fake-build.sh /tmp/fake-lint.sh /tmp/fake-test.sh
printf 'build_cmd=/tmp/fake-build.sh\nstatic_cmd=/tmp/fake-lint.sh\ntest_cmd=/tmp/fake-test.sh\n' > .loopfocus/gates.conf
out=$(bash "$S/fast-gate.sh" 2>&1)
echo "$out" | grep -q '"gate":"build","status":"PASS"' || { echo "T8 FAIL: fast-gate should pass build"; fail=1; }
echo "$out" | grep -q '"gate":"test","status":"PASS"' || { echo "T9 FAIL: fast-gate should pass test"; fail=1; }

printf '#!/usr/bin/env bash\nexit 1\n' > /tmp/fake-build.sh
out=$(bash "$S/fast-gate.sh" 2>&1)
echo "$out" | grep -q '"gate":"build","status":"FAIL"' || { echo "T10 FAIL: fast-gate should catch build failure"; fail=1; }
echo "$out" | grep -q '"gate":"test"' && { echo "T11 FAIL: fast-gate should stop after build failure"; fail=1; }

git init -q . && git add -A && git commit -qm init
printf 'x\n' >> tracked.txt && git add tracked.txt
out=$(node "$S/git-state.js" 2>&1)
echo "$out" | grep -q 'tracked.txt' || { echo "T12 FAIL: git-state should list changed files"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
