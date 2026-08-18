---
name: smoke-test
description: Verify nothing broke on the accessible.tips built site — drive Playwright over the local build and assert search, equivalence injection, assets/SRI, Plausible, RSS, console cleanliness, internal links, and alias resolution still work. Use when a change touches templates/SCSS/JS/config.toml/search/taxonomy, or when asked to smoke-test / verify the built site / check nothing broke before shipping. Requires a vision-capable model. Builds on site-browser.
---

# smoke-test

## Requires a vision-capable model

Run by a vision-capable model only. If a non-vision model invokes it, that is on
the invoker.

## Scope

Owns the BREAKAGE ASSERTIONS. For serving, driving, artifacts, teardown, and the
driving principles, use **site-browser** — this skill assumes those mechanics and
only adds what to check.

Hand off: two-version / A/B / before-after comparison → **a-b-compare**.
Content/frontmatter linting, alias-policy decisions, `equiv.toml` regeneration
→ not this skill.

## Preconditions

**site-browser** preconditions, plus: the build exits 0. Then serve with
`bin/preview.sh` (search needs it); for alias checks use **site-browser**'s
manual local-baseURL build.

Artifacts go under `.scratch/test-artifacts/<timestamp>-smoke/` (layout per
**site-browser**); **create the directory if absent**.

## Checks (pick by what changed)

Items marked *verify* need their selector/term confirmed against the theme
before first use.

- **Search end-to-end (best single canary).** `preview.sh` only. Navigate
  `/search/?q=<known-tip-term>`; assert the status element reads
  `N results for …` (shape, not count), no error class, results rendered. Fails
  if Pagefind didn't run, `--renderToMemory` leaked in, or it's served over
  `file://`. *Verify:* status-element selector in
  `themes/hugo-xmin/layouts/_default/search.html`.
- **`/search-vocab.json` + corrector.** `GET /search-vocab.json` → 200, parses,
  key count above a floor; navigate a deliberate misspelling and assert the
  "Did you mean" suggestion renders.
- **Equivalence-class annotation (highest-value invisible check).** Confirmed
  markup: `_partials/equiv-inject.html` emits
  `<ul style="display:none" aria-hidden="true">…<li>…</li></ul>` inside the
  `data-pagefind-body` region (called from `single.html:6`). Assert
  `[data-pagefind-body] ul[aria-hidden="true"] > li` count > 0;
  `el.closest('[data-pagefind-body]')` non-null and
  `el.closest('[data-pagefind-ignore]')` null;
  `getComputedStyle(ul).display === 'none'`; end-to-end a synonym search returns
  a page whose `document.body.innerText` does not contain the term. (Related:
  `search-filters.html:13` emits `data-pagefind-filter` spans the same way.)
- **Aliases + host guard.** Manual local-baseURL build only. `GET /<alias-path>/`
  → 200; parse the `http-equiv=refresh` target and assert it starts with
  `http://localhost:<port>/`; follow it and assert the host guard plus a real
  landing page (`article`/`main` present).
- **Assets load.** CSS (`style.css`/`chroma.css`/`fonts.css`) is plain `<link>`
  with no integrity; JS (`theme-toggle.js`, `search-page.js`, two footer
  scripts) IS `fingerprint`+`integrity`. Assert JS requests `< 400`; assert
  `document.styleSheets[0].cssRules.length > 0` (an integrity mismatch or missing
  sheet still 200s but yields zero rules — this is the real "CSS applied" check).
- **Post-JS behaviour.** Assert the element's post-script state, not the
  script's 200. The `theme-toggle` button is revealed by its deferred script;
  `/search/` is submit-only (no keystroke handler).
- **Plausible.** Assert the embed in `<head>`: the loader
  `script[src^="https://plausible.accessible.tips/js/"]` (async, no
  `data-domain` attribute — switched 2026-08-17 from the legacy
  `plausible.kemonine.info` + `data-domain` script to the new-script embed
  with the `window.plausible` queue/init inline snippet). Element, not the
  network request — the request may fail offline.
