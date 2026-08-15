#!/usr/bin/env bash
set -u
# Playwright E2E driver — render → interact → screenshot → compare → normalize
# requires: npx playwright (auto-installs on first use)

usage() {
  echo "usage: e2e.sh install | run [--browser chromium|firefox|webkit] [--project <name>] | shot <url> <out.png>"
  exit 2
}

sub="${1:-}"

case "$sub" in
  install)
    npm init -y >/dev/null 2>&1
    npm i -D @playwright/test >/dev/null 2>&1
    npx playwright install --with-deps chromium firefox webkit >/dev/null 2>&1 || npx playwright install chromium firefox webkit
    echo '{"e2e":"installed"}'
    ;;
  run)
    shift
    args=()
    while [ $# -gt 0 ]; do
      case "$1" in
        --browser) args+=("--project=$2"); shift 2 ;;
        --project) args+=("--project=$2"); shift 2 ;;
        *) shift ;;
      esac
    done
    npx playwright test "${args[@]}"
    ;;
  shot)
    shift
    url="${1:-}"; out="${2:-shot.png}"
    [ -n "$url" ] || usage
    mkdir -p .loopfocus/evidence
    npx playwright screenshot --viewport-size=1280,800 "$url" "$out" 2>/dev/null \
      || node -e '
        const { chromium } = require("playwright");
        (async () => {
          const b = await chromium.launch();
          const p = await b.newPage({ viewport: { width: 1280, height: 800 } });
          await p.goto(process.argv[1]);
          await p.screenshot({ path: process.argv[2] });
          await b.close();
        })(process.argv[1], process.argv[2]);
      ' "$url" "$out"
    echo "screenshot: $out"
    ;;
  *) usage ;;
esac
