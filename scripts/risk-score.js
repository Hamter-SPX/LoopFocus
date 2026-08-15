#!/usr/bin/env node
"use strict";

const args = process.argv.slice(2);
function getFlag(name) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : null;
}

const severity = getFlag("severity") || "Info";
const confidence = getFlag("confidence") || "Unknown";
const exploitability = getFlag("exploitability") || "unverified";
const verified = exploitability === "reproduced" || exploitability === "tool-verified";

const validSev = ["Info", "Low", "Medium", "High", "Critical"];
const validConf = ["Unknown", "Likely", "Known"];
if (!validSev.includes(severity) || !validConf.includes(confidence)) {
  console.error("invalid severity/confidence");
  process.exit(2);
}

const result = {
  risk: `${severity}/${confidence}`,
  severity,
  confidence,
  verified,
};

if (confidence === "Unknown" && (severity === "High" || severity === "Critical")) {
  result.downgrade = "candidate";
  result.advice = "Unknown confidence cannot report at full severity — route to Exploitability Judge";
  result.verdict = "HOLD";
} else if (confidence !== "Unknown" && !verified && (severity === "High" || severity === "Critical")) {
  result.verdict = "HOLD";
  result.advice = "High/Critical requires a reproduction or tool output before reporting";
} else if (confidence === "Unknown" || !verified) {
  result.verdict = "CANDIDATE";
  result.advice = "candidate finding — verify before report";
} else {
  result.verdict = "REPORT";
  result.advice = "verified finding, report with evidence attached";
}

console.log(JSON.stringify(result));
process.exit(result.verdict === "REPORT" ? 0 : 1);
