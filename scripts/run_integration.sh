#!/usr/bin/env bash
# scripts/run_integration.sh
# Build the docker integration image and run the repo's setup in dry-run mode.
# Writes `ci-artifacts/install.log` locally for inspection.
set -Eeuo pipefail
IFS=$'\n\t'

DRY_RUN=true
OUT_DIR="ci_artifacts"
OUT_LOG="${OUT_DIR}/install.log"

usage() {
  cat <<'EOF'
Usage: run_integration.sh [--dry-run|--no-dry-run]

Builds the Docker image and runs the container. By default uses dry-run.
Outputs ci-artifacts/install.log in the repo root.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --no-dry-run|--no-dryrun)
      DRY_RUN=false
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1"; usage; exit 2
      ;;
  esac
done

mkdir -p "$OUT_DIR"

echo "Building docker image..."
docker build -t entropy-bootstrap-ci .

echo "Running container (DRY_RUN=${DRY_RUN})..."
# Mount the output directory so install.log is written to the host
docker run --rm -v "$(pwd)/${OUT_DIR}:/entropy_bootstrap_linux" --env DRY_RUN=${DRY_RUN} --name entropy-bootstrap-run entropy-bootstrap-ci \
  bash -lc "cd /entropy_bootstrap_linux && ./bootstrap/setup.sh --dry-run 2>&1 | tee /entropy_bootstrap_linux/install.log; exit \\\${PIPESTATUS[0]}"

if [ -s "$OUT_LOG" ]; then
  echo "Integration install log written to $OUT_LOG"
else
  echo "Warning: $OUT_LOG is empty or missing"
fi

exit 0
