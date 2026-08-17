#!/usr/bin/env sh
#
# preview.sh — build and serve a local, searchable HTTP preview of the site.
#
# DEFAULT (no args, or just a port): WORKING-DIRECTORY mode.
#   Previews your CURRENT working tree exactly as it sits on disk — including
#   uncommitted, unstaged edits — WITHOUT committing, branching, or creating a
#   worktree. It builds the repo's current state via bin/build.sh into a
#   port-keyed scratch dir OUTSIDE the repo
#   (${TMPDIR:-/tmp}/accessible-tips-preview-<port>) and serves it over HTTP.
#   It never writes to public/ and never creates untracked files inside the
#   repo, so `git status` stays clean. The port keying + per-instance Hugo
#   cache dir make concurrent preview.sh runs on different ports fully
#   independent — they no longer clobber a shared scratch dir or race on a
#   shared cache at the repo root.
#
#   This is the everyday mode: edit files, run it, see your changes rendered
#   (with working Pagefind search) — no git dance required.
#
# OPTIONAL (a branch name as the first arg): isolated WORKTREE/BRANCH mode.
#   Previews ANY branch's COMMITTED state without disturbing your checked-out
#   branch or any other worktree. It creates a *detached* linked worktree at
#   <repo-root>/_preview-<port> (detached so it works even when the target
#   branch is already checked out elsewhere), builds there, and serves that.
#   The worktree path is port-keyed for the same concurrency reason as the
#   scratch dir: two concurrent branch previews on different ports each get
#   their own worktree instead of fighting over one _preview.
#
# Both modes serve over real HTTP: Pagefind search needs it — opening files as
# file:// renders pages but returns NO search results.
#
# Usage:
#   bin/preview.sh                 # working-dir mode, port 1313 (default)
#   bin/preview.sh <port>          # working-dir mode on <port>  (all-numeric arg)
#   bin/preview.sh <branch> [port] # worktree/branch mode (non-numeric first arg)
#     e.g.  bin/preview.sh
#           bin/preview.sh 9000
#           bin/preview.sh overhaul-work
#           bin/preview.sh overhaul-work 9000
#
# Default port is 1313 (matching Hugo). Stop the server with Ctrl-C.
# In worktree/branch mode the _preview-<port> worktree is left in place; clean
# up with:
#   bin/end-preview.sh [port]      (or: git worktree remove _preview-<port> --force)
#
set -eu
if (set -o pipefail) 2>/dev/null; then set -o pipefail; fi

# ---------------------------------------------------------------------------
# Argument dispatch: no first arg OR an all-numeric first arg => working-dir
# mode; a non-numeric first arg => branch name for worktree mode.
# ---------------------------------------------------------------------------
if [ "$#" -eq 0 ]; then
  MODE="workdir"
  PORT="${1:-1313}"
else
  case "$1" in
    ''|*[!0-9]*)
      MODE="branch"
      BRANCH="$1"
      PORT="${2:-1313}"
      ;;
    *)
      MODE="workdir"
      PORT="$1"
      ;;
  esac
fi

if [ "$MODE" = "workdir" ]; then
  # -------------------------------------------------------------------------
  # WORKING-DIRECTORY mode (default): build the current on-disk working tree,
  # uncommitted changes and all, into a scratch dir OUTSIDE the repo. No git
  # writes, no worktree, no touching public/, no untracked files in the repo.
  # -------------------------------------------------------------------------
  # Resolve the repo root from this script's own location (like bin/build.sh),
  # so it works when invoked by absolute path from any cwd.
  SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
  ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
  SCRATCH="${TMPDIR:-/tmp}/accessible-tips-preview-$PORT"

  # Build from the current working tree into the out-of-repo scratch dir.
  # build.sh resolves ITS OWN root from its location, so it always builds this
  # repo's current on-disk state; the absolute $SCRATCH keeps output out of the
  # repo (public/ is never touched). The second arg gives this instance its
  # own Hugo file cache so concurrent previews don't race on a shared one. The
  # third arg overrides baseURL to the preview origin so feeds, robots.txt and
  # alias redirects resolve against THIS server, not production.
  echo "Removing previous scratch build at $SCRATCH…"
  rm -rf "$SCRATCH"
  echo "Building current working tree (uncommitted changes included) into $SCRATCH…"
  "$ROOT/bin/build.sh" "$SCRATCH" "$SCRATCH/hugo-cache" "http://localhost:$PORT/"

  # Serve over HTTP (required for Pagefind search to work).
  echo
  echo "Serving current working tree at http://localhost:$PORT  (Ctrl-C to stop)"
  echo "NOTE: search only works over this HTTP server — file:// will not."
  exec python3 -m http.server "$PORT" --directory "$SCRATCH"
fi

# ---------------------------------------------------------------------------
# WORKTREE/BRANCH mode: preview a branch's COMMITTED state in isolation.
# ---------------------------------------------------------------------------
# Resolve the MAIN working tree (repo root), regardless of where this runs
# from — including from inside a linked worktree. --git-common-dir points at
# the shared <main>/.git for every worktree of the repo.
COMMON_GIT_DIR="$(git rev-parse --git-common-dir)"
MAIN_ROOT="$(cd "$(dirname "$COMMON_GIT_DIR")" && pwd -P)"
PREVIEW_DIR="$MAIN_ROOT/_preview-$PORT"
SCRATCH="${TMPDIR:-/tmp}/accessible-tips-preview-$PORT"

cd "$MAIN_ROOT"   # ensure cwd is not inside _preview, so we can replace it

# Verify the requested branch exists.
if ! git rev-parse --verify --quiet "$BRANCH" >/dev/null; then
  echo "preview.sh: branch '$BRANCH' not found" >&2
  exit 1
fi

# Refresh: drop any previous _preview for THIS port, then recreate it detached
# at $BRANCH. NOTE: we deliberately do NOT run a blanket `git worktree prune` —
# prune removes EVERY worktree whose directory isn't visible in the current
# mount namespace, which can clobber unrelated worktrees (e.g. one living
# under a path this shell can't see). We only ever touch _preview-<port>, by
# exact path.
if [ -e "$PREVIEW_DIR" ]; then
  echo "Removing existing $PREVIEW_DIR…"
  git worktree remove --force "$PREVIEW_DIR" 2>/dev/null || rm -rf "$PREVIEW_DIR"
fi
echo "Creating detached worktree at '$BRANCH' in $PREVIEW_DIR…"
git worktree add --detach --force "$PREVIEW_DIR" "$BRANCH"

# Build with the vendored binaries (Hugo + Pagefind; zero Node), with this
# instance's own Hugo file cache (port-keyed scratch) so concurrent branch
# previews don't race on the shared default cache. baseURL is overridden to
# the preview origin for the same reasons as working-dir mode.
cd "$PREVIEW_DIR"
echo "Building '$BRANCH' into $PREVIEW_DIR/public…"
./bin/build.sh public "$SCRATCH/hugo-cache" "http://localhost:$PORT/"

# Serve over HTTP (required for Pagefind search to work).
echo
echo "Serving '$BRANCH' at http://localhost:$PORT  (Ctrl-C to stop)"
echo "NOTE: search only works over this HTTP server — file:// will not."
exec python3 -m http.server "$PORT" --directory public
