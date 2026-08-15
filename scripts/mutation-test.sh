#!/usr/bin/env bash
# Mutation testing — prove the tests actually catch bugs.
# Injects simple mutations into source files, runs the test command,
# and measures how many mutants the suite kills.
set -u

TMPDIR_WORK=$(mktemp -d)
trap 'rm -rf "$TMPDIR_WORK"' EXIT

test_cmd=""
[ -f .loopfocus/gates.conf ] && test_cmd=$(grep -E '^test_cmd=' .loopfocus/gates.conf 2>/dev/null | head -1 | cut -d= -f2-)
[ -z "$test_cmd" ] && test_cmd="node --test"

src_files=$(find src lib app -name "*.js" -o -name "*.py" -o -name "*.ts" 2>/dev/null | grep -v test | grep -v __tests__ | head -10)
[ -z "$src_files" ] && src_files=$(find . -maxdepth 3 -name "*.js" -not -path "*/node_modules/*" -not -name "*.test.js" -not -path "*/test/*" 2>/dev/null | head -10)

[ -z "$src_files" ] && { echo '{"mutation":{"skipped":"no source files found"}}'; exit 0; }

killed=0
total=0

for src in $src_files; do
  base=$(basename "$src")
  for i in 1 2 3; do
    case $i in
      1) find_str='==='; mut='s/===/!==/g' ;;
      2) find_str='+';   mut='s/ + / - /g' ;;
      3) find_str='&&';  mut='s/&&/||/g' ;;
    esac
    grep -qF "$find_str" "$src" 2>/dev/null || continue
    cp "$src" "$TMPDIR_WORK/$base.mut"
    sed -i.bak "$mut" "$TMPDIR_WORK/$base.mut" 2>/dev/null && rm -f "$TMPDIR_WORK/$base.mut.bak"
    if ! cmp -s "$src" "$TMPDIR_WORK/$base.mut"; then
      total=$((total + 1))
      cp "$src" "$src.lf-bak"
      cp "$TMPDIR_WORK/$base.mut" "$src"
      if (eval "$test_cmd") >/dev/null 2>&1; then
        echo "  SURVIVED: $base (mutation $i) — your tests do NOT catch this class of bug"
      else
        killed=$((killed + 1))
      fi
      cp "$src.lf-bak" "$src" && rm -f "$src.lf-bak"
    fi
  done
done

[ $total -eq 0 ] && { echo '{"mutation":{"skipped":"no mutable statements found"}}'; exit 0; }

score=$((killed * 100 / total))
printf '{"mutation_score":%d,"killed":%d,"total":%d,"verdict":"%s"}\n' "$score" "$killed" "$total" "$([ $score -ge 80 ] && echo PASS || echo WEAK)"

[ $score -ge 80 ] && exit 0
exit 1
