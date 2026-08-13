---
name: orientation
description: Author or refresh this repo's orientation brief at `.agents/orientation.md` — a single short document (validated-at + authored-by headers, path-only anchors, ~1,500-token target, 2,500-token ceiling) capturing the durable, load-bearing facts and judgment that let a coding agent become productive here fast. Use when asked to write, generate, or refresh the orientation file. This workspace skill shadows the global orientation skill to target this project's path.
---

# Orientation

You are authoring or refreshing this repo's **orientation file** at
`.agents/orientation.md`. Explore the repo, then write **one** orientation
document. There is no follow-up task.

## Target & relationship to AGENTS.md

- **Target path:** `.agents/orientation.md` (this project's convention). Write
  the finished file directly there.
- **Complementarity:** `AGENTS.md` at the repo root is the routing layer
  (read-first pointers, stack pins, build/serve, skills, conventions). The
  orientation file is the **detailed map** — durable facts and judgment,
  path-anchored, differential. Do not duplicate `AGENTS.md`'s routing; stay the
  detailed differential brief.
- **Refresh-in-place:** the file already exists. Refreshing means preserve the
  shape and the `[anchor:]` set, update content as the repo evolves, and bump the
  headers (below). Treat it as an update to the existing file, not a
  first-authoring — do not blank and rewrite it from scratch unless asked.

## What an orientation file is for

A short brief that lets a capable coding agent become productive in this repo
*fast* — the durable, load-bearing facts and judgment that are NOT obvious from a
quick look and NOT cheaply rediscovered every session. It is not a tutorial, not
an API dump, not a file-by-file tour.

## Hard constraints

- **One *final* file.** The finished orientation goes to `.agents/orientation.md`
  — that write is the only one that matters. Draft and measure freely in a
  scratch file under `/tmp` first (see *How to work*); write the real file once,
  at the end.
- **Length: aim for ~1,500 tokens; 2,500 is the hard ceiling.** Treat 1,500 as
  the target you draft toward, not a gate to chase. **"Done" rule, to avoid a
  trim loop: if the draft is at or under 2,500 tokens, it is acceptable — write
  it and stop.** Only revise for length when you are *over 2,500*; once a
  revision brings it under the ceiling, stop revising and write. Do not loop
  re-trimming to approach 1,500 — a few hundred tokens over target is fine. (More
  than one trim pass is OK; what is not OK is repeatedly trimming-then-rechecking
  trying to hit a number.) If you are far over 2,500, you are restating what the
  repo already encodes — cut that, not detail. **Do all of this trimming against
  the `/tmp` scratch draft, never the real file** — the real file is written
  once, at the end.
- **Differential, not duplicative.** Point to where the repo already encodes a
  fact (path/file/symbol) instead of restating it. Spell a fact out in full *only*
  when nothing in the repo captures it (e.g. an unwritten gotcha, a non-obvious
  invariant, the reason a thing is the way it is).
- **Stable facts + judgment only.** Architecture and module boundaries, the core
  control flow, key invariants, sharp edges / footguns, the conventions a
  newcomer would violate. Skip anything churny or trivially greppable.

## How to work

1. Explore with the read-only tools available to you (`read`, `grep`, `glob`,
   `ls`, or their equivalents) and `bash`.
2. Get the repo's HEAD commit sha **once**: run `git rev-parse HEAD` via bash.
3. **Draft to scratch:** write your candidate to `/tmp/orientation-draft.md` and
   revise it there. Do *all* your drafting and length iteration in the scratch
   file.
4. **Measure on scratch:** read the scratch file to estimate its length
   (~4 characters ≈ 1 token, so the 2,500-token ceiling ≈ ~10 KB, the ~1,500
   target ≈ ~6 KB). Trim *in the scratch file* until it is within limits (per
   the length rule above).
5. **Finalize once:** only when the scratch draft is within limits, write its
   final contents a single time to `.agents/orientation.md`. Never write the real
   file repeatedly while trimming.

## Required shape of the file

- A header line `validated-at: <sha>` using the sha from step 2. If the sha
  lookup returns an empty result (not a git repo), **omit this line entirely** —
  do not invent one.
- A header line `authored-by: <model-id>` — a sibling of `validated-at:` (which
  keeps its own semantics untouched), recording which model authored the file:
  - If a model id was passed as this skill's argument, use it **verbatim**.
  - Otherwise, state the model you are. Family-level identification is the
    minimum (`claude`, `glm`, `qwen`, `kimi`, `minimax`, ...); use a finer
    provider/model id (e.g. `opencode-go/minimax-m3`) only when you actually know
    it. If you are unsure what model you are, ask the user.
  - **Never block on resolving the id** — family level is always acceptable.
- Each substantive claim that is tied to specific code carries a **path-only**
  anchor, e.g. `[anchor: themes/hugo-xmin/layouts/single.html, config.toml]` —
  paths only, no line numbers, no per-file commits.
- Otherwise use whatever clear prose/structure serves the reader. Lead with what
  matters.

Write tightly. The value is in what you choose to leave out.
