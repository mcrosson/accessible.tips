// A5 discbound undated MONTHLY DECK
// One PDF per day-label centering choice; each deck contains:
//   instruction page(s) — screen-only, do not print
//   then 7 duplex pairs (front|back):
//     A: dot-grid page          | left page (Mo–Th)
//     B: right page, 0 cells  | left page
//     C: right page, 1 cell   | left page
//     D: right page, 2 cells  | left page
//     E: right page, 0 cells  | dot-grid page
//     F: right page, 1 cell   | dot-grid page
//     G: right page, 2 cells  | dot-grid page
// Builds:
//   typst compile monthly-grid.typ monthly-grid.pdf
//   typst compile --input daylabel-over-space=true monthly-grid.typ monthly-grid-daylabel-over-space.pdf

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

#let hline(x0, x1, y) = place(top + left, dx: x0, dy: y, line(length: x1 - x0, stroke: hair))
#let vline(x, y0, y1) = place(top + left, dx: x, dy: y0, line(start: (0mm, 0mm), end: (0mm, y1 - y0), stroke: hair))

// Day-label centering: default = centered over the full 30mm column;
// with `--input daylabel-over-space=true` the labels center over the white space
// between the day-number box's right edge and the column edge (+6.25mm).
#let daylabel-over-space = sys.inputs.at("daylabel-over-space", default: "false") == "true"
#let daylabel-center-offset = if daylabel-over-space { 21.25mm } else { 15mm }

#let dayletter(xcenter, label) = place(top + left, dx: xcenter - 15mm, dy: 18mm, box(width: 30mm, height: 10mm)[#align(center + horizon, label)])

#let daybox(x, y) = place(top + left, dx: x, dy: y, rect(width: 12.5mm, height: 8mm, stroke: hair, inset: 0mm))

#let overflowcell(y) = {
  place(top + left, dx: 108mm, dy: y, rect(width: 30mm, height: 35mm, stroke: hair, fill: white))
  daybox(108mm, y)
}

#let dayboxes-at(cols) = {
  for x in cols {
    for y in (28mm, 63mm, 98mm, 133mm, 168mm) { daybox(x, y) }
  }
}

// ---- RIGHT page (Fr–Su + notes column), with `cells` overflow cells (0, 1, or 2) ----
#let rsu-page(cells) = {
  hline(18mm, 138mm, 18mm)
  hline(18mm, 138mm, 203mm)
  vline(18mm, 18mm, 203mm)
  vline(138mm, 18mm, 203mm)
  hline(18mm, 108mm, 28mm)
  for y in (63mm, 98mm, 133mm, 168mm) { hline(18mm, 108mm, y) }
  for x in (48mm, 78mm) { vline(x, 28mm, 203mm) }
  vline(108mm, 18mm, 203mm)
  hline(108mm, 138mm, 28mm)
  dotgrid(110.5mm, 30.5mm, 6, 35)
  dayletter(18mm + daylabel-center-offset, "Fr")
  dayletter(48mm + daylabel-center-offset, "Sa")
  dayletter(78mm + daylabel-center-offset, "Su")
  dayletter(123mm, "Notes")
  dayboxes-at((18mm, 48mm, 78mm))
  if cells >= 2 { overflowcell(133mm) }
  if cells >= 1 { overflowcell(168mm) }
}

// ---- LEFT page (Mo–Th) ----
#let lpage() = {
  // MONTH + YEAR write-in boxes (top margin, above border)
  place(top + left, dx: 10mm, dy: 6mm, rect(width: 40mm, height: 8mm, stroke: hair))
  place(top + left, dx: 54mm, dy: 6mm, rect(width: 22mm, height: 8mm, stroke: hair))
  hline(10mm, 130mm, 18mm)
  hline(10mm, 130mm, 203mm)
  vline(10mm, 18mm, 203mm)
  vline(130mm, 18mm, 203mm)
  hline(10mm, 130mm, 28mm)
  for y in (63mm, 98mm, 133mm, 168mm) { hline(10mm, 130mm, y) }
  for x in (40mm, 70mm, 100mm) { vline(x, 28mm, 203mm) }
  dayletter(10mm + daylabel-center-offset, "Mo")
  dayletter(40mm + daylabel-center-offset, "Tu")
  dayletter(70mm + daylabel-center-offset, "We")
  dayletter(100mm + daylabel-center-offset, "Th")
  dayboxes-at((10mm, 40mm, 70mm, 100mm))
}

