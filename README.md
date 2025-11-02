# entropy_bootstrap_linux

Entropy bootstrap for a developer-first, modular Linux setup. Designed for Pop!_OS but compatible with Debian/Ubuntu-based systems.

## Quick usage

1. Inspect the repository and review the scripts in `scripts/` and `configs/`.
2. Make the main orchestrator executable and run it:

# entropy_bootstrap_linux

Entropy bootstrap for a developer-first, modular Linux setup. Designed for Pop!_OS but compatible with Debian/Ubuntu-based systems.

## Quick usage

1. Inspect the repository and review the scripts in `scripts/` and `configs/`.
2. Make the main orchestrator executable and run it:

```bash
chmod +x setup.sh
./setup.sh
```

The scripts are designed to be re-runnable and idempotent where possible. Run them in an isolated environment (Codespaces or VM) before using on production hardware.

## Security disclaimer

Review every script before running it. This project is intended to be transparent and readable — do not run the scripts as root without understanding the commands. The maintainers accept no responsibility for damage or data loss; always back up important data.

## CI

A GitHub Actions workflow is included at `.github/workflows/syntax-check.yml` which validates shell script syntax on push and pull requests.

## 📜 Script Overview

- `setup.sh` — Orchestrator that updates the system and sources the modular scripts in `scripts/`. Use this to run the full bootstrap after you have reviewed each script.
- `scripts/devtools.sh` — Installs minimal developer tools (git, curl, build-essential, python3-pip, etc.). Run this when provisioning a fresh developer environment.
- `scripts/privacy.sh` — Installs basic security utilities (ufw, fail2ban, clamav, gnupg) and enables a firewall. Run this to apply a simple security baseline.
- `scripts/aliases.sh` — Adds convenient shell aliases to `~/.bash_aliases` in an idempotent way. Run this to populate common shortcuts.
- `scripts/tweaks.sh` — Applies optional GNOME/Pop!_OS tweaks when `gsettings` is available (e.g., reduce animations, enable tiling). Use when running on a GNOME-based desktop.

Please inspect and understand each script before running `setup.sh`. The project is intentionally explicit — read the commands and verify they match your expectations.
