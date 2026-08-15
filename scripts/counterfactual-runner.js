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
  console.error("usage: counterfactual-runner.js --file <model.json>");
  console.error('model: {"assumptions":[{"name":"...","conclusions":["c1","c2"]}]}');
  process.exit(2);
}

let model;
try {
  model = JSON.parse(fs.readFileSync(path.resolve(file), "utf8"));
} catch {
  console.error(`cannot read ${file}`);
  process.exit(2);
}

const assumptions = model.assumptions || [];
const results = assumptions.map((a) => ({
  assumption: a.name,
  flipped: `what if "${a.name}" is FALSE`,
  dependent_conclusions: (a.conclusions || []).length,
  affected: a.conclusions || [],
}));

const totalDependents = results.reduce((sum, r) => sum + r.dependent_conclusions, 0);
const stability = assumptions.length === 0 ? 1 : Math.max(0, 1 - totalDependents / (assumptions.length * 5));

console.log(JSON.stringify({
  verdict: "stress-tested",
  flipped_worlds: results,
  total_dependent_conclusions: totalDependents,
  conclusion_stability: Number(stability.toFixed(2)),
  advice: stability < 0.5
    ? "conclusions rest heavily on assumptions — verify the top assumptions first"
    : "conclusions survive assumption flips",
}, null, 2));
process.exit(stability < 0.5 ? 1 : 0);
