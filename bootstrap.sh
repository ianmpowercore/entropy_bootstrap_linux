#!/usr/bin/env bash
# bootstrap.sh — orchestrates modular setup with dry-run and logging
set -Eeuo pipefail
IFS=$'\n\t'

if [ -f defaults.env ]; then
  # shellcheck disable=SC1091
  source defaults.env
fi

# shellcheck disable=SC1091
source install/helpers.sh

echo "🚀 Entropy Bootstrap ${ENTROPY_VERSION:-v0.1.3} (Dry Run: ${DRY_RUN:-true})"
mkdir -p "${CI_ARTIFACT_DIR:-ci-artifacts}"

run_stage "System Update" "
  if [ \"${DRY_RUN:-true}\" = true ]; then
    echo 'DRY_RUN: sudo apt update && sudo apt upgrade -y'
  else
    sudo apt update && sudo apt upgrade -y
  fi
"

run_stage "Developer Tools" "bash install/devtools.sh"
run_stage "Security Setup" "bash install/security.sh"
run_stage "App Installation" "bash install/apps.sh"
run_stage "Power Tools" "bash install/powertools_linux.sh"

echo '✅ Bootstrap complete! Restart your shell to apply changes.'
