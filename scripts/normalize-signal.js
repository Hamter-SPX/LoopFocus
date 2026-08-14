#!/usr/bin/env node
"use strict";

const args = process.argv.slice(2);
function getFlag(name, fallback) {
  const i = args.indexOf("--" + name);
  return i !== -1 && i + 1 < args.length ? args[i + 1] : fallback;
}

const attempt = Number(getFlag("attempt", "0"));
const source = getFlag("source", "unknown");
const status = getFlag("status", "unknown");
const prevFails = Number(getFlag("previous-failures", "0"));
const currFails = Number(getFlag("current-failures", "0"));
const failureClass = getFlag("failure-class", "");
const newRegressions = Number(getFlag("new-regressions", "0"));
const evidenceFresh = getFlag("evidence-fresh", "true") === "true";

const delta = prevFails - currFails;
const progress = currFails < prevFails && newRegressions === 0 && evidenceFresh;
const mutationNeeded = !progress && status === "fail" && delta <= 0;
const rollbackNeeded = newRegressions > 0;

let nextAction = "continue";
if (mutationNeeded) nextAction = "mutate";
if (rollbackNeeded) nextAction = "rollback";
if (status === "pass" && progress === false && newRegressions === 0) nextAction = "continue";

console.log(JSON.stringify({
  attempt,
  source,
  status,
  previous_failures: prevFails,
  current_failures: currFails,
  delta: delta >= 0 ? `+${delta}` : `${delta}`,
  failure_class: failureClass,
  new_regressions: newRegressions,
  evidence_fresh: evidenceFresh,
  progress,
  next_action: nextAction,
}));
