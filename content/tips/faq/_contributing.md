---
title: _ Contributing _
author: KemoNine
publishDate: 2023-03-20
lastMod: 2023-03-20
toc: true
draft: false
categories:
  - tips
  - faq
tags:
  - contributing
---

## Changelog
{{< back_to_top >}}

{{< changelog >}}
{{< change 2023-03-20 "Initial creation" >}}
{{< /changelog >}}

{{< end_section >}}

## Contributing
{{< back_to_top >}}

We welcome contributions to the site and ask that you use our [GitHub repository](https://github.com/mcrosson/accessible.tips) for any contributions.

We welcome our user's feedback ; including but not limited to

- Issue submissions
- Code updates
- Website content updates
- More

{{< end_section >}}

## Style Guidelines
{{< back_to_top >}}

If submitting content or copy edits, please note the following

- Each 2nd level heading should have the <code>{{&lt; back_to_top &gt;}}</code> short code on the line following the heading
- Each 3rd or higher level heading should have the <code>{{&lt; end_section &gt;}}</code> or <code>{{&lt; back_to_top &gt;}}</code> shortcode present at the end of the section. Use your best judgement on which of these two shortcodes to use
- If there are any sections beyond `Changelog`, the table of contents must be enabled
- When naming files, categories, tags and similar: use dashes ( `-` ) for separating words. Changes using Snakes ( `_` ) or `CamelCase` will **not** be approved for inclusion

{{< end_section >}}

## Authorship

Fell free set your preferred name as the author, we like to attribute our authors. If you prefer to remain anonymous, please set authorship to `Anonymous`.

Please note: Authorship metadata will be publicly visible.

{{< end_section >}}

## Last Modified Date

When editing an exiting post, we require you update the `lastMod` date in the front matter of all content pages. The date you use here should match the date used on the `Changelog` entry. See [Changelog Entries]({{< ref "#changelog-entries" >}}) for more info on `Changelog` dates.

{{< end_section >}}

## Changelog Entries

This site uses GitHub for tracking the changes to the content used to generate the site. Please consider GitHub the source of truth for the data contained on this website.

However, that does *not* do our readers any good and we require all content pages have a `Changelog` section at the top. We require at least an entry for `Initial creation` as well.

If you are editing an existing page, we require that you add a dated entry with a summary of the changes made.

If you are not sure what date to use, please use the first date you worked on the changes you plan to submit for inclusion on the website.

Programmers take note: this can be a copy/paste of your git commit. However, this assumes you write meaningful commit messages. Which you do, right?

{{< end_section >}}

## Categories

We have tried to keep categories to a small, very high level set and we would like to keep this list focused and small presently.

That said: everyone conceptualizes references between information differently and we are open to working with users and authors to come up with a general list over time for the site.

We'd also like to point out the information contained on the site assumes just **one** category per content page. This is due to how `hugo` (our underlying technology for creating this site) organizes information as a set of folders. Due to this limitation we ask that contributors ensure that content has either `blog` or `tips` category set and only *one* other *primary* category.

If you'd like to get a new category added, please create a new issue [here](https://github.com/mcrosson/accessible.tips/issues/new) with the category, a brief description and any existing content page(s) you feel should be included in the category.

Please note: the submitted content page(s) do *not* have to be exhaustive or all inclusive.

{{< end_section >}}

## Tags

We have tried to keep tags to a well curated list that help tie many different `Tips` togther. We have also tried to ensure tags are relevant to the category specified on each `Tip`.

Given how many words have large numbers of synonyms (alternatives), we have tried to stick to single tags for single concepts.

Please review the main tag list [here](/tags) prior to creating a new tag. If one is missing, please add it.

Long term we hope to build a tag glossary to enhance discovery, search and synonym management. If/when this glossary is created, we will update our guidelines related to tagging.

{{< end_section >}}

## Cross References

If you are cross referencing information you can use the following code.

<code>[Link Text]]({{&lt; ref "[category]/[file].md" &gt;}})</code> where `[category]` is the category you defined and `[file]` is the markdown file name with the content you would like to reference.

Please use this format for cross references between content pages. It helps us better manage cross references between content pages over time.

{{< back_to_top >}}
