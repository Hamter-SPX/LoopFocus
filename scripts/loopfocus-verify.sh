#!/usr/bin/env bash
set -u

STATE=".loopfocus/state.md"
LEDGER=".loopfocus/ledger.md"

fail() {
  local gate="$1" reason="$2" action="$3"
  printf '{"gate":"%s","status":"FAIL","reason":"%s","blocking":true,"next_action":"%s"}\n' \
    "$gate" "$reason" "$action"
  exit 1
}

pass() {
  printf '{"gate":"completion","status":"PASS","blocking":false,"next_action":"ready_to_finish"}\n'
  exit 0
}

[ -f "$STATE" ] || fail "completion" "no .loopfocus/state.md recorded" "record_state"

if grep -qE '^UNKNOWN:' "$STATE" && ! grep -qE '^UNKNOWN: none$' "$STATE"; then
  fail "completion" "known blockers remain" "resolve_blockers"
fi

if grep -qE '^NEXT:' "$STATE" && ! grep -qE '^NEXT: (none|done)$' "$STATE"; then
  fail "completion" "next action still pending" "finish_next_action"
fi

if [ ! -f "$LEDGER" ] || ! grep -qE '^actual result:' "$LEDGER"; then
  fail "completion" "no ledger with actual results" "record_ledger"
fi

pass
