validated-at: ffc07798412e3079ab9da3529dc99b40456d1013
authored-by: minimax/MiniMax-M3

# accessible.tips — orientation

## Purpose and shape

Hugo static site: zettelkasten-style accessibility knowledge base — short, cross-referenced tips with separate anecdotes, FAQ, and dated news. Heavily customized `themes/hugo-xmin/` plus a vendored `themes/hugo-admonitions/`. Deployed via Netlify. CC BY-SA 4.0. **Accessibility IS the product** — WCAG AA floor, AAA free/cheap; low-bandwidth is a hard requirement (Hugo `--minify`, responsive WebP via `figure` shortcode, lazy lightbox). [anchor: README.md, LICENSE, config.toml, netlify.toml]

Content roots: `content/tips/`, `content/anecdotes/`, `content/faq/`, `content/news/`. The contributing FAQ still references a non-existent `posts/` — the real blog is `news/`. Each section has a `_test/index.md` (likely draft) exercising section-specific behavior. `content/test-form/` is a standing draft that renders ONLY on the `forms-test` Netlify branch deploy context (see *Build and deployment*). [anchor: content/faq/contributing/, content/_index.md, content/test-form/]

Treat `themes/hugo-xmin/` as application code (the in-theme README is stale). `themes/hugo-admonitions/VENDOR.md` is the source of truth for that component's pin and the one sanctioned direct edit (`aria-hidden="true" focusable="false"` on icon `<svg>`s). The empty `Staticfile` is legacy, not the active deploy target. [anchor: themes/hugo-xmin/, themes/hugo-admonitions/VENDOR.md, Staticfile]

## Front matter and content contracts

Archetypes in `archetypes/` are the scaffolding source of truth. Tips/FAQ/anecdotes carry a `changelog` list of `{date, text}`; `single.html` auto-renders it as `<h2 id="changelog">` AFTER `.Content` — do NOT hand-write `## Changelog` in body. The "Updated" masthead date is the newest changelog entry (sorted desc), NOT `lastMod`/`GitInfo` — `enableGitInfo` is OFF, so "Updated" tracks the changelog only. `partials/util/changelog-latest.html` returns the raw date; each caller applies its own `dateFormat`. [anchor: archetypes/, themes/hugo-xmin/layouts/single.html, themes/hugo-xmin/layouts/_partials/page_meta.html, themes/hugo-xmin/layouts/_partials/util/changelog-latest.html]

The anecdotes WARNING banner is gated by `eq .Section "anecdotes"` in `page_meta.html` (section membership, NOT a front-matter category check). FAQ is tagged `faq` only; news is intentionally untagged. Tips carry a single primary category; filenames conventionally begin with that category. Use page bundles (`directory/index.md`). One optional search-only front-matter: `search_terms` — terms the page should be findable by that the body never names. Emitted as a Pagefind `data-pagefind-meta` span AND folded into the corrector vocabulary. NOT a tag; does NOT feed related. Synonym clusters belong in `data/equiv.toml`. [anchor: themes/hugo-xmin/layouts/_partials/page_meta.html, themes/hugo-xmin/layouts/index.searchvocab.json, data/equiv.toml, content/anecdotes/]

Content conventions (see `content/faq/contributing/` for the full list): `{{< back_to_top >}}` after every H2, `{{< end_section >}}` at deeper-section ends, cross-references as Hugo `ref` shortcodes (`[category]-[file]` for tips, `section/file` for faq/anecdotes). The `figure` shortcode is required for images — 400w/800w/1200w responsive WebP, the 1200w wrapped in a Tobii lightbox trigger. The Tobii runtime loads only when a page has a `<figure>`; image-less pages pay zero JS cost. [anchor: content/faq/contributing/, themes/hugo-xmin/layouts/shortcodes/figure.html, themes/hugo-xmin/layouts/_partials/footer.html]

## Rendering pipeline

