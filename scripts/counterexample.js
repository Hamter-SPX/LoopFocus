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
const file = path.join(cwd, ".loopfocus", "claims.jsonl");
const sub = args[0];

function load() {
  try {
    return fs.readFileSync(file, "utf8").split("\n").filter(Boolean).map((l) => JSON.parse(l));
  } catch {
    return [];
  }
}

if (sub === "record") {
  const claim = getFlag("claim");
  const attempt = getFlag("attempt");
  const result = getFlag("result");
  if (!claim || !attempt || !result) {
    console.error("usage: counterexample.js record --claim \"...\" --attempt \"...\" --result held|broken");
    process.exit(2);
  }
  const entry = { claim, attempt, result, at: new Date().toISOString() };
  fs.appendFileSync(file, JSON.stringify(entry) + "\n");
  console.log(`recorded: ${result === "broken" ? "BROKEN — the claim is falsified, write the finding" : "held — attempt recorded"}`);
} else if (sub === "check") {
  const claims = load();
  const byClaim = {};
  for (const c of claims) {
    if (!byClaim[c.claim]) byClaim[c.claim] = [];
    byClaim[c.claim].push(c);
  }
  const problems = [];
  for (const [claim, attempts] of Object.entries(byClaim)) {
    if (attempts.length === 0) problems.push(`claim without attempts: ${claim}`);
    if (attempts.some((a) => a.result === "broken")) problems.push(`claim BROKEN by counterexample: ${claim}`);
  }
  if (problems.length) {
    console.log(JSON.stringify({ verdict: "FAIL", problems }, null, 2));
    process.exit(1);
  }
  console.log(JSON.stringify({ verdict: "PASS", claims_with_attempts: Object.keys(byClaim).length, note: "every safety claim has surviving counterexample attempts" }));
  process.exit(0);
} else {
  console.error("usage: counterexample.js record --claim ... --attempt ... --result held|broken | check [--cwd dir]");
  process.exit(2);
}
