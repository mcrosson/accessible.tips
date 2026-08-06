# Vendored: hugo-admonitions

This theme component is **vendored** (tracked files, no external dependency, no
Hugo Modules, no Node), mirroring how the site pins its other third-party tools
(`bin/hugo-0.155.3`, `bin/pagefind`) — a fixed, checked-in copy at a known
version rather than a fetched dependency.

- **Upstream:** https://github.com/KKKZOZ/hugo-admonitions
- **Version:** v0.12.1
- **Pinned commit:** `f3a2412dac3365c32beb8d572c31e8e0c8a4717b`
- **Source archive:** https://codeload.github.com/KKKZOZ/hugo-admonitions/tar.gz/f3a2412dac3365c32beb8d572c31e8e0c8a4717b
- **Fetched:** 2026-07-16
- **License:** MIT (see `LICENSE`)

## What is vendored (consumer files only)

- `layouts/_default/_markup/render-blockquote-alert.html` — the single blockquote
  render hook (branches on `.Type`; renders alerts + plain blockquotes; self-emits
  its own fingerprinted + SRI'd CSS `<link>`, deduped per page via `Page.Store`).
- `layouts/partials/admonitions/icons/*.svg` — 17 admonition icons.
  - **Sanctioned direct edit:** each carries an owner-approved `aria-hidden="true" focusable="false"` on its opening `<svg>` (A11Y-06, commit `3e7a62d`) — the icons are purely decorative and CSS can't add an HTML attribute, so this one exception bypasses "vendored means untouched." Preserve it on the next upstream re-fetch; not drift.
- `assets/sass/vendors/_admonitions.scss` and
  `assets/sass/vendors/_admonitions-user-settings.scss` — the styles the hook
  transpiles via Hugo Pipes (`_admonitions.scss` imports `-user-settings`).
- `i18n/*.yaml` — 11 label translation files (`T "admonitions.<type>"`).
- `theme.yaml`, `LICENSE`.

## Deliberately excluded (upstream dev tooling — not consumer files)

`package.json`, `package-lock.json`, `.husky/`, `.github/`, `commitlint.config.js`,
`release.config.js`, `go.mod`, `docs/`, `README.md`, `.gitignore`, `hugo.toml`.

## Activation

Registered site-wide in `config.toml`:

    theme = ["hugo-admonitions", "hugo-xmin"]

`hugo-admonitions` is left-most (higher precedence per upstream README);
`hugo-xmin` has no blockquote render hook, so there is no conflict. No
`[markup.goldmark]` block is required — the hook rides Hugo's native
GitHub-alert blockquote support (default-on in Hugo 0.155.3) and self-guards on
Hugo >= 0.140.

## Updating

Re-fetch the desired tag's archive, re-copy the consumer files above (keeping the
excluded list excluded), and update the version/commit/date here.
