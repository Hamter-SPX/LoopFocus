#!/usr/bin/env bash
set -u

DIR=".loopfocus"
SKILL_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$DIR/evidence"

[ -f "$DIR/state.md" ] || cp "$SKILL_ROOT/templates/state.md.template" "$DIR/state.md"
[ -f "$DIR/ledger.md" ] || cp "$SKILL_ROOT/templates/ledger.md.template" "$DIR/ledger.md"
[ -f "$DIR/profile" ] || printf 'LIGHT\n' > "$DIR/profile"
[ -f "$DIR/metrics" ] || printf 'runs=0\ntest_count=0\nno_progress_streak=0\n' > "$DIR/metrics"

bash "$SKILL_ROOT/scripts/tool-discovery.sh"

echo "initialized .loopfocus/:"
ls -1 "$DIR"
echo
echo "next: edit $DIR/state.md — write the goal, invariants, and choose the profile"
