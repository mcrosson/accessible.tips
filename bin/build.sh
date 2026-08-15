#!/usr/bin/env sh
#
# build.sh — production build for the Hugo + Pagefind static site.
#
# What it does:
#   1. Builds the site with the vendored Hugo binary (--gc --minify).
#   2. Runs the vendored Pagefind binary over the rendered HTML output to
#      generate the /pagefind/ search index/bundle in place.
#   Both steps use vendored binaries only — zero Node involved anywhere.
#
# Usage:
#   bin/build.sh [output-dir] [cache-dir]
#   Default output-dir is "public" (the operator's production deploy
#   target). Pass a different path (e.g. a scratch/temp dir) to build
#   without touching public/.
#   NOTE: a RELATIVE output-dir is resolved against the REPO ROOT, not your
#   current directory — the script cd's to the repo root (below) before using
#   it. Pass an absolute path (e.g. /tmp/site-build) to get output where you
#   stand.
#   An optional second argument routes Hugo's file cache (--cacheDir) to a
#   per-instance directory. Concurrent builds of the same tree (e.g. two
#   preview.sh runs on different ports) MUST each pass their own cache dir,
#   or they race on the shared cache at the repo root. Omitted = Hugo's
#   default (unchanged behavior for single/production builds).
#
# Notes:
#   - "--minify" is a low-bandwidth production default; the operator can
#     drop it for local/debug builds if desired.
#   - Pagefind MUST run AFTER Hugo, because Pagefind indexes the rendered
#     HTML files as they sit on disk in the output dir. This means Hugo's
#     "--renderToMemory" option is NOT compatible with this pipeline —
#     Pagefind needs real files to scan.
#
set -eu
if (set -o pipefail) 2>/dev/null; then set -o pipefail; fi

# Resolve repo root from this script's own location: script lives in
# "<root>/bin/", so root is one directory up, regardless of caller cwd.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

OUT="${1:-public}"
CACHE_DIR="${2:-}"

echo "Building site..."
if [ -n "$CACHE_DIR" ]; then
  "$ROOT/bin/hugo-0.155.3" --gc --minify --cacheDir "$CACHE_DIR" -d "$OUT"
else
  "$ROOT/bin/hugo-0.155.3" --gc --minify -d "$OUT"
fi

echo "Indexing with Pagefind..."
"$ROOT/bin/pagefind" --site "$OUT"

echo "Build complete: $OUT"