// ---- LEADING dot-grid page (right side: spine/punch on the left) ----
#let dotgrid-page() = {
  hline(18mm, 138mm, 18mm)
  hline(18mm, 138mm, 203mm)
  vline(18mm, 18mm, 203mm)
  vline(138mm, 18mm, 203mm)
  dotgrid(20.5mm, 23.5mm, 24, 35)  // 5.5mm top inset: leaves a name band above the top dot-row inside the frame
}

// ---- TRAILING dot-grid page (left side: spine/punch on the right) ----
#let trailing-page() = {
  hline(10mm, 130mm, 18mm)
  hline(10mm, 130mm, 203mm)
  vline(10mm, 18mm, 203mm)
  vline(130mm, 18mm, 203mm)
  dotgrid(12.5mm, 20.5mm, 24, 37)
}

// ============================================================
// INSTRUCTIONS (screen-only)
// ============================================================
#set page(margin: (x: 13mm, y: 12mm))
#set heading(numbering: "1.")

#let sheet-pages(l) = context {
  let loc = query(l).first().location()
  let n = loc.page()
  link(l)[#(n)–#(n + 1)]
}

// ============ TITLE PAGE ============
#let native-version = datetime.today().display("[year]-[month]-[day]")  // Typst native max (date only — docs: today() is the current date, no time-of-day)
#let version-stamp = if "version" in sys.inputs { native-version + " " + sys.inputs.at("version") } else { native-version }  // build shell appends e.g. hhmm via --input version

// ---- instruction-page header + footer ----
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

#align(center + horizon)[
  #block[
    #text(size: 7mm)[Monthly Planner]
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

This file holds undated monthly-page templates. Print as many months as you need. Each month is two pages, printed on both sides of one sheet.

- The left page is Monday through Thursday. It has a month box and a year box at the top, and day boxes below.
- The right page is Friday through Sunday, with a notes column down the right side.

Every day box has a small square in the corner. Write the day's number in that square; the rest of the box is for writing.

Months don't always fill the grid evenly. The last day or two that won't fit are called overflow. A 31-day month that starts late in the week, for example, leaves its last two days with no row.

#pagebreak()
#instr-footer()
#instr-header()
#heading(level: 1)[Two ways to handle overflow] <two-ways-to-handle-overflow>

Overflow days can be handled two ways. Pick one.

*The easy way — no extra boxes*

Print every month as a plain month. When a month runs past the fifth row, write the extra day numbers in the first row's empty Monday and Tuesday boxes. Those boxes are always empty in such months, because the month starts on a Saturday or a Sunday.

Print:
- the #link(<first-sheet>)[First sheet]: once
- the #link(<no-overflow-month>)[No-overflow month] sheet: once for each month except the last
- the #link(<last-month-no-overflow>)[Last month (no overflow)] sheet: once

That's the full print list.

*The boxed way — overflow boxes*

If you'd rather give overflow days their own boxes, sort the months into three groups.

Use a calendar. For each month, decide its group:

- *Group 0 — no overflow.* Anything not in group 1 or 2 is here. Most months are.
- *Group 1 — one overflow box.* A 31-day month starting on Saturday, or a 30-day month starting on Sunday.
- *Group 2 — two overflow boxes.* A 31-day month starting on Sunday.

Sort every month except the last into these groups, and count each:

#block(inset: (x: 6mm, y: 1mm))[
- group 0 (not the last): #text("______")
- group 1 (not the last): #text("______")
- group 2 (not the last): #text("______")
]

