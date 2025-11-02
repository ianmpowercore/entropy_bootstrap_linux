#!/usr/bin/env bash
# entropy_bootstrap_linux/scripts/tweaks.sh
# Applies optional GNOME/Pop!_OS tweaks (uses gsettings when available).
set -Eeuo pipefail
IFS=$'\n\t'

echo "🎨 Applying Pop!_OS / GNOME tweaks (if available)..."

# Respect DRY_RUN
if [ "${DRY_RUN:-false}" = "true" ]; then
  DRY_ECHO=true
else
  DRY_ECHO=false
fi

# Check for gsettings before trying to apply GNOME settings
if command -v gsettings >/dev/null 2>&1; then
  # Attempt to enable tiling by default (pop-shell extension)
  if gsettings list-schemas | grep -q org.gnome.shell.extensions.pop-shell; then
    if [ "${DRY_ECHO}" = "true" ]; then
      echo "DRY_RUN: gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true"
    else
      gsettings set org.gnome.shell.extensions.pop-shell tile-by-default true || true
    fi
  fi

  # Reduce animations for speed
  if [ "${DRY_ECHO}" = "true" ]; then
    echo "DRY_RUN: gsettings set org.gnome.desktop.interface enable-animations false"
  else
    gsettings set org.gnome.desktop.interface enable-animations false || true
  fi
else
  echo "gsettings not found; skipping GNOME tweaks"
fi

echo "✅ Tweaks applied (dry-run: ${DRY_ECHO})"
