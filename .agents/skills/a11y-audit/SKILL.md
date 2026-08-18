---
name: a11y-audit
description: Full accessibility audit of accessible.tips — WCAG AA floor (every applicable criterion) with AAA layered in where free/cheap, over ALL pages and ALL outputs in light AND dark. Owns the judgment artifacts (exception list, vision checklist, triage); builds on site-browser for serve/drive/axe mechanics. Requires a vision-capable model.
---

# a11y-audit

## What this skill is

Full-site accessibility certification: every page and output the build emits,
both themes, a 3-layer automation stack plus vision judgment. **AA is the
floor** — any AA failure is a finding. AAA is layered in where free/cheap.
The audit is ALL pages/outputs; the smoke-test gate is a separate, trimmed
tripwire — never conflate the two.

**Layering rationale (#21, as reshaped by #22):** this skill owns the
JUDGMENT artifacts — `exceptions.toml` (triage output lands here; ownership
follows the writer) and `vision-checklist.md`. The axe MECHANICS (vendored
bundle, pin, inject/run recipe) live in `site-browser`, consumed BY PATH —
as does the smoke gate. `exceptions.toml`'s header `axe_version` and
`site-browser/vendor/.MANIFEST` form ONE version pair; the gate asserts their
equality before trusting either. Splitting judgment from mechanics further
would re-create the cross-skill sync burden #22 closed.

## Constraints

- **No Node in the site build — ever.** The gitignored `vsr/` harness in
  this directory is a test-time-only carve-out: reconstructed on demand by
  the priming procedure below, never committed, never shipped, never in the
  build. Same spirit as the vendored axe bundle: no "helpful"
  `npm install` drift.
- **Serial execution (operator, 2026-08-15):** ONE audit agent drives the
  shared Playwright MCP browser at a time. Agent A completes its FULL pass
  before agent B starts. Concurrent browser driving clobbers state — proven,
  empirically, 2026-08-15.
- Never follow alias stubs (#9): canonical pages are audited; alias
  resolution is a smoke-test concern.

## Preconditions

1. `site-browser` skill loaded — its serve/drive mechanics AND its
   "Inject-and-run axe" section are assumed available.
2. `vision-checklist.md` and `exceptions.toml` (this directory) read in full.
3. The orchestrator's brief carries: the verbatim ordered page enumeration,
   assigned ports, run dir, batch ranges, wall-clock expectation.
4. `vsr/` primed (below) — audit agents only CONSUME the harness.

## Per-page protocol

**Layer order is FIXED: VSR → axe → AX-tree → vision.** axe mutates the DOM
(highlight styles, `mark` elements); VSR is fed via saved `page.content()`
and must see a clean tree.

1. **Capture the clean tree first** — save `page.content()` to the run dir;
   run the VSR harness on that file (once per page; theme-invariant).
2. **AX-tree** snapshot (once per page; theme-invariant).
3. **axe in LIGHT** — assert theme, inject + run per the site-browser
   recipe, persist raw JSON.
4. **axe in DARK** — same, after switching via the theme state machine.
5. **Vision captures in BOTH themes** (screenshots are the evidence),
   per `vision-checklist.md`.
6. **Auto-state pass (#35):** orchestrator-designated 1–2 pages ONLY, run
   LAST per agent, via Playwright `colorScheme` emulation (auto state under
   emulated light, reload + assert; emulated dark, reload + assert); reset
   to a known state after; clear the emulation.
7. **Write the per-page note** (template below) before moving on.

**Theme state machine (mandatory).** The toggle cycles auto→light→dark→auto
and persists via `localStorage["theme"]` — never click blind. (1) Read the
current mode from the toggle's `dataset.mode`/`aria-label`; click to a KNOWN
state. (2) Before EVERY capture assert
`document.documentElement.dataset.theme === 'light'|'dark'`; a failed assert
is a page error — never a silent wrong-theme capture. (3) The auto-state
pass runs LAST. (4) Clear `colorScheme` emulation afterward.

**Layer × theme multiplicity:** axe and vision run in BOTH themes (contrast
and pixels are theme-dependent); AX-tree and VSR run ONCE per page
(structure and announcement order are theme-invariant).

**Search page (`/search/`, preview server only):** audit exercises idle +
post-query + absurd-query/no-results states (#28). VSR: idle ONLY
(JS-injected results cannot render in jsdom regardless).

**VSR expected differences are NON-findings** — record, never report:
JS-revealed controls (the theme toggle ships `hidden`, revealed by its
script) and JS-injected regions (search results) — VSR executes no site JS,
so "control not announced" on JS-dependent DOM is expected. Conversely,
content inside `aria-hidden="true"` MAY be announced by VSR (jsdom-backed,
it walks the DOM without enforcing aria-hidden propagation — observed
2026-08-18, `/test-form/` honeypot); real ATs read the browser AX tree,
which excludes it — trust the AX-tree layer over VSR for aria-hidden
content and never report such VSR announcements as findings.

**Retry/abort (#29):** an empty/errored tool step retries ONCE; a second
failure marks the page errored and the agent CONTINUES. Four CONSECUTIVE
errored pages = suspected environmental failure: STOP, note
"suspected environmental failure," preserve artifacts, tear down per the
brief, report. **No early exit (#23):** slowness is never an exit excuse.

## Batching and run dirs

- Run dir: `.scratch/test-artifacts/<ts>-a11y-audit-<model>/` with sanitized
  model labels (`minimax-m3`, `qwen3.7-plus`).
- **Sequential page-range batches** over the brief's ordered enumeration;
  a checkpoint index file lives in the run dir between batches; resume =
  first missing note.
- Each batch writes RAW results to disk UNMODIFIED (full axe JSON, VSR
  announcement logs, snapshots, screenshots, per-page notes) and summarizes
  its own raw output while context is fresh. Consolidation (the
  orchestrator) works from chunk summaries; raw notes are pulled only as
  adjudication evidence.
- The notes tree MIRRORS the site tree (#31):
  `tips/foo-tip/index.md` → `pages/tips/foo-tip.notes.md`;
  `tips/index.md` (section index) → `pages/tips.notes.md`.

**Per-page note template (fixed sections):** `axe` (violation summary or
clean) / `vision` (checklist findings) / `console` (browser errors) /
`artifacts` (screenshot paths light+dark, snapshot path) / `variants`
(states exercised — e.g. search idle vs queried).

## Layer ownership

- **axe** (both themes): mechanical WCAG/ARIA rules via the site-browser
  recipe. Every violation is a finding UNLESS on `exceptions.toml`.
- **AX-tree** (once): roles/names/states/hierarchy — 4.1.2-shaped checks.
- **VSR** (once): navigation-order announcements, name-from-content —
  deliberately NARROW scope; static tree only.
- **vision** (both themes): everything the mechanical layers cannot judge —
  enumerated in `vision-checklist.md`.

## Findings and consolidation (#33)

Same-finding key: same criterion + same page + same element/selector,
regardless of which agent found it. Per-finding schema: `{criterion,
rule_id (axe rule — shared trail with exceptions), level (AA / AAA-free /
best-practice), page, element/selector, evidence (screenshot / axe ref /
announcement log), finding, suggested fix, agents, status (pending
adjudication)}`. Agent disagreements = ONE row, both positions cited, both
evidence trails preserved. ALL findings flow to the operator for
adjudication in adjudicable increments — nothing is filtered out.

## Exception list lifecycle (`exceptions.toml`)

- Entries land ONLY via operator adjudication of audit findings — never by
  an agent, never during a run.
- Identity key: the triple `(rule_id, page, selector)`; `page` is the
  CANONICAL URL PATH (e.g. `/tips/foo/`), never a filename.
- The gate asserts the header `axe_version` equals the vendored pin before
  consulting the list; mismatch = FAIL "re-triage pending", never a vacuous
  pass.
- An axe version bump is a deliberate event (procedure in
  `site-browser/vendor/.MANIFEST`): re-run the full pass, re-triage, update
  header and every entry's `axe_version`.

## VSR harness — priming procedure

`vsr/` (this directory, gitignored) is reconstructed on demand. The
ORCHESTRATOR primes ONCE — never two concurrent primers (npm install race;
moot under serial execution, still one primer).

1. `mkdir -p vsr && cd vsr` (inside this skill's directory).
2. Verify `node --version` (>= 18) and npm registry reachability
   (`npm ping`). On failure: report, do not improvise.
3. `npm init -y` then `npm install @guidepup/virtual-screen-reader jsdom` —
   package.json and node_modules stay INSIDE the gitignored `vsr/`.
4. Write `harness.mjs` from the embedded copy below.
5. Smoke run: save any locally served page's HTML to a file, run
   `node harness.mjs <in.html> <out.json>`, and assert `out.json` parses
   with a non-empty `announcements` array. **If the guidepup API has
   drifted** (a method below doesn't exist), FIX `harness.mjs` and update
   the embedded copy in this SKILL.md to match — the embedded copy is the
   source of truth for the next reconstruction.

**I/O contract:** input = absolute path to a saved-HTML file, optional
`--url <origin>` for record-keeping; output = JSON at the given path:

```json
{ "url": "…|null", "source": "in.html filename", "vsrVersion": "…|null",
  "generatedAt": "ISO-8601", "announcements": [ { "index": 0, "text": "…" } ],
  "quickKeys": { "h": ["…"] , "k": ["…"] } }
```

Exit non-zero with a stderr message on any failure. Site JS must NOT
execute (jsdom default — never pass `runScripts`).

**Embedded harness (`vsr/harness.mjs`):**

```js
// VSR announcement harness — test-time only; lives in the gitignored vsr/.
// Contract: node harness.mjs <input.html> <output.json> [--url <origin>]
import { readFile, writeFile } from "node:fs/promises";

const fail = (m) => { console.error(`harness: ${m}`); process.exit(1); };
const argv = process.argv.slice(2);
if (argv.length < 2) fail("usage: harness.mjs <input.html> <output.json> [--url <origin>]");
const [inFile, outFile] = argv;
const u = argv.indexOf("--url");
const origin = u !== -1 ? argv[u + 1] : undefined;

let html;
try { html = await readFile(inFile, "utf8"); } catch (e) { fail(`read input: ${e.message}`); }

let JSDOM, virtual;
try {
  ({ JSDOM } = await import("jsdom"));
  ({ virtual } = await import("@guidepup/virtual-screen-reader"));
} catch (e) { fail(`import (is vsr/ primed?): ${e.message}`); }

let vsrVersion = null;
try {
  const pkg = JSON.parse(await readFile(new URL("./node_modules/@guidepup/virtual-screen-reader/package.json", import.meta.url), "utf8"));
  vsrVersion = pkg.version;
} catch { /* optional */ }

const dom = new JSDOM(html, { url: origin || "http://localhost/" });
let vsr;
try { vsr = virtual; await vsr.start({ container: dom.window.document.body, window: dom.window }); }
catch (e) { fail(`vsr start: ${e.message}`); }

// 1) Linear navigation: walk the full order; capture per-item text when the
//    API exposes it; the accumulated spoken log is ground truth.
//    guidepup >= 0.32: next() resolves void and WRAPS at the end of the
//    document; the wrap restart re-announces "document" — break there.
const items = [];
try {
  for (let i = 0; i < 5000; i++) {
    await vsr.next();
    const log = await vsr.spokenPhraseLog();
    const last = String(log[log.length - 1]);
    if (i > 0 && last === "document") break;
    let text = null;
    try { text = await vsr.itemText(); } catch { /* optional API */ }
    items.push({ text });
  }
} catch (e) { fail(`vsr traversal: ${e.message}`); }

let spoken = [];
try { spoken = await vsr.spokenPhraseLog(); } catch { /* fall back to items */ }

// 2) Quick-key passes (best effort): each press appends to the spoken log.
//    guidepup >= 0.32: press() resolves void and wraps; stop when the log
//    stops growing or the first match of the pass comes round again.
const quickKeys = {};
for (const key of ["h", "k"]) {
  const pass = [];
  try {
    for (let i = 0; i < 500; i++) {
      const before = (await vsr.spokenPhraseLog()).length;
      await vsr.press(key);
      const after = await vsr.spokenPhraseLog();
      if (after.length === before) break;
      const phrase = String(after[after.length - 1]);
      if (pass.length > 0 && phrase === pass[0]) break;
      pass.push(phrase);
    }
    quickKeys[key] = pass;
  } catch { quickKeys[key] = null; }
}

try { await vsr.stop(); } catch { /* best effort */ }

// Announcements: per-item when complete; otherwise the spoken log verbatim.
const withText = items.filter((i) => i.text);
const announcements = withText.length === items.length && items.length > 0
  ? items.map((i, index) => ({ index, text: i.text }))
  : spoken.map((text, index) => ({ index, text: String(text) }));

if (announcements.length === 0) fail("no announcements captured (empty/invalid HTML?)");

const out = { url: origin ?? null, source: inFile.split("/").pop(), vsrVersion,
  generatedAt: new Date().toISOString(), announcements, quickKeys };
try { await writeFile(outFile, JSON.stringify(out, null, 2)); }
catch (e) { fail(`write output: ${e.message}`); }
console.log(`harness: ${announcements.length} announcements -> ${outFile}`);
```
