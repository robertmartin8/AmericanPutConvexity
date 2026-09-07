#!/usr/bin/env bash
# Run the real Comparator and NanoDa; the caller supplies pinned tool binaries.
set -euo pipefail
cd "$(dirname "$0")"

: "${COMPARATOR_BIN:?Set COMPARATOR_BIN to the pinned Comparator executable}"
: "${COMPARATOR_LANDRUN:?Set COMPARATOR_LANDRUN to Landrun (or the explicitly disclosed development shim)}"
: "${COMPARATOR_LEAN4EXPORT:?Set COMPARATOR_LEAN4EXPORT to the Lean 4.32.0 exporter}"
: "${COMPARATOR_NANODA:?Set COMPARATOR_NANODA to the pinned NanoDa executable}"

if [[ "${1:-}" == "--native-development" ]]; then
  echo "DEVELOPMENT REHEARSAL: this does not establish Linux sandbox confinement."
elif [[ $# -ne 0 ]]; then
  echo "usage: bash check.sh [--native-development]" >&2
  exit 2
elif [[ "$(uname -s)" != "Linux" ]]; then
  echo "Non-Linux runs must explicitly use --native-development." >&2
  exit 2
fi

mkdir -p build
export COMPARATOR_LANDRUN COMPARATOR_LEAN4EXPORT COMPARATOR_NANODA
export LEAN_NUM_THREADS=1
lake env "$COMPARATOR_BIN" comparator.json 2>&1 | tee build/comparator.log
lake env lean Audit.lean 2>&1 | tee build/axioms.log
