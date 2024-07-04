---
title: How this site is hosted and managed
author: 
  - KemoNine
publishDate: 2023-03-21
lastMod: 2024-07-04
toc: true
draft: false
categories:
  - faq
tags:
  - faq
changelog:
  - date: 2024-07-04
    text: "Adjust info based on removal of Static CMS"
  - date: 2023-03-21
    text: "Initial creation"
---
## Technology Used
{{< back_to_top >}}

The technology used to build and manage this website can be distilled into just a few key concepts:

- The main website url is a domain name record purchased from and managed by NameCheap.
- We use a text editor or a web page to write content for the site. The content is just a folder with some files and sub-folders in it.
- We use GitHub (a file version control hosting service) for publishing but it is *wholly optional*. You can upload the files to our hosting provider for publishing instead of using GitHub if desired.

If you'd like more detal please see the [Tech Used FAQ page]({{< ref "faq/tech-used" >}}).

{{< end_section >}}

## Domain Name

A quick note on the domain name: we used [NameCheap](https://namecheap.com) to purchse the domain name and followed our hosting provider's instructions on how to setup the record with NameCheap.

We do not have e-mail or other services setup for the site and the domain setup was very simple and minimal.

{{< end_section >}}

## Change Management
{{< back_to_top >}}

For this website, we use [GitHub](https://github.com) for managing and tracking changes over time.

### GitHub
{{< back_to_top >}}

GitHub is a site designed for programmers by programmers and can be overwhelming. It's never obvious why people would use the site. It's because GitHub uses [git](https://git-scm.com/) behind the scenes due to `git` being a very powerful versioning tool that allows tracking changes to files and folders over time.

We can admit it: GitHub is not the most accessible site for non-programmers. We address this in the below sections.

### Why GitHub
{{< back_to_top >}}

If you're wondering why we would fight with GitHub, git and the seemingly overwhelming nature of the GitHub user interface: we desire change tracking and git (the technology behind GitHub) is the most robust tool available for change management as of this writing. We also wanted collaboration tools which GitHub provides as well.

The trick with GitHub is to ignore pretty much everything but the `Code`, `Issues` and `Edit` links.

Change tracking over time can be extremely important, especially when managing a knowledge base. GitHub allows us to have a version history of each page similar to how Wikipedia has a change history link on every page. There is a dedicated link in the `Code` zone that provides this on GitHub.

GitHub also spent time building robust tools for collaboration between contributors. Specifically the `Issues` area which allows public discussion of items related to this site. The `Issues` section is also where users can submit requests and questions to the contributors of this site.

Please see the [_ Contributing _ page]({{< ref "faq/contributing" >}}) for additional detail on how we use GitHub for collaboration.

### GitHub Quick and Fast
{{< back_to_top >}}

Once you ignore all the programmer specific tools, GitHub starts to make a lot more sense. The items that are relevant to manging this website are:

- The `repository` is the main URL on GitHub for the project
- The `Code` section is the files/folders comprising the project
- The `Issues` section is the location of any to do items that need to be addressesd
- The `Edit` link is shown on individual files so you can edit them directly in your web browser

### How GitHub Is Used
{{< back_to_top >}}

By using GitHub we are able to give our contributors and users the following tools and more:

- The `git` tool for offline development with a text editor
- The GitHub web interface for browser based text editing
- A web based editor that's tuned to facilitate editing this website with a more graphical user interface
- A way to track issues, questions and submissions related to the site with a focus on collaboration as a group
- A single source of truth for the files that represent the live website

{{< end_section >}}

## Content Managment
{{< back_to_top >}}

This site is primarily developed using a text editor and file manager with git (KemoNine's standard workflow).

Each page of the site is a simple text file containing [markdown](https://en.wikipedia.org/wiki/Markdown) and can be edited with your preferred text editor.

This site also has a web based content editor setup. It is very trim in terms of features and can be somewhat fiddly to use on a phone. Long-term this area of the site will be looked at closer. For now it's not supported for editing this site.

We even tested editing the contents of this website via the main GitHub website. It works, it's browser based and a really good option for those that prefer a simple web based text editor environment.

For images and similar content, each of the methods of editing will allow you to add or upload files for use on individual pages.

Please see the [_ Contributing _ page]({{< ref "faq/contributing" >}}) for additional detail on content management for this site.

{{< end_section >}}

## Publishing (Hosting)
{{< back_to_top >}}

For publishing and hosting we use [Netlify](https://netlify.com). Specifically we are using a free plan with the `Identity` service (it's free) for our web editor and `Git Gateway` service (it's free) for deployments and updates of the website.

Netlify has two primary deployment and hosting options available for free:

- Uploading zip file containing a static website which they will then host
- Automatically update and deploy your website from a GitHub repo

Both approaches have limits imposed. However, this site and the theme used are very small and not resource intense. We should be able to run this site, for free, for a very long period of time.

We chose to use the GitHub integration via the `Git Gateway` service as it allows us to better collaborate as contributors and have a single source of truth for the contents of the website that are publicly available for download.

The setup was well documented online and whenever a change gets added to GitHub, Netlify will automatically update the website with the changes. It's a very hands off, non thinky process outside of the initial setup which was simply pushing one or two buttons in the main Netlify management console.

The manual file upload is a good option if you want to skip the GitHub integration or don't want to introduce the complexities of git or GitHub to your own setup. We used this deployment model when building a minimum viable website to ensure Netlify was a usable option for us and others who may want to use our approach for themselves.

{{< end_section >}}

## Maintenance

To maintain the website over time we simply use GitHub and respond to any submitted requests that surface. Editing existing pages is simply editing some text files and adding new pages is just creating a new text file.

Updating and managing the website is a very low brain activity outside of the actual writing. The content writing and copy editing is the most thoughtful part of the maintenance of the site.

All the technological amenities are very hands off and present to help with collaboration, change tracking and copy editing while staying out of the way.

The only downside we have found so far is the GitHub interface overwhelming users and contributors initially. Hopefully the [_ Contributing _ page]({{< ref "faq/contributing" >}}) can help bridge this gap for our users and collaborators.

{{< end_section >}}
