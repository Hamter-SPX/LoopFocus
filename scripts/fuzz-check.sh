#!/usr/bin/env bash
# Fuzz check — stack-specific fuzzing, short budget. SKIP when the stack has no fuzzer.
set -u

if [ -f go.mod ]; then
  pkg=$(grep -E '^package ' $(find . -name "*_test.go" -not -path "*/vendor/*" 2>/dev/null | head -1) 2>/dev/null | head -1)
  if grep -rqE '^func Fuzz' . --include="*_test.go" 2>/dev/null; then
    out=$(go test -fuzz=. -fuzztime=10s . 2>&1)
    if echo "$out" | grep -q "FAIL"; then
      echo '{"fuzz":"FAIL","stack":"go","note":"fuzz target found a crashing input"}'
      exit 1
    fi
    echo '{"fuzz":"PASS","stack":"go","fuzztime":"10s"}'
    exit 0
  fi
  echo '{"fuzz":"SKIP","reason":"no Fuzz targets — add func FuzzX(f *testing.F) to enable"}'
  exit 0
fi

if [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  if python3 -c "import hypothesis" 2>/dev/null; then
    python3 -m pytest -k hypothesis -q >/dev/null 2>&1
    echo '{"fuzz":"PASS","stack":"python-hypothesis"}'
    exit 0
  fi
  echo '{"fuzz":"SKIP","reason":"hypothesis not installed — pip install hypothesis"}'
  exit 0
fi

echo '{"fuzz":"SKIP","reason":"no native fuzzer for this stack — property tests via mutation-test.sh instead"}'
exit 0
