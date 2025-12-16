#import "../utils/utils.typ": *
#import "@preview/hydra:0.6.2": hydra

// Much taken from IEEE-charged template

// Date formatter
#let date-format = date => if type(date) == type(datetime.today()) {
  date.display("[weekday], [year] [month repr:short] [day]")
} else { date }


#let question(..args, status: "none") = {
  let color = if status == "done" {
    green
  } else if status == "partial" {
    yellow
  } else if status == "todo" {
    red
  } else {
    black
  }
  gatbox(
    color: color,
    breakable: true,
    // body-inset: (x: 30pt, y: 10pt),
    ..args,
  )
}
#let solution(cols: 1, body) = [
  #columns(cols)[
    #body
  ]
]
#let boxed-solution = box.with(inset: (x: 4pt, y: 0pt), outset: (y: 5pt), radius: 2pt, stroke: 1pt)

#let sub-solution = showybox.with(
  title: "Sub-Solution",
  frame: (border-color: blue, title-color: blue),
  breakable: true,
)
#let notes = showybox.with(
  title: "Notes",
  frame: (border-color: purple, title-color: purple),
  breakable: true,
)

// Main template function
#let homework(
  title: "Homework",
  course: none,
  university: none,
  author: none,
  email: none,
  collaborators: [],
  resources: [],
  date: datetime.today(),
  cols: 1,
  show-header: true,
  paper-size: "us-letter",
  body,
) = {
  // Store info for access - ADD THIS PART
  let info = (
    title: title,
    course: course,
    university: university,
    author: author,
    email: email,
    collaborators: collaborators,
    resources: resources,
    date: date,
  )

  // Set document metadata.
  set document(title: title, author: (author,))

  set columns(gutter: 12pt)
  set page(
    // columns: 2,
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    header: context [#text(fill: gray)[*#hydra(2)*]],
  )

  // Text Settings (Contingent on # of columns)
  set text(size: {
    if cols == 1 {
      13pt
    } else if cols == 2 {
      10pt
    } else {
      panic("cols not in {1, 2}")
    }
  })
  show link: it => {
    set text(fill: blue.darken(20%))
    it
  }

  // Doesn't work
  // let solution = solution.with(cols: cols)


  // Heading Settings
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 16pt)
    // colbreak(weak: true) + it
    it
  }
  show heading.where(level: 2): it => {
    set text(size: 14pt)
    it
  }
  show heading.where(level: 3): it => {
    set text(size: 14pt, fill: blue.darken(30%))
    it
  }

  // Math Settings
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em) // Test

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure Bibliography
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], style: "ieee")

  // Paragraph Settings
  set par(justify: true, first-line-indent: (amount: 1em, all: true), spacing: 0.5em, leading: 0.5em)

  // Header
  if show-header {
    heading(level: 1, numbering: none)[#title \ #university #course]
    align(center)[
      #author (#email)
      #sym.dot #date-format(date) \
      Collaborators: #collaborators #sym.dot Resources Used: #resources
    ]
  }

  // Content
  body
}
