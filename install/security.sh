#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
source install/helpers.sh

run_stage "Security & Privacy" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: sudo apt install -y ufw fail2ban clamav gnupg'
  else
    sudo apt install -y ufw fail2ban clamav gnupg
    sudo ufw enable || true
  fi
"
