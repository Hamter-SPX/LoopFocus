#!/usr/bin/env bash
# Constitution Check — no proposal may violate or silently skip the Security Constitution
set -u

CONST=".loopfocus/constitution.md"
PROPOSAL=".loopfocus/proposal.md"

[ -f "$CONST" ] || { echo '{"verdict":"FAIL","reason":"no constitution.md — write the Security Constitution first"}'; exit 1; }
[ -f "$PROPOSAL" ] || { echo '{"verdict":"FAIL","reason":"no proposal.md — declare compliance per CONST"}'; exit 1; }

problems=""
blocked=""

while IFS= read -r line; do
  id=$(echo "$line" | sed -n 's/^\(CONST-[0-9]*\)[[:space:]].*/\1/p')
  [ -n "$id" ] || continue
  verdict_line=$(grep -E "^$id:" "$PROPOSAL" | head -1)
  if [ -z "$verdict_line" ]; then
    problems="$problems $id(unaddressed)"
  elif echo "$verdict_line" | grep -qE '^'$id':[[:space:]]*violate'; then
    blocked="$blocked $id"
  fi
done < "$CONST"

if [ -n "$blocked" ]; then
  echo "{\"verdict\":\"BLOCKED\",\"violated\":[$(echo $blocked | tr ' ' '\n' | sed '/^$/d' | sed 's/^/"/;s/$/"/' | paste -sd, -)],\"action\":\"SecurityArch may not override the Constitution\"}"
  exit 1
fi

if [ -n "$problems" ]; then
  echo "{\"verdict\":\"FAIL\",\"problems\":[$(echo $problems | tr ' ' '\n' | sed '/^$/d' | sed 's/^/"/;s/$/"/' | paste -sd, -)],\"action\":\"declare compliance for every CONST\"}"
  exit 1
fi

echo '{"verdict":"PASS","note":"all CONSTs addressed, none violated"}'
exit 0