`single.html` composes header, metadata, then a searchable `<main data-pagefind-body>` that holds: `[equiv-inject.html, search-filters.html, .Content, auto-changelog]`. Related pages use Hugo's built-in `.CurrentSection.RegularPages.Related .`; `page_meta.html` computes `$related` once and passes it as a dict to `related.html`. `hugo-admonitions` is registered left-most in `config.toml` (higher precedence per upstream README); `hugo-xmin` has no blockquote render hook. Goldmark `unsafe = true` — raw HTML in pages renders AND is indexed by Pagefind. [anchor: themes/hugo-xmin/layouts/single.html, themes/hugo-xmin/layouts/_partials/page_meta.html, themes/hugo-xmin/layouts/_partials/related.html, themes/hugo-admonitions/VENDOR.md, config.toml]

Project-level SCSS override at `assets/sass/vendors/_admonitions-user-settings.scss` (Hugo asset union filesystem beats vendored stub) remaps all 21 admonition types to six semantic buckets and fixes the auto-dark default-dark contrast condition (specificity `:root:not([data-theme="light"])` beats vendored attribute selectors). Header text is pinned to high-contrast ink — never rely on colour alone for contrast. [anchor: assets/sass/vendors/_admonitions-user-settings.scss, themes/hugo-admonitions/VENDOR.md]

## Search — build + runtime

Search is a post-build concern. Pagefind writes its bundle to `/pagefind/` in the output dir — every query must be served over HTTP (`file://` returns nothing) and `bin/dev.sh` is search-inert. `/search-vocab.json` is a build-time corrector vocabulary, generated by the custom output format `index.searchvocab.json`. [anchor: themes/hugo-xmin/layouts/index.searchvocab.json, config.toml]

