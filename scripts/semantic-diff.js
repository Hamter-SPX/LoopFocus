#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const beforeFile = getFlag("before");
const afterFile = getFlag("after");
if (!beforeFile || !afterFile) {
  console.error("usage: semantic-diff.js --before <world-model-old.json> --after <world-model-new.json>");
  process.exit(2);
}

function load(f) {
  try {
    return JSON.parse(fs.readFileSync(path.resolve(f), "utf8"));
  } catch {
    console.error(`cannot read ${f}`);
    process.exit(2);
  }
}

const before = load(beforeFile);
const after = load(afterFile);

const edgeKey = (e) => `${e.from}->${e.to}:${e.kind}`;
const beforeEdges = new Map((before.edges || []).map((e) => [edgeKey(e), e]));
const afterEdges = new Map((after.edges || []).map((e) => [edgeKey(e), e]));

const deltas = [];

for (const [key, e] of afterEdges) {
  if (!beforeEdges.has(key)) {
    deltas.push({ delta: "NEW_EDGE", edge: key, class: e.kind === "trust" ? "NEW_TRUST" : e.kind === "privilege" ? "WIDER_PRIVILEGE" : "NEW_EXPOSURE" });
  } else if (e.verified !== beforeEdges.get(key).verified) {
    deltas.push({ delta: "VERIFICATION_CHANGED", edge: key, from: beforeEdges.get(key).verified, to: e.verified });
  }
}
for (const key of beforeEdges.keys()) {
  if (!afterEdges.has(key)) {
    deltas.push({ delta: "REMOVED_EDGE", edge: key, class: "INVARIANT_RISK" });
  }
}

const sev = ["INVARIANT_RISK", "NEW_TRUST", "WIDER_PRIVILEGE", "NEW_EXPOSURE"];
const securityRelevant = deltas.filter((d) => sev.includes(d.class));
console.log(JSON.stringify({
  verdict: securityRelevant.length ? "SECURITY_MODEL_CHANGED" : "NEUTRAL",
  total_deltas: deltas.length,
  security_relevant: securityRelevant,
  all_deltas: deltas,
}, null, 2));
process.exit(securityRelevant.length ? 1 : 0);
