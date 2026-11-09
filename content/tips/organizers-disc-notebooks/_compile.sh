#!/usr/bin/env bash
# Generic compile script for the discbound planner printables.

set -euo pipefail

# Resolve to this script's own directory so it can be run from anywhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# --- Tooling check: fail fast with the full list before compiling anything. ---
missing=()
for cmd in typst date; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    missing+=("$cmd")
  fi
done

if (( ${#missing[@]} > 0 )); then
  echo "Compile aborted: missing required tool(s)/command(s):" >&2
  for cmd in "${missing[@]}"; do
    echo "  - $cmd" >&2
  done
  exit 1
fi

# --- Build everything, stamping the current HHMM as the version. ---
HHMM="$(date +%H%M)"

echo "Compiling monthly deck (version stamp: $HHMM)…"
typst compile --input version="$HHMM" monthly-grid.typ monthly-grid.pdf
typst compile --input daylabel-over-space=true --input version="$HHMM" monthly-grid.typ monthly-grid-daylabel-over-space.pdf

echo "Compiling weekly spread (version stamp: $HHMM)…"
typst compile --input version="$HHMM" weekly-spread.typ weekly-spread.pdf

echo "Compiling lined pages (version stamp: $HHMM)…"
typst compile --input version="$HHMM" lined-page.typ lined-page.pdf

echo "Done: monthly-grid.pdf, monthly-grid-daylabel-over-space.pdf, weekly-spread.pdf, lined-page.pdf"