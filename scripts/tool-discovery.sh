#!/usr/bin/env bash
set -u

DIR=".loopfocus"
CONF="$DIR/gates.conf"
MAP="$DIR/tool-map.md"

mkdir -p "$DIR"
[ -f "$CONF" ] && backup=$(grep -c . "$CONF")
: > "$CONF"
: > "$MAP"

detect_json_scripts() {
  [ -f package.json ] || return
  if grep -q '"test"' package.json; then
    tc=$(sed -n 's/.*"test"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' package.json | head -1)
    [ -n "$tc" ] && printf 'test_cmd=%s\n' "$tc" >> "$CONF"
  fi
  if grep -q '"lint"' package.json; then
    lc=$(sed -n 's/.*"lint"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' package.json | head -1)
    [ -n "$lc" ] && printf 'static_cmd=%s\n' "$lc" >> "$CONF"
  fi
  if grep -q '"build"' package.json; then
    bc=$(sed -n 's/.*"build"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' package.json | head -1)
    [ -n "$bc" ] && printf 'build_cmd=%s\n' "$bc" >> "$CONF"
  fi
  echo "- npm project (package.json)" >> "$MAP"
}

detect_python() {
  [ -f pyproject.toml ] || return
  if grep -q 'pytest' pyproject.toml; then
    printf 'test_cmd=python -m pytest\n' >> "$CONF"
    printf 'test_count_cmd=python -m pytest -q | grep -c "passed"\n' >> "$CONF"
  fi
  if grep -q 'ruff' pyproject.toml; then
    printf 'static_cmd=python -m ruff check .\n' >> "$CONF"
  fi
  echo "- python project (pyproject.toml)" >> "$MAP"
}

detect_rust() {
  [ -f Cargo.toml ] || return
  printf 'build_cmd=cargo build\n' >> "$CONF"
  printf 'test_cmd=cargo test\n' >> "$CONF"
  printf 'static_cmd=cargo clippy\n' >> "$CONF"
  echo "- rust project (Cargo.toml)" >> "$MAP"
}

detect_go() {
  [ -f go.mod ] || return
  printf 'build_cmd=go build ./...\n' >> "$CONF"
  printf 'test_cmd=go test ./...\n' >> "$CONF"
  printf 'static_cmd=go vet ./...\n' >> "$CONF"
  echo "- go project (go.mod)" >> "$MAP"
}

detect_ci() {
  if [ -d .github/workflows ]; then
    printf 'has_ci=github\n' >> "$CONF"
    echo "- CI: GitHub Actions (.github/workflows)" >> "$MAP"
  elif [ -f .gitlab-ci.yml ]; then
    printf 'has_ci=gitlab\n' >> "$CONF"
    echo "- CI: GitLab (.gitlab-ci.yml)" >> "$MAP"
  else
    printf 'has_ci=none\n' >> "$CONF"
    echo "- CI: none detected" >> "$MAP"
  fi
}

detect_docker() {
  [ -f Dockerfile ] && { printf 'has_dockerfile=yes\n' >> "$CONF"; echo "- Docker (Dockerfile)" >> "$MAP"; }
}

detect_e2e() {
  if grep -q 'playwright' package.json 2>/dev/null || [ -f playwright.config.js ] || [ -f playwright.config.ts ]; then
    printf 'has_playwright=yes\n' >> "$CONF"
    echo "- E2E: Playwright" >> "$MAP"
  fi
}

detect_json_scripts
detect_python
detect_rust
detect_go
detect_ci
detect_docker
detect_e2e

echo "# Tool Map — $(date +%F)" >> "$MAP"
sort -u "$MAP" -o "$MAP"
echo "tool map written: $MAP"
