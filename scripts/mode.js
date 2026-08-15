#!/usr/bin/env node
"use strict";
const fs = require("fs");
const path = require("path");

const MODES = {
  "analysis-intelligence": {
    trigger: ["analyze", "explain", "what", "why", "how does", "review the code", "understand", "อธิบาย", "คืออะไร"],
    may: "read, run read-only commands, explain, draw canvases",
    must_not: "edit files, install dependencies, change state",
    gates: ["entry", "context"],
    closes_when: "the explanation is delivered with file:line evidence",
    safe_unasked: true,
    flow: "none — read-only",
  },
  debug: {
    trigger: ["bug", "fix", "broken", "failing", "error", "crash", "ไม่ทำงาน", "แก้", "พัง"],
    may: "everything inside the bug-fix flow",
    must_not: "fix symptoms without root-cause evidence; retry a failed approach",
    gates: ["entry", "context", "mutation", "build", "test", "regression", "progress", "repeat", "completion"],
    closes_when: "root cause fixed, regression-free, verify PASS",
    safe_unasked: false,
    flow: "flow/bug-fix-flow.md",
  },
  build: {
    trigger: ["build", "feature", "add", "implement", "create", "new component", "ทำฟีเจอร์", "เพิ่ม"],
    may: "everything inside the feature-build flow (M4)",
    must_not: "code before canvas + predictive + DoD graph; expand scope unapproved",
    gates: ["entry", "context", "plan", "mutation", "change-radius", "build", "static", "test", "regression", "artifact", "completion"],
    closes_when: "DoD chain complete, gates pass, verify PASS",
    safe_unasked: false,
    flow: "flow/feature-build-flow.md",
  },
  "security-arch": {
    trigger: ["security", "audit", "scan", "vulnerab", "cve", "secure", "pentest", "ช่องโหว่"],
    may: "inspect everything, run every audit tool, write findings, build threat models",
    must_not: "apply fixes without user selection (Fix Policy); report unverified suspicions as findings; declare anything 'secure'",
    gates: ["entry", "context", "assumption", "artifact", "coverage", "mutation", "sast", "completion"],
    closes_when: "7 categories walked + Layer-2 machine scans run (sast/fuzz/audit) + threat model drawn + every finding evidenced + user asked about fixes",
    safe_unasked: false,
    flow: "flow/security-audit-flow.md",
  },
  review: {
    trigger: ["review", "pr", "pull request", "check my code", "code review", "รีวิว"],
    may: "read, run tests, produce dual-verdict findings",
    must_not: "fix findings without being asked; approve without evidence",
    gates: ["entry", "context", "artifact"],
    closes_when: "spec + quality verdicts delivered with evidenced findings",
    safe_unasked: false,
    flow: "flow/review-flow.md",
  },
  recover: {
    trigger: ["resume", "continue", "recover", "ต่อจาก", "ต่อ", "pick up", "restore"],
    may: "read the recovery capsule, cross-check, resume at NEXT",
    must_not: "redo PROVEN work; start from the prompt alone",
    gates: ["entry", "recovery", "evidence-freshness"],
    closes_when: "resumed at the recorded NEXT with a resume ledger entry",
    safe_unasked: true,
    flow: "flow/recovery-flow.md",
  },
  ship: {
    trigger: ["ready", "merge", "finish", "deploy", "release", "ส่งมอบ", "ปิดงาน"],
    may: "run full gates, package the completion report",
    must_not: "merge/push/discard on the user's behalf; claim done with blockers",
    gates: ["completion", "ci", "artifact"],
    closes_when: "integration options presented, user chose, no silent decisions",
    safe_unasked: false,
    flow: "none — completion contract in SKILL.md",
  },
  "author-skill": {
    trigger: ["author skill", "create skill", "write skill", "edit skill", "สกิล"],
    may: "run TDD RED/GREEN/REFACTOR on skill content",
    must_not: "write SKILL.md content before baseline pressure tests (Iron Law)",
    gates: ["entry", "artifact", "completion"],
    closes_when: "baseline documented, skill written, GREEN passed, loopholes closed",
    safe_unasked: false,
    flow: "none — writing-skills discipline",
  },
};

function resolve(text) {
  const lower = text.toLowerCase();
  const scores = {};
  for (const [name, m] of Object.entries(MODES)) {
    let score = 0;
    for (const t of m.trigger) {
      if (lower.includes(t.toLowerCase())) score++;
    }
    if (score > 0) scores[name] = score;
  }
  if (Object.keys(scores).length === 0) return { mode: "analysis-intelligence", matched: [], note: "no trigger — analysis-intelligence is the only always-safe mode" };
  const sorted = Object.entries(scores).sort((a, b) => b[1] - a[1]);
  if (sorted.length > 1 && sorted[0][1] === sorted[1][1]) {
    console.error(JSON.stringify({ error: "ambiguous", candidates: sorted.filter(([, s]) => s === sorted[0][1]).map(([n]) => n) }));
    process.exit(1);
  }
  return { mode: sorted[0][0], matched: sorted.map(([n, s]) => `${n}:${s}`) };
}

const sub = process.argv[2];

if (sub === "resolve") {
  const text = process.argv.slice(3).join(" ") || process.argv[3] || "";
  console.log(JSON.stringify(resolve(text)));
} else if (sub === "show") {
  const name = process.argv[3];
  if (!name || !MODES[name]) {
    console.error(`modes: ${Object.keys(MODES).join(" ")}`);
    process.exit(name ? 2 : 0);
  }
  console.log(JSON.stringify({ mode: name, ...MODES[name] }, null, 2));
} else if (sub === "list") {
  for (const [name, m] of Object.entries(MODES)) {
    console.log(`${name.padEnd(14)} ${m.safe_unasked ? "(safe unasked)" : ""}  flow: ${m.flow}`);
  }
} else if (sub === "check") {
  const name = process.argv[3];
  if (!name || !MODES[name]) {
    console.error("usage: mode.mjs check <mode> [--state .loopfocus/mode-state.json]");
    process.exit(2);
  }
  const stateFlag = process.argv.indexOf("--state");
  const statePath = stateFlag !== -1 ? process.argv[stateFlag + 1] : ".loopfocus/mode-state.json";
  let state = null;
  try {
    state = JSON.parse(fs.readFileSync(path.resolve(statePath), "utf8"));
  } catch {
    console.log(JSON.stringify({ verdict: "FAIL", reason: "no mode-state recorded", next_action: "record_mode_state" }));
    process.exit(1);
  }
  const m = MODES[name];
  const problems = [];
  if (state.mode !== name) problems.push(`mode-state says ${state.mode}, not ${name}`);
  if (!state.goal_locked) problems.push("goal not locked");
  for (const g of m.gates) {
    if (!state.gates_ran || !state.gates_ran.includes(g)) problems.push(`gate not run: ${g}`);
  }
  if (!state.self_audit_pass) problems.push("self-audit pass not done");
  if (problems.length === 0) {
    console.log(JSON.stringify({ verdict: "PASS", mode: name }));
    process.exit(0);
  }
  console.log(JSON.stringify({ verdict: "FAIL", mode: name, problems, next_action: "resolve_problems" }));
  process.exit(1);
} else {
  console.error("usage: mode.mjs resolve <text> | show <mode> | list | check <mode> [--state file]");
  process.exit(2);
}
