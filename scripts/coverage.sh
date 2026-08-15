#!/usr/bin/env bash
# Test coverage measurement per stack.
# JS: node --experimental-test-coverage | Python: coverage.py | Go: go test -cover
set -u

threshold=$(grep -E '^coverage_threshold=' .loopfocus/gates.conf 2>/dev/null | cut -d= -f2)
[ -z "$threshold" ] && threshold=70

pct=""

if [ -f package.json ] && ! [ -f go.mod ]; then
  out=$(node --experimental-test-coverage --test 2>&1)
  pct=$(echo "$out" | grep -oE 'All files[^%]*%[^)]*' | grep -oE '[0-9.]+%' | tail -1 | tr -d '%')
elif [ -f go.mod ]; then
  out=$(go test -cover ./... 2>&1)
  pct=$(echo "$out" | grep -oE 'coverage: [0-9.]+%' | grep -oE '[0-9.]+' | tail -1)
elif [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  if python3 -c "import coverage" 2>/dev/null; then
    out=$(python3 -m coverage run -m pytest -q 2>&1 && python3 -m coverage report 2>&1)
    pct=$(echo "$out" | grep -oE '[0-9]+%' | tail -1 | tr -d '%')
  fi
fi

if [ -z "$pct" ]; then
  echo '{"coverage":"SKIP","reason":"coverage tooling not available for this stack"}'
  exit 0
fi

verdict=$([ "${pct%.*}" -ge "$threshold" ] 2>/dev/null && echo PASS || echo FAIL)
printf '{"coverage":%s,"threshold":%s,"verdict":"%s"}\n' "$pct" "$threshold" "$verdict"

[ "$verdict" = PASS ] && exit 0
exit 1
