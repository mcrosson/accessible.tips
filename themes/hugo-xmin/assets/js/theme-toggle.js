// theme-toggle.js — progressive-enhancement colour-mode control (cycling button).
//
// The site is fully themed WITHOUT this script: auto mode is pure CSS
// (`@media (prefers-color-scheme)`), and a tiny inline head snippet applies any
// saved override before first paint (no flash). This file only adds the manual
// override control and persists the choice.
//
// Mirrors the wake-lock switch's progressive-enhancement + a11y pattern: the
// button ships with the `hidden` attribute and is revealed ONLY once this
// script runs, so a no-JS reader never sees a dead affordance.
//
// The control is a SINGLE button that cycles auto -> light -> dark -> auto. On
// each click it: persists the choice, applies it to the document, swaps the
// visible icon (via data-mode, CSS shows the matching one), rewrites the
// aria-label to name the current + next mode, and speaks the new mode through a
// visually hidden aria-live region so assistive tech announces the result.
//
// STORAGE CONTRACT (kept identical to baseof.html's anti-FOUC snippet and the
// _theme.scss cascade): localStorage key "theme"; values "light"/"dark"; auto =
// key removed and data-theme cleared, so the OS media query takes over.
//
// Built with Hugo Pipes (esbuild, minified) + fingerprinted for SRI; `defer`
// keeps it off the critical path.
(function () {
  "use strict";

  var STORAGE_KEY = "theme";
  var MODES = ["auto", "light", "dark"];

  var root = document.documentElement;
  var btn = document.querySelector("[data-theme-toggle]");
  if (!btn) return;

  var status = document.querySelector("[data-theme-status]");

  // Human-facing copy per mode: the button's accessible name (current + next),
  // and the short phrase announced through the live region after a change.
  var LABEL = {
    auto: "Theme: automatic (match system). Activate to switch to light.",
    light: "Theme: light. Activate to switch to dark.",
    dark: "Theme: dark. Activate to switch to automatic.",
  };
  var ANNOUNCE = {
    auto: "Automatic theme, matching your system.",
    light: "Light theme.",
    dark: "Dark theme.",
  };

  function stored() {
    try {
      return localStorage.getItem(STORAGE_KEY);
    } catch (e) {
      return null;
    }
  }

  // Persist the choice: auto clears the key, light/dark write it.
  function persist(mode) {
    try {
      if (mode === "auto") {
        localStorage.removeItem(STORAGE_KEY);
      } else {
        localStorage.setItem(STORAGE_KEY, mode);
      }
    } catch (e) {
      /* storage may be unavailable (private mode); still apply for this page. */
    }
  }

  // Apply to the document: clear data-theme for auto (fall back to the OS media
  // query), otherwise force the chosen mode. This matches the anti-FOUC snippet.
  function applyToDocument(mode) {
    if (mode === "auto") {
      delete root.dataset.theme;
    } else {
      root.dataset.theme = mode;
    }
  }

  // Reflect a mode into the button (icon + accessible name).
  function reflect(mode) {
    btn.dataset.mode = mode;
    btn.setAttribute("aria-label", LABEL[mode]);
  }

  // Nothing stored => auto. Reflect the current state without announcing it.
  var current = stored();
  if (current !== "light" && current !== "dark") current = "auto";
  reflect(current);

  // Reveal the control now that JavaScript is running.
  btn.hidden = false;

  btn.addEventListener("click", function () {
    var next = MODES[(MODES.indexOf(current) + 1) % MODES.length];
    current = next;
    persist(next);
    applyToDocument(next);
    reflect(next);
    if (status) status.textContent = ANNOUNCE[next];
  });
})();
