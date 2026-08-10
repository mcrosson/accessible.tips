---
title: "_ Test _"
authors:
  - KemoNine
date: 2024-01-01
toc: false
draft: true
categories:
  - anecdote
tags:
  - anecdote
changelog:
  - date: 2024-01-01
    text: Initial creation
---

This is a test page for the `anecdotes` section. It exercises the WARNING banner (required by the `anecdote` category) and the personal-narrative posture.

A short personal narrative. The page renders the warning at the top because of the `anecdote` category.

## What this section tests

A multi-paragraph personal story. The page should render the `anecdote-meta` warning at the top, with the rest of the content flowing naturally below.

- A bulleted list.
- Inline code like `something`.
- A [link to the home page](/).

A second paragraph continues the narrative.

### Sub-experience

A `###` sub-section for nested content.

{{< end_section >}}

## A code snippet

Sometimes anecdotes include technical bits. Here's a quick example:

```bash
echo "Hello from an anecdote"
```



## Admonition color buckets

> [!QUOTE]
> Neutral bucket (site teal). Shared by: quote, code.

> [!NOTE]
> Info bucket (blue). Shared by: note, info, abstract, memo, notify, example, question, conclusion.

> [!TIP]
> Tip bucket (green). Shared by: tip, success, idea, experiment, goal, task.

> [!IMPORTANT]
> Important bucket (purple). Only: important.

> [!WARNING]
> Warning bucket (amber). Shared by: warning, caution.

> [!DANGER]
> Danger bucket (red). Shared by: danger, error.

{{< end_section >}}
