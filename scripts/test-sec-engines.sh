#!/usr/bin/env bash
set -u
S="$(cd "$(dirname "$0")" && pwd)"
TMP=$(mktemp -d)
fail=0
mkdir -p "$TMP/.loopfocus"

node "$S/world-model.js" init --cwd "$TMP" >/dev/null 2>&1
[ -f "$TMP/.loopfocus/world-model.json" ] || { echo "T1 FAIL: init should create model"; fail=1; }

cat > "$TMP/.loopfocus/world-model.json" << 'EOF'
{
  "system": "test",
  "entities": [
    { "type": "agent", "name": "review-bot", "zone": "semi-trusted", "anchor": "agent.yaml:1" },
    { "type": "service", "name": "ci-runner", "zone": "trusted", "anchor": "ci.yaml:1" },
    { "type": "secret", "name": "deploy-key", "zone": "trusted", "anchor": "secrets.yaml:1" },
    { "type": "service", "name": "web", "zone": "untrusted", "anchor": "server.js:1" },
    { "type": "data", "name": "orders", "zone": "trusted", "anchor": "db.js:1", "classification": "sensitive" }
  ],
  "edges": [
    { "from": "review-bot", "to": "ci-runner", "kind": "trust", "reason": "bot triggers CI", "verified": false, "assumption": "A1" },
    { "from": "ci-runner", "to": "deploy-key", "kind": "privilege", "reason": "deploy step", "verified": true },
    { "from": "web", "to": "orders", "kind": "data-flow", "reason": "query", "verified": false, "assumption": null }
  ],
  "invariants": ["orders never cross tenants"]
}
EOF

out=$(node "$S/world-model.js" check --cwd "$TMP")
echo "$out" | grep -q '"verdict":"PASS"' || { echo "T2 FAIL: valid model should pass check"; fail=1; }

out=$(node "$S/trust-entropy.js" --cwd "$TMP")
echo "$out" | grep -q '"trust_entropy"' || { echo "T3 FAIL: entropy should compute"; fail=1; }

out=$(node "$S/blast-radius.js" --cwd "$TMP")
echo "$out" | grep -q 'crown_jewel_candidates' || { echo "T4 FAIL: blast radius should compute"; fail=1; }

out=$(node "$S/capability-graph.js" --cwd "$TMP")
echo "$out" | grep -q '"overreach": true' || { echo "T5 FAIL: agent->ci->key transitive overreach should flag"; fail=1; }
node "$S/capability-graph.js" --cwd "$TMP" >/dev/null 2>&1
[ $? -eq 1 ] || { echo "T6 FAIL: overreach should exit 1"; fail=1; }

cp "$TMP/.loopfocus/world-model.json" "$TMP/before.json"
node -e "
const m = JSON.parse(require('fs').readFileSync('$TMP/.loopfocus/world-model.json','utf8'));
m.edges.push({ from: 'web', to: 'deploy-key', kind: 'privilege', reason: 'oops', verified: false });
require('fs').writeFileSync('$TMP/.loopfocus/world-model.json', JSON.stringify(m));
"
out=$(node "$S/semantic-diff.js" --before "$TMP/before.json" --after "$TMP/.loopfocus/world-model.json")
echo "$out" | grep -q 'SECURITY_MODEL_CHANGED' || { echo "T7 FAIL: new privilege edge should change security model"; fail=1; }

(cd "$TMP" && node "$S/counterexample.js" record --claim "webhook auth is secure" --attempt "forged callback with leaked secret" --result held) >/dev/null 2>&1
out=$(cd "$TMP" && node "$S/counterexample.js" check)
echo "$out" | grep -q '"verdict":"PASS"' || { echo "T8 FAIL: held claim should pass check"; fail=1; }
(cd "$TMP" && node "$S/counterexample.js" record --claim "webhook auth is secure" --attempt "replay with old signature" --result broken) >/dev/null 2>&1
out=$(cd "$TMP" && node "$S/counterexample.js" check)
echo "$out" | grep -q '"verdict": "FAIL"' || { echo "T9 FAIL: broken claim should fail check"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
