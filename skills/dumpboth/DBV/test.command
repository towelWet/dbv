#!/bin/zsh
# Run DBV tests with the same external TMPDIR/build-path as build.command.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=/dev/null
source "$ROOT/dbv-swift-env.sh"

cd "$ROOT"
python3 "$ROOT/Tools/generate-format-registry.py"
swift test --build-path "$SWIFT_BUILD_DIR"
