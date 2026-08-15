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

const cls = getFlag("class");
const files = (getFlag("files") || "").split(",").filter(Boolean).sort();
const error = getFlag("error") || "";
const approach = getFlag("approach") || "";

if (!cls || !approach) {
  console.error("usage: loop-fingerprint.js --class <name> --approach <family> [--files a,b] [--error <class>] [--cwd <dir>]");
  process.exit(2);
}

const db = loadGenome();
const entry = db[cls];
const fp = { files, error, approach };

if (!entry) {
  console.log(JSON.stringify({ verdict: "no-past-records", match: false, action: "allowed" }));
  process.exit(0);
}

let matched = null;
for (const a of entry.attempts) {
  if (a.result === "success") continue;
  if (approach !== a.strategy) continue;
  if (a.failure_class && error && error !== a.failure_class) continue;
  if (a.files && files.length && files.join(",") !== a.files.sort().join(",")) continue;
  matched = a;
  break;
}

if (matched) {
  console.log(JSON.stringify({
    verdict: "repeat-blocked",
    match: true,
    reason: `attempt ${matched.n} failed with the same fingerprint: ${matched.strategy} ${matched.reason}`,
    action: "mutate",
  }));
  process.exit(1);
}
console.log(JSON.stringify({ verdict: "allowed", match: false, action: "continue" }));
