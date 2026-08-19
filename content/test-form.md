---
title: Test Form
authors:
  - KemoNine
date: 2026-08-18
draft: true
changelog:
  - date: 2026-08-18
    text: "Initial creation — Netlify Forms test page"
---

A standing test bed for the Netlify Forms contribution-submission experiment.
This page is a draft: it never renders in production builds, only on the
`forms-test` branch deploy (see the notes below).

<form name="contribution-test" method="POST" data-netlify="true" netlify-honeypot="bot-field" action="/form-thanks/>
  <p class="u-visually-hidden" aria-hidden="true">
    <label>Leave this field empty: <input name="bot-field" tabindex="-1" /></label>
  </p>
  <p>
    <label for="tf-title">Title: <input id="tf-title" type="text" name="title" /></label>
  </p>
  <p>
    <label for="tf-email">Email (optional): <input id="tf-email" type="email" name="email" /></label>
  </p>
  <p>
    <label for="tf-body">Message: <textarea id="tf-body" name="body"></textarea></label>
  </p>
  <p><button type="submit">Send</button></p>
</form>

> [!INFO]
> **Testing this form live** (complete the one-time Netlify setup in the note
> below first):
>
> 1. `git checkout -b forms-test`
> 2. `git push -u origin forms-test`
> 3. Open `https://forms-test--<site-subdomain>.netlify.app/test-form/` and
>    submit. Submissions appear in the Netlify UI under Forms →
>    `contribution-test`.
> 4. To retest after changes: `git push origin forms-test`
> 5. Teardown: `git push origin --delete forms-test`, then locally
>    `git checkout main && git branch -d forms-test`

> [!MEMO]
> **One-time Netlify setup (UI only):**
>
> - Enable form detection: **Forms → Usage and configuration → Form
>   detection → Enable form detection**.
> - Add the branch: **Project configuration → Build & deploy → Continuous
>   Deployment → Branches and deploy contexts**, set `forms-test` as a branch
>   deploy branch.
> - Optional: **Project configuration → Notifications → Form submission
>   notifications**, add an email notification to watch submissions arrive.
>
> Anti-spam needs no setup: Akismet filters every submission automatically,
> and the form above carries a hidden honeypot field. Submissions from the
> test branch land in the same Forms inbox as production forms and count
> against the free plan's monthly submission limit — delete test entries when
> done.
