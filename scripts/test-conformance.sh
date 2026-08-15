#!/usr/bin/env bash
set -u
CF=/Users/jirawat/Projects/SkillHub/LoopFocus/scripts/loopfocus-conformance.sh
ROOT=/Users/jirawat/Projects/SkillHub/LoopFocus
TMP=$(mktemp -d)
fail=0

mkdir -p "$TMP/skill"
cp -R "$ROOT/SKILL.md" "$ROOT/references" "$ROOT/flow" "$ROOT/schemas" "$ROOT/templates" "$ROOT/scripts" "$TMP/skill/" 2>/dev/null

bash "$CF" --dir "$TMP/skill" >/dev/null 2>&1
[ $? -eq 0 ] || { echo "T1 FAIL: healthy skill should pass"; fail=1; }

rm "$TMP/skill/references/gate-engine.md"
bash "$CF" --dir "$TMP/skill" >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T2 FAIL: missing reference should fail"; fail=1; }

echo "broken json" > "$TMP/skill/schemas/signal.schema.json"
bash "$CF" --dir "$TMP/skill" >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T3 FAIL: broken schema should fail"; fail=1; }

cp -R "$ROOT/SKILL.md" "$ROOT/references" "$ROOT/flow" "$ROOT/schemas" "$ROOT/templates" "$ROOT/scripts" "$TMP/skill/" 2>/dev/null
sed -i '' 's/^name: loopfocus/name: bad_name_with_underscore/' "$TMP/skill/SKILL.md"
bash "$CF" --dir "$TMP/skill" >/dev/null 2>&1
[ $? -ne 0 ] || { echo "T4 FAIL: invalid skill name should fail"; fail=1; }

[ $fail -eq 0 ] && echo "ALL PASS"
exit $fail
