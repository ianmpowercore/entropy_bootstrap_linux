#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
source install/helpers.sh

run_stage "Developer Tools" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: sudo apt install -y git curl wget build-essential python3-pip neofetch htop vim zsh'
  else
    sudo apt install -y git curl wget build-essential python3-pip neofetch htop vim zsh
    chsh -s $(which zsh) || true
  fi
"
