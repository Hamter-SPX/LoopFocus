# Secrets Gate

## What

Finds and verifies the handling of secrets everywhere they can hide: source files, configs, environment, logs, build artifacts, git history, client bundles.

## Why

A secret in any of these locations is a credential, not a string. Secrets are the one finding class where a single miss = full compromise, and where the scan surface is genuinely broad: the code you wrote, the code you committed, and the artifacts you shipped.

## When

As a machine scan (sast rules + git history sweep) plus a manual pass on storage and transit (Data Flow Security already traces them).

## Protocol

1. **Machine scan**: `loopfocus sast` flags hardcoded-key patterns with file:line; sweep git history for committed secrets (`git log -p` pattern check).
2. **Storage check**: where do secrets live at runtime — env, secrets manager, config file? Who can read them there?
3. **Transit check**: do they pass through logs, error messages, debug endpoints, or client bundles? (Data Flow trace supplies this.)
4. **Rotation check**: is there a rotation path? A secret with no rotation plan is a future breach with a fixed cost.
5. Every hit is a finding with its location class — a secret in git history is a DIFFERENT finding from one in source (different remediation, different severity).

## Evidence gates

- machine scans run, output attached
- runtime storage + transit verdicts recorded per secret class
- git history sweep done (not just working tree)

## Anti-patterns

- Scanning only the working tree (history and artifacts keep their own secrets)
- Treating `.env.example` as a secret leak (it is a template — check whether real values ever followed it)
- Finding a secret and fixing only that instance (the class needs the flow trace)

## Example

db.js hardcoded the production DB password (F4 High) AND /debug dumped db.config unauth (F5 High) — the gate's storage+transit checks connected one credential to two findings, and the remediation (env + rotate + close /debug) covered the class, not the instance.
