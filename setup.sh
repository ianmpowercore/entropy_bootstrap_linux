#!/usr/bin/env bash
# entropy_bootstrap_linux/setup.sh
# Orchestrator: run modular bootstrap scripts from `scripts/` and apply configs.
# Usage: review scripts/, then run this script from the repo root.
set -Eeuo pipefail
IFS=$'\n\t'

# Load repo defaults if present (does not export from file)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "${REPO_ROOT}/configs/defaults.env" ]; then
  # shellcheck source=/dev/null
  # shellcheck disable=SC1091
  source "${REPO_ROOT}/configs/defaults.env"
fi

# CLI argument parsing
DRY_RUN="${DRY_RUN:-false}"
show_help() {
  cat <<'EOF'
Usage: setup.sh [--dry-run] [-h|--help]

Options:
  --dry-run     Run in dry-run mode (echo actions instead of executing)
  -h, --help    Show this help message

Note: The script will source `configs/defaults.env` if present. By default
DRY_RUN is true in the test defaults file; to perform real installs set
DRY_RUN=false explicitly.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 2
      ;;
  esac
done

echo "Entropy Bootstrap ${ENTROPY_VERSION:-v0.1.3-tested} - Dry run: ${DRY_RUN:-false}"
echo "🚀 Starting Entropy Bootstrap for Linux..."

echo "📁 Repo root: ${REPO_ROOT}"

echo "🔁 Updating package lists (safe to re-run)..."
if [ "${DRY_RUN}" = "true" ]; then
  echo "DRY_RUN: sudo apt update && sudo apt upgrade -y"
else
  sudo apt update && sudo apt upgrade -y
fi

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
