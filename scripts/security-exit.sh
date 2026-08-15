#!/usr/bin/env bash
# Security Exit Gate — the only door out of SecurityArch mode
set -u

STATE=".loopfocus/state.md"
LEDGER=".loopfocus/ledger.md"
missing=""

check() {
  local name="$1" ok="$2"
  if [ "$ok" -eq 0 ]; then
    printf '{"condition":"%s","status":"PASS"}\n' "$name"
  else
    printf '{"condition":"%s","status":"FAIL"}\n' "$name"
    missing="$missing $name"
  fi
}

[ -f "$LEDGER" ] || { echo '{"verdict":"FAIL","missing":["ledger"]}'; exit 1; }

grep -qiE 'trust boundary|trust-boundary|zones:' "$LEDGER" \
  && grep -qiE 'attack surface|entry point' "$LEDGER" \
  && grep -qiE 'data flow|data-flow' "$LEDGER" \
  && grep -qiE 'privilege' "$LEDGER"; check mappers $?

grep -qiE 'threat model|threat-model' "$LEDGER"; check threat_model $?
grep -qiE 'invariant' "$LEDGER"; check invariants $?

grep -qiE 'injection' "$LEDGER" \
  && grep -qiE 'authn|authentication|authz|authorization' "$LEDGER" \
  && grep -qiE 'secret' "$LEDGER" \
  && grep -qiE 'dependency' "$LEDGER" \
  && grep -qiE 'transport|network' "$LEDGER" \
  && grep -qiE 'data exposure|exposure' "$LEDGER" \
  && grep -qiE 'business logic|logic' "$LEDGER"; check seven_categories $?

grep -qiE 'sast' "$LEDGER"; check machine_scans $?
grep -qiE 'decision|accepted|rejected' "$LEDGER"; check decision_log $?
grep -qiE 're-verify|reverify|re_verify' "$LEDGER"; check re_verify $?
grep -qiE 'asked|propose|selection' "$LEDGER"; check user_asked $?

if [ -z "$missing" ]; then
  echo '{"verdict":"PASS"}'
  exit 0
else
  echo "{\"verdict\":\"FAIL\",\"missing\":[$(echo $missing | tr ' ' '\n' | sed '/^$/d' | sed 's/^/"/;s/$/"/' | paste -sd, -)]}"
  exit 1
fi
