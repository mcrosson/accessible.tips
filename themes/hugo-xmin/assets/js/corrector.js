// corrector.js — SEARCH STEP 3: query-side typo corrector (SUGGEST-ONLY).
//
// A pure suggestion layer for the /search/ page. It NEVER touches the query that
// Pagefind receives and NEVER auto-corrects: the typed query always runs against
// Pagefind unchanged, and this module only computes an optional "Did you mean …?"
// hint. search-page.js renders that hint and, on click, rewrites the box + re-runs.
//
// How it decides (plan-search.md §Architecture-3 "Resolution / tiebreak rule"):
//   - Tokenize the query on whitespace; correct each token INDEPENDENTLY, then
//     offer the recombined phrase (one real term per token).
//   - Per token: deburr-fold + lowercase. Skip tokens shorter than MIN_TOKEN_LEN.
//     If the folded token is already in the vocabulary → no suggestion for it
//     (so real indexed terms, incl. injected regional variants like courgette /
//     capsicum, are never flagged as typos).
//   - Otherwise find vocabulary terms within MAX_DISTANCE (Damerau–Levenshtein on
//     the folded forms); pick the SMALLEST distance, break ties by HIGHEST document
//     frequency, then shortest term, then lexicographic (fully deterministic).
//   - If no token changed (or the recombined phrase equals the query) → no hint.
//
// The vocabulary is the build-time /search-vocab.json asset (term -> document
// frequency), built from the same indexed surface + injected equivalence members
// as the index (so it always tracks the live corpus). Frequency is used ONLY as a
// tiebreak.
//
// Thresholds (MAX_DISTANCE / MIN_TOKEN_LEN) are v1 defaults picked from a corpus
// analysis.
// D=2 is deliberate so double-typos like "brocolli"→"broccoli" (edit distance 2)
// are caught, matching the plan's cited example; MIN_TOKEN_LEN=5 keeps D=2 from
// reaching a third of the vocabulary on very short tokens.
import levenshtein from "./vendor/damerau-levenshtein.js";
import deburr from "./vendor/lodash.deburr.js";

var MAX_DISTANCE = 2;
var MIN_TOKEN_LEN = 4;

// Fold a raw query token to its comparison form: strip diacritics + lowercase.
// (The vocabulary was produced by the shared normalizer, which is ASCII/lowercase;
// deburr brings an accented query token into the same alphabet, e.g. "jalapeño".)
function fold(tok) {
  return deburr(String(tok)).toLowerCase();
}

// Resolve ONE folded token to its best in-vocabulary correction, or null.
function correctToken(tok, vocab) {
  var bestTerm = null;
  var bestDist = MAX_DISTANCE + 1;
  var bestDf = -1;
  for (var term in vocab) {
    if (!Object.prototype.hasOwnProperty.call(vocab, term)) continue;
    // Cheap length prune: DL distance is at least the length difference.
    if (Math.abs(term.length - tok.length) > MAX_DISTANCE) continue;
    var d = levenshtein(tok, term).steps;
    if (d > MAX_DISTANCE) continue;
    var df = vocab[term];
    var better =
      d < bestDist ||
      (d === bestDist && df > bestDf) ||
      (d === bestDist && df === bestDf && term.length < bestTerm.length) ||
      (d === bestDist &&
        df === bestDf &&
        term.length === bestTerm.length &&
        term < bestTerm);
    if (better) {
      bestDist = d;
      bestDf = df;
      bestTerm = term;
    }
  }
  return bestTerm;
}

// Given a raw query string and the vocab map (term -> df), return a suggestion
// { text: "<recombined corrected phrase>" } or null when nothing should be shown.
export function suggest(query, vocab) {
  if (!vocab) return null;
  var rawTokens = String(query).split(/\s+/).filter(Boolean);
  if (!rawTokens.length) return null;

  var out = rawTokens.slice();
  var changed = false;
  for (var i = 0; i < rawTokens.length; i++) {
    var folded = fold(rawTokens[i]);
    if (folded.length < MIN_TOKEN_LEN) continue;
    if (Object.prototype.hasOwnProperty.call(vocab, folded)) continue; // known term
    var corrected = correctToken(folded, vocab);
    if (corrected && corrected !== folded) {
      out[i] = corrected;
      changed = true;
    }
  }
  if (!changed) return null;

  var text = out.join(" ");
  // Never offer a "correction" that is really the same query back.
  if (fold(text) === fold(query)) return null;
  return { text: text };
}
