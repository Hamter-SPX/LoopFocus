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
  console.error("usage: evidence-check.js --file <finding.json>");
  process.exit(2);
}

let finding;
try {
  finding = JSON.parse(fs.readFileSync(path.resolve(file), "utf8"));
} catch (e) {
  console.error(`cannot read finding: ${e.message}`);
  process.exit(2);
}

const REQUIRED = [
  "evidence",
  "attack_preconditions",
  "affected_boundary",
  "impact",
  "confidence",
  "contradicting_evidence",
  "verification_status",
];

const missing = REQUIRED.filter((f) => finding[f] === undefined || finding[f] === null || finding[f] === "");

if (missing.length > 0) {
  console.log(JSON.stringify({
    verdict: "FAIL",
    missing,
    note: "SecurityArch reports no finding without the 7 evidence fields — Critical because 'I think so' is forbidden",
  }));
  process.exit(1);
}

console.log(JSON.stringify({
  verdict: "PASS",
  note: "all 7 evidence fields present — finding is reportable",
}));
process.exit(0);