The SAME per-page equivalence computation lives in `equiv-page-inject.html` (haystack = title + body + tags + search_terms; class match by `\b` word boundaries on a normalized lowercase form; no singularizer — add `s`/`es` variants as explicit members). It returns a slice; `equiv-inject.html` renders it as hidden in-body text inside `data-pagefind-body` (Pagefind 1.5.2's static parser does NOT skip CSS-hidden in-body text), and `index.searchvocab.json` folds the same slice into the corrector vocabulary. ONE computation, two consumers — they cannot drift. [anchor: themes/hugo-xmin/layouts/_partials/equiv-page-inject.html, themes/hugo-xmin/layouts/_partials/equiv-inject.html, themes/hugo-xmin/layouts/index.searchvocab.json, data/equiv.toml, data/search/stopwords.yaml]

The `/search/` page is submit-only; the first `/pagefind/` request fires on Enter or the Search button. The corrector (`corrector.js`) is SUGGEST-ONLY — never alters the query Pagefind receives; per-token Damerau–Levenshtein (`MAX_DISTANCE=2`, `MIN_TOKEN_LEN=4`), deburr-fold + lowercase, deterministic tiebreak (smaller distance → higher df → shorter term → lexicographic). The Pagefind runtime is loaded via `new Function("src", "return import(src)")` so esbuild does not try to bundle a file absent at build time. Facets are `section` and `tag` (OR within a facet, AND across). [anchor: themes/hugo-xmin/assets/js/search-page.js, themes/hugo-xmin/assets/js/corrector.js, themes/hugo-xmin/layouts/_default/search.html, themes/hugo-xmin/layouts/robots.txt, themes/hugo-xmin/layouts/_partials/header.html]

## Theme toggle and accessibility primitives

The theme toggle is a single cycling `<button>` (auto→light→dark→auto) persisting only `light`/`dark` to `localStorage["theme"]`; auto = key absent. The header's anti-FOUC inline snippet applies any override before first paint. The button ships with `hidden` (no dead control without JS); icons carry a shape difference (split disc / sun / moon), not colour alone. A visually hidden `aria-live="polite"` region announces the new mode. Keep the localStorage key, the inline snippet, and the SCSS in lock-step. [anchor: themes/hugo-xmin/layouts/_partials/theme-toggle.html, themes/hugo-xmin/layouts/_partials/header.html, themes/hugo-xmin/assets/js/theme-toggle.js]

Tobii lightbox sets `inert` on `<main>`/`<article>` while open — preserve that on template refactors. [anchor: themes/hugo-xmin/assets/js/tobii-a11y-overrides.js]

## Build and deployment

Self-contained — vendored binaries, zero Node. `bin/build.sh [output-dir [cache-dir [baseurl]]]` runs Hugo 0.155.3 with `--gc --minify` then Pagefind. A *relative* `output-dir` is resolved against the repo root; pass an absolute path (e.g. `/tmp/site-build`) to output where you stand. `cache-dir` routes Hugo's `--cacheDir` per-instance — concurrent builds MUST each pass their own, or they race on the shared cache at the repo root. Pagefind indexes files on disk AFTER Hugo (`--renderToMemory` is NOT compatible). Netlify publishes `public/` via `bin/build.sh`. [anchor: bin/build.sh, netlify.toml]

`bin/dev.sh [port]` runs Hugo's dev server with `--renderToMemory --disableFastRender -D` and a per-port Hugo cache dir. An optional first arg is parsed as a port (all-numeric → port, anything else passes through to `hugo server`). Live-reload works; `/search/` is INERT — use `bin/preview.sh` for real HTTP, searchable builds. [anchor: bin/dev.sh]

`bin/preview.sh [port|branch [port]]` dispatches by whether the first arg is numeric. WORKING-DIR (default, or all-numeric port) builds the on-disk tree (uncommitted changes included) into `${TMPDIR:-/tmp}/accessible-tips-preview-$PORT` and serves with `python3 -m http.server`. `git status` stays clean, `public/` is never touched; each port gets its own out-of-repo scratch dir + per-instance Hugo cache. WORKTREE/BRANCH (non-numeric first arg) creates a *detached* port-keyed linked worktree at `<repo>/_preview-$PORT`. Both modes serve over real HTTP (Pagefind needs it). `bin/end-preview.sh [port]` removes the `_preview-$PORT` worktree + scratch dir and is idempotent. It deliberately does NOT run a blanket `git worktree prune` (can clobber unrelated worktrees invisible in the current mount namespace). [anchor: bin/preview.sh, bin/end-preview.sh]

Two Netlify deploy contexts: production `[build]` runs `bin/build.sh` (drafts excluded); the `forms-test` branch context builds with `--buildDrafts` so the `content/test-form/` draft renders for the live-form experiment. The test page itself documents the one-time UI setup (form detection, branch registration, optional notifications). [anchor: netlify.toml, content/test-form/]

`public/` is gitignored stale output — never hand-edit, never regenerate as a deliverable. [anchor: .gitignore]

## High-risk maintenance points

Site-wide behavior lives in `config.toml` and the customized `hugo-xmin` — particularly `layouts/_partials/header.html`, `layouts/_partials/page_meta.html`, `layouts/single.html`, `layouts/_default/search.html`, `assets/js/search-page.js`, `assets/js/corrector.js`, `layouts/_partials/theme-toggle.html`, `assets/css/style.css`. The vendored `hugo-admonitions` blockquote render hook is the only place admonition markup is generated — don't fork it. A typo in `data-pagefind-filter` or a moved `data/equiv.toml` member is silent without HTTP preview — always verify search changes via `bin/preview.sh` over HTTP (don't use `bin/dev.sh` or `file://`). [anchor: config.toml, themes/hugo-xmin/, themes/hugo-admonitions/]

The repo-local testing skills (`.agents/skills/`: `site-browser`, `smoke-test`, `a-b-compare`, `a11y-audit`, `orientation`) — except `orientation` — are all Playwright-driven and all REQUIRE a vision-capable model. Test artifacts go under `.scratch/test-artifacts/` (gitignored). Git is the operator's — never run git write operations; never prompt about commits. [anchor: .agents/skills/, .scratch/, .gitignore]
