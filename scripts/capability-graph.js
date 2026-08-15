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

const outgoing = {};
for (const ed of model.edges || []) {
  if (!outgoing[ed.from]) outgoing[ed.from] = [];
  outgoing[ed.from].push(ed.to);
}

const agents = (model.entities || []).filter((e) => e.type === "agent").map((e) => e.name);

function closure(start) {
  const seen = new Set();
  const stack = [start];
  while (stack.length) {
    const cur = stack.pop();
    if (seen.has(cur)) continue;
    seen.add(cur);
    for (const next of outgoing[cur] || []) stack.push(next);
  }
  seen.delete(start);
  return [...seen];
}

const results = agents.map((a) => {
  const reach = closure(a);
  const sensitive = reach.filter((n) => {
    const e = (model.entities || []).find((x) => x.name === n);
    return e && (e.type === "secret" || e.type === "data" || e.classification === "secret" || e.classification === "crown-jewel");
  });
  return {
    agent: a,
    transitive_reach: reach,
    reaches_sensitive: sensitive,
    overreach: sensitive.length > 0,
  };
});

console.log(JSON.stringify({
  verdict: "computed",
  agents: results,
  advice: results.some((r) => r.overreach)
    ? "overreach found — an agent reaching secrets via tools is the finding; break the chain"
    : "no agent reaches sensitive nodes",
}, null, 2));
process.exit(results.some((r) => r.overreach) ? 1 : 0);
