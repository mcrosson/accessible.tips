---
title: _ Contributing _
slug: contributing
authors: 
  - KemoNine
date: 2023-03-20
toc: true
draft: false
changelog:
  - date: 2026-08-19
    text: "Cleanup to match current site setup and processes"
  - date: 2024-07-04
    text: "Adjust conventions to accommodate the changelog for each page being moved to the front matter"
  - date: 2023-03-23 
    text: "Add info on anecdotes, related pages, related anecdotes, conflicting access needs, attribution and syndication"
  - date: 2023-03-22
    text: "Fix typo"
  - date: 2023-03-21
    text: "Remove source code section as it's spurious info presently"
  - date: 2023-03-21
    text: "Re-order sections to be more similar to the order of the initial sections of content pages"
  - date: 2023-03-21
    text: "Add detail on submitting content updates"
  - date: 2023-03-21
    text: "Add missing jump links"
  - date: 2023-03-21
    text: "Re-order some sections for better flow and clarity"
  - date: 2023-03-21
    text: "Add note about source code"
  - date: 2023-03-21
    text: "Add additional info on GitHub and how it's used for contributions"
  - date: 2023-03-21
    text: "Add note that change log is exempt from 2nd level heading 'back to top'"
  - date: 2023-03-20
    text: "Initial creation"
---

## Submitting Contributions

We welcome contributions to the site and ask that you use our [GitHub repository](https://github.com/mcrosson/accessible.tips) for any contributions.


### Issues and Questions

If you run into any problems with the website or have specific questions, please use the `Issues` section of our GitHub repository [here](https://github.com/mcrosson/accessible.tips/issues).

We politely ask you review the open issues for existing items that overlap. Please comment on an existing issue that is relevant prior to creating a new issue.

If there is not an existing issue for your need, please create a new issue. We politely ask you provide us as much detail as possible so we can hopefully respond without having to play a game of 20 questions.


### Website Content Updates

We welcome updates to the contents of this website. Please use the `Issues` section [here](https://github.com/mcrosson/accessible.tips/issues) to submit any change requests for the site.

Changes can be:

- accessibility concerns, issues, needs, etc
- simple edits with info on what changes to make (ie. spelling and grammar mistakes, bad sentence structure)
- full markdown files that are updates to existing pages
- asking for a tag to be added to a page
- asking to adjust categorization of a page or multiple pages
- various forms of the above
- pull requests (see below for an important note)
- more

If you'd like to submit full markdown files or larger edits, please review the contents of this page prior to submission. We've outlined some details on how we manage the content of this site below and ask our contributors follow these guidelines when submitting markdown changes.


### Anonymous Anecdotes

If you'd like to submit an anecdote to the site anonymously, please get in touch via a burner account. We can work with you to get your anecdote published on the site via a ghost writer.


### Pull Requests

If you've used GitHub and git in the past, we will accept `Pull Requests` for updates. However, we will *not* describe the process here as it is an advanced topic we are not supporting directly. Consider `Pull Requests` a convenience that could go away in the future due to their inherent complexity.


### And More

Any other requests we ask be submitted as GitHub `Issues` [here](https://github.com/mcrosson/accessible.tips/issues).

---

## File and Folder Organization

Files and folders are setup with the following overall layout.

``` txt
/content/
         tips/
              category-topic-1/index.md
              category-topic-2/index.md
              category-topic-3/index.md
         news/yyyy-MM-dd-title/index.md
               yyyy-MM-dd-title/index.md
         faq/title-1/index.md
             title-2/index.md
         anecdotes/[author]-[title]/index.md
                   [author]-[title]/index.md
```

We use `Page Bundles` ([Hugo docs](https://gohugo.io/content-management/page-bundles/)) for all content. `Page Bundles` are just folders with an `index.md` file and related assets. The `index.md` file is the main content and any files stored next to `index.md` can be easily referenced directly from `index.md`. This is particularly helpful for managing image assets and keeping them organized.


### Tips Directory

The `tips` directory contains the main knowledge base data. Each folder + index.md file represents a different page on the site and they are named using the format `[tag]-[title]/index.md` with `[tag]` being the 'category set' in the page metadata and `[title]` being the title set in the page metadata.

This allows us to easily cross reference information within a tag (see [here]({{< ref "#cross-references" >}}) for how to cross reference pages) and keep the topic file names from colliding if there is any overlap between categories.


### News Directory

In this layout the `news` directory contains all of the news posts with dated file names using the given pattern. It's a pretty standard and simple folder organization scheme.


### FAQ Directory

In this layout the `faq` directory contains all of the FAQ pages with file names matching the page title. It's a pretty standard and simple folder organization scheme.

### Anecdotes Directory

In this layout the `anecdotes` directory contains all of the Anecdote pages with `[author]` being the name of the first author and `[title]` being the title of the page.

---

## Authorship

Feel free set your preferred name as the author, we like to attribute our authors. If you prefer to remain anonymous, please set authorship to `Anonymous`.

Please note: Authorship metadata will be publicly visible.

---

## Using Tags

Tags are used as a kind of 'category' and only for tips. These are very high level tags that are more topical than anything. This is to help facilitate filling out the related pages section of the page headers. Nothing more. Tags should only be applied to tips and be the same as the filename prefix of the tip's folder.

We do this because there are so many synonyms for words and tags are a massive overhead for upkeep long-term. Rather than try to have all the tags for all the things we've spent time ensuring the site search is robust. The site search will let you search for content and includes synonyms in the underlying setup so we can allow more flexible searches and not be forced to make a mess of the on-page content.

---

## Changelog Entries

This site uses GitHub for tracking the changes to the content used to generate the site. Please consider GitHub the source of truth for the data contained on this website.

However, that does *not* do our readers any good and we require all content pages have a `changelog` section in the front matter of each page.

If you are editing an existing page, we require that you add a dated entry with a summary of the changes made.

If you are not sure what date to use, please use the first date you worked on the changes you plan to submit for inclusion on the website.

Programmers take note: this can be a copy/paste of your git commit. However, this assumes you write meaningful commit messages. Which you do, right?

---

## Attribution and Syndication

When syndicating content we require contributors include an `Attribution` section at the top of the page.

We do not have a standard format for this section and leave it to the contributor to choose a format that works best for the attribution(s) needed.

---

## Style Guidelines

If submitting content or copy edits, please note the following

- If there are any sections beyond `Changelog`, the table of contents must be enabled
- When naming files and similar: use dashes ( `-` ) for separating words. Changes using Snakes ( `_` ) or `CamelCase` will **not** be approved for inclusion

---

## Cross References

If you are cross referencing information you can use the following code.

<code>[Link Text]({{&lt; ref "[category]-[file]" &gt;}})</code> where `[category]` is the main content folder for the page and `[file]` is the markdown file name with the content you would like to reference.

Please use this format for cross references between content pages. It helps us better manage cross references between content pages over time.

---

## Images

We have setup a short code that we ask authors to use for adding images. This shortcode will handle ensuring the appropriate `alt-text` is added to the image, generate responsive `WebP` variants for low-bandwidth delivery, and wire the image into the site's lightbox viewer.

You can use the shortcode using the following pattern:

<code>{{&lt; figure src="[filename]" alt="[alt-text]" caption="[visible-caption]" &gt;}}</code>

Where `[filename]` is the filename, including extension, of the image file. `[alt-text]` is the `img` tag's `alt-text` attribute value. `[visible-caption]` is the text that is shown just underneath each image as a caption; the `caption` parameter is optional and may contain inline HTML.

---
