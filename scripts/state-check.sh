#!/usr/bin/env bash
set -u

STATE=".loopfocus/state.md"
problems=0

report() { printf '  - %s\n' "$1"; problems=$((problems + 1)); }

[ -f "$STATE" ] || { echo '{"verdict":"FAIL","reason":"no state.md"}'; exit 1; }

grep -qE '^goal:' "$STATE" || report "no 'goal:' line"
grep -qE '^#{0,6}[[:space:]]*UNKNOWN:' "$STATE" || report "no UNKNOWN: line (must end 'UNKNOWN: none')"
grep -qE '^#{0,6}[[:space:]]*NEXT:' "$STATE" || report "no NEXT: line (must end 'NEXT: none' or 'NEXT: done')"

grep -E '^#{0,6}[[:space:]]*UNKNOWN' "$STATE" | grep -vqE '^#{0,6}[[:space:]]*UNKNOWN:[[:space:]]*none$' \
  && report "UNKNOWN contains non-'none' entries — blockers remain"
grep -E '^#{0,6}[[:space:]]*NEXT' "$STATE" | grep -vqE '^#{0,6}[[:space:]]*NEXT:[[:space:]]*(none|done)$' \
  && report "NEXT contains non-none/done entries — work remains"

[ -f .loopfocus/ledger.md ] || report "no ledger.md"
[ -f .loopfocus/profile ] || report "no profile"

if [ $problems -eq 0 ]; then
  echo '{"verdict":"PASS"}'
  exit 0
else
  echo "{\"verdict\":\"FAIL\",\"problems\":$problems}"
  exit 1
fi
