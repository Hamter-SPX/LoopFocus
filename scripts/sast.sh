#!/usr/bin/env bash
# SAST — static security scan with curated rules (no external tool required).
# Every finding: file:line + rule + severity. Exit 1 on Critical/High.
set -u

scan() {
  local pattern="$1" rule="$2" sev="$3"
  grep -rnE "$pattern" src lib app server 2>/dev/null | grep -v node_modules | grep -v ".test." | head -20 | while IFS=: read -r f l line; do
    printf '{"file":"%s","line":%s,"rule":"%s","severity":"%s"}\n' "$f" "$l" "$rule" "$sev"
  done
}

{
  scan '"SELECT[^"]*"[^)]*\+' sql-string-concat Critical
  scan '"INSERT[^"]*"[^)]*\+' sql-string-concat Critical
  scan '\beval\s*\(' eval-execution Critical
  scan '\bexec\s*\(' command-execution Critical
  scan 'child_process[.]exec' command-execution Critical
  scan 'dangerouslySetInnerHTML' unsafe-html High
  scan 'v-html=' unsafe-html High
  scan '(api[_-]?key|secret|password|token)["'"'"']?\s*[:=]\s*["'"'"'][A-Za-z0-9_-]{12,}' hardcoded-secret High
  scan 'innerHTML\s*=' unsafe-html Medium
  scan 'os[.]system' command-execution Critical
  scan 'shell\s*=\s*True' command-execution Critical
  scan 'pickle[.]load' unsafe-deserialization High
  scan 'md5\s*\(|sha1\s*\(' weak-crypto Medium
  scan 'http://' insecure-transport Low
} | sort > /tmp/lf-sast-findings.jsonl 2>/dev/null

count=$(wc -l < /tmp/lf-sast-findings.jsonl 2>/dev/null | tr -d ' ')
crit=$(grep -c '"severity":"Critical"' /tmp/lf-sast-findings.jsonl 2>/dev/null | tr -d ' ')

if [ "${count:-0}" -eq 0 ]; then
  echo '{"sast":"PASS","findings":0,"note":"no patterns matched the curated rules"}'
  exit 0
fi

cat /tmp/lf-sast-findings.jsonl
printf '{"sast":"%s","findings":%s,"critical":%s}\n' "$([ "$crit" -gt 0 ] && echo FAIL || echo WARN)" "$count" "$crit"

[ "$crit" -gt 0 ] && exit 1
exit 0
