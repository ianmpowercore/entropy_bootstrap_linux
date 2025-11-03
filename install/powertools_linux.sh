#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
source install/helpers.sh

run_stage "PowerTools Suite" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: install wmctrl devilspie2 tesseract-ocr autokey-gtk gnome-tweaks'
  else
    sudo apt install -y wmctrl devilspie2 tesseract-ocr autokey-gtk gnome-tweaks
  fi
"
