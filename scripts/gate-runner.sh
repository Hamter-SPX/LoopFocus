#!/usr/bin/env bash
set -u

DIR=".loopfocus"
CONF="$DIR/gates.conf"
METRICS="$DIR/metrics"
PROFILE="$DIR/profile"
STATE="$DIR/state.md"
LEDGER="$DIR/ledger.md"

profile=$(cat "$PROFILE" 2>/dev/null || echo NORMAL)
attempt=0
blocking_fail=0

[ -f "$METRICS" ] && { runs=$(grep -E '^runs=' "$METRICS" | cut -d= -f2); attempt=$(( ${runs:-0} + 1 )); }
printf 'runs=%s\n' "$attempt" > "$METRICS"

get_conf() { grep -E "^$1=" "$CONF" 2>/dev/null | head -1 | cut -d= -f2-; }

emit() {
  local gate="$1" status="$2" blocking="$3" reason="$4" next="$5"
  printf '{"gate":"%s","status":"%s","attempt":%s,"reason":"%s","blocking":%s,"next_action":"%s"}\n' \
    "$gate" "$status" "$attempt" "$reason" "$blocking" "$next"
}

emit_pass() { emit "$1" PASS false "" ""; }
emit_fail() { emit "$1" FAIL true "$2" "$3"; blocking_fail=1; }
emit_skip() { emit "$1" SKIP false "$2" ""; }

in_profile() {
  case "$profile" in
    LIGHT) case "$1" in entry|build|test|completion) return 0;; *) return 1;; esac ;;
    NORMAL) case "$1" in entry|build|static|test|regression|evidence-freshness|checkpoint|completion) return 0;; *) return 1;; esac ;;
    DEEP) return 0 ;;
  esac
}

run_gate() { local cmd="$1"; (eval "$cmd") >/dev/null 2>&1; }

in_profile entry && {
  if [ -f "$STATE" ] && grep -qE '^goal:' "$STATE"; then
    emit_pass entry
  else
    emit_fail entry "no .loopfocus/state.md with goal recorded" "record_state"
  fi
}

in_profile build && {
  bc=$(get_conf build_cmd)
  if [ -n "$bc" ]; then
    if run_gate "$bc"; then emit_pass build; else emit_fail build "build command failed" "fix_build"; fi
  else
    emit_skip build "no build_cmd configured"
  fi
}

in_profile static && {
  sc=$(get_conf static_cmd)
  if [ -n "$sc" ]; then
    if run_gate "$sc"; then emit_pass static; else emit_fail static "static checks failed" "fix_static"; fi
  else
    emit_skip static "no static_cmd configured"
  fi
}

in_profile test && {
  tc=$(get_conf test_cmd)
  if [ -n "$tc" ]; then
    if run_gate "$tc"; then emit_pass test; else emit_fail test "test command failed" "fix_tests"; fi
  else
    emit_skip test "no test_cmd configured"
  fi
}

in_profile regression && {
  tcc=$(get_conf test_count_cmd)
  if [ -n "$tcc" ]; then
    old=$(grep -E '^test_count=' "$METRICS" 2>/dev/null | cut -d= -f2)
    new=$(eval "$tcc" 2>/dev/null | tr -d '[:space:]')
    if [ -n "$old" ] && [ -n "$new" ] && [ "$new" -lt "$old" ] 2>/dev/null; then
      emit_fail regression "test count dropped $old -> $new" "fix_regression"
    else
      emit_pass regression
    fi
    printf 'test_count=%s\n' "$new" >> "$METRICS"
  else
    emit_skip regression "no test_count_cmd configured"
  fi
}

in_profile evidence-freshness && {
  if [ -f "$STATE" ]; then
    stale=$(find . -path ./.git -prune -o -path ./.loopfocus -prune -o -type f -newer "$STATE" -print 2>/dev/null | head -1)
    if [ -n "$stale" ]; then
      emit_fail evidence-freshness "code changed after state was recorded" "update_state"
    else
      emit_pass evidence-freshness
    fi
  else
    emit_skip evidence-freshness "no state.md"
  fi
}

in_profile checkpoint && {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    emit_pass checkpoint
  else
    emit_fail checkpoint "no git repository — no rollback point" "init_git"
  fi
}

in_profile artifact && {
  af=$(get_conf artifact_file)
  if [ -n "$af" ]; then
    if [ -s "$af" ]; then emit_pass artifact; else emit_fail artifact "artifact file missing or empty" "produce_artifact"; fi
  else
    emit_skip artifact "no artifact_file configured"
  fi
}

in_profile completion && {
  completion_ok=1
  if grep -E '^#{0,6}[[:space:]]*UNKNOWN' "$STATE" 2>/dev/null | grep -vqE '^#{0,6}[[:space:]]*UNKNOWN:[[:space:]]*none$'; then
    emit_fail completion "known blockers remain" "resolve_blockers"
    completion_ok=0
  fi
  if grep -E '^#{0,6}[[:space:]]*NEXT' "$STATE" 2>/dev/null | grep -vqE '^#{0,6}[[:space:]]*NEXT:[[:space:]]*(none|done)$'; then
    emit_fail completion "next action still pending" "finish_next_action"
    completion_ok=0
  fi
  if [ ! -f "$LEDGER" ] || ! grep -qE '^actual result:' "$LEDGER"; then
    emit_fail completion "no ledger with actual results" "record_ledger"
    completion_ok=0
  fi
  if [ "$completion_ok" -eq 1 ]; then
    emit_pass completion
  fi
}

exit $blocking_fail
