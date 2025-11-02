#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/devtools.sh
# Installs minimal developer packages useful for initial provisioning.
# Re-runable; inspect before executing.
set -Eeuo pipefail
IFS=$'\n\t'

echo "🧑‍💻 Installing development tools..."

# Minimal, commonly useful developer packages. Safe to re-run.
sudo apt install -y \
  git \
  curl \
  wget \
  build-essential \
  python3-pip \
  neofetch \
  htop \
  vim \
  gnome-tweaks || true

# Optional: install zsh and set as login shell if available
if command -v zsh >/dev/null 2>&1; then
  echo "zsh already installed"
else
  sudo apt install -y zsh || true
fi

if command -v zsh >/dev/null 2>&1; then
  # Change shell for the current user only if not already zsh
  if [ "$(basename "${SHELL:-}")" != "zsh" ]; then
    echo "Changing login shell to zsh for user $USER"
    chsh -s "$(command -v zsh)" || true
  fi
fi

echo "✅ Developer tools installed."
