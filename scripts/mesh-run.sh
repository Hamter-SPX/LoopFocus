#!/usr/bin/env bash
# Analysis Mesh dispatcher — blind round-1 analyst prompts to prevent anchoring
set -u

problem="${1:-}"
shift || true
analysts="$*"
[ -z "$problem" ] && { echo "usage: mesh-run.sh \"<problem>\" <analyst...>"; exit 2; }
[ -z "$analysts" ] && analysts="software hardware data"

echo "PROBLEM: $problem"
echo
echo "MESH RULE: round 1 is BLIND — each analyst analyzes WITHOUT seeing the others' conclusions."
echo "Anchoring is forbidden; the Causal Synthesizer combines after round 1."
echo
for a in $analysts; do
  echo "--- DISPATCH: ${a}-analyst ---"
  echo "Role: analyze the problem from the ${a} angle only."
  echo "Blind rule: do NOT see or assume other analysts' conclusions."
  echo "Deliverable: your ${a} findings + the assumptions you used + what evidence would change them."
  echo
done

echo "--- SYNTHESIS: causal-synthesizer ---"
echo "Combine the independent analyst reports. Name disagreements explicitly — they are information."
echo
echo "--- JUDGE: adversarial-judge ---"
echo "Challenge the synthesized conclusion: steelman the strongest counter-conclusion, then verdict."
