#!/usr/bin/env node
"use strict";
const { execSync } = require("child_process");
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
function sh(cmd) {
  try {
    return execSync(cmd, { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"], cwd }).trim();
  } catch {
    return "";
  }
}

function complexityNow() {
  const stat = sh("git diff HEAD --stat");
  if (!stat) return { files: 0, lines: 0 };
  const lines = stat.split("\n");
  let files = 0;
  let changes = 0;
  for (const line of lines) {
    const m = line.match(/(\d+) (insertions?|deletions?)/g);
    if (m) files++;
    const nums = [...line.matchAll(/(\d+)/g)].map((x) => Number(x[1]));
    if (nums.length >= 2) changes += nums[0] + nums[1];
  }
  return { files, lines: changes };
}

const cls = getFlag("class");
const now = complexityNow();

const historyPath = path.join(storageDir(), "entropy.json");
let history = {};
try {
  history = JSON.parse(fs.readFileSync(historyPath, "utf8"));
} catch {
  history = {};
}
history[cls || "default"] = now;
fs.mkdirSync(storageDir(), { recursive: true });
fs.writeFileSync(historyPath, JSON.stringify(history, null, 2) + "\n");

const db = loadGenome();
const entry = db[cls];
let progressFlat = false;
if (entry) {
  const recent = entry.attempts.slice(-3).map((a) => a.delta);
  if (recent.length >= 2 && recent.every((d) => d <= 0)) progressFlat = true;
}

const entropy = now.files >= 10 || (progressFlat && now.files >= 4);
const result = {
  complexity: now,
  progress_flat: progressFlat,
  entropy_warning: entropy,
  action: entropy ? "simplify" : "continue",
  note: entropy ? "complexity growing while progress flat — return to last stable checkpoint" : "",
};
console.log(JSON.stringify(result));
process.exit(entropy ? 1 : 0);
