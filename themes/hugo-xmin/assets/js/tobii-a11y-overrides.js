// tobii-a11y-overrides.js — mark the page background `inert` while the Tobii
// lightbox is open, so keyboard/AT focus cannot escape behind the modal
// overlay. Tobii toggles the `tobii-is-open` class on <body>; this observer
// mirrors that state onto the main landmark. On close, Tobii refocuses the
// triggering .lightbox link itself, but it does so while <main> is still
// inert and the focus call is dropped; this file instead clears inert and
// restores focus to the trigger captured at open time. Paired with the
// vendored /vendor/tobii/tobii-a11y-overrides.css focus-ring fixes.
(() => {
  const bg = document.querySelector('main, article');
  if (!bg) return;
  // Most-recent .lightbox link the user activated. Capture phase, so it runs
  // regardless of where the click is handled; keyboard Enter on a link fires
  // a click, so this covers both input paths.
  let trigger = null;
  document.addEventListener('click', (event) => {
    const link = event.target.closest('.lightbox');
    if (link) trigger = link;
  }, true);
  let wasOpen = false;
  new MutationObserver(() => {
    const open = document.body.classList.contains('tobii-is-open');
    if (wasOpen && !open && trigger) {
      // Open→closed transition: Tobii's own refocus ran against the still-
      // inert <main> and landed on <body>; clear inert first, then restore
      // focus to the trigger ourselves.
      bg.removeAttribute('inert');
      trigger.focus();
      trigger = null;
    } else {
      bg.toggleAttribute('inert', open);
    }
    wasOpen = open;
  }).observe(document.body, { attributes: true, attributeFilter: ['class'] });
})();