- **RSS.** `GET /index.xml` → 200, parses as XML, items > 0. *Verify:* whether a
  section-exclusion invariant is worth asserting.
- **Console errors + internal-link sweep.** Zero console **errors** on sampled
  pages (allowlist the Plausible fetch failure and its
  `Ignoring Event: localhost` **warning** — emitted by the current
  `pa-*.js` embed too, observed 2026-08-17). Sample `a[href^="/"]` across
  home, a tip, an anecdote, a FAQ, and a term page; each returns 200 — catches
  broken `ref` shortcodes.
- **Network-host allowlist.** Every request host is `localhost:<port>` or the
  expected external (`plausible.accessible.tips`). Any other host fails; a
  *blocked* Plausible request is acceptable. *Verify:* the site's actual
  external hosts.
- **Duplicate-id sweep.** `[...document.querySelectorAll('[id]')].map(e => e.id)`
  has no repeats. Cheap; run on every page visited.
- **Pagefind sanity floor.** Indexed-page count in the same neighbourhood as the
  content corpus; a large drop is itself a finding (no frozen number).

### Accessibility — AA floor (run on template/SCSS/content-structure changes)

- **Contrast (1.4.3).** Via `evaluate`, compute fg/bg contrast for text nodes;
  flag < 4.5:1 (normal text) / < 3:1 (large). The vision model also eyeballs the
  screenshot for low contrast the calc misses.
- **Reflow/zoom (1.4.10).** Resize the viewport to 320 CSS px and apply 200%/400%
  page zoom; assert no horizontal scrollbar and no content loss/overlap (snapshot
  + screenshot).
- **Focus visible (2.4.7).** Tab through; `:focus-visible` yields a visible
  outline (getComputedStyle on the focused element).
- **Text alternatives & structure (1.1.1, 1.3.1, 2.4.1, 2.4.2, 3.1.1, 3.3.2).**
  Every `img` has `alt` (empty ok for decorative); every input has an associated
  label; skip-link, `<title>`, `<html lang>` present; heading order intact (from
  the snapshot).
- **AAA when free.** Note zero-cost AAA wins (target size ≥ 24px, contrast ≥ 7:1
  where the palette already allows) — report, don't fail.

### Axe gate (automated AA-regression tripwire; additive to the manual AA-floor checks)

**Coexistence rule:** axe is AUTHORITATIVE for its rules on gate pages; the
manual AA-floor checks above are RETAINED wherever axe is silent (reflow,
focus-visible, target size, zoom, judgment calls). Nothing above is cut by
this gate. Mechanics (inject recipe, pin, caveats) come from **site-browser**'s
"Inject-and-run axe" section; the exception baseline lives in **a11y-audit**
(`exceptions.toml`, consumed by path).

**Preconditions — any failure stops the gate with the stated status, never a
silently green run:**

1. Vendored asset: `.agents/skills/site-browser/vendor/axe-core-<ver>.min.js`
   exists AND its sha256 equals `vendor/.MANIFEST`'s (checked ONCE per gate
   run, before the first inject). Absent/mismatch → gate reports
   **`SKIPPED: asset absent/pin mismatch`** (loud skip; the rest of the smoke
   run is unaffected).
2. Exception list: `.agents/skills/a11y-audit/exceptions.toml` exists.
   Absent → **FAIL — fail-closed** (no list = zero exceptions).
3. Version pair: the list's header `axe_version` == the `.MANIFEST` version.
   Mismatch → **FAIL "re-triage pending"** — never a vacuous pass.

