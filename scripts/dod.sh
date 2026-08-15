#!/usr/bin/env bash
set -u

DOD=".loopfocus/dod.md"

emit() {
  local node="$1" status="$2" reason="$3"
  printf '{"node":"%s","status":"%s","reason":"%s"}\n' "$node" "$status" "$reason"
}

[ -f "$DOD" ] || { echo '{"error":"no .loopfocus/dod.md — write the DoD chain at LOCK"}'; exit 1; }

prev_fail=0
exit_code=0

while IFS= read -r line; do
  [ -n "$(echo "$line" | tr -d '[:space:]')" ] || continue
  node=$(echo "$line" | sed -n 's/^\([^←]*\)[[:space:]]*←.*/\1/p' | sed 's/[[:space:]]*$//')
  cmd=$(echo "$line" | sed -n 's/^[^←]*←[[:space:]]*//p')
  if [ -z "$node" ]; then
    node=$(echo "$line" | sed 's/[[:space:]]*$//')
    cmd=""
  fi

  if [ $prev_fail -eq 1 ]; then
    emit "$node" BLOCKED "earlier node failed — chain broken"
    continue
  fi

  case "$cmd" in
    "")
      emit "$node" UNVERIFIED "no evidence command"
      prev_fail=1
      exit_code=1
      ;;
    *)
      if (eval "$cmd") >/dev/null 2>&1; then
        emit "$node" PASS ""
      else
        emit "$node" FAIL "command failed"
        prev_fail=1
        exit_code=1
      fi
      ;;
  esac
done < "$DOD"

exit $exit_code
