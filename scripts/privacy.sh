#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/privacy.sh
# Installs and configures a basic security baseline (ufw, fail2ban, etc.).
# Review before running.
set -Eeuo pipefail
IFS=$'\n\t'

echo "🔒 Setting up privacy and security..."

# Respect DRY_RUN
if [ "${DRY_RUN:-false}" = "true" ]; then
  DRY_ECHO=true
else
  DRY_ECHO=false
fi

run_cmd() {
  if [ "${DRY_ECHO}" = "true" ]; then
    echo "DRY_RUN: $*"
  else
    eval "$*"
  fi
}

run_cmd "sudo apt install -y \
  ufw \
  fail2ban \
  clamav \
  gnupg || true"

# Enable UFW if not active
if command -v ufw >/dev/null 2>&1; then
  if [ "${DRY_ECHO}" = "true" ]; then
    echo "DRY_RUN: check and enable ufw if needed"
  else
    if ! sudo ufw status | grep -qi active; then
      echo "Enabling ufw firewall"
      sudo ufw --force enable
    else
      echo "ufw already enabled"
    fi
  fi
fi

echo "✅ Security baseline (dry-run: ${DRY_ECHO})"
