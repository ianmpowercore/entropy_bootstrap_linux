#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/aliases.sh
# Adds a small set of convenient shell aliases to ~/.bash_aliases.
# Safe to run multiple times.
set -Eeuo pipefail
IFS=$'\n\t'

echo "⚙️ Setting up aliases..."

TARGET="$HOME/.bash_aliases"
MARKER="# entropy_bootstrap_linux aliases - start"

if grep -Fq "$MARKER" "$TARGET" 2>/dev/null; then
  echo "Aliases already present in $TARGET"
else
  cat << 'EOF' >> "$TARGET"
# entropy_bootstrap_linux aliases - start
alias update='sudo apt update && sudo apt upgrade -y'
alias ll='ls -lh --color=auto'
alias cls='clear'
alias edit='nano'
alias rebootnow='sudo reboot'
# entropy_bootstrap_linux aliases - end
EOF
  echo "Added aliases to $TARGET"
fi

echo "✅ Aliases added (or were already present)."