**Page picks — computed AT RUN TIME, never a locked list** (the corpus grows;
s/m/l shift; #10/#11):

1. Serve via `bin/preview.sh <port>`; `SCRATCH=/tmp/accessible-tips-preview-<port>`.
2. Per section (tips / anecdotes / faq / news): leaf pages with alias stubs
   excluded, sorted by size:
   ```sh
   find "$SCRATCH/<section>" -mindepth 2 -name index.html -print0 \
     | xargs -0 grep -L 'http-equiv=refresh' \
     | while read -r f; do printf '%s\t%s\n' "$(wc -c < "$f")" "$f"; done \
     | sort -n
   ```
   (`-mindepth 2` so a section's own index isn't a leaf; stubs are the
   smallest files and would systematically win "smallest".) Pick
   **smallest / lower-median (line ⌊(n+1)/2⌋) / largest** → 12 pages.
3. Plus: the **About slot** — `/about/` IF the build contains
   `$SCRATCH/about/index.html`, ELSE the homepage `/` (this site currently
   has no About page; the homepage carries the About/Intent content —
   resolved dynamically each run, never assumed); **`/search/` idle only**
   (tripwire scope; the audit does post-query states); and **one random
   lightbox page**: candidates derived FROM THE BUILD —
   `grep -rl -i 'tobii' "$SCRATCH" --include=index.html` (rendered
   lightbox markup — immune to front-matter slug renames and draft
   exclusion, unlike content-dir greps; a slug like
   `tech-phone-as-a-laptop/` building as `using-a-phone-or-tablet-as-a-laptop/`
   silently breaks dirname→URL mapping); `shuf -n 1` among them; **the pick
   is logged** so a failure traces to its page.
4. **Log every pick** in the gate report.

**Execution:** each picked page, in **BOTH themes** (contrast rules are
theme-dependent — light-only axe misses dark-mode regressions). Theme state
machine (see a11y-audit): set a KNOWN theme, assert
`document.documentElement.dataset.theme` BEFORE each run; a failed assert is
a gate error, never a silent wrong-theme result. Inject + run per the
site-browser recipe; assert `results.testEngine.version` == pin. Batching
multiple pages inside one `run_code_unsafe` call per theme is fine (and
cheaper).

**Dark-theme reflow wait (mandatory):** after theme switches, wait for the
CSS custom properties to recompute BEFORE axe inspects computed styles —
force a reflow + two `requestAnimationFrame` ticks (+ ~80ms timer) after
the switch. Without it, dark runs can read LIGHT-theme (or mid-transition)
colors and fire spurious `color-contrast` violations — observed 2026-08-17
(smoke-3: `.top-link` 1.19:1 phantom; post-wait re-measure ~13:1, zero
violations). If a dark-theme color-contrast violation appears, re-verify
it after a proper reflow wait before believing it.

**Verdict:**

- A violation NOT matched by an exception entry → **FAIL**. Exception match =
  `(rule_id, page, selector)` with `page` the canonical URL path
  (e.g. `/tips/foo/`). Each failing violation reported as
  `{rule_id, page, selector, impact, help}`.
- All violations matched (or none) → page passes.
- **Bootstrap expectation:** with a header-only exception list, every
  pre-existing violation fails the gate — EXPECTED and correct
  pre-adjudication. The operator's {fix}/{exception} adjudication of the
  audit's findings seeds the baseline; a massive first-run list is the point,
  not a defect.

**Report:** `.scratch/test-artifacts/<ts>-smoke/axe-gate/` — `picks.log`
(all picks incl. the random lightbox choice), raw per-page axe JSON
(unmodified), `verdict.md` (status + failing violations table + version-pair
line).

### Page weight (low-bandwidth)

- Sum per-page transfer size from `playwright_browser_network_requests`; flag
  heavy assets/totals. **No frozen number** — compare to the corpus
  neighbourhood; a regression is a finding.
- No web fonts, no client bundles beyond the existing esbuild JS; any new
  external or weighted request is a finding.
- Text assets (HTML/CSS/JS) ship compressed (`Content-Encoding: br`/`gzip`); a
  missing encoding is a weight regression.

## Non-goals

Does not lint content/frontmatter or decide whether an alias is owed — only
checks what renders. Does not regenerate or reason about `data/equiv.toml` or the
search normalizer — only checks search works end to end. Does not fix anything;
it reports (page, selector, expected, actual). Does not test production. Does not
add Node to the repo.
