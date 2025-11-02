# entropy_bootstrap_linux

Entropy bootstrap for a developer-first, modular Linux setup. Designed for Pop!_OS but compatible with Debian/Ubuntu-based systems.

## Quick usage

1. Inspect the repository and review the scripts in `scripts/` and `configs/`.
2. Make the main orchestrator executable and run it:

![Shell Lint](https://github.com/ianmpowercore/entropy_bootstrap_linux/actions/workflows/lint.yml/badge.svg)

# entropy_bootstrap_linux

Entropy bootstrap for a developer-first, modular Linux setup. Designed for Pop!_OS but compatible with Debian/Ubuntu-based systems.

## Quick Start

```bash
git clone https://github.com/ianmpowercore/entropy_bootstrap_linux.git
cd entropy_bootstrap_linux
chmod +x setup.sh
./setup.sh
```

Run the above in an isolated environment (Codespaces or VM) first. The scripts are designed to be re-runnable and idempotent where possible.

## Security Notice

Always inspect and understand each script before executing `setup.sh`. This project aims for transparency; do not run scripts as root without reviewing their contents. Back up important data before making system changes.

## Test in Docker

To run a lightweight syntax-only test in Docker:

```bash
docker build -t entropy-bootstrap .
docker run --rm entropy-bootstrap
```

## CI

A GitHub Actions workflow is included at `.github/workflows/lint.yml` which validates shell script syntax with `bash -n` and runs `shellcheck` on all `.sh` scripts.

## 📜 Script Overview

- `setup.sh` — Orchestrator that updates the system and sources the modular scripts in `scripts/`. Use this to run the full bootstrap after you have reviewed each script.
- `scripts/devtools.sh` — Installs minimal developer tools (git, curl, build-essential, python3-pip, etc.). Run this when provisioning a fresh developer environment.
- `scripts/privacy.sh` — Installs basic security utilities (ufw, fail2ban, clamav, gnupg) and enables a firewall. Run this to apply a simple security baseline.
- `scripts/aliases.sh` — Adds convenient shell aliases to `~/.bash_aliases` in an idempotent way. Run this to populate common shortcuts.
- `scripts/tweaks.sh` — Applies optional GNOME/Pop!_OS tweaks when `gsettings` is available (e.g., reduce animations, enable tiling). Use when running on a GNOME-based desktop.

Please inspect and understand each script before running `setup.sh`. The project is intentionally explicit — read the commands and verify they match your expectations.
