# Go Domain Pack

## Discovery

tool-discovery.sh reads `go.mod` → build/test/static commands automatically.

## Gate commands

```bash
# gates.conf (auto-generated)
build_cmd=go build ./...
test_cmd=go test ./...
static_cmd=go vet ./...
test_count_cmd=go test ./... 2>/dev/null | grep -cE '^ok'
audit_cmd=govulncheck ./...
```

## Bug patterns (what the ladder usually finds)

| Symptom | Common root cause | Discriminating evidence |
|---|---|---|
| `nil pointer dereference` | unchecked error return, nil interface vs nil pointer | the err-return chain — Go bugs hide in ignored errors |
| Race in tests | shared state across goroutines, t.Parallel misuse | `go test -race ./...` |
| Deadlock / hang | unbuffered channel circular wait, mutex re-entry | `go test -timeout` + stack dump (SIGQUIT) |
| Works locally, fails CI | GOFLAGS/version differences, module cache state | `go version` parity + `go mod tidy` |
| Silent wrong values | shadowed variables (`:=` in inner scope), timezone-less time.Now comparisons | `go vet` (shadow check) + boundary probes |

## LoopFocus specifics

- `failure_class` examples: `nil-deref`, `ignored-error`, `goroutine-race`, `shadowed-var`
- Predictable hotspots: error handling paths (`if err != nil` skipped), goroutine ownership, interface nil traps (`var p *T = nil; var i I = p; i != nil`)
- Evidence commands: `go test -race ./...`, `go vet ./...`, `go build ./...`

## Security notes (M3 quick hits)

- ignoring error returns on crypto/io calls
- `io.ReadAll` on unbounded request bodies
- SQL string concat (use `database/sql` placeholders)
- path traversal via `filepath.Join` with user input (Join cleans, but check the result)
- debug endpoints in production builds
