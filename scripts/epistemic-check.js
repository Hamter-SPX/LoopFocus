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
  console.error("usage: epistemic-check.js --file <claims.txt>");
  process.exit(2);
}

const VALID = ["FACT", "INFERENCE", "ASSUMPTION", "HYPOTHESIS", "UNKNOWN", "CONTRADICTION"];

let lines;
try {
  lines = fs.readFileSync(path.resolve(file), "utf8").split("\n").filter((l) => l.trim());
} catch {
  console.error(`cannot read ${file}`);
  process.exit(2);
}

const problems = [];
const counts = {};
for (const line of lines) {
  const m = line.match(/^([A-Z]+):\s*(.+)$/);
  if (!m) {
    problems.push(`untagged claim: ${line.slice(0, 60)}`);
    continue;
  }
  const cls = m[1];
  if (!VALID.includes(cls)) {
    problems.push(`invalid class '${cls}': ${line.slice(0, 60)}`);
    continue;
  }
  counts[cls] = (counts[cls] || 0) + 1;
}

if (problems.length) {
  console.log(JSON.stringify({ verdict: "FAIL", problems, note: "every claim must carry FACT/INFERENCE/ASSUMPTION/HYPOTHESIS/UNKNOWN/CONTRADICTION" }, null, 2));
  process.exit(1);
}
console.log(JSON.stringify({ verdict: "PASS", class_counts: counts, note: "all claims epistemically tagged" }));
process.exit(0);
