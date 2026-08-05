// search-page.js — SUBMIT-based search for the dedicated /search/ page.
//
// The /search/ page ships a static search <form> and an empty results list;
// this script wires them to the Pagefind JS API (generated into /pagefind/ by
// the Pagefind build step, NOT bundled by Hugo). It searches ONLY on submit —
// pressing Enter or clicking the Search button — and never on keystroke. There
// is deliberately NO input/keyup listener, so typing fetches nothing: the first
// /pagefind/ request only fires when a query is actually submitted. (The old
// PagefindUI widget searched as-you-type, re-fetching index chunks on every
// keystroke; PagefindUI 1.5.2 exposes no option to disable that, so we drive the
// lower-level API ourselves.)
//
// With JavaScript off the page is inert but harmless — the form just reloads
// /search/?q=… — which is acceptable for a client-side search tool. Asset load
// is graceful: if the Pagefind bundle can't be fetched (offline, or the index
// was never built), the reader sees a plain message instead of a thrown error.
//
// SEARCH STEP 3: this file also drives the SUGGEST-ONLY typo corrector. The typed
// query always reaches Pagefind unchanged; alongside it, corrector.js computes an
// optional "Did you mean …?" hint from the build-time /search-vocab.json vocabulary.
// The hint is clickable — it rewrites the box to the corrected phrase and re-runs
// via the normal submit path — and is bound to the same stale-token guard as the
// results, so a superseded search never leaves a stale suggestion behind.
import { suggest } from "./corrector.js";

