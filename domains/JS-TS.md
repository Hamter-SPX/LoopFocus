# JS-TS Domain Pack

## Discovery

tool-discovery.sh reads `package.json` scripts: `test`, `lint`, `build` → gates.conf. Detects Playwright via `playwright.config.js/ts` or package.json dependency.

## Gate commands

```bash
# gates.conf (typical)
build_cmd=npm run build          # or: npx tsc --noEmit
static_cmd=npm run lint          # eslint / prettier --check
test_cmd=node --test             # or: npm test / vitest run / jest
test_count_cmd=node --test --test-reporter=spec | grep -cE "^✔|^✓"
audit_cmd=npm audit --audit-level=high
```

## Bug patterns (what the ladder usually finds)

| Symptom | Common root cause | Discriminating evidence |
|---|---|---|
| `X is not a function` | export-key typo / default-vs-named mismatch / circular import | read the callee's module.exports; `node --print` the import |
| `Cannot read properties of undefined` | async ordering, missing guard, prop name drift | stack trace line + the data source that feeds it |
| Silent failure / unhandled rejection | swallowed catch, missing await, event listener never attached | add a rejection handler, log the chain |
| Weird numbers/strings | JS float math, timezone parsing (date-only strings parse as UTC), `==` coercion | isolate the util: `(1.005).toPrecision(21)`; `['x'] == 'x'` |
| Test passes locally, fails CI | node version, env var, path separator, case-sensitivity | read the CI job's node version + run same version locally |

## LoopFocus specifics

- `failure_class` examples: `greeting-undefined`, `float-rounding`, `missing-await`, `coercion-bypass`
- Predictable hotspots: shared utils without tests, vendored dependencies, date/time handling, any `==` on user input
- Evidence commands: `node --check file.js` (syntax), `node --test` (suite), `npm audit` (deps)

## Security notes (M3 quick hits)

- `==` on tokens → array/type-juggling bypass (`?token[]=x`)
- prototype pollution via `req.query` deep parsing (qs)
- `JSON.stringify` of error objects leaking stack traces to clients
- `child_process.exec` with interpolated strings
