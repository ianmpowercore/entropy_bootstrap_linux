#!/usr/bin/env bash
# bootstrap/bootstrap_main.sh - optional orchestrator
set -Eeuo pipefail
IFS=$'\n\t'

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"${DIR}/setup.sh" "$@"