Note the last month's group: 0 / 1 / 2

#pagebreak()
#instr-footer()
#instr-header()
#heading(level: 1)[What and how many to print] <what-and-how-many-to-print>

Here are the seven pieces, their page range, and how many of each to print.

#table(
  columns: (auto, auto, auto),
  [_piece_], [_pages_], [_print this many_],
  [#link(<first-sheet>)[First sheet]], [#sheet-pages(<first-sheet>)], [1],
  [#link(<no-overflow-month>)[No-overflow month]], [#sheet-pages(<no-overflow-month>)], [one per group 0 month],
  [#link(<one-box-month>)[One-box month]], [#sheet-pages(<one-box-month>)], [one per group 1 month],
  [#link(<two-box-month>)[Two-box month]], [#sheet-pages(<two-box-month>)], [one per group 2 month],
  [#link(<last-month-no-overflow>)[Last month (no overflow)]], [#sheet-pages(<last-month-no-overflow>)], [1, if the last month is in group 0],
  [#link(<last-month-one-overflow>)[Last month (one overflow)]], [#sheet-pages(<last-month-one-overflow>)], [1, if the last month is in group 1],
  [#link(<last-month-two-overflow>)[Last month (two overflow)]], [#sheet-pages(<last-month-two-overflow>)], [1, if the last month is in group 2],
)

If you chose the easy way, only three rows matter: #link(<first-sheet>)[First sheet], #link(<no-overflow-month>)[No-overflow month] (one per month), and #link(<last-month-no-overflow>)[Last month (no overflow)].

*Example, boxed way.* Months sort into group 0 = 8, group 1 = 3, group 2 = 1, with the last month in group 2. Print:
- #link(<first-sheet>)[First sheet]: 1
- #link(<no-overflow-month>)[No-overflow month]: 8
- #link(<one-box-month>)[One-box month]: 3
- #link(<two-box-month>)[Two-box month]: 1
- #link(<last-month-two-overflow>)[Last month (two overflow)]: 1

After printing, you'll have a pile per piece. Next: #link(<printer-setup>)[Set up your printer].

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

1. #link(<first-sheet>)[First sheet] on top.
2. Month sheets next, in calendar order, for every month except the last.
3. Last month sheet at the bottom.

The sheets are unmarked, so pick each month's sheet by its overflow:

- No overflow: #link(<no-overflow-month>)[No-overflow month].
- One overflow day: #link(<one-box-month>)[One-box month].
- Two overflow days: #link(<two-box-month>)[Two-box month].

(Easy way: every month is a #link(<no-overflow-month>)[No-overflow month].)

Now bind the stack:

Lay the notebook open with the discs in the middle. Take the sheets one at a time and snap each one onto the discs. Check two things on each sheet:

- The *punched edge* snaps onto the discs.
- The *day labels* read upright. The left page has Mo Tu We Th along its top; the right page has Fr Sa Su along its top.

When you're done, flip through the notebook. If any sheet is upside down, pop it off and turn it around.

#pagebreak()
#set par(spacing: 1.1mm)

// ============================================================
// DECK — 7 spreads
// ============================================================

#set page(margin: (x: 0mm, y: 0mm))
#{ dotgrid-page() } <first-sheet>
#pagebreak()
#{ lpage() }
#pagebreak()

#{ rsu-page(0) } <no-overflow-month>
#pagebreak()
#{ lpage() }
#pagebreak()

#{ rsu-page(1) } <one-box-month>
#pagebreak()
#{ lpage() }
#pagebreak()

#{ rsu-page(2) } <two-box-month>
#pagebreak()
#{ lpage() }
#pagebreak()

#{ rsu-page(0) } <last-month-no-overflow>
#pagebreak()
#{ trailing-page() }
#pagebreak()

#{ rsu-page(1) } <last-month-one-overflow>
#pagebreak()
#{ trailing-page() }
#pagebreak()

#{ rsu-page(2) } <last-month-two-overflow>
#pagebreak()
#{ trailing-page() }