// finding 1.7: caption-toggle uniqueness + visible-slide aria-hidden fix.
// Tobii renders one `.caption-toggle` button per slide. While the lightbox is
// open every slide keeps `aria-hidden="true"` (the visible one included) and
// every toggle has `tabindex=0` with identical text, so keyboard/SR users tab
// through N identical "Hide caption" buttons while the visible caption stays
// hidden from AT.
// finding #5: Tobii numbers each slide's `<figcaption>` `tobii-figcaption-<n>`
// off a per-instance counter (held on its image slide class, reset to 0 by
// `reset()`/`destroy()` and restarted on every `new Tobii()`), so re-creating
// or re-instantiating the lightbox — or running several instances — collides
// ids across galleries, and every `.caption-toggle` `aria-controls` (plus the
// figure `<img>`'s `aria-labelledby`, which points at the same id) references
// a non-unique target, invalidating the ARIA id-reference contract. This file
// assigns each figcaption a page-unique id from a monotonic module counter
// and repoints both references at it.
// Four-part fix, (re)applied on open and on every slide change:
//   1. page-unique, per-slide-stable `id` on each `<figcaption>`, keeping the
//      slide's `.caption-toggle` `aria-controls` and the figure `<img>`'s
//      `aria-labelledby` pointed at that one id (finding #5);
//   2. unique `aria-label` per toggle: "Hide caption — image N of M";
//   3. `tabindex="-1"` on all non-current toggles; only the current slide's
//      toggle stays in the tab order (Tobii's own Tab trap already excludes
//      `[tabindex^="-"]` from its focusable list);
//   4. `aria-hidden` removed from the current slide only; non-current slides
//      keep `aria-hidden="true"`.
// Current-slide detection: Tobii never marks the current slide in the DOM.
// Slides sit inside `.tobii__slider`, each `width: 100%`, and the slider is
// moved with an inline `transform: translate(-index * width, 0)` written on
// open, on every slide change (keyboard arrows, nav buttons, committed swipe,
// programmatic `select()`) and on resize. Observing that inline style is
// therefore the slide-change signal, and the index is recovered by rounding
// `-translateX / offsetWidth`. Swipe drags write transient transforms, so
// applies are debounced and skipped while `.tobii__slider--is-dragging` is
// present — Tobii removes that class before committing the final transform.
(() => {
  // Only the open gallery's slider is visible: Tobii flips the active slider
  // to `aria-hidden="false"` on open and back to `"true"` on close, and CSS
  // hides any `[aria-hidden="true"]` slider with display:none.
  const ACTIVE_SLIDER = '.tobii__slider[aria-hidden="false"]';
  const DRAGGING = 'tobii__slider--is-dragging';
  // finding #5: page-unique figcaption ids. The monotonic counter never
  // resets for the life of the page, so ids stay unique across galleries,
  // across opens, and across Tobii reset()/destroy() cycles (which restart
  // Tobii's own counter at 0). The prefix also lets apply() recognize a
  // figcaption we already numbered, keeping ids stable per slide.
  const ID_PREFIX = 'tobii-figcaption-a11y-';
  let figcaptionSeq = 0;
  let slider = null;
  let slideObserver = null;
  let lastIndex = -1;
  let timer = null;

  const readIndex = () => {
    const slides = slider.querySelectorAll('.tobii__slide');
    if (!slides.length) return 0;
    const m = /translate\(\s*(-?[\d.]+)/.exec(slider.style.transform || '');
    if (!m) return 0;
    const width = slider.offsetWidth || 1;
    const idx = Math.round(parseFloat(m[1]) / -width);
    return Math.max(0, Math.min(idx, slides.length - 1));
  };

  const apply = (index) => {
    const slides = Array.from(slider.querySelectorAll('.tobii__slide'));
    const total = slides.length;
    slides.forEach((slide, n) => {
      const current = n === index;
      if (current) slide.removeAttribute('aria-hidden');
      else slide.setAttribute('aria-hidden', 'true');
      const figcaption = slide.querySelector('figcaption');
      if (!figcaption) return;
      // finding #5: give the caption one id that is unique for the whole
      // page and stable for this slide — assigned only when it does not
      // already carry our prefix, so re-running this pass on open and on
      // every slide change never churns ids. A brand-new figcaption (e.g.
      // Tobii renumbered after a reset) gets a fresh, never-reused id.
      // Tobii generated the figure <img>'s aria-labelledby and the toggle's
      // aria-controls from its own colliding id; both are repointed at this
      // one id so no reference in the ARIA id-reference contract dangles.
      let id = figcaption.getAttribute('id');
      if (!id || id.indexOf(ID_PREFIX) !== 0) {
        id = ID_PREFIX + figcaptionSeq++;
        figcaption.setAttribute('id', id);
      }
      const img = figcaption.parentElement.querySelector('img');
      if (img) img.setAttribute('aria-labelledby', id);
      const toggle = slide.querySelector('.caption-toggle');
      if (!toggle) return;
      toggle.setAttribute('aria-controls', id);
      toggle.setAttribute('aria-label', 'Hide caption — image ' + (n + 1) + ' of ' + total);
      toggle.setAttribute('tabindex', current ? '0' : '-1');
    });
  };

  const scheduleApply = () => {
    if (timer) window.clearTimeout(timer);
    timer = window.setTimeout(() => {
      timer = null;
      if (!slider || slider.classList.contains(DRAGGING)) return;
      const index = readIndex();
      if (index !== lastIndex) {
        apply(index);
        lastIndex = index;
      }
    }, 50);
  };

  // Attach to the active slider and bring the three behaviors in line with
  // the current index. Runs once per open (body-class transition); the open
  // task has already written the settled transform by the time this fires.
  const track = () => {
    if (slideObserver) { slideObserver.disconnect(); slideObserver = null; }
    if (timer) { window.clearTimeout(timer); timer = null; }
    slider = document.querySelector(ACTIVE_SLIDER);
    if (!slider) return;
    const index = readIndex();
    apply(index);
    lastIndex = index;
    slideObserver = new MutationObserver(scheduleApply);
    slideObserver.observe(slider, { attributes: true, attributeFilter: ['style'] });
  };

  // Undo our DOM changes on close so nothing is left mutated behind the
  // (aria-hidden) closed lightbox; the next open reapplies from scratch.
  // figcaption ids are deliberately NOT undone: they stay page-unique and
  // stable, and the next open's apply() reuses them via the prefix check
  // instead of churning the counter.
  const reset = () => {
    if (slideObserver) { slideObserver.disconnect(); slideObserver = null; }
    if (timer) { window.clearTimeout(timer); timer = null; }
    if (!slider) return;
    slider.querySelectorAll('.tobii__slide').forEach((slide) => {
      slide.setAttribute('aria-hidden', 'true');
      const toggle = slide.querySelector('.caption-toggle');
      if (!toggle) return;
      toggle.setAttribute('tabindex', '0');
      toggle.removeAttribute('aria-label');
    });
    slider = null;
    lastIndex = -1;
  };

  let wasOpen = false;
  new MutationObserver(() => {
    const open = document.body.classList.contains('tobii-is-open');
    if (open && !wasOpen) track();
    else if (!open && wasOpen) reset();
    wasOpen = open;
  }).observe(document.body, { attributes: true, attributeFilter: ['class'] });
})();