---
title: Convert Photo to Coloring Page
author: 
  - KemoNine
publishDate: 2023-03-23
lastMod: 2023-03-23
toc: true
draft: false
categories:
  - tips
  - art
tags:
  - coloring
  - krita
---

## Changelog
{{< changelog >}}
{{< change 2023-03-23 "Initial creation" >}}
{{< /changelog >}}

{{< end_section >}}

## Sounds Cool, Is Tricky
{{< back_to_top >}}

Before getting into how to convert a photo into a coloring page, I'd like to point out a fundamental concern: this is _not_ easy and a mild PITA. It also deserves some manual cleanup to get best results. I recommend doing this only if you have time to try the process and focus on some of the subtleties while also converting a ton of photos.

Like most forms of art, this one takes some practice to get desired results. I got disheartened early on but after running the process on tens of images I started getting a feel for what source images worked for conversion and as a more 'realistic' coloring page.

{{< end_section >}}

## Example Gallery
{{< back_to_top >}}

If you'd like to see a number of my photographs run through conversion to coloring page, I've published a number of pages at <https://www.kemonine.photography/Coloring-Pages/n-cRk9Fj>

{{< end_section >}}

## Critical Note
{{< back_to_top >}}

The following processes and procedures are a way to run the photo to coloring page conversion with [Krita](https://krita.org/). That said, the process should be generally the same in other image editing programs.

{{< end_section >}}


## TLDR
{{< back_to_top >}}

This is the cheat sheet check list I use when converting pages. I recommend skipping this section for the full procedure in the following section(s) if you are new to this process.

1. Open image in Krita
2. Duplicate layer (ctrl - J)
3. Desaturate (average) (ctrl - shift - U)
4. Duplicate (ctrl - J)
5. Invert (ctrl - I)
6. Color dodge for layers
7. Gaussian blur
8. Levels (ctrl - L)
9. Merge layers (ctrl - E)

{{< end_section >}}

## Conversion Process
{{< back_to_top >}}

When I went digging for information I found plenty of guides for image editors and drawing apps that were _not_ Krita. The guides I found were for very common photo editing programs and apps but not for Krita. Thankfully every guide had a pretty consistent 'process' for converting photos to coloring pages.

As I was working through the info I did manage to find one video on performing the conversion in Krita. The video is up on [YouTube here](https://www.youtube.com/watch?v=lgj0WPlwMGI) and breaks down the process. I watched it on mute so I cannot speak to the commentary but the video walk through shows what you need to do within Krita quite nicely.

Rather than force folk, or my future self, to watch an almost 8 minute video that could be taken down, I've replicated the process the artist used as an ordered list below. The example gallery linked above used this conversion process.

1. Open photo as new image
2. Duplicate layer
3. Select new layer
4. Filter -&gt; Adjust -&gt; Desaturate
    - Destauration method: average
5. Duplicate desaturated layer
6. Select new layer
7. Filter -&gt; Adjust -&gt; Invert
8. Layers docker -&gt; Change from 'Normal' to 'Color Dodge'
9. Filter -&gt; Blur -&gt; Gaussian blur...
    - Increase both sliders until it looks reasonable as a coloring page
10. Filter -&gt; Adjust -&gt; Levels
    - Adjust top slider middle arrow handle
    - Adjust bottom slider right arrow handle
    - Adjust remaining sliders, if desired,  until it looks like a reasonable coloring page
11. Group all but background layer in layers docker
12. Duplicate group
13. Name original group 'archives', lock, hide
14. Merge the copied group layers together
15. Rename the merged group to something meaningful
16. Select group
17. Filter -&gt; Colors -&gt; Color to alpha
    - Select white from color picker / sampler if not already selected
18. Use pencil brush + eraser to cleanup image
    - Optional

{{< back_to_top >}}
