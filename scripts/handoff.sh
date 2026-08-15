#!/usr/bin/env bash
set -u

DIR=".loopfocus"
OUT="$DIR/handoff.md"
ASK="${1:-<what the receiver is being asked to do>}"

[ -f "$DIR/state.md" ] || { echo "no .loopfocus/state.md — run state-init.sh and LOCK first"; exit 1; }

{
  echo "# Handoff Package"
  echo
  echo "## 1. Locked goal + invariants"
  grep -E '^(goal|invariants|profile|intent):' "$DIR/state.md" || echo "(none recorded)"
  echo
  echo "## 2. Constraints"
  grep -E '^constraint' "$DIR/ledger.md" 2>/dev/null || echo "(none recorded)"
  echo
  echo "## 3. Attempts and fingerprints"
  node "$(dirname "$0")/loop-genome.js" summary 2>/dev/null || echo "(genome empty)"
  echo
  echo "## 4. Failures and evidence"
  grep -E '^actual result:|^- Hypothesis|^- Verdict' "$DIR/ledger.md" 2>/dev/null | tail -20 || echo "(ledger empty)"
  echo
  echo "## 5. Evidence paths"
  ls "$DIR/evidence/" 2>/dev/null || echo "(none)"
  echo
  echo "## 6. The request"
  echo "$ASK"
  echo
  echo "## Last commit"
  git log --oneline -3 2>/dev/null || echo "(not a git repo)"
} > "$OUT"

echo "handoff written: $OUT"
