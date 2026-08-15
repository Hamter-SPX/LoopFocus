#!/usr/bin/env bash
set -u

usage() {
  echo "usage: sandbox.sh run <image> <command...>   — run a command in an isolated container"
  echo "       sandbox.sh check                       — verify docker is available"
  exit 2
}

sub="${1:-}"

case "$sub" in
  check)
    if docker info >/dev/null 2>&1; then
      echo '{"sandbox":"ready"}'
    else
      echo '{"sandbox":"unavailable","action":"start docker or skip sandbox — mark the gate SKIP"}'
      exit 1
    fi
    ;;
  run)
    shift
    image="$1"; shift || usage
    [ -n "$image" ] || usage
    workdir="/work"
    cmd="${*:-true}"
    docker run --rm -v "$(pwd):$workdir" -w "$workdir" "$image" sh -c "$cmd"
    ;;
  *) usage ;;
esac
