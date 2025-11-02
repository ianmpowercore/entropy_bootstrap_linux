#!/usr/bin/env bash
# bootstrap/validate_env.sh - check for required commands
set -Eeuo pipefail
IFS=$'\n\t'

required=(bash sudo curl docker)
missing=()
for cmd in "${required[@]}"; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing required commands: ${missing[*]}" >&2
  exit 2
fi

echo "Environment OK"
