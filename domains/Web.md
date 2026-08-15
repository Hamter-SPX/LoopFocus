# Web Domain Pack

Frontend-heavy work (React/Vue/Svelte/vanilla). Pairs with the Playwright E2E driver.

## Gate commands

```bash
# gates.conf (typical)
build_cmd=npm run build
static_cmd=npm run lint
test_cmd=node --test       # or vitest run
e2e_cmd=npx playwright test
```

## The UI loop (render → interact → screenshot → compare → normalize)

```bash
loopfocus e2e run --browser chromium          # full E2E suite per browser
loopfocus e2e shot http://localhost:3000 .loopfocus/evidence/cur.png
# compare against the reference/previous state, then:
loopfocus signal --source local:e2e --status fail --previous-failures 17 --current-failures 3 --failure-class webkit-nav --attempt 12
```

## Bug patterns (what the ladder usually finds)

| Symptom | Common root cause | Discriminating evidence |
|---|---|---|
| Button does nothing | wrong `type` (button vs submit), handler never attached, silent JS error killing the bundle | console errors (Playwright captures them) — browser console is evidence |
| State flickers/stale | effect ordering, missing cleanup, race between fetch and render | React DevTools timeline / re-render counters |
| Works in Chrome, breaks WebKit | browser API differences (WebKit lacks some newer APIs) | run the same test per `--project` — the failure domain IS the evidence |
| Form submits empty | controlled inputs without onChange, name/id mismatch | inspect the network payload (Playwright request capture) |
| Layout breaks at width | missing responsive states, flex/grid misuse | Playwright `--viewport-size` matrix |

## CI Matrix Brain (Web-specific)

Chromium PASS / WebKit FAIL / Firefox FAIL → failure domains: `webkit`, `firefox`. Rerun only those shards; a shared-cause (bundled polyfill, user-agent sniffing) is the oscillation-detector's hint.

## LoopFocus specifics

- `failure_class` examples: `webkit-nav`, `handler-not-attached`, `silent-js-error`, `stale-state`
- Predictable hotspots: event handler binding, effects without deps, date/currency formatting in render, browser-API sniffing
- Evidence: Playwright screenshots + console logs + network captures, all attached via `artifact.sh`

## Security notes (M3 quick hits)

- XSS: `dangerouslySetInnerHTML`, `v-html`, innerHTML with data
- secrets bundled into client builds (env vars prefixed with `VITE_`/`NEXT_PUBLIC_` are PUBLIC)
- missing CSRF on state-changing requests
- CORS misconfiguration
