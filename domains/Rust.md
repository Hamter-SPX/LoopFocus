# Rust Domain Pack

## Discovery

tool-discovery.sh reads `Cargo.toml` → build/test/static commands automatically.

## Gate commands

```bash
# gates.conf (auto-generated)
build_cmd=cargo build
test_cmd=cargo test
static_cmd=cargo clippy -- -D warnings
audit_cmd=cargo audit
```

## Bug patterns (what the ladder usually finds)

| Symptom | Common root cause | Discriminating evidence |
|---|---|---|
| Borrow-checker fight | architectural ownership problem, not a syntax problem — the compiler is often right | draw the ownership on the Canvas before fighting |
| `unwrap()` panic in prod | error path not modeled | `cargo clippy` + grep for `unwrap`/`expect` in non-test code |
| Integer overflow (debug vs release) | release builds wrap; debug panics — behavior differs by profile | test in both profiles (`cargo test --release`) |
| Unsafe block UB | aliasing, lifetimes crossing FFI | Miri (`cargo +nightly miri test`) for unsafe paths |
| Test flakiness | thread races, env dependencies, temp file collisions | run with `--test-threads=1` to isolate |

## LoopFocus specifics

- `failure_class` examples: `borrow-design`, `unwrap-panic`, `overflow-release`, `unsafe-ub`
- Predictable hotspots: `unsafe` blocks, FFI boundaries, integer arithmetic on user input, async runtime joins
- Evidence commands: `cargo check` (fast), `cargo test`, `cargo clippy`, `cargo audit`

## Security notes (M3 quick hits)

- `unwrap()` on parsed user input (panic = DoS)
- unsafe pointer arithmetic around FFI
- plaintext secrets in `build.rs` or committed `config.toml`
- dependencies from unverified sources in Cargo.toml
