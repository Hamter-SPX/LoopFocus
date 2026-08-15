#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
const graphFile = args[0];

if (!graphFile) {
  console.error("usage: critical-path.js <task-graph.json>");
  console.error('graph: {"tasks":[{"id":"a","depends":[]},{"id":"b","depends":["a"]}]}');
  process.exit(2);
}

let graph;
try {
  graph = JSON.parse(fs.readFileSync(path.resolve(graphFile), "utf8"));
} catch (e) {
  console.error(`cannot read graph: ${e.message}`);
  process.exit(2);
}

const tasks = graph.tasks || [];
const byId = {};
for (const t of tasks) byId[t.id] = t;

const memo = {};
function depth(id, stack) {
  if (stack.includes(id)) throw new Error(`cycle detected at ${id}`);
  if (memo[id] !== undefined) return memo[id];
  const t = byId[id];
  if (!t) throw new Error(`unknown task ${id}`);
  const deps = t.depends || [];
  if (deps.length === 0) {
    memo[id] = 1;
    return 1;
  }
  let max = 0;
  for (const d of deps) {
    const dd = depth(d, [...stack, id]);
    if (dd > max) max = dd;
  }
  memo[id] = max + 1;
  return memo[id];
}

const depths = {};
for (const t of tasks) depths[t.id] = depth(t.id, []);
const maxDepth = Math.max(...Object.values(depths));
const critical = tasks.filter((t) => depths[t.id] === maxDepth).map((t) => t.id);

console.log(JSON.stringify({
  task_depths: depths,
  critical_path_length: maxDepth,
  critical_path: critical,
  non_critical: tasks.filter((t) => depths[t.id] !== maxDepth).map((t) => t.id),
}, null, 2));
