#!/usr/bin/env bash
# helpers.sh - shared logic for modular installers
set -Eeuo pipefail
IFS=$'\n\t'

: "${INSTALL_LOG:=./ci-artifacts/install.log}"
: "${DRY_RUN:=true}"

run_stage() {
  local name="$1"
  local cmd="$2"

  echo -e "\n🧩 [$name]\n--------------------------------" | tee -a "$INSTALL_LOG"
  if [ "$DRY_RUN" = true ]; then
    echo "DRY_RUN: $cmd" | tee -a "$INSTALL_LOG"
  else
    bash -lc "$cmd" 2>&1 | tee -a "$INSTALL_LOG"
    local rc=${PIPESTATUS[0]:-0}
    [ "$rc" -ne 0 ] && echo "✖ $name failed ($rc)" | tee -a "$INSTALL_LOG"
  fi
  echo "✅ $name complete!" | tee -a "$INSTALL_LOG"
}
