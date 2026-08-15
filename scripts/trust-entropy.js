#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const cwd = getFlag("cwd") || process.cwd();
const modelPath = path.join(cwd, ".loopfocus", "world-model.json");

let model;
try {
  model = JSON.parse(fs.readFileSync(modelPath, "utf8"));
} catch {
  console.log(JSON.stringify({ verdict: "FAIL", reason: "no world-model.json" }));
  process.exit(1);
}

const zoneOf = {};
for (const e of model.entities || []) zoneOf[e.name] = e.zone;

let total = 0;
const contributors = [];
for (const ed of model.edges || []) {
  if (ed.kind !== "trust") continue;
  let score = 0;
  let cls = "";
  if (ed.verified && ed.reason) { score = -1; cls = "explicit-verified"; }
  else if (ed.assumption) { score = 0; cls = "assumption-registered"; }
  else { score = 2; cls = "implicit"; }
  if ((cls === "implicit") && zoneOf[ed.from] && zoneOf[ed.to] && zoneOf[ed.from] !== zoneOf[ed.to]) {
    score = 5;
    cls = "implicit-cross-zone";
  }
  total += score;
  if (score > 0) contributors.push({ edge: `${ed.from} -> ${ed.to}`, score, cls });
}

contributors.sort((a, b) => b.score - a.score);
const n = (model.entities || []).length || 1;
console.log(JSON.stringify({
  verdict: "computed",
  trust_entropy: total,
  normalized: Number((total / n).toFixed(1)),
  top_contributors: contributors.slice(0, 5),
  advice: contributors.length ? "kill the top contributors — every implicit edge is a compromise path" : "all trust edges explicit",
}, null, 2));
process.exit(0);
