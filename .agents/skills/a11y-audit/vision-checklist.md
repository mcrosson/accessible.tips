# vision-checklist.md — the vision-pass brief artifact (a11y-audit)

Loaded VERBATIM by every audit agent. This is what the mechanical layers
(axe / AX-tree / VSR) cannot judge. **AA is the floor; take AAA when free or
cheap.** Every check runs in BOTH light and dark themes unless marked
theme-invariant. Screenshots are the evidence; pair every contrast judgment
with an `evaluate` computed-color ratio.

## VSR expected differences — NON-findings (do not report)

- JS-revealed controls: the theme toggle ships `hidden` and is revealed by
  its script — VSR runs no site JS, so its absence from announcements is
  EXPECTED.
- JS-injected regions: search results — same reason.
- `/search/` in VSR: idle state ONLY (results cannot render in jsdom).

## SC-by-SC responsibility matrix (#19)

Owners: **A** = axe (both themes) · **T** = AX-tree (once) · **V** = VSR
(once) · **E** = vision (both themes) · **—** = out of scope (absent feature;
E confirms absence once per run, not per page).

### Perceivable

| SC | Name | Owner(s) | Notes |
|---|---|---|---|
| 1.1.1 | Non-text content | A + E | axe covers alt-presence mechanics; E judges alt QUALITY (meaning) |
| 1.2.1–1.2.8 | Audio/video | — | No media on site; E confirms none emitted |
| 1.3.1 | Info & relationships | A + E | landmarks, headings, labels; NOTE: current known best-practice violations (landmark-one-main, region) |
| 1.3.2 | Meaningful sequence | V + E | VSR announcement order is the primary instrument |
| 1.3.3 | Sensory characteristics | E | instructions relying on shape/color/position |
| 1.3.4 | Orientation | E | no loss at portrait/square viewports |
| 1.3.5 | Identify input purpose | A | autocomplete on inputs where applicable |
| 1.4.1 | Use of color | E | color-only distinctions (links-in-prose check) |
| 1.4.2 | Audio control | — | no audio |
| 1.4.3 | Contrast (minimum) | A + E | axe both themes; E verifies computed pairs 4.5:1 / 3:1 large |
| 1.4.4 | Resize text | E | 200% zoom, no loss of function |
| 1.4.5 | Images of text | E | |
| 1.4.10 | Reflow | E | 320px width, no horizontal scroll (`scrollWidth` check), no loss |
| 1.4.11 | Non-text contrast | A + E | UI components/graphical objects 3:1 — focus indicators, borders, icons |
| 1.4.12 | Text spacing | E | spacing override script, no loss/clipping |
| 1.4.13 | Content on hover/focus | E | dismissible/hoverable/persistent — lightbox, any tooltips |
| (1.4.6) | AAA: Contrast enhanced | E | 7:1 / 4.5:1 large — TAKE WHERE FREE |
| (1.4.9) | AAA: Images of text (no exception) | E | |

### Operable

| SC | Name | Owner(s) | Notes |
|---|---|---|---|
| 2.1.1 | Keyboard | E | every interactive element incl. lightbox, toggle, search |
| 2.1.2 | No keyboard trap | E | lightbox open→escape→close; search focus |
| 2.1.4 | Character-key shortcuts | E | verify none exist (single-char triggers) |
| 2.2.1–2.2.5 | Timing | — | no timers/session expiry; E confirms once |
| 2.3.1–2.3.2 | Flashes | — | no animated/flashing content; E confirms once |
| 2.4.1 | Bypass blocks | A | landmark/heading structure |
| 2.4.2 | Page titled | A | document-title |
| 2.4.3 | Focus order | E + V | tab order matches visual/logical order |
| 2.4.4 | Link purpose (in context) | A + E | link-name mechanics + E judges ambiguity; ↑Top aria-label pattern |
| 2.4.5 | Multiple ways | E | nav + search + sitemap exist |
| 2.4.6 | Headings and labels | E | descriptive, not empty |
| 2.4.7 | Focus visible | E | `:focus-visible` present on ALL interactive elements, BOTH themes (contrast of indicator = 1.4.11) |
| 2.5.1 | Pointer gestures | E | lightbox swipe has click alternative if swipe exists |
| 2.5.2 | Pointer cancellation | E | no down-trigger-only actions |
| 2.5.3 | Label in name | A | label-content-name-mismatch |
| 2.5.4 | Motion actuation | — | no motion-triggered UI |
| 2.5.7 | Dragging movements | E | verify lightbox/anything drag-based has alternative |
| 2.5.8 | Target size (minimum) | E | ≥24×24 AA |
| (2.5.5) | AAA: Target size enhanced | E | ≥44×44 — TAKE WHERE FREE (inline text links exempt) |
| (2.4.8) | AAA: Location | E | breadcrumbs/here-marker where free |
| (2.4.9) | AAA: Link purpose (site) | E | aria-label disambiguation where free |

