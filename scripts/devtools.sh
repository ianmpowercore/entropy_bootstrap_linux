#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/devtools.sh
# Installs minimal developer packages useful for initial provisioning.
# Re-runable; inspect before executing.
set -Eeuo pipefail
IFS=$'\n\t'

echo "🧑‍💻 Installing development tools..."

# Respect DRY_RUN: if DRY_RUN=true, echo actions instead of running them
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

# Minimal, commonly useful developer packages. Safe to re-run.
run_cmd "sudo apt install -y \
  git \
  curl \
  wget \
  build-essential \
  python3-pip \
  neofetch \
  htop \
  vim \
  gnome-tweaks || true"

# Optional: install zsh and set as login shell if available
if command -v zsh >/dev/null 2>&1; then
  echo "zsh already installed"
else
  run_cmd "sudo apt install -y zsh || true"
fi

if command -v zsh >/dev/null 2>&1; then
  # Change shell for the current user only if not already zsh
  if [ "$(basename "${SHELL:-}")" != "zsh" ]; then
    echo "Changing login shell to zsh for user $USER"
    run_cmd "chsh -s \"$(command -v zsh)\" || true"
  fi
fi

echo "✅ Developer tools (dry-run: ${DRY_ECHO})"
