#!/usr/bin/env bash
# Build LOOPFOCUS_ALL_IN_ONE.md — deterministic combined reference for chat AIs
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/LOOPFOCUS_ALL_IN_ONE.md"

{
  echo "# LOOPFOCUS — All-In-One Reference"
  echo
  echo "> Built: $(date -u +%Y-%m-%dT%H:%MZ) | Source: github.com/Hamter-SPX/LoopFocus | Version: 0.7.0"
  echo "> This file is COMPLETE and SELF-CONTAINED. A chat AI with no file access can follow everything in it."
  echo
  echo "---"
  echo
  echo "# Part 0 — Chat-Only Operating Rules (read this FIRST if you are a chat AI without tools)"
  cat "$ROOT/references/chat-only-mode.md"
  echo
  echo "---"
  echo
  echo "# Part 1 — Core Discipline"
  sed '1,/^---$/d' "$ROOT/SKILL.md"
  echo
  echo "---"
  echo
  echo "# Part 2 — Deep References (all systems)"
  for f in "$ROOT"/references/state-machine.md "$ROOT"/references/gate-engine.md "$ROOT"/references/effort-elasticity.md "$ROOT"/references/dynamic-focus-depth.md "$ROOT"/references/skillfocus.md "$ROOT"/references/canvas.md "$ROOT"/references/predictive-analysis.md "$ROOT"/references/security-arch.md "$ROOT"/references/build-mode.md "$ROOT"/references/verification-and-claim-governance.md "$ROOT"/references/toolbus.md "$ROOT"/references/security-arch/*.md "$ROOT"/references/loop-control/*.md "$ROOT"/references/reasoning/*.md "$ROOT"/references/goal/*.md "$ROOT"/references/progress/*.md "$ROOT"/references/state-memory/*.md "$ROOT"/references/knowledge/*.md; do
    echo
    echo "## $(basename "$f" .md | tr '-' ' ' | awk '{for(i=1;i<=NF;i++) sub(/./,toupper(substr($i,1,1)),$i)}1')"
    cat "$f"
  done
  echo
  echo "---"
  echo
  echo "# Part 3 — Flows"
  for f in "$ROOT"/flow/README.md "$ROOT"/flow/*.md; do
    [ "$f" = "$ROOT/flow/README.md" ] && continue
    echo
    echo "## $(basename "$f" .md)"
    cat "$f"
  done
  echo
  echo "---"
  echo
  echo "# Part 4 — Mode Contracts (8 modes)"
  cat "$ROOT/references/mode-contracts.md"
  echo
  echo "---"
  echo
  echo "# Part 5 — Domain Packs (stack knowledge)"
  for f in "$ROOT"/domains/*.md; do
    echo
    echo "## $(basename "$f" .md)"
    cat "$f"
  done
  echo
  echo "---"
  echo
  echo "# Part 6 — Templates (copy these into chat when working without files)"
  for f in "$ROOT"/templates/*.template; do
    echo
    echo "### $(basename "$f" .template)"
    echo '```'
    cat "$f"
    echo '```'
  done
  echo
  echo "---"
  echo
  echo "# Part 7 — Worked Examples"
  for f in "$ROOT"/examples/*.md; do
    echo
    echo "## $(basename "$f" .md)"
    cat "$f"
  done
  echo
  echo "---"
  echo
  echo "# End of reference. The discipline above is complete — no external files are required."
} > "$OUT"

echo "built: $OUT ($(wc -l < "$OUT") lines, $(wc -c < "$OUT") bytes)"
