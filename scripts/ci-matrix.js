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
  console.error("usage: ci-matrix.js <run-id>  — parses the run's jobs into failure domains");
  process.exit(2);
}

const jobs = sh(`gh run view ${runId} --json jobs --jq '.jobs[] | {name: .name, conclusion: .conclusion}'`, true);
if (!jobs) {
  console.error("no jobs found — is gh authenticated?");
  process.exit(1);
}

const parsed = jobs.split("\n").map((l) => JSON.parse(l));
const failed = parsed.filter((j) => j.conclusion === "failure");
const passed = parsed.filter((j) => j.conclusion === "success");
const other = parsed.filter((j) => j.conclusion !== "failure" && j.conclusion !== "success");

const domains = [...new Set(failed.map((j) => {
  const m = j.name.match(/\((.*?)\)/);
  return m ? m[1] : j.name;
}))];

console.log(JSON.stringify({
  run: runId,
  total_jobs: parsed.length,
  failed_jobs: failed.map((j) => j.name),
  passed_jobs: passed.map((j) => j.name),
  other: other.map((j) => `${j.name}:${j.conclusion}`),
  failure_domains: domains,
  advice: failed.length === 0
    ? "clean run"
    : domains.length === 1
      ? `single failure domain: ${domains[0]} — rerun only that shard (gh run rerun ${runId} --failed)`
      : `multiple failure domains: ${domains.join(", ")} — investigate shared cause (a build break explains test failures downstream)`,
}, null, 2));
