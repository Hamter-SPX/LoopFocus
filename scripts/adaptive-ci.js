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
const mappingFile = getFlag("map");
const changedRaw = getFlag("changed") || "";

let changed = changedRaw.split(",").filter(Boolean);
if (changed.length === 0) {
  const { execSync } = require("child_process");
  try {
    changed = execSync("git diff --name-only HEAD", { encoding: "utf8", cwd })
      .split("\n").filter(Boolean);
  } catch {
    changed = [];
  }
}

if (changed.length === 0) {
  console.log(JSON.stringify({ stage: "no-change", advice: "nothing changed — skip CI this round" }));
  process.exit(0);
}

let map = {};
try {
  map = JSON.parse(fs.readFileSync(path.resolve(mappingFile || path.join(cwd, ".loopfocus", "test-map.json")), "utf8"));
} catch {
  map = {};
}

const affected = new Set();
for (const f of changed) {
  let matched = false;
  for (const [pattern, tests] of Object.entries(map)) {
    if (f.includes(pattern.replace(/^\*/, "").replace(/\*$/, ""))) {
      for (const t of tests) affected.add(t);
      matched = true;
    }
  }
  if (!matched) affected.add(`full-suite (unmapped change: ${f})`);
}

const stages = ["fast-checks", ...(affected.size ? ["affected-tests"] : []), "relevant-matrix", "full-gate"];

console.log(JSON.stringify({
  stage: stages[0],
  changed_files: changed,
  affected_tests: [...affected],
  pipeline: stages,
  advice: "small change → fast checks + affected tests only; expand to full gate near completion",
}, null, 2));