(function () {
  "use strict";

  var mount = document.getElementById("search");
  if (!mount) return;

  var form = mount.querySelector(".search-page__form");
  var input = mount.querySelector(".search-page__input");
  var status = mount.querySelector(".search-page__status");
  var list = mount.querySelector(".search-page__results");
  var suggestionEl = mount.querySelector(".search-page__suggestion");
  if (!form || !input || !status || !list) return;

  var PAGE_SIZE = 25; // results per page; a "Load more" control reveals the rest.

  // Pagefind writes its runtime into the build OUTPUT at this absolute path, so
  // it is NOT resolvable in Hugo's asset graph. A literal import("/pagefind/…")
  // would make esbuild try to bundle a file that does not exist at build time;
  // constructing the dynamic import through new Function hides the specifier from
  // the bundler so it stays a genuine runtime import of the generated module.
  var importModule = new Function("src", "return import(src);");

  // Load + init the Pagefind JS API once, lazily, on the FIRST submitted search.
  // Memoised so repeat searches reuse the same initialised module.
  var pfPromise = null;
  function getPagefind() {
    if (!pfPromise) {
      pfPromise = importModule("/pagefind/pagefind.js").then(function (pf) {
        return Promise.resolve(pf.init()).then(function () {
          return pf;
        });
      });
    }
    return pfPromise;
  }

  // Load the corrector vocabulary (term -> document frequency) once, lazily, on
  // the first submitted search. Failure is graceful: the promise resolves to null
  // and the corrector simply stays silent — search itself is unaffected.
  var vocabPromise = null;
  function getVocab() {
    if (!vocabPromise) {
      vocabPromise = fetch("/search-vocab.json")
        .then(function (r) {
          if (!r.ok) throw new Error("vocab unavailable");
          return r.json();
        })
        .then(function (j) {
          return (j && j.df) || null;
        })
        .catch(function () {
          return null;
        });
    }
    return vocabPromise;
  }

  var token = 0; // increments per search; stale async renders bail out.
  var moreBtn = null; // the live "Load more" button, if any.

  function clearSuggestion() {
    if (!suggestionEl) return;
    suggestionEl.textContent = "";
    suggestionEl.hidden = true;
  }

  function clearResults() {
    list.textContent = "";
    if (moreBtn) {
      moreBtn.remove();
      moreBtn = null;
    }
    clearSuggestion();
    mount.classList.remove("search-page__widget--error");
  }

  // Compute + render the "Did you mean …?" hint for this query. Independent of the
  // Pagefind results (it only needs the query + vocabulary), but gated on myToken so
  // a superseded search never leaves a stale suggestion. Clicking the correction
  // rewrites the box and re-runs through the normal submit path.
  function renderSuggestion(query, myToken) {
    if (!suggestionEl) return;
    getVocab()
      .then(function (vocab) {
        if (myToken !== token) return; // superseded
        var s = vocab ? suggest(query, vocab) : null;
        if (!s) return;
        suggestionEl.textContent = "Did you mean ";
        var btn = document.createElement("button");
        btn.type = "button";
        btn.className = "search-page__suggestion-btn";
        btn.textContent = s.text;
        btn.addEventListener("click", function () {
          input.value = s.text;
          syncUrlAndRun(s.text);
        });
        suggestionEl.appendChild(btn);
        suggestionEl.appendChild(document.createTextNode("?"));
        suggestionEl.hidden = false;
      })
      .catch(function () {
        /* vocab/corrector failure is non-fatal — no hint. */
      });
  }

  // Build one result <li> from a Pagefind result-data object.
  // The card is intentionally minimal — TITLE + PUBLISH DATE, and no excerpt
  // (owner-decided final form). Title is plain text; the date comes from the
  // Pagefind meta field `d.meta.date` emitted at index time by the single
  // layouts.
  function buildResult(d) {
    var li = document.createElement("li");
    li.className = "search-page__result";

    var titleP = document.createElement("p");
    titleP.className = "search-page__result-title";
    var a = document.createElement("a");
    a.className = "search-page__result-link";
    a.href = d.url;
    a.textContent = (d.meta && d.meta.title) || d.url;
    titleP.appendChild(a);

    // Publish date (Pagefind meta `date`, pre-formatted like "Dec 5, 2022"),
    // inline after the title text, parenthesized.
    if (d.meta && d.meta.date) {
      var dateSpan = document.createElement("span");
      dateSpan.className = "search-page__result-date";
      dateSpan.textContent = " (" + d.meta.date + ")";
      titleP.appendChild(dateSpan);
    }

    li.appendChild(titleP);

    return li;
  }

  // Append the next PAGE_SIZE results and (re)wire the Load-more control.
  // Each result's data() is what actually fetches its /pagefind/ fragment, so
  // this is where on-submit fetching happens — never before.
  function renderPage(results, start, myToken) {
    var slice = results.slice(start, start + PAGE_SIZE);
    return Promise.all(
      slice.map(function (r) {
        return r.data();
      })
    ).then(function (datas) {
      if (myToken !== token) return; // superseded by a newer search
      datas.forEach(function (d) {
        list.appendChild(buildResult(d));
      });
      var next = start + slice.length;
      if (moreBtn) {
        moreBtn.remove();
        moreBtn = null;
      }
      if (next < results.length) {
        moreBtn = document.createElement("button");
        moreBtn.type = "button";
        moreBtn.className = "search-page__more";
        moreBtn.textContent = "Load more results";
        moreBtn.addEventListener("click", function () {
          moreBtn.disabled = true;
          renderPage(results, next, myToken);
        });
        mount.appendChild(moreBtn);
      }
    });
  }

  function runSearch(query) {
    query = (query || "").trim();
    var myToken = ++token;
    clearResults();
    if (!query) {
      status.textContent = "";
      return;
    }
    renderSuggestion(query, myToken);
    status.textContent = "Searching…";
    getPagefind()
      .then(function (pf) {
        return pf.search(query);
      })
      .then(function (s) {
        if (myToken !== token) return;
        var n = s.results.length;
        if (!n) {
          status.textContent = "No results for “" + query + "”.";
          return;
        }
        status.textContent =
          n + " result" + (n === 1 ? "" : "s") + " for “" + query + "”.";
        return renderPage(s.results, 0, myToken);
      })
      .catch(function () {
        if (myToken !== token) return;
        clearResults();
        mount.classList.add("search-page__widget--error");
        status.textContent = "Search is unavailable right now.";
      });
  }

  // Sync the address bar's ?q (so the result view is shareable/reloadable) and run
  // the search. Shared by the form submit and the clickable "Did you mean …?" hint.
  function syncUrlAndRun(raw) {
    try {
      var u = new URL(window.location.href);
      var q = (raw || "").trim();
      if (q) u.searchParams.set("q", q);
      else u.searchParams.delete("q");
      window.history.replaceState(null, "", u);
    } catch (err) {
      /* history unavailable — non-fatal */
    }
    runSearch(raw);
  }

  // SUBMIT only: Enter or the Search button. No keystroke listener exists, so
  // typing never fires a search or any /pagefind/ fetch.
  form.addEventListener("submit", function (e) {
    e.preventDefault();
    syncUrlAndRun(input.value);
  });

  // ?q= handoff from the header search form: prefill the input and run ONE
  // search on load. That is a submitted query, so it is allowed to fetch.
  var initial = new URLSearchParams(window.location.search).get("q");
  if (initial) {
    initial = initial.trim();
    if (initial) {
      input.value = initial;
      runSearch(initial);
    }
  }
})();
