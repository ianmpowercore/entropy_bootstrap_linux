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
# entropy_bootstrap_linux