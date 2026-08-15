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
  for f in "$ROOT"/references/state-machine.md "$ROOT"/references/gate-engine.md "$ROOT"/references/effort-elasticity.md "$ROOT"/references/dynamic-focus-depth.md "$ROOT"/references/skillfocus.md "$ROOT"/references/canvas.md "$ROOT"/references/predictive-analysis.md "$ROOT"/references/build-mode.md "$ROOT"/references/verification-and-claim-governance.md "$ROOT"/references/toolbus.md "$ROOT"/references/loop-control/*.md "$ROOT"/references/reasoning/*.md "$ROOT"/references/goal/*.md "$ROOT"/references/progress/*.md "$ROOT"/references/state-memory/*.md "$ROOT"/references/knowledge/*.md; do
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
  echo "# Part 4b — SecurityArch Mode (IDENTITY + DOCS + 126 systems in 8 layers)"
  cat "$ROOT/modes/security-arch/IDENTITY.md"
  cat "$ROOT/modes/security-arch/DOCS.md"
  for layer in L1-world-mapping L2-analysis L3-adversarial L4-verification L5-autonomous L6-meta L7-formal L8-cross-layer gates exit; do
    for f in "$ROOT"/modes/security-arch/references/$layer/*.md; do
      echo
      echo "## $layer/$(basename "$f" .md)"
      cat "$f"
    done
  done
  echo
  echo "---"
  echo
  echo "# Part 4c — Analysis Intelligence Mode (IDENTITY + DOCS + 291 systems in 9 layers)"
  cat "$ROOT/modes/analysis-intelligence/IDENTITY.md"
  cat "$ROOT/modes/analysis-intelligence/DOCS.md"
  for layer in L1-understanding L2-causal L3-evidence L4-adversarial L5-systems L6-decision L7-prediction L8-formal L9-discovery; do
    for f in "$ROOT"/modes/analysis-intelligence/references/$layer/*.md; do
      echo
      echo "## $layer/$(basename "$f" .md)"
      cat "$f"
    done
  done
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
