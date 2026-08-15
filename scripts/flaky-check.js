#!/usr/bin/env node
"use strict";
const { execSync } = require("child_process");

function sh(cmd, ok) {
  try {
    return execSync(cmd, { encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }).trim();
  } catch (e) {
    if (ok) return "";
    console.error(e.stderr.trim());
    process.exit(1);
  }
}

const runId = process.argv[2];
if (!runId) {
  console.error("usage: flaky-check.js <run-id> — reruns failed jobs once and separates flaky from real failures");
  process.exit(2);
}

console.log(`rerunning failed jobs of ${runId} once...`);
const rerun = sh(`gh run rerun ${runId} --failed`, true);
if (!rerun) {
  console.error("no failed jobs to rerun (or gh failed)");
  process.exit(1);
}

sh(`gh run watch ${runId} --exit-status >/dev/null 2>&1`, true);

const jobs = sh(`gh run view ${runId} --json jobs --jq '.jobs[] | {name: .name, conclusion: .conclusion}'`, true);
const parsed = jobs.split("\n").map((l) => JSON.parse(l));
const stillFailed = parsed.filter((j) => j.conclusion === "failure");
const recovered = parsed.filter((j) => j.conclusion === "success");

console.log(JSON.stringify({
  verdict: stillFailed.length === 0 ? "flaky" : "code-failure",
  still_failed: stillFailed.map((j) => j.name),
  recovered_on_rerun: recovered.map((j) => j.name),
  advice: stillFailed.length === 0
    ? "all failed jobs passed on rerun — environment/flaky, do NOT touch code"
    : `jobs ${stillFailed.map((j) => j.name).join(", ")} fail deterministically — real code failure, investigate with ci-controller.js logs ${runId}`,
}, null, 2));

process.exit(stillFailed.length === 0 ? 0 : 1);
