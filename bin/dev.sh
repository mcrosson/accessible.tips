#!/usr/bin/env sh
#
# dev.sh — fast live-reload dev server for the CURRENT working tree.
#
# Runs Hugo's dev server against your working directory exactly as it sits on
# disk (uncommitted edits included). It watches content, layouts, SCSS and JS,
# rebuilds on save, and live-reloads the browser — no worktree, no commit, no
# fuss. This is the "get it right in text" loop.
#
#   !!  SEARCH DOES NOT WORK HERE.  Pagefind is a separate post-build step that
#   indexes built files on disk; `hugo server` never runs it, so the /search/
#   page returns nothing and the header search box goes nowhere. Everything else
#   live-reloads normally. When you need to test search, run the full build:
#       bin/preview.sh          # Hugo + Pagefind, serves the working tree
#
# Usage:
#   bin/dev.sh              # live server at http://localhost:1313
#   bin/dev.sh 9000         # on a custom port
#   bin/dev.sh 9000 -F      # any extra args pass straight through to hugo server
#
# Flags baked in:
#   --renderToMemory   don't serve the stale on-disk public/; render fresh
#   --disableFastRender  full re-render each save, so your change ALWAYS shows
#   -D                 include draft content (new pages start draft = true)
#   --cacheDir         per-PORT Hugo file cache, so concurrent dev.sh runs on
#                      different ports don't race on a shared cache at the
#                      repo root (renders are already per-process in memory)
#
# Stop with Ctrl-C.
#
set -eu
if (set -o pipefail) 2>/dev/null; then set -o pipefail; fi

# Resolve repo root from this script's own location (like bin/build.sh), so it
# works when invoked by absolute path from any cwd, not only from inside the repo.
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Optional numeric first arg = port; anything else passes through to hugo.
PORT=1313
case "${1:-}" in
  ''|*[!0-9]*) ;;
  *) PORT="$1"; shift ;;
esac

cd "$ROOT"
CACHE_DIR="${TMPDIR:-/tmp}/accessible-tips-dev-$PORT/hugo-cache"
echo "Live dev server (working tree) at http://localhost:$PORT  —  Ctrl-C to stop"
echo "NOTE: /search/ is inert here (no Pagefind index); use bin/preview.sh for search."
exec "$ROOT/bin/hugo-0.155.3" server \
  --renderToMemory \
  --disableFastRender \
  -D \
  --port "$PORT" \
  --cacheDir "$CACHE_DIR" \
  "$@"
