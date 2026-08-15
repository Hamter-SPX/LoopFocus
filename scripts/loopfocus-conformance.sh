#!/usr/bin/env bash
set -u

DIR="$(pwd)"
while [ $# -gt 0 ]; do
  case "$1" in
    --dir) DIR="$2"; shift 2 ;;
    *) echo "usage: loopfocus-conformance.sh [--dir <skill-root>]"; exit 2 ;;
  esac
done

cd "$DIR" || { echo "dir not found: $DIR"; exit 2; }
[ -f SKILL.md ] || { echo "CONFORMANCE FAIL: no SKILL.md in $DIR"; exit 1; }

problems=0
report() { printf '  - %s\n' "$1"; problems=$((problems + 1)); }
header() { printf '[%s]\n' "$1"; }

header "metadata"
name=$(sed -n 's/^name: *//p' SKILL.md | head -1)
desc=$(sed -n 's/^description: *//p' SKILL.md | head -1)
echo "$name" | grep -qE '^[a-z0-9-]+$' || report "name '$name' must be lowercase letters, numbers, hyphens only"
[ -n "$desc" ] || report "description missing"
echo "$desc" | grep -q '^Use when' || report "description must start with 'Use when'"
[ "$(printf '%s' "$desc" | wc -c)" -le 1024 ] || report "description exceeds 1024 chars"

header "references"
refs_ok=1
for ref in $(grep -oE '`(references|flow|schemas|templates|prompts)/[a-zA-Z0-9/._-]+\.(md|json|template)`' SKILL.md | tr -d '`'); do
  [ -f "$ref" ] || { report "missing reference: $ref"; refs_ok=0; }
done
[ $refs_ok -eq 1 ] && echo "  - all referenced files exist"

header "required structure"
for d in references flow schemas templates scripts; do
  [ -d "$d" ] || report "missing directory: $d"
done
for f in scripts/loopfocus-verify.sh scripts/gate-runner.sh scripts/fast-gate.sh scripts/tool-discovery.sh scripts/loop-genome.js scripts/normalize-signal.js scripts/git-state.js scripts/ci-controller.js; do
  [ -f "$f" ] || report "missing tool: $f"
done
for f in flow/bug-fix-flow.md flow/feature-build-flow.md flow/security-audit-flow.md flow/review-flow.md flow/recovery-flow.md; do
  [ -f "$f" ] || report "missing flow: $f"
done
for f in templates/state.md.template templates/ledger.md.template templates/dod.md.template; do
  [ -f "$f" ] || report "missing template: $f"
done
[ -f LOOPFOCUS_ALL_IN_ONE.md ] || report "missing all-in-one: run scripts/build-all-in-one.sh"

header "schemas valid JSON"
for s in schemas/*.json; do
  [ -f "$s" ] || continue
  node -e "JSON.parse(require('fs').readFileSync('$s','utf8'))" 2>/dev/null || report "invalid JSON: $s"
done

header "script syntax"
for sh in scripts/*.sh; do
  bash -n "$sh" 2>/dev/null || report "syntax error: $sh"
done
for js in scripts/*.js; do
  node --check "$js" 2>/dev/null || report "syntax error: $js"
done

header "test suites"
for t in test-verify test-gate test-genome test-toolbus test-security-exit test-sec-tools test-sec-engines; do
  if [ -f "scripts/$t.sh" ]; then
    bash "scripts/$t.sh" >/dev/null 2>&1 && echo "  - $t: PASS" || report "$t: FAIL"
  fi
done

if [ $problems -eq 0 ]; then
  echo "CONFORMANCE: PASS"
  exit 0
else
  echo "CONFORMANCE: FAIL ($problems problems)"
  exit 1
fi
