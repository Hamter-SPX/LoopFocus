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

const sub = process.argv[2];
const id = process.argv[3];

switch (sub) {
  case "runs":
    console.log(sh("gh run list --limit 10"));
    break;
  case "failed-jobs":
    if (!id) { console.error("usage: ci-controller.js failed-jobs <run-id>"); process.exit(2); }
    console.log(sh(`gh run view ${id} --json jobs --jq '.jobs[] | select(.conclusion==\"failure\") | .name'`));
    break;
  case "logs":
    if (!id) { console.error("usage: ci-controller.js logs <run-id>"); process.exit(2); }
    console.log(sh(`gh run view ${id} --log-failed`, true) || "no failed logs");
    break;
  case "rerun-failed":
    if (!id) { console.error("usage: ci-controller.js rerun-failed <run-id>"); process.exit(2); }
    console.log(sh(`gh run rerun ${id} --failed`));
    break;
  case "artifacts":
    if (!id) { console.error("usage: ci-controller.js artifacts <run-id>"); process.exit(2); }
    console.log(sh(`gh run view ${id} --json artifacts --jq '.artifacts[] | .name'`));
    break;
  default:
    console.error("usage: ci-controller.js runs | failed-jobs <id> | logs <id> | rerun-failed <id> | artifacts <id>");
    process.exit(2);
}
