#!/usr/bin/env node
"use strict";
const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}
function getMulti(name) {
  const i = args.indexOf("--" + name);
  if (i === -1) return [];
  const out = [];
  for (let j = i + 1; j < args.length && !args[j].startsWith("--"); j++) out.push(args[j]);
  return out;
}

const modules = getMulti("modules");
const edges = getMulti("edges");
const format = getFlag("format") || "mermaid";

if (modules.length === 0) {
  console.error("usage: canvas.js --modules a b c [--edges a->b b->c] [--format mermaid|ascii]");
  process.exit(2);
}

const edgeSet = new Map();
for (const e of edges) {
  const m = e.match(/^(.+?)->(.+)$/);
  if (m) {
    const [from, to] = [m[1].trim(), m[2].trim()];
    if (!edgeSet.has(from)) edgeSet.set(from, []);
    edgeSet.get(from).push(to);
  }
}

if (format === "ascii") {
  const w = Math.max(...modules.map((m) => m.length)) + 2;
  const box = (m) => `[ ${m.padEnd(w - 4)} ]`;
  for (const m of modules) console.log(box(m));
  for (const [from, tos] of edgeSet) {
    for (const to of tos) console.log(`${from} --> ${to}   (label: <what travels>)`);
  }
} else {
  console.log("```mermaid");
  console.log("flowchart LR");
  for (const m of modules) console.log(`  ${m.replace(/[^a-zA-Z0-9]/g, "")}["${m}"]`);
  for (const [from, tos] of edgeSet) {
    for (const to of tos) console.log(`  ${from.replace(/[^a-zA-Z0-9]/g, "")} -->|"<what travels>"| ${to.replace(/[^a-zA-Z0-9]/g, "")}`);
  }
  console.log("```");
  console.log("");
  console.log("mark: where the change goes / what touches it / what must not break (invariants)");
}
