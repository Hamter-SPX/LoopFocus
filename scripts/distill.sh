#!/usr/bin/env bash
set -u

STATE=".loopfocus/state.md"
OUT=".loopfocus/current-truth.md"

[ -f "$STATE" ] || { echo "no .loopfocus/state.md — LOCK first"; exit 1; }

mission=$(grep -E '^goal:' "$STATE" | head -1 | sed 's/^goal:[[:space:]]*//')
preserve=$(grep -A5 '^invariants:' "$STATE" | grep -E '^[[:space:]]*- ' | head -3 | sed 's/^[[:space:]]*- //' | tr '\n' ';' | sed 's/;$//')

blocker=""
unknown_line=$(grep -E '^#{0,6}[[:space:]]*UNKNOWN:' "$STATE" | head -1 | sed 's/^#*[[:space:]]*UNKNOWN:[[:space:]]*//')
[ -n "$unknown_line" ] && [ "$unknown_line" != "none" ] && blocker="$unknown_line"
[ -z "$blocker" ] && blocker="(none recorded)"

next=$(grep -E '^#{0,6}[[:space:]]*NEXT:' "$STATE" | head -1 | sed 's/^#*[[:space:]]*NEXT:[[:space:]]*//')
[ -z "$next" ] && next="(none)"

{
  echo "MISSION:        $mission"
  echo "MUST PRESERVE:  ${preserve:- (none recorded)}"
  echo "CURRENT BLOCKER: $blocker"
  echo "NEXT PROOF:     $next"
} > "$OUT"

cat "$OUT"
echo
echo "distilled to $OUT — pin these four lines at every loop start"
