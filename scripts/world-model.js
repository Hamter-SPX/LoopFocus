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
const sub = args[0];

function load() {
  try {
    return JSON.parse(fs.readFileSync(modelPath, "utf8"));
  } catch {
    return null;
  }
}

if (sub === "init") {
  fs.mkdirSync(path.join(cwd, ".loopfocus"), { recursive: true });
  if (fs.existsSync(modelPath)) {
    console.log("world model already exists — run 'check' instead");
    process.exit(0);
  }
  const model = {
    system: "<name>",
    entities: [
      { type: "user|service|agent|api|data|secret|role|network|dependency|device", name: "<name>", zone: "untrusted|semi-trusted|trusted", anchor: "<file:line or config path>" },
    ],
    edges: [
      { from: "<entity>", to: "<entity>", kind: "trust|privilege|data-flow", reason: "<why this edge exists>", verified: false, assumption: null },
    ],
    invariants: ["<security rules that must hold>"],
  };
  fs.writeFileSync(modelPath, JSON.stringify(model, null, 2) + "\n");
  console.log(`world model scaffolded: ${modelPath}`);
} else if (sub === "check") {
  const model = load();
  if (!model) {
    console.log(JSON.stringify({ verdict: "FAIL", reason: "no world-model.json — run world-model init" }));
    process.exit(1);
  }
  const problems = [];
  for (const e of model.entities || []) {
    if (!e.name || !e.zone) problems.push(`entity without name/zone: ${JSON.stringify(e)}`);
    if (!e.anchor) problems.push(`entity without anchor: ${e.name}`);
  }
  for (const ed of model.edges || []) {
    if (!ed.from || !ed.to || !ed.kind) problems.push(`edge missing from/to/kind: ${JSON.stringify(ed)}`);
    if (!ed.reason) problems.push(`edge without reason (implicit trust): ${ed.from} -> ${ed.to}`);
  }
  if (problems.length === 0) {
    console.log(JSON.stringify({ verdict: "PASS", entities: (model.entities || []).length, edges: (model.edges || []).length }));
    process.exit(0);
  }
  console.log(JSON.stringify({ verdict: "FAIL", problems }, null, 2));
  process.exit(1);
} else if (sub === "show") {
  const model = load();
  if (!model) { console.log("no world model"); process.exit(1); }
  console.log(JSON.stringify(model, null, 2));
} else {
  console.error("usage: world-model.js init | check | show [--cwd dir]");
  process.exit(2);
}
