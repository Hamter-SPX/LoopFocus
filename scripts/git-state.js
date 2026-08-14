#!/usr/bin/env node
"use strict";
const { execSync } = require("child_process");

function sh(cmd) {
  try {
    return execSync(cmd, { encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] }).trim();
  } catch {
    return "";
  }
}

const sub = process.argv[2];

if (sub === "worktree-new") {
  const name = process.argv[3] || `attempt-${Date.now()}`;
  const out = sh(`git worktree add -b ${name} ../${name} HEAD`);
  if (!out && !sh("git worktree list").includes(name)) {
    console.log(`created worktree: ${name}`);
  } else {
    console.log(out || `created worktree: ${name}`);
  }
} else if (sub === "worktree-list") {
  console.log(sh("git worktree list") || "no worktrees");
} else if (sub === "worktree-remove") {
  const name = process.argv[3];
  if (!name) {
    console.error("usage: git-state.js worktree-remove <name>");
    process.exit(2);
  }
  console.log(sh(`git worktree remove --force ../${name}`) || `removed worktree: ${name}`);
} else {
  const branch = sh("git rev-parse --abbrev-ref HEAD");
  const commits = sh("git log --oneline -5");
  const staged = sh("git diff --cached --name-only");
  const unstaged = sh("git diff --name-only");
  const untracked = sh("git ls-files --others --exclude-standard");
  const stat = sh("git diff HEAD --stat");
  console.log(JSON.stringify({
    branch,
    last_commits: commits.split("\n").filter(Boolean),
    staged_files: staged.split("\n").filter(Boolean),
    unstaged_files: unstaged.split("\n").filter(Boolean),
    untracked_files: untracked.split("\n").filter(Boolean),
    diff_stat: stat.split("\n").filter(Boolean),
  }, null, 2));
}
