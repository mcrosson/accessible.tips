---
name: site-browser
description: The capability layer for testing accessible.tips — build and serve the local site over HTTP and drive the Playwright MCP browser against it. Use directly when asked to serve / drive / preview the local site; the smoke-test and a-b-compare skills build on this. Requires a vision-capable model.
---

# site-browser

## Requires a vision-capable model

This skill is for viewing and judging a rendered webpage. It must be run by a
vision-capable model. If a non-vision model invokes it, that is on the invoking
model to sort — this skill does not guard against it.

## What this skill does

Serves the local workspace site (built from this repo with the vendored
Hugo + Pagefind) over HTTP, drives the Playwright MCP browser against it,
captures review artifacts, and tears down. It is the FOUNDATION layer: it owns
mechanics, not judgments.

## Scope guard — hand off

- Correctness / breakage assertions (did anything break?) → **smoke-test**.
- Two-version comparison / A/B / before-after → **a-b-compare**.
- Content / frontmatter linting, alias-policy decisions, equiv.toml regeneration
  → not this skill's job. This skill only serves, drives, captures.
- It never edits content/templates/data, never fixes anything, never tests the
  production site.

## Preconditions — check before starting; stop if one fails

1. `bin/hugo-0.155.3` and `bin/pagefind` exist and are executable.
2. The Playwright MCP tools (`playwright_browser_navigate`,
   `playwright_browser_evaluate`, etc.) are callable.
3. The chosen port is free (a probe like `curl -s -o /dev/null
   http://localhost:<port>/` fails).
4. Hugo builds exit 0. A build-halting `errorf` is a source bug, not a testing
   finding — report it verbatim and stop.

## Choosing the server

Two local servers, picked by what is under test. Both default to port 1313.

- `bin/dev.sh [port]` — Hugo live-reload dev server
  (`--renderToMemory --disableFastRender -D`). REQUIRED to see draft content
  (`-D` includes drafts; new pages start `draft = true`). Search is inert here —
  Pagefind never runs, `/search/` returns nothing. Use for layout, content,
  navigation, the theme toggle, accessibility structure, and any draft page —
  anything except search/facets/equivalence.
- `bin/preview.sh [port|branch]` — production-like build
  (`hugo --gc --minify` + Pagefind) over HTTP. Drafts EXCLUDED (no `-D`), so
  draft pages will not appear. Search, facets, and equivalence WORK here. A
  non-numeric first arg is a branch name: builds that branch's committed state in
  a detached `_preview` worktree. NOTE: it builds with `config.toml`'s production
  baseURL — see the trap below.
- **Manual local-baseURL build** — only for aliases, canonical/`og:url`, or RSS
  absolute-link tests (see trap). Neither `dev.sh` nor `preview.sh` suffices.

Rule of thumb: testing search → `preview.sh`. Testing drafts → `dev.sh`. Testing
alias/absolute-URL resolution → manual build. Anything else → either (`dev.sh`
is faster).

## Aliases and absolute URLs — the baseURL trap

Hugo alias stubs are `http-equiv=refresh` redirects to **absolute** URLs at the
built baseURL. `config.toml`'s baseURL is the production host, and
`preview.sh`/`build.sh` pass no override — so following any alias in a local
`preview.sh` run navigates to the live production site and the test passes
vacuously. The site has aliases (several `content/anecdotes/*.md` and two tips),
so this is real.

To test alias/absolute-URL resolution locally, build with an explicit local
baseURL into a scratch dir and serve the matching port:

```
./bin/hugo-0.155.3 --gc --minify --baseURL http://localhost:<port>/ -d /tmp/at-smoke
./bin/pagefind --site /tmp/at-smoke
python3 -m http.server <port> --directory /tmp/at-smoke   # background it
```

**Hard guard: after following any alias, assert
`new URL(location.href).host === 'localhost:<port>'`.** Landing on the production
host invalidates the run. The same override is what makes canonical/`og:url`/RSS
item links resolve locally.

## Artifacts

Operator-reviewable output goes under
`.scratch/test-artifacts/<timestamp>-<purpose>/` (e.g. `2026-08-13T14-22-smoke/`,
`…-ab/`). Create the directory if absent (`.scratch/` is gitignored). Each run
dir holds: screenshots, snapshot text dumps, an `evaluate`-results log, and a
short run summary the operator can open to review. Keep-or-delete is the
operator's call — never auto-delete review material. Never write artifacts into
the repo proper or into `public/`.

## Drive Playwright (MCP primitives)

1. `playwright_browser_navigate` → `http://localhost:<port>/`
2. `playwright_browser_wait_for` — a few seconds, first paint / dynamic bits.
3. `playwright_browser_snapshot` — accessibility tree (structure, text, roles,
   labels).
4. `playwright_browser_take_screenshot` (png, css) — the rendered page (the
   vision-capable model reads this).
5. Interact: `click`, `type`, `select_option`, etc.
6. `playwright_browser_evaluate` — counts, computed styles, DOM facts the
   snapshot can't express.
7. `playwright_browser_network_requests` — request / asset / SRI checks.

## Driving principles (apply to every purpose skill)

- **Snapshot + screenshot together.** Snapshot gives structure; screenshot gives
  the rendered truth. The vision-capable model judges the screenshot.
- **Assert on the DOM, never raw-HTML regex.** `--minify` strips attribute
  quotes in the raw HTML; `view-source` lies, `document.querySelector` doesn't.
- **No frozen counts.** Anchor on shape/existence/uniqueness, never a magic
  number (hit count, page total) that rots when content is published.
- **Report every failure as:** page URL, selector/expression, expected vs actual.
- **AA is the floor.** WCAG AA is a site-wide hard requirement (see `AGENTS.md`);
  treat any AA regression as a finding no matter which check ran. Take AAA when
  free. The vision-capable model judges contrast/reflow/zoom from the screenshot;
  pair it with `evaluate` for computed-color contrast ratios.
- **Page weight is a budget.** Maximal usability on slow/intermittent connections
  is a hard requirement; treat transfer size as a first-class signal — heavy
  assets, web fonts, or new client bundles are findings, not trivia.

## Teardown

- `bin/end-preview.sh [port]` — stops the preview HTTP server, removes the
  scratch build and the `_preview` worktree. Idempotent. Default port 1313. Does
  NOT run a blanket `git worktree prune` — only `_preview` by exact path, so
  unrelated worktrees are safe.
- `dev.sh` has no dedicated teardown; Ctrl-C or kill by port.
- Manual-build scratch (`/tmp/at-smoke`, etc.): `rm -rf`; never into the repo.

## Constraints

- Never target the production URL for verification.
- Match the server to the work (`dev.sh` / `preview.sh` / manual baseURL).
- All servers default to 1313 — pick a numeric port per concurrent instance.
- `bin/build.sh` only emits static files; use `dev.sh`, `preview.sh`, or the
  manual recipe to serve.
- No Node in the site build or the browser toolchain — Playwright via MCP only;
  never add `package.json`, `node_modules/`, or `@playwright/test` to the site or
  this skill. Sole sanctioned exception: the gitignored `vsr/` test harness under
  `a11y-audit` (test-time Node only; never in the build, never shipped, never
  committed).
