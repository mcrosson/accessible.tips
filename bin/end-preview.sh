#!/usr/bin/env sh
#
# end-preview.sh — tear down what preview.sh created: stop the local preview
# server, remove the out-of-repo working-dir scratch build, and remove the
# detached _preview worktree. Safe to run any time (idempotent — does nothing
# if there's nothing to clean).
#
# Does NOT touch your checked-out branch, its uncommitted changes, or any
# other worktree — only the preview scratch dir and the _preview worktree.
#
# Usage:
#   bin/end-preview.sh [port]     (port defaults to 1313; only used to stop
#                                  a still-running preview server)
#
set -eu
if (set -o pipefail) 2>/dev/null; then set -o pipefail; fi

PORT="${1:-1313}"

# Resolve the MAIN working tree (repo root) from anywhere, incl. inside a
# linked worktree.
COMMON_GIT_DIR="$(git rev-parse --git-common-dir)"
MAIN_ROOT="$(cd "$(dirname "$COMMON_GIT_DIR")" && pwd -P)"
PREVIEW_DIR="$MAIN_ROOT/_preview"
SCRATCH="${TMPDIR:-/tmp}/accessible-tips-preview"

cd "$MAIN_ROOT"   # ensure cwd is not inside _preview so it can be removed

# 1. Best-effort: stop a preview HTTP server still listening on $PORT.
#    (If you started it in the foreground, Ctrl-C already handled this.)
if command -v fuser >/dev/null 2>&1; then
  fuser -k "${PORT}/tcp" >/dev/null 2>&1 && echo "Stopped server on port $PORT." || true
elif command -v lsof >/dev/null 2>&1; then
  pids="$(lsof -ti "tcp:${PORT}" 2>/dev/null || true)"
  if [ -n "$pids" ]; then kill $pids 2>/dev/null && echo "Stopped server on port $PORT." || true; fi
else
  pkill -f "http.server ${PORT}" >/dev/null 2>&1 && echo "Stopped server on port $PORT." || true
fi

# 2. Remove the _preview worktree (and any stray dir), by exact path only.
#    NOTE: no blanket `git worktree prune` here — prune removes every worktree
#    whose directory isn't visible in the current mount namespace, which can
#    clobber unrelated worktrees. We only ever touch _preview.
if [ -e "$PREVIEW_DIR" ]; then
  echo "Removing _preview worktree…"
  git worktree remove --force "$PREVIEW_DIR" 2>/dev/null || rm -rf "$PREVIEW_DIR"
else
  echo "No _preview directory to remove."
fi

# 3. Remove the out-of-repo working-dir scratch build, if present.
if [ -e "$SCRATCH" ]; then
  echo "Removing working-dir scratch build at $SCRATCH…"
  rm -rf "$SCRATCH"
fi

echo "Cleanup complete."
