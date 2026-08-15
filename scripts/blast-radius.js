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

const dataClass = {};
for (const e of model.entities || []) {
  if (e.type === "data") dataClass[e.name] = e.classification || "unknown";
}

const fanOut = {};
const fanIn = {};
for (const ed of model.edges || []) {
  fanOut[ed.from] = (fanOut[ed.from] || 0) + 1;
  fanIn[ed.to] = (fanIn[ed.to] || 0) + 1;
}

const radius = {};
for (const e of model.entities || []) {
  const fout = fanOut[e.name] || 0;
  const fin = fanIn[e.name] || 0;
  const sensitive = e.type === "secret" || dataClass[e.name] === "sensitive" || dataClass[e.name] === "secret" || dataClass[e.name] === "crown-jewel";
  radius[e.name] = {
    fan_out: fout,
    fan_in: fin,
    holds_sensitive: sensitive,
    blast: fout + fin + (sensitive ? 3 : 0),
  };
}

const ranked = Object.entries(radius)
  .sort((a, b) => b[1].blast - a[1].blast)
  .map(([name, r]) => ({ name, ...r }));

console.log(JSON.stringify({
  verdict: "computed",
  ranked_components: ranked,
  crown_jewel_candidates: ranked.filter((r) => r.holds_sensitive).map((r) => r.name),
}, null, 2));
process.exit(0);
