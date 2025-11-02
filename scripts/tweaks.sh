#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/tweaks.sh
# Applies optional GNOME/Pop!_OS tweaks (uses gsettings when available).
set -Eeuo pipefail
IFS=$'\n\t'

echo "🎨 Applying Pop!_OS / GNOME tweaks (if available)..."

# Check for gsettings before trying to apply GNOME settings
if command -v gsettings >/dev/null 2>&1; then
  # Attempt to enable tiling by default (pop-shell extension)
  if gsettings list-schemas | grep -q org.gnome.shell.extensions.pop-shell; then
    gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true || true
  fi

  # Reduce animations for speed
  gsettings set org.gnome.desktop.interface enable-animations false || true
else
  echo "gsettings not found; skipping GNOME tweaks"
fi

echo "✅ Tweaks applied (where supported)."
