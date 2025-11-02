#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/aliases.sh
# Adds a small set of convenient shell aliases to ~/.bash_aliases.
# Safe to run multiple times.
set -Eeuo pipefail
IFS=$'\n\t'

echo "⚙️ Setting up aliases..."

# Respect DRY_RUN
if [ "${DRY_RUN:-false}" = "true" ]; then
  DRY_ECHO=true
else
  DRY_ECHO=false
fi

TARGET="$HOME/.bash_aliases"
MARKER="# entropy_bootstrap_linux aliases - start"

if grep -Fq "$MARKER" "$TARGET" 2>/dev/null; then
  echo "Aliases already present in $TARGET"
else
  if [ "${DRY_ECHO}" = "true" ]; then
    echo "DRY_RUN: append aliases to $TARGET"
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
fi

echo "✅ Aliases added (dry-run: ${DRY_ECHO})"
