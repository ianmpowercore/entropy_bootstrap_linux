#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/privacy.sh
set -euo pipefail

echo "🔒 Setting up privacy and security..."

sudo apt install -y \
  ufw \
  fail2ban \
  clamav \
  gnupg || true

# Enable UFW if not active
if command -v ufw >/dev/null 2>&1; then
  if ! sudo ufw status | grep -qi active; then
    echo "Enabling ufw firewall"
    sudo ufw --force enable
  else
    echo "ufw already enabled"
  fi
fi

echo "✅ Security baseline complete."
