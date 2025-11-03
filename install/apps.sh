#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'
source install/helpers.sh

run_stage "Cursor IDE" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: install Cursor IDE'
  else
    curl -LO https://downloader.cursor.sh/linux/cursor.deb &&
    sudo apt install -y ./cursor.deb &&
    mkdir -p ~/.config/Cursor &&
    cp config/cursor/settings.json ~/.config/Cursor/settings.json 2>/dev/null || true
  fi
"

run_stage "Obsidian" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: flatpak install flathub md.obsidian.Obsidian'
  else
    sudo apt install -y flatpak
    flatpak install -y flathub md.obsidian.Obsidian
  fi
"

run_stage "Brave Browser" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: install Brave via apt'
  else
    sudo apt install -y apt-transport-https curl gnupg
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo 'deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main' | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update && sudo apt install -y brave-browser
  fi
"

run_stage "KeePassXC" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: install KeePassXC'
  else
    sudo apt install -y keepassxc
  fi
"

run_stage "Flameshot (ShareX Alt)" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: sudo apt install -y flameshot'
  else
    sudo apt install -y flameshot
  fi
"

run_stage "ChatGPT Desktop" "
  if [ '${DRY_RUN}' = 'true' ]; then
    echo 'DRY_RUN: flatpak install flathub com.openai.ChatGPT'
  else
    sudo apt install -y flatpak
    flatpak install -y flathub com.openai.ChatGPT
  fi
"
