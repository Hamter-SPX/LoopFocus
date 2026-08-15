#!/usr/bin/env node
"use strict";
// Runtime Observer — pull Prometheus/OTel-style metrics from an endpoint and normalize latency deltas
const http = require("http");
const https = require("https");

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const url = getFlag("url");
const metric = getFlag("metric");
const baseline = Number(getFlag("baseline") || "0");

if (!url) {
  console.error("usage: otel-observe.js --url <metrics-endpoint> --metric <name> [--baseline <ms>]");
  process.exit(2);
}

const lib = url.startsWith("https") ? https : http;
lib.get(url, (res) => {
  let body = "";
  res.on("data", (c) => (body += c));
  res.on("end", () => {
    const lines = body.split("\n").filter((l) => l && !l.startsWith("#"));
    const match = lines.find((l) => metric ? l.startsWith(metric) : l.includes("latency"));
    if (!match) {
      console.log(JSON.stringify({ observed: "no-matching-metric", metric, note: "metric not found in endpoint output" }));
      process.exit(0);
    }
    const value = Number(match.split(" ").filter((t) => t !== "").slice(-1)[0]);
    const current = value;
    let delta = 0;
    let verdict = "continue";
    if (baseline > 0 && current > baseline * 1.5) {
      verdict = "regression";
      delta = current - baseline;
    }
    console.log(JSON.stringify({
      metric: match.split("{")[0].trim(),
      current_value: current,
      baseline,
      delta_ms: delta,
      verdict,
      advice: verdict === "regression"
        ? `tests may pass but latency jumped ${delta}ms — normalize as: --source runtime:otel --status fail --failure-class latency`
        : "runtime healthy",
    }));
  });
}).on("error", (e) => {
  console.log(JSON.stringify({ observed: "unavailable", note: e.message, advice: "mark runtime gate SKIP — no runtime telemetry reachable" }));
  process.exit(0);
});
