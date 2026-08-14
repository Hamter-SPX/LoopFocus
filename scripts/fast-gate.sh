#!/usr/bin/env bash
set -u

CONF=".loopfocus/gates.conf"
attempt=0
fail=0

[ -f .loopfocus/metrics ] && attempt=$(( $(grep -E '^runs=' .loopfocus/metrics | cut -d= -f2) + 1 ))
mkdir -p .loopfocus
printf 'runs=%s\n' "$attempt" > .loopfocus/metrics

get_conf() { grep -E "^$1=" "$CONF" 2>/dev/null | head -1 | cut -d= -f2-; }

emit() {
  local gate="$1" status="$2" reason="$3"
  printf '{"gate":"%s","status":"%s","attempt":%s,"reason":"%s","blocking":%s,"next_action":"%s"}\n' \
    "$gate" "$status" "$attempt" "$reason" "$([ "$status" = FAIL ] && echo true || echo false)" \
    "$([ "$status" = FAIL ] && echo "fix_$gate" || echo "")"
}

run_stage() {
  local name="$1" cmd="$2"
  if [ -z "$cmd" ]; then
    emit "$name" SKIP "no ${name}_cmd configured"
    return 0
  fi
  if (eval "$cmd") >/dev/null 2>&1; then
    emit "$name" PASS ""
    return 0
  else
    emit "$name" FAIL "${name} command failed"
    fail=1
    return 1
  fi
}

run_stage build "$(get_conf build_cmd)" || exit 1
run_stage static "$(get_conf static_cmd)" || exit 1
run_stage test "$(get_conf test_cmd)" || exit 1

exit $fail
