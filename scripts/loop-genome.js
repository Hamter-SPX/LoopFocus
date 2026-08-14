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
const genomePath = () => path.join(storageDir(), "genome.json");

function load() {
  try {
    return JSON.parse(fs.readFileSync(genomePath(), "utf8"));
  } catch {
    return {};
  }
}
function save(db) {
  fs.mkdirSync(storageDir(), { recursive: true });
  fs.writeFileSync(genomePath(), JSON.stringify(db, null, 2) + "\n");
}

function record(db, cls, strategy, result, delta, reason, hypothesis) {
  const entry = db[cls] || { attempts: [], strategies: {}, winner: null };
  entry.attempts.push({
    n: entry.attempts.length + 1,
    strategy,
    result,
    delta: Number(delta),
    reason,
    hypothesis,
    at: new Date().toISOString(),
  });
  const st = entry.strategies[strategy] || { fails: 0, successes: 0, banned: false };
  if (result === "success") st.successes++;
  else st.fails++;
  if (st.fails >= 2 && st.successes === 0) st.banned = true;
  entry.strategies[strategy] = st;
  let best = null;
  for (const [name, s] of Object.entries(entry.strategies)) {
    if (s.successes > 0 && (best === null || s.successes > best.successes)) best = { name, successes: s.successes };
  }
  entry.winner = best ? best.name : null;
  db[cls] = entry;
}

function query(db, cls) {
  const keys = Object.keys(db);
  const hits = cls === "__all__" ? keys : keys.filter((k) => k.includes(cls));
  if (hits.length === 0) {
    console.log("no past records");
    return;
  }
  for (const key of hits) {
    const entry = db[key];
    console.log(`class: ${key}`);
    console.log(`winner strategy: ${entry.winner || "(none yet)"}`);
    const banned = Object.entries(entry.strategies).filter(([, s]) => s.banned).map(([n]) => n);
    console.log(`banned: ${banned.length ? banned.join(", ") : "(none)"}`);
    for (const a of entry.attempts) {
      console.log(`  attempt ${a.n}: ${a.strategy} -> ${a.result} (delta ${a.delta}) ${a.reason}`);
    }
  }
}

const cmd = args[0];
const db = load();

if (cmd === "record") {
  const cls = getFlag("class");
  const strategy = getFlag("strategy");
  const result = getFlag("result");
  const delta = getFlag("delta") || "0";
  const reason = getFlag("reason") || "";
  const hypothesis = getFlag("hypothesis") || "";
  if (!cls || !strategy || !result) {
    console.error("record requires --class --strategy --result");
    process.exit(2);
  }
  record(db, cls, strategy, result, delta, reason, hypothesis);
  save(db);
  console.log(`recorded: ${cls} #${db[cls].attempts.length} ${strategy} -> ${result}`);
} else if (cmd === "query") {
  query(db, getFlag("class") || "__all__");
} else if (cmd === "summary") {
  for (const [key, entry] of Object.entries(db)) {
    console.log(`${key}: winner=${entry.winner || "-"} attempts=${entry.attempts.length}`);
  }
} else {
  console.error("usage: loop-genome.js record|query|summary [--cwd dir] [--class name] [--strategy s] [--result fail|partial|success] [--delta n] [--reason r] [--hypothesis h]");
  process.exit(2);
}
