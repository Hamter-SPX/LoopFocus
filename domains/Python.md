# Python Domain Pack

## Discovery

tool-discovery.sh reads `pyproject.toml` for `pytest` and `ruff` sections → gates.conf.

## Gate commands

```bash
# gates.conf (typical)
build_cmd=python -m compileall -q src
static_cmd=python -m ruff check .
test_cmd=python -m pytest
test_count_cmd=python -m pytest -q | grep -oE '[0-9]+ passed' | grep -oE '[0-9]+'
audit_cmd=pip-audit
```

## Bug patterns (what the ladder usually finds)

| Symptom | Common root cause | Discriminating evidence |
|---|---|---|
| `AttributeError: 'NoneType' object has no attribute` | function returning None implicitly, chained access on optional | traceback + the returning function's last expression |
| Works in REPL, fails in app | import side effects, sys.path/working-dir differences, mutable default args | `python -c "import X"` from the app's cwd |
| Silent wrong data | timezone-naive datetimes, float rounding, mutable default arguments | probe the util directly with boundary inputs |
| Test passes alone, fails in suite | shared fixture state, test pollution, global mutation | run tests in isolation (`pytest -k`) vs full suite |
| `RecursionError` / infinite loop | missing base case, mutated collection during iteration | minimal repro (S3) with a counter |

## LoopFocus specifics

- `failure_class` examples: `none-return`, `naive-datetime`, `mutable-default`, `fixture-pollution`
- Predictable hotspots: `datetime`/`time` handling, list/dict defaults in signatures, global state in modules, subprocess calls
- Evidence commands: `python -m pytest -x` (stop at first fail — information gain routing), `python -m ruff check`, `pip check`

## Security notes (M3 quick hits)

- `os.system` / shell=True subprocess with interpolated strings
- `eval`/`exec` on input
- pickle loading untrusted data
- hardcoded secrets in `settings.py` / committed `.env`
- missing `django SECRET_KEY` rotation / Flask `debug=True`
