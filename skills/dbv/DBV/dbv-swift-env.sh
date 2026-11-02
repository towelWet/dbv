#!/bin/zsh
# Shared Swift/clang offload for DBV — source from build.command and test.command.
# Never write .build or module cache under ~/… on internal disk.

dbv_pick_offload_tmp() {
  local candidate
  for candidate in "${DBV_OFFLOAD_TMP:-${TMPDIR:-/tmp}/dbv}"; do
    if mkdir -p "$candidate/clang-module-cache" "$candidate/dbv-swift-build" 2>/dev/null; then
      print -r -- "$candidate"
      return 0
    fi
  done
  return 1
}

DBV_TMP="$(dbv_pick_offload_tmp)" || {
  echo "error: no writable temp folder; set DBV_OFFLOAD_TMP" >&2
  return 1 2>/dev/null || exit 1
}

export TMPDIR="$DBV_TMP"
export CLANG_MODULE_CACHE_PATH="$DBV_TMP/clang-module-cache"
export SWIFT_BUILD_DIR="$DBV_TMP/dbv-swift-build"
