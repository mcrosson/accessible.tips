---
name: a-b-compare
description: Compare two renderings of accessible.tips side by side — A/B test, before/after an edit, or two branches. Serves both versions locally, drives Playwright on each, and produces paired screenshots plus a structural diff for judgment. Use when asked to A/B test / compare versions / before-after / which looks better. Requires a vision-capable model. Builds on site-browser.
---

# a-b-compare

## Requires a vision-capable model

Run by a vision-capable model only — the whole point is judging the rendered
page.

## Scope

Owns the TWO-VERSION orchestration: serving two sources, capturing paired
artifacts, producing a diff. For serve/drive/artifacts/teardown and the driving
principles, use **site-browser**.

Hand off: correctness/breakage assertions (did anything break?) → **smoke-test**.
This skill compares; it does not certify either version as correct.

## Process

1. **Pick the two sources.** Common cases:
   - Two branches: `bin/preview.sh <branchA> <portA>` and
     `bin/preview.sh <branchB> <portB>` (or manual baseURL builds).
   - Before/after an edit: the current working tree vs a stash/branch tip.
   - Two builds on two ports.
2. **Serve both** on distinct ports (see **site-browser**). Use `preview.sh` for
   searchable output; use the manual local-baseURL build if aliases/absolute URLs
   are part of what's being compared.
3. **Drive Playwright on both** for each comparison URL: identical navigation,
   then paired `playwright_browser_snapshot` + `playwright_browser_take_screenshot`
   per version.
4. **Write artifacts** into one run dir
   `.scratch/test-artifacts/<timestamp>-ab/` with `a/` and `b/` subdirs and
   paired filenames (e.g. `a/home.png` / `b/home.png`,
   `a/home.snap.txt` / `b/home.snap.txt`). Create the dir if absent.
5. **Produce a diff.**
   - Structural: snapshot text diff, plus a DOM/computed-style diff via
     `playwright_browser_evaluate` (differing computed styles on key elements,
     differing text content).
   - Visual: the paired screenshots — the vision-capable model reads and judges
     them.
   - **Accessibility & weight diff.** Run the AA-floor checks (contrast, reflow,
     focus, alt/labels) on BOTH versions and report regressions; report the
     per-page transfer-weight delta. A version that regresses AA or grows page
     weight is not an improvement even if it "looks better."
6. **Report.** Per comparison URL: what differs structurally, and the visual
   judgment. The operator is the final arbiter — present pairs + diff; do not
   silently auto-promote a winner.

## Non-goals

Does not decide correctness (→ **smoke-test**). Does not auto-apply or
auto-promote a version. Does not test production. Does not add Node to the repo.
