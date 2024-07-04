---
title: Converting PDF Coloring Pages
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
changelog:
  - date: 2023-03-23
    text: "Initial creation"
---

## Required Program
{{< back_to_top >}}

If you have access to `imagemagick` you can quickly convert a PDF coloring page(s) to grayscale PNG using the below procedure and notes.

{{< end_section >}}

## Notes
{{< back_to_top >}}

- The `pdfimages` will get you a dpi listing for each page in the PDF that has an image, use that value instead of `300` in the below, **if** it is present.
- The `-type Grayscale` parameter can be removed if you need color output.

{{< end_section >}}

## Conversion
{{< back_to_top >}}

1. Install `imagemagick`
1. `pdfimages -list shipspage1.pdf`
1. ``for file in `ls *.pdf`; do convert -density 300 -type Grayscale ${file} ${file}.png; done``

{{< end_section >}}

## External Resources
{{< back_to_top >}}

- <https://stackoverflow.com/questions/50006770/how-to-get-dpi-of-a-pdf-file>
- <https://jdhao.github.io/2019/11/20/convert_pdf_to_image_imagemagick/>
- <https://stackoverflow.com/questions/2869908/convert-pdf-to-png-using-imagemagick>
- <https://legacy.imagemagick.org/discourse-server/viewtopic.php?t=11279>

{{< end_section >}}
