#!/usr/bin/env node
"use strict";

const text = process.argv.slice(2).join(" ").toLowerCase();
if (!text) {
  console.error("usage: analysis-router.js <problem text>");
  process.exit(2);
}

const DOMAINS = [
  ["software", ["code", "bug", "api", "function", "server", "service", "app", "compiler", "runtime", "database", "cache", "memory leak"]],
  ["hardware", ["gpu", "cpu", "npu", "fpga", "memory", "ram", "pcie", "thermal", "power", "hardware", "soc", "accelerator", "ai", "inference", "training", "model"]],
  ["performance", ["slow", "latency", "throughput", "performance", "ช้า", "bottleneck", "timeout"]],
  ["temporal", ["after", "before", "since", "เปลี่ยน", "trend", "regression", "หลัง", "ก่อน", "recently"]],
  ["causal", ["why", "cause", "root", "because", "ทำไม", "สาเหตุ", "เกิดจาก"]],
  ["data", ["data", "dataset", "outlier", "bias", "distribution", "missing"]],
  ["decision", ["should", "choose", "better", "worth", "trade", "ควร", "เลือก", "คุ้ม"]],
  ["strategy", ["architecture", "company", "business", "market", "competitor", "strategy"]],
  ["diagnostic", ["error", "fail", "crash", "พัง", "fail"]],
  ["predictive", ["predict", "forecast", "future", "จะ", "ทำนาย"]],
];

const matched = DOMAINS.filter(([, kws]) => kws.some((k) => text.includes(k))).map(([d]) => d);
const engines = matched.length ? matched : ["software"];

const complexity = (text.match(/[.,;]/g) || []).length + (matched.length >= 3 ? 3 : 0) + (text.includes("multi") || text.includes("หลาย") ? 2 : 0);
const uncertaintyHints = ["ไม่รู้", "unsure", "maybe", "น่าจะ", "probably", "ไม่แน่ใจ"].filter((k) => text.includes(k)).length;
const level =
  matched.length >= 5 ? "L5"
  : matched.length >= 4 ? "L4"
  : complexity >= 8 ? "L3"
  : complexity >= 4 || uncertaintyHints >= 1 ? "L2"
  : complexity >= 1 ? "L1"
  : "L0";

console.log(JSON.stringify({
  domains: matched,
  engines,
  level,
  note: level === "L0" ? "quick analysis — escalate if evidence surprises" : `composed ${engines.length} engines at ${level}`,
}, null, 2));
