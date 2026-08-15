# Domain Packs

Language/stack-specific knowledge for LoopFocus: gate commands, bug patterns, audit tools. Load only the pack for the project's stack. The generic discipline applies in all packs — a pack supplies the stack-specific commands and smells.

| Pack | Use when | File |
|---|---|---|
| JS-TS | package.json, node_modules, .ts/.tsx/.js/.jsx | `JS-TS.md` |
| Python | pyproject.toml / requirements.txt / .py | `Python.md` |
| Go | go.mod | `Go.md` |
| Rust | Cargo.toml | `Rust.md` |
| Web | frontend UI work (React/Vue/Svelte/vanilla) | `Web.md` |
| Security | M3 mode + any audit | `Security.md` |

Each pack covers: discovery (what tool-discovery.sh detects), gate commands (build/static/test/audit), common bug patterns (what the root-cause ladder usually finds), and evidence commands (what to run for the signal).