### Understandable

| SC | Name | Owner(s) | Notes |
|---|---|---|---|
| 3.1.1 | Language of page | A | html-has-lang / html-lang-valid |
| 3.1.2 | Language of parts | E | foreign-language snippets get `lang` |
| 3.2.1 | On focus | E | no context change on focus alone |
| 3.2.2 | On input | E | search input behavior |
| 3.2.3 | Consistent navigation | E | across sections |
| 3.2.4 | Consistent identification | E | same icon/label = same meaning everywhere |
| 3.2.6 | Consistent help | E | help access same place on pages where present |
| 3.3.1 | Error identification | E | search no-results state announces errors in text |
| 3.3.2 | Labels or instructions | A + E | search input labeled |
| 3.3.3 | Error suggestion | E | |
| 3.3.4/3.3.7/3.3.8 | Forms/auth | — | no such forms |

### Robust

| SC | Name | Owner(s) | Notes |
|---|---|---|---|
| 4.1.2 | Name, role, value | A + T | custom widgets — toggle, lightbox |
| 4.1.3 | Status messages | E + T | search results count/updates — live region present and used |

## Checklist (#20) — the per-page vision pass

1. **Contrast, computed** — `evaluate` computed colors on text/UI pairs in
   light AND dark: 4.5:1 text, 3:1 large text and UI components; 7:1 where
   free (AAA).
2. **Zoom 200% / 400%** — no loss of function or content; **reflow at 320px**
   — `document.scrollingElement.scrollWidth <= clientWidth`, no horizontal
   scroll; nothing clipped.
3. **Tab order + keyboard operability** — every interactive element reachable
   and operable; order matches visual flow. Lightbox: open, navigate,
   escape/close. Toggle: operates from keyboard. Search: type + submit.
4. **`:focus-visible`** — visible on every interactive element, both themes
   (indicator contrast under 1.4.11).
5. **Heading hierarchy** — no skipped levels without structural cause;
   one `h1` per page where the template provides it.
6. **Link purpose in context** — ambiguous links flagged with page context
   cited; named-pattern links (↑Top) carry `aria-label`.
7. **Language of page/parts** — `<html lang>` present/valid; foreign
   snippets marked.
8. **Target size** — interactive targets ≥24×24 (AA); ≥44×44 where free.
9. **Admonition buckets (#14)** — explicit look, light AND dark: all 21
   buckets render (the `_test/` pages collectively cover them;
   `tips/_test` has the full set); bucket text contrast, ARIA/structure
   intact. High-risk lock-step pair — prime contrast/structure surface.
10. **Lightbox operability** — keyboard path, focus management, escape,
    no trap; content accessible.
11. **`prefers-reduced-motion` (#25)** — emulate reduced motion; verify no
    essential information is motion-only and any transitions respect it
    (e.g. theme switch).
12. **Text spacing (1.4.12)** — apply spacing overrides; no clipping/overlap.
13. **Theme state machine compliance** — every capture asserted against
    `document.documentElement.dataset.theme` BEFORE being recorded;
    screenshots labeled light/dark. A failed assert = page error, never a
    wrong-theme capture.
