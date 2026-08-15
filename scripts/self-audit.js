#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const claimFile = getFlag("claims");
if (!claimFile) {
  console.error("usage: self-audit.js --claims <file>");
  console.error('claims file: one claim per line: "claim | evidence-path"');
  process.exit(2);
}

let lines;
try {
  lines = fs.readFileSync(path.resolve(claimFile), "utf8").split("\n").filter((l) => l.trim());
} catch {
  console.error(`cannot read ${claimFile}`);
  process.exit(2);
}

const report = [];
let blocking = 0;

for (const line of lines) {
  const [claim, evidence] = line.split("|").map((s) => (s || "").trim());
  if (!claim) continue;

  let problems = [];
  if (/always|never|100%|definitely|certain|secure|perfect/.test(claim)) {
    problems.push("absolute language on a claim");
  }
  if (!evidence) {
    problems.push("no evidence path");
  } else {
    const resolved = path.resolve(evidence);
    if (!fs.existsSync(resolved)) {
      problems.push(`evidence missing: ${evidence}`);
    } else {
      const stat = fs.statSync(resolved);
      const oneHour = 60 * 60 * 1000;
      if (Date.now() - stat.mtimeMs > oneHour * 24) {
        problems.push(`evidence older than 24h: ${stat.mtime.toISOString()}`);
      }
    }
  }

  if (problems.length === 0) {
    report.push({ claim, verdict: "bound", evidence });
  } else {
    report.push({ claim, verdict: "unbound", problems });
    blocking++;
  }
}

console.log(JSON.stringify({ checked: report.length, unbound: blocking, report }, null, 2));
process.exit(blocking > 0 ? 1 : 0);
