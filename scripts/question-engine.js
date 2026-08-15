#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const file = getFlag("file");
if (!file) {
  console.error("usage: question-engine.js --file <questions.txt>");
  console.error("format: 'context: <text>' then 'questions:' then one question per '- ' line");
  process.exit(2);
}

let raw;
try {
  raw = fs.readFileSync(path.resolve(file), "utf8");
} catch {
  console.error(`cannot read ${file}`);
  process.exit(2);
}

const questions = raw.split("\n")
  .map((l) => l.trim())
  .filter((l) => l.startsWith("- "))
  .map((l) => l.slice(2));

if (!questions.length) {
  console.error("no questions found (lines starting with '- ')");
  process.exit(2);
}

function score(q) {
  let s = 0;
  if (/what|which|where|how|when|why/i.test(q)) s += 2;
  if (/is|are|does|can|should/.test(q)) s += 1;
  if (q.split(" ").length <= 8) s += 2;
  if (/color|name of|favorite|weather|racket|paint/.test(q)) s -= 5;
  if (/cause|root|bottleneck|bound|depends|affect|change|impact|threshold/.test(q)) s += 3;
  if (/slow|latency|performance|memory|cpu|gpu|error|fail/.test(q)) s += 2;
  return s;
}

const ranked = questions
  .map((q) => ({ question: q, information_value: score(q) }))
  .sort((a, b) => b.information_value - a.information_value);

console.log(JSON.stringify({
  ranked,
  best_question: ranked[0].question,
  note: "Question Supremacy: the best question is the one whose answer changes the most conclusions",
}, null, 2));
process.exit(0);
