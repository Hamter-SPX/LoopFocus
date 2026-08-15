#!/usr/bin/env node
"use strict";
const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const cwd = getFlag("cwd") || process.cwd();
const target = getFlag("target");

if (!target) {
  console.error("usage: predictive.js --target <module-or-file> [--cwd <dir>]");
  process.exit(2);
}

function sh(cmd) {
  try {
    return execSync(cmd, { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"], cwd }).trim();
  } catch {
    return "";
  }
}

function findFiles() {
  const byPath = path.resolve(cwd, target);
  if (fs.existsSync(byPath)) return [target];
  const matches = [];
  for (const ext of ["js", "ts", "py", "go", "rs", "jsx", "tsx", "vue", "rb", "java", "php"]) {
    const p = `${target}.${ext}`;
    if (fs.existsSync(path.resolve(cwd, p))) matches.push(p);
  }
  if (matches.length) return matches;
  const dirHits = sh(`find . -path ./node_modules -prune -o -type f -name "${path.basename(target)}*" -print`)
    .split("\n").filter(Boolean).slice(0, 20);
  return dirHits.length ? dirHits.map((p) => p.replace(/^\.\//, "")) : [];
}

const files = findFiles();
if (files.length === 0) {
  console.log(JSON.stringify({ target, found: false, note: "no files matched — verify the module name" }));
  process.exit(0);
}

const results = [];
for (const f of files) {
  const symbol = path.basename(f, path.extname(f));
  const refs = sh(`grep -rEl "${symbol}" --include="*.js" --include="*.ts" --include="*.jsx" --include="*.tsx" --include="*.py" --include="*.go" --include="*.rs" . 2>/dev/null | grep -v node_modules | head -30`)
    .split("\n").filter((l) => l && l.replace(/^\.\//, "") !== f);
  const churn = sh(`git log --oneline -5 -- ${f}`).split("\n").filter(Boolean).length;
  const hasTest = files.some(() => {
    const t1 = f.replace(/\.(js|ts|jsx|tsx|py|go|rs)$/, ".test.$1");
    const t2 = `test/${path.basename(f)}`;
    const t3 = `tests/${path.basename(f)}`;
    return fs.existsSync(path.resolve(cwd, t1)) || fs.existsSync(path.resolve(cwd, t2)) || fs.existsSync(path.resolve(cwd, t3));
  });
  const lines = sh(`wc -l < ${f}`).trim();
  results.push({
    file: f,
    callers: refs.length,
    caller_list: refs.slice(0, 10),
    churn_last_5_commits: churn,
    has_test: hasTest,
    lines: Number(lines) || 0,
    confidence: refs.length > 0 ? "Known" : "Likely",
  });
}

console.log(JSON.stringify({ target, found: true, touch_map: results }, null, 2));
