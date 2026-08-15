#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const file = getFlag("file");
if (!file) {
  console.error("usage: conclusion-score.js --file <conclusion.json>");
  process.exit(2);
}

let c;
try {
  c = JSON.parse(fs.readFileSync(path.resolve(file), "utf8"));
} catch {
  console.error(`cannot read ${file}`);
  process.exit(2);
}

const evidence = Number(c.evidence_count || 0);
const assumptions = Number(c.assumption_count || 0);
const disagreement = Number(c.disagreement_count || 0);
const stability = Number(c.stability || 0);

const score = Math.round(
  Math.min(100, Math.max(0,
    evidence * 10 - assumptions * 5 - disagreement * 8 + stability * 30 + 20
  ))
);

const verdict = score >= 70 ? "RELIABLE" : score >= 40 ? "MODERATE" : "WEAK";

console.log(JSON.stringify({
  conclusion: c.conclusion,
  reliability_score: score,
  verdict,
  breakdown: {
    evidence_contribution: evidence * 10,
    assumption_penalty: assumptions * 5,
    disagreement_penalty: disagreement * 8,
    stability_bonus: Math.round(stability * 30),
  },
  advice: verdict === "WEAK"
    ? "too few evidence / too many assumptions — run the hypothesis engine before acting"
    : verdict === "MODERATE"
      ? "actionable with stated uncertainty — attach the sensitivity map"
      : "solid — still name the strongest counter-argument",
}, null, 2));
process.exit(verdict === "WEAK" ? 1 : 0);
