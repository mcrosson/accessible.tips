---
title: _ Contributing _
author: 
  - KemoNine
publishDate: 2023-03-20
lastMod: 2023-03-21
toc: true
draft: false
categories:
  - faq
tags:
  - faq
---

## Changelog
{{< changelog >}}
{{< change 2023-03-23 "Add info on anecdotes" >}}
{{< change 2023-03-22 "Fix typo" >}}
{{< change 2023-03-21 "Remove source code section as it's spurrious info presently" >}}
{{< change 2023-03-21 "Re-order sections to be more similar to the order of the initial sections of content pages" >}}
{{< change 2023-03-21 "Add detail on submitting content updates" >}}
{{< change 2023-03-21 "Add missing jump links" >}}
{{< change 2023-03-21 "Re-order some sections for better flow and clarity" >}}
{{< change 2023-03-21 "Add note about source code" >}}
{{< change 2023-03-21 "Add additional info on GitHub and how it's used for contributions" >}}
{{< change 2023-03-21 "Add note that change log is exempt from 2nd level heading 'back to top'" >}}
{{< change 2023-03-20 "Initial creation" >}}
{{< /changelog >}}

{{< end_section >}}

## Submitting Contributions
{{< back_to_top >}}

We welcome contributions to the site and ask that you use our [GitHub repository](https://github.com/mcrosson/accessible.tips) for any contributions.

{{< back_to_top >}}

### Issues and Questions
{{< back_to_top >}}

If you run into any problems with the website or have specific questions, please use the `Issues` section of our GitHub repository [here](https://github.com/mcrosson/accessible.tips/issues).

We politely ask you review the open issues for exiting items that overlap. Please comment on an existing issue that is relevant prior to creating a new issue.

If there is not an existing issue for your need, please create a new issue. We politely ask you provide us as much detail as possible so we can hopefully respond without having to play a game of 20 questions.

{{< back_to_top >}}

### Website Content Updates
{{< back_to_top >}}

We welcome updates to the contents of this website. Please use the `Issues` section [here](https://github.com/mcrosson/accessible.tips/issues) to submit any change requests for the site.

Changes can be:

- accessibility concerns, issues, needs, etc
- simple edits with info on what changes to make (ie. spelling and grammer mistakes, bad sentence structure)
- full markdown files that are updates to existing pages
- asking for a tag to be added to a page
- asking to adjust categorization of a page or multiple pages
- various forms of the above
- pull requests (see below for an important note)
- more

If you'd like to submit full markdown files or larger edits, please review the contents of this page prior to submission. We've outlined some details on how we manage the content of this site below and ask our contributors follow these guidelines when submitting markdown changes.

{{< back_to_top >}}

### Anonymous Anecdotes
{{< back_to_top >}}

If you'd like to submit an anecdote to the site anonymously, please get in touch via a burner account. We can work with you to get your anecdote published on the site via a ghost writer.

{{< back_to_top >}}

### Pull Requests

If you've used GitHub and git in the past, we will accept `Pull Requests` for updates. However, we will *not* describe the process here as it is an avanced topic we are not supporting directly. Consider `Pull Requests` a convenience that could go away in the future due to their inherent complexity.

{{< back_to_top >}}

### And More
{{< back_to_top >}}

Any other requests we ask be submitted as GitHub `Issues` [here](https://github.com/mcrosson/accessible.tips/issues).

{{< end_section >}}

## File and Folder Organization
{{< back_to_top >}}

Files and folders are setup with the following overall layout.

``` txt
/content/
         tips/
              category-topic-1.md
              category-topic-2.md
              category-topic-3/index.md
         posts/yyyy-MM-dd-title.md
               yyyy-MM-dd-title/index.md
         faq/title-1.md
             title-2/index.md
         anecdotes/[author]-[title]-[nnnn].md
                   [author]-[title]-[nnnn]/index.md
```

{{< back_to_top >}}

### Tips Directory
{{< back_to_top >}}

The `tips` directory contains the main knowledge base data. Each file represents a different page on the site and they are named using the format `[category]-[title].md` with `[category]` being the category set in the page metadata and `[title]` being the title set in the page metadata.

This allows us to easily cross reference information within a category (see [here]({{< ref "#cross-references" >}}) for how to cross reference pages) and keep the topic file names from colliding if there is any overlap between categories.

This rigid, tree'd structure is imposed by Hugo and we have adapted our file and folder organization to work with Hugo instead of against it.

This is also why we can have *only one* primary category for content currently.

We will also use `Page Bundles` ([Hugo docs](https://gohugo.io/content-management/page-bundles/)) for content that includes non-textual content or download links. `Page Bundles` are just folders with an `index.md` file and related assets. The `index.md` file is the main content and any files stored next to `index.md` can be easily referenced directly from `index.md`. This is particularly helpful for managing image assets and keeping them organized.

{{< back_to_top >}}

### Posts Directory
{{< back_to_top >}}

In this layout the `posts` directory contains all of the blog posts with dated file names using the given pattern. It's a pretty standard and simple folder organization scheme.

We will also use `Page Bundles` ([Hugo docs](https://gohugo.io/content-management/page-bundles/)) for content that includes non-textual content or download links. `Page Bundles` are just folders with an `index.md` file and related assets. The `index.md` file is the main content and any files stored next to `index.md` can be easily referenced directly from `index.md`. This is particularly helpful for managing image assets and keeping them organized.

{{< back_to_top >}}

### FAQ Directory
{{< back_to_top >}}

In this layout the `faq` directory contains all of the FAQ pages with file names matching the page title. It's a pretty standard and simple folder organization scheme.

We will also use `Page Bundles` ([Hugo docs](https://gohugo.io/content-management/page-bundles/)) for content that includes non-textual content or download links. `Page Bundles` are just folders with an `index.md` file and related assets. The `index.md` file is the main content and any files stored next to `index.md` can be easily referenced directly from `index.md`. This is particularly helpful for managing image assets and keeping them organized.

### Anecdotes Directory
{{< back_to_top >}}

In this layout the `anecdotes` directory contains all of the Anecdote pages with `[author]` being the name of the first author, `[title]` being the title of the page and `[nnnn]` being a left padded 4 digit number that counts up from 1. This numbered serial allows us to avoid file name collisions while keeping the file layout a bit easier to manage.

We will also use `Page Bundles` ([Hugo docs](https://gohugo.io/content-management/page-bundles/)) for content that includes non-textual content or download links. `Page Bundles` are just folders with an `index.md` file and related assets. The `index.md` file is the main content and any files stored next to `index.md` can be easily referenced directly from `index.md`. This is particularly helpful for managing image assets and keeping them organized.

{{< end_section >}}

## Authorship
{{< back_to_top >}}

Fell free set your preferred name as the author, we like to attribute our authors. If you prefer to remain anonymous, please set authorship to `Anonymous`.

Please note: Authorship metadata will be publicly visible.

{{< end_section >}}

## Last Modified Date
{{< back_to_top >}}

When editing an exiting post, we require you update the `lastMod` date in the front matter of all content pages. The date you use here should match the date used on the `Changelog` entry. See [Changelog Entries]({{< ref "#changelog-entries" >}}) for more info on `Changelog` dates.

{{< end_section >}}

## Using Categories
{{< back_to_top >}}

We have tried to keep categories to a small, very high level set and we would like to keep this list focused and small presently.

That said: everyone conceptualizes references between information differently and we are open to working with users and authors to come up with a general list over time for the site.

We'd also like to point out the information contained on the site assumes just **one** category per content page. This is due to how `hugo` (our underlying technology for creating this site) organizes information as a set of folders. Due to this limitation we ask that contributors ensure that content has either `blog` or `tips` category set and only *one* other *primary* category.

If you'd like to get a new category added, please create a new issue [here](https://github.com/mcrosson/accessible.tips/issues/new) with the category, a brief description and any existing content page(s) you feel should be included in the category.

Please note: the submitted content page(s) do *not* have to be exhaustive or all inclusive.

{{< end_section >}}

## Using Tags
{{< back_to_top >}}

We have tried to keep tags to a well curated list that help tie many different `Tips` togther. We have also tried to ensure tags are relevant to the category specified on each `Tip`.

Given how many words have large numbers of synonyms (alternatives), we have tried to stick to single tags for single concepts.

Please review the main tag list [here](/tags) (warning: this list can be large and take awhile to load) prior to creating a new tag. If one is missing, please add it.

Long term we hope to build a tag glossary to enhance discovery, search and synonym management. If/when this glossary is created, we will update our guidelines related to tagging.

### Conflicting Access Needs

If you are working on a tip that conflicts with any access needs, the tip *must* be tagged as conflicting with the form `conflicting-need-[specific_need]` where `specific_need` is a need such as `low-vision`.

{{< end_section >}}

## Tag and Category Extra Considerations
{{< back_to_top >}}

## Anecdotes

You **must** only apply the `anecdote` tag and category to anecdote pages. These pages are personal accounts of living with disability and can be very triggering for readers.

We have setup the site to include a warning at the top of all anecdote pages and it *requires* the `anecdote` category be applied to these pages.

Submissions not tagging or categorizing anecdotes properly will *not* be approved for inclusion on this site.

### FAQ

For the `FAQ` section of the site we ask that you *only tag* entries with the `faq` tag. This allows the FAQ pages to be related to each other but still remain independent of the main site content. Adding additional tags will tie the FAQ pages into other content which is exactly what we want to avoid.

### News

For the `News` section of the site we ask that you do **NOT** tag entries. The news pages are meant to be minimal and kept independent of the main site information. Adding a tag will tie the news pages into other content which is exactly what we want to avoid.

{{< end_section >}}

## Changelog Entries
{{< back_to_top >}}

This site uses GitHub for tracking the changes to the content used to generate the site. Please consider GitHub the source of truth for the data contained on this website.

However, that does *not* do our readers any good and we require all content pages have a `Changelog` section at the top. We require at least an entry for `Initial creation` as well.

If you are editing an existing page, we require that you add a dated entry with a summary of the changes made.

If you are not sure what date to use, please use the first date you worked on the changes you plan to submit for inclusion on the website.

Programmers take note: this can be a copy/paste of your git commit. However, this assumes you write meaningful commit messages. Which you do, right?

{{< end_section >}}

## Attribution and Syndication
{{< back_to_top >}}

When syndicating content we require contributors include an `Attribution` section immediately following the `Changelog` section.

We do not have a standard format for this section and leave it to the contributor to choose a format that works best for the attribution(s) needed.

{{< end_section >}}

## Style Guidelines
{{< back_to_top >}}

If submitting content or copy edits, please note the following

- Each 2nd level heading should have the <code>{{&lt; back_to_top &gt;}}</code> short code on the line following the heading
  - The `Changelog` heading is exempt from this rule as it is used for the `Back to top` and `Back to ToC` page links
- Each 3rd or higher level heading should have the <code>{{&lt; end_section &gt;}}</code> or <code>{{&lt; back_to_top &gt;}}</code> shortcode present at the end of the section. Use your best judgement on which of these two shortcodes to use
- If there are any sections beyond `Changelog`, the table of contents must be enabled
- When naming files, categories, tags and similar: use dashes ( `-` ) for separating words. Changes using Snakes ( `_` ) or `CamelCase` will **not** be approved for inclusion

{{< end_section >}}

## Cross References
{{< back_to_top >}}

If you are cross referencing information you can use the following code.

<code>[Link Text]]({{&lt; ref "[category]-[file]" &gt;}})</code> where `[category]` is the category you defined and `[file]` is the markdown file name with the content you would like to reference.

Please use this format for cross references between content pages. It helps us better manage cross references between content pages over time.

{{< end_section >}}

## Images
{{< back_to_top>}}

When adding images to a page the page must be setup as a `Page Bundle` and the images stored in the page's bundle.

We have setup a short code that we ask authors to use for adding images. This shortcode will handle ensuring the appropriate `alt-text` is added to the image.

You can use the shortcode using the following pattern:

<code>{{&lt; figure src="[filename]" alt="[alt-text]" caption="[visible-caption]" &gt;}}</code>

Where `[filename]` is the filename, including extension, of the image file. `[alt-text]` is the `img` tag's `alt-text` attribute value. `[visible-caption]` is the text that is shown just underneath each image as a caption.

Please note: we *require* contributors include `alt-text` on all images if not using the `figure` short code.

{{< end_section >}}

## Related Pages and Anecdotes
{{< back_to_top >}}

We encourage contributors to include `Related Pages` and `Related Anecdotes` sections to cross link information on the site.

However, we know this may not be possible and will accept pages lacking these sections.

These sections should be simple bulleted lists with links to related content.
