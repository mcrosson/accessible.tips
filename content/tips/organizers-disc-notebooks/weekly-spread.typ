// A5 discbound weekly spread — reconciled to mirror the monthly deck.
// Page 1 = Fr–Su (right page; punch LEFT, 15mm disc clearance)
// Page 2 = Mo–Th (left page; punch RIGHT, 15mm disc clearance)

#set page(width: 148mm, height: 210mm, margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm))
#set text(font: "DejaVu Sans", size: 3.4mm, lang: "en")

#show link: set text(fill: blue)
#show outline.entry: set text(fill: blue)

#let hair = (thickness: 0.25mm, paint: black)
#let dot = circle(radius: 0.25mm, fill: luma(165))

#let dotgrid(x0, y0, cols, rows) = {
  for i in range(cols) {
    for j in range(rows) {
      place(top + left, dx: x0 + i * 5mm, dy: y0 + j * 5mm, dot)
    }
  }
}

#let hline(x0, x1, y) = place(top + left, dx: x0, dy: y, line(start: (0mm, 0mm), end: (x1 - x0, 0mm), stroke: hair))

#let header(x, y, label) = {
  place(top + left, dx: x, dy: y, rect(width: 8mm, height: 8mm, stroke: hair, inset: 0mm)[#align(center + horizon, label)])
  place(top + left, dx: x + 8mm, dy: y, rect(width: 25mm, height: 8mm, stroke: hair))
}

#let band(x0, ytop, rows, label) = {
  header(x0, ytop, label)
  dotgrid(x0 + 1.25mm, ytop + 7.75mm, 25, rows)
}

// ---- printable pages (layout frozen) ----
#let fri-sun-page() = {
  let days = ("Fr", "Sa", "Su")
  for i in range(3) { band(15mm, 15mm + i * 60mm, 11, days.at(i)) }
  for y in (15mm, 75mm, 135mm) { hline(15mm, 138mm, y) }
}

#let mon-thu-page() = {
  let days = ("Mo", "Tu", "We", "Th")
  for i in range(4) { band(10mm, 15mm + i * 45mm, 8, days.at(i)) }
  for y in (15mm, 60mm, 105mm, 150mm) { hline(10mm, 133mm, y) }
}

#let dotgrid-page(left-margin) = {
  let grid-pitch = 5mm
  let dot-cols = 25
  let dot-x-inset = 1.75mm
  let dot-top = 17.75mm
  let dot-bottom = 192.75mm
  let rows = calc.floor((dot-bottom - dot-top) / grid-pitch) + 1
  dotgrid(left-margin + dot-x-inset, dot-top, dot-cols, rows)
}

// ============================================================
// SCREEN-ONLY
// ============================================================
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
    #text(size: 7mm)[Weekly Planner]
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

This file holds undated weekly-page templates. Print as many weeks as you need. Each week is two pages, printed on both sides of one sheet.

- The left page is Monday through Thursday. It has four day rows.
- The right page is Friday through Sunday. It has three day rows, a little taller.

Each day row has a small box with the day's letters and a wider box beside it to write the date or a heading. The rest of the row is a dot grid for that day.

#pagebreak()

#instr-footer()
#instr-header()
#heading(level: 1)[What and how many to print] <what-and-how-many-to-print>

Here are the three pieces, their page range, and how many of each to print.

#table(
  columns: (auto, auto, auto),
  [_piece_], [_pages_], [_print this many_],
  [#link(<leading-sheet>)[Leading sheet]], [#sheet-pages(<leading-sheet>)], [1],
  [#link(<weekly-sheet>)[Weekly sheet]], [#sheet-pages(<weekly-sheet>)], [one per week, minus one],
  [#link(<trailing-sheet>)[Trailing sheet]], [#sheet-pages(<trailing-sheet>)], [1],
)

*Example.* Ten weeks:
- #link(<leading-sheet>)[Leading sheet]: 1
- #link(<weekly-sheet>)[Weekly sheets]: 9
- #link(<trailing-sheet>)[Trailing sheet]: 1

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

Sort the printed sheets into one stack:

1. Leading sheet on top.
2. Weekly sheets next, in order.
3. Trailing sheet at the bottom.

Then snap each sheet onto the discs: day labels upright, punched edge toward the center. Flip through when done — each week shows Monday–Thursday on the left and Friday–Sunday on the right.

#pagebreak()

#set page(margin: (x: 0mm, y: 0mm))

// ---- LEADING sheet: dot-grid front (punch LEFT) + Mo–Th back ----
#{ dotgrid-page(15mm) } <leading-sheet>
#pagebreak()
#{ mon-thu-page() }
#pagebreak()

// ---- WEEKLY sheet: Fr–Su front + Mo–Th back ----
#{ fri-sun-page() } <weekly-sheet>
#pagebreak()
#{ mon-thu-page() }
#pagebreak()

// ---- TRAILING sheet: Fr–Su front + dot-grid back (punch RIGHT) ----
#{ fri-sun-page() } <trailing-sheet>
#pagebreak()
#{ dotgrid-page(10mm) }