#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");
const os = require("os");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const cwd = getFlag("cwd") || process.cwd();
function storageDir() {
  const local = path.join(cwd, ".loopfocus");
  if (fs.existsSync(local)) return local;
  return path.join(os.homedir(), ".loopfocus");
}
function loadGenome() {
  try {
    return JSON.parse(fs.readFileSync(path.join(storageDir(), "genome.json"), "utf8"));
  } catch {
    return {};
  }
}

function classify(seq) {
  if (seq.length < 2) return { verdict: "insufficient-data", action: "continue" };
  const [first, last] = [seq[0], seq[seq.length - 1]];
  let decreases = 0;
  let increases = 0;
  let equals = 0;
  for (let i = 1; i < seq.length; i++) {
    if (seq[i] < seq[i - 1]) decreases++;
    else if (seq[i] > seq[i - 1]) increases++;
    else equals++;
  }
  const allFlat = seq.every((v) => v === first);
  if (allFlat && first > 0) return { verdict: "flat", action: "tax" };
  if (allFlat && first === 0) return { verdict: "converged", action: "continue" };
  if (decreases >= 2 && increases >= 2) return { verdict: "unstable", action: "mutate" };
  if (last > first) return { verdict: "regressed", action: "rollback" };
  if (decreases >= 2 && increases === 0) return { verdict: "converging", action: "continue" };
  return { verdict: "mixed", action: "mutate" };
}

let seq = [];
const rawSeq = getFlag("sequence");
const cls = getFlag("class");

if (rawSeq) {
  seq = rawSeq.split(",").map((n) => Number(n.trim())).filter((n) => !Number.isNaN(n));
} else if (cls) {
  const db = loadGenome();
  const entry = db[cls];
  if (!entry) {
    console.log(JSON.stringify({ verdict: "no-past-records", action: "start-fresh" }));
    process.exit(0);
  }
  seq = entry.attempts.filter((a) => a.current_failures !== undefined).map((a) => a.current_failures);
  if (seq.length === 0) {
    console.log(JSON.stringify({ verdict: "insufficient-data", action: "continue", note: "record with --current-failures to enable" }));
    process.exit(0);
  }
} else {
  console.error("usage: convergence.js [--sequence 18,11,6] | [--class <name> --cwd <dir>]");
  process.exit(2);
}

const result = classify(seq);
result.sequence = seq;
console.log(JSON.stringify(result));
process.exit(result.action === "rollback" || result.action === "mutate" ? 2 : 0);
