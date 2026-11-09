// A5 discbound LINED-PAGE DECK — one sheet, printed on both sides.
//   front page: punch LEFT  (wide disc clearance on the left)
//   back page:  punch RIGHT (wide disc clearance on the right)
// Each side: a 10mm ghost-dot header band (draw-your-own), a 2mm gap,
// then 7mm ruled lines. Rules = luma 200; header dots = luma 220.

#set page(width: 148mm, height: 210mm, margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm))
#set text(font: "DejaVu Sans", size: 3.4mm, lang: "en")

#show link: set text(fill: blue)
#show outline.entry: set text(fill: blue)

// ---------------------------------------------------------------------------
// Geometry — named constants; no hand-tuned magic numbers in the page layouts.
// Side margins come from the leading/trailing pages of the two existing decks
// (minimum where they disagree). The top figure is the printer's dead zone.
// ---------------------------------------------------------------------------
#let page-w = 148mm
#let page-h = 210mm

#let margin-punch = 15mm   // disc-clearance side (monthly 18 / weekly 15 -> 15)
#let margin-plain = 10mm   // non-punch side (both files 10)
#let margin-top = 7mm      // page margin: printer dead zone at the top
#let dot-first-y = 8mm     // first header-dot row, measured from the sheet top
#let margin-bottom = 7mm   // monthly frame bottom inset (only explicit value present)

#let rule-pitch = 7mm
#let rule-stroke = (thickness: 0.25mm, paint: luma(200))

#let dot-pitch = 5mm
#let dot-radius = 0.25mm
#let dot-fill = luma(220)
#let header-rows = 3                 // 3 dot rows = 2 cells = 10mm band
#let header-height = (header-rows - 1) * dot-pitch
#let header-gap = 2mm                // gap between bottom dot row and first rule
#let header-dot = circle(radius: dot-radius, fill: dot-fill)

#let hair = (thickness: 0.25mm, paint: black)   // instruction chrome only

// ---------------------------------------------------------------------------
// Printable side layouts.
// ---------------------------------------------------------------------------
#let header-grid(x0, x1, y0) = {
  let dot-x0 = x0 + dot-pitch / 2
  let cols = calc.floor((x1 - x0 - dot-pitch) / dot-pitch) + 1
  [
    #for i in range(cols) [
      #for j in range(header-rows) [
        #place(top + left, dx: dot-x0 + i * dot-pitch, dy: y0 + j * dot-pitch, header-dot)
      ]
    ]
  ]
}

#let ruled-lines(x0, x1, y0) = {
  let last-y = page-h - margin-bottom
  let n = calc.floor((last-y - y0) / rule-pitch) + 1
  [
    #for i in range(n) [
      #place(top + left, dx: x0, dy: y0 + i * rule-pitch,
        line(length: x1 - x0, stroke: rule-stroke))
    ]
  ]
}

#let lined-side(x0, x1) = [
  #header-grid(x0, x1, dot-first-y)
  #ruled-lines(x0, x1, dot-first-y + header-height + header-gap)
]

#let lined-front() = lined-side(margin-punch, page-w - margin-plain)
#let lined-back() = lined-side(margin-plain, page-w - margin-punch)

// ---------------------------------------------------------------------------
// Screen-only instructions.
// ---------------------------------------------------------------------------
#set page(margin: (x: 13mm, y: 12mm))
#set heading(numbering: "1.")

#let native-version = datetime.today().display("[year]-[month]-[day]")
#let version-stamp = if "version" in sys.inputs { native-version + " " + sys.inputs.at("version") } else { native-version }

#let instr-header() = [
  #grid(columns: (1fr, 1fr), align(left)[_Instructions_], align(right)[_Do not print this page_])
  #line(length: 100%, stroke: hair)
  #v(3mm)
]

#let instr-footer() = place(bottom + left, dx: 0mm, dy: -7mm, block(width: 122mm, inset: 0mm)[
  #line(length: 100%, stroke: hair)
  #v(1.5mm)
  #grid(columns: (1fr, 1fr), [#text(size: 2.8mm)[Version:]#text(size: 2.8mm, font: "DejaVu Sans Mono")[#(" " + version-stamp)]], align(right)[#text(size: 2.8mm)[#context counter(page).display()]])
])

#let sheet-pages(l) = context {
  let loc = query(l).first().location()
  let n = loc.page()
  link(l)[#(n)–#(n + 1)]
}

#align(center + horizon)[
  #block[
    #text(size: 7mm)[Lined Pages]
    #v(6mm)
    #text(size: 4mm)[_How to print and use_]
  ]
]

#pagebreak()

#outline(title: "Contents")

#pagebreak()

#instr-footer()
#instr-header()
#heading(level: 1)[What you are printing] <what-you-are-printing>

This file holds undated lined-page templates. Print as many sheets as you need. Each insert is one sheet, printed on both sides.

- Both sides have 7mm ruled lines.
- The front page is punched on the left; the back page is punched on the right.
- Across the top of each side, above the rules, is a light dot grid.

The top band is a dot grid for drawing your own date or title boxes if you want them. You can also ignore it entirely — the dots are faint enough to leave blank and write over.

#pagebreak()
#instr-footer()
#instr-header()
#heading(level: 1)[What and how many to print] <what-and-how-many-to-print>

There is one piece, and every sheet is the same, so there is nothing to sort.

#table(
  columns: (auto, auto, auto),
  [_piece_], [_pages_], [_print this many_],
  [#link(<sheet>)[Lined sheet]], [#sheet-pages(<sheet>)], [one per insert],
)

#pagebreak()
#instr-footer()
#instr-header()
#heading(level: 1)[Set up your printer] <printer-setup>

Open the print window and set these:

1. *Paper size:* A5. If your printer has no A5 preset, set a custom size of 148 × 210 mm (5.83 × 8.27 in).
2. *Scale:* 100% ("actual size"). Do not use "fit to page" — it shrinks the pages and throws off the punch holes.
3. *Pages and copies:* type the page numbers in the pages box, and the copy count in the copies box.
4. *Two-sided printing:* three ways to print both sides:
   - Automatic duplex: choose "flip on the long edge."
   - Even/odd runs: print the odd (front) pages, put the whole stack back in the tray, then print the even (back) pages.
   - By hand: print the front pages, then feed each sheet back through one at a time to print its back.

If you're not sure about a setting, print one sheet — both sides — and check it before printing the rest.

#pagebreak()
#instr-footer()
#instr-header()
#heading(level: 1)[Put the sheets together] <assembly>

Lay the notebook open with the discs in the middle. Snap each sheet onto the discs, punched edge toward the center.

There is no up or down to track — both sides are the same. Flip through when done; every sheet should sit straight.

#pagebreak()

// ---------------------------------------------------------------------------
// Printable deck — exactly one sheet (two sides).
// ---------------------------------------------------------------------------
#set page(margin: (x: 0mm, y: 0mm))

#{ lined-front() } <sheet>
#pagebreak()
#{ lined-back() }