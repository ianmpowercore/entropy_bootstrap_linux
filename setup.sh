#!/usr/bin/env bash
# entropy_bootstrap_linux/setup.sh
# Orchestrator: run modular bootstrap scripts from `scripts/` and apply configs.
# Usage: review scripts/, then run this script from the repo root.
set -Eeuo pipefail
IFS=$'\n\t'

echo "Entropy Bootstrap v0.1.1"
echo "🚀 Starting Entropy Bootstrap for Linux..."

# Ensure we are in the repository root when running the script
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Repo root: ${REPO_ROOT}"

echo "🔁 Updating package lists (safe to re-run)..."
sudo apt update && sudo apt upgrade -y

# Source modular scripts if they exist
if [ -f "${REPO_ROOT}/scripts/devtools.sh" ]; then
  echo "🧑‍💻 Running devtools..."
  # shellcheck source=/dev/null
  source "${REPO_ROOT}/scripts/devtools.sh"
fi

if [ -f "${REPO_ROOT}/scripts/privacy.sh" ]; then
  echo "🔒 Running privacy & security setup..."
  # shellcheck source=/dev/null
  source "${REPO_ROOT}/scripts/privacy.sh"
fi

if [ -f "${REPO_ROOT}/scripts/aliases.sh" ]; then
  echo "⚙️ Applying aliases..."
  # shellcheck source=/dev/null
  source "${REPO_ROOT}/scripts/aliases.sh"
fi

if [ -f "${REPO_ROOT}/scripts/tweaks.sh" ]; then
  echo "🎨 Applying system tweaks..."
  # shellcheck source=/dev/null
  source "${REPO_ROOT}/scripts/tweaks.sh"
fi

echo "🧩 Applying configuration files to home directory (idempotent)..."
# Only copy the known config files to avoid copying .. or .git
for f in .bash_aliases .zshrc .gitconfig .vimrc; do
  if [ -f "${REPO_ROOT}/configs/${f}" ]; then
    cp -f "${REPO_ROOT}/configs/${f}" "$HOME/${f}"
    echo "  -> $f"
  fi
done

echo "✅ Setup complete!"
echo "Run 'source ~/.bash_aliases' or 'source ~/.zshrc' to apply shell changes, or restart your shell."
