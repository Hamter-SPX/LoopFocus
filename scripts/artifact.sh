#!/usr/bin/env bash
set -u

DIR=".loopfocus"
sub="${1:-}"

usage() {
  echo "usage: artifact.sh save <file> --attempt N --source <label> | list | clean"
  exit 2
}

case "$sub" in
  save)
    shift
    src=""
    attempt="0"
    source_label="unknown"
    while [ $# -gt 0 ]; do
      case "$1" in
        --attempt) attempt="$2"; shift 2 ;;
        --source) source_label="$2"; shift 2 ;;
        -*) shift ;;
        *) src="$1"; shift ;;
      esac
    done
    [ -n "$src" ] || usage
    [ -f "$src" ] || { echo "artifact: file not found: $src"; exit 1; }
    mkdir -p "$DIR/evidence"
    ext="${src##*.}"
    dst="$DIR/evidence/attempt-${attempt}-${source_label}.${ext}"
    cp "$src" "$dst"
    echo "artifact saved: $dst"
    ;;
  list)
    ls -1 "$DIR/evidence/" 2>/dev/null || echo "(no artifacts)"
    ;;
  clean)
    rm -f "$DIR/evidence/"* 2>/dev/null
    echo "artifacts cleaned"
    ;;
  *) usage ;;
esac
