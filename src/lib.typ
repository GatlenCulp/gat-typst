// preamble.typ
// Diagramming
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.5.0" as lq
// Math
#import "@preview/mannot:0.3.0": *
#import "@preview/matset:0.1.0"
#import "@preview/equate:0.3.2": equate
#import "@preview/physica:0.9.5": *
// Compatibility
#import "@preview/mitex:0.2.5": mitex, mitex-convert, mitext
// Display
#import "@preview/showybox:2.0.4": showybox
#import "@preview/frame-it:1.2.0": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/fontawesome:0.6.0": * // Note: Must have these installed
// Code
#import "@preview/callisto:0.2.4"
#import "@preview/lovelace:0.3.0": pseudocode-list
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": codly-languages
#import "@preview/cmarker:0.1.6"
// Color
#import "@preview/splash:0.5.0": xcolor
#import "@preview/typpuccino:0.1.0": frappe, latte, macchiato, mocha

// ------ HOMEWORK UTILS -------
// #let solution = text.with(fill: red.darken(60%))
#let solution = text.with(fill: black)
#let boxed-solution = box.with(inset: (x: 4pt, y: 0pt), outset: (y: 5pt), radius: 2pt, stroke: 1pt)

#let sub-solution = showybox.with(
  title: "Sub-Solution",
  frame: (border-color: blue, title-color: blue),
  breakable: true,
)

// ------ COLOR UTILS -------


#let color-cycle-factory(count, colors: (blue, red, green, orange, purple)) = {
  let color-cycle() = {
    count.step()
    let color-i() = calc.rem(count.get().at(0) - 1, colors.len())
    colors.at(color-i())
  }
  color-cycle
}

// #let cycle-a-counter = counter("color-cycle-a")
// #let cycle-a = color-cycle-factory(cycle-a-counter)

// #let cycle-b-counter = counter("color-cycle-b")
// #let cycle-b = color-cycle-factory(cycle-b-counter, colors: (white, black))

// For the love of god cannot get this to work
// #let color-cycle-counter = counter("color-cycle-counter")
// #let ColorCycle(
//   colors: (blue, red, green, orange, purple),
// ) = {
//   let counter-id() = color-cycle-counter.get().at(0)
//   color-cycle-counter.step()
//   let count() = counter("color-cycle-" + str(counter-id()))
//   return count()
// }

// #let cycle-0 = ColorCycle
// #let cycle-1 = ColorCycle


// #let ColorCycle(counter-name, colors: (blue, red, green, orange, purple)) = {
//   let count = counter(counter-name)
//   let color-cycle() = {
//     count.step()
//     let color-i() = calc.rem(count.get().at(0) - 1, colors.len())
//     colors.at(color-i())
//   }
//   color-cycle
// }

// ------ BOX UTILS --------

#let showybox = showybox.with(
  breakable: true,
  title-style: (color: black),
)

#let gatbox-color-counter = counter("gatbox-color-counter")

// OKAY apparently you cannot compose anything with context which is STUPID. They all have to be in one function.
#let gatbox-color-cycle = color-cycle-factory(gatbox-color-counter)
// Thank god this works
#let gatbox(color: black, color-cycle: false, ..args) = {
  if not (color-cycle) {
    return showybox(
      frame: (
        border-color: color.darken(30%),
        title-color: color.lighten(80%),
        body-color: color.lighten(95%),
      ),
      breakable: true,
      title-style: (color: black),
      ..args,
    )
  }
  let colors = (blue, red, green, orange, purple)
  gatbox-color-counter.step()
  let color-i() = calc.rem(gatbox-color-counter.get().at(0) - 1, colors.len())
  let color() = colors.at(color-i())
  context showybox(
    frame: (
      border-color: color().darken(30%),
      title-color: color().lighten(80%),
      body-color: color().lighten(95%),
    ),
    breakable: true,
    title-style: (color: black),
    ..args,
  )
}

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
  gatbox(color: color, breakable: true, ..args)
}

// ------ MATH UTILS --------
// Reasoning
#let st = $"s.t."$
#let If = $#strong("if")$
#let Else = $#strong("else")$
#let Then = $#strong("then")$
// ML/RL
#let KL(u, v) = $D_"KL" (#u || #v)$
#let refPol = $overline(pi)$
// Misc
#let SE = $"SE"$
#let ddot = sym.dot.double
#let alias = $<-^"alias"$

// ------ MISC UTILS --------
#let llm = text.with(fill: green.darken(30%))

// ------- TEMPLATES ----------

// Date formatter
#let date-format = date => if type(date) == type(datetime.today()) {
  date.display("[weekday], [year] [month repr:short] [day]")
} else { date }


#let common(body) = {
  fa-version("6")
  show: codly-init.with()
  show: super-T-as-transpose // Render "..^T" as transposed matrix

  show: equate.with(breakable: true, sub-numbering: false)

  body
}

#let cheatsheet(
  title: "Cheatsheet",
  course: none,
  university: none,
  author: none,
  email: none,
  collaborators: [],
  resources: [],
  date: datetime.today(),
  body,
) = {
  set page(paper: "us-letter", margin: 0.5cm, columns: 3)
  set columns(gutter: 0.3cm)
  set text(size: 6pt)
  // #set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 7pt, weight: "bold")
    it
  }
  show heading.where(level: 2): it => {
    set align(center)
    set text(size: 6pt, weight: "bold")
    it
  }
  show heading.where(level: 3): it => {
    set text(size: 6pt, style: "oblique")
    it
  }

  show: common.with()
  heading(level: 1, numbering: none)[#course #title]
  align(center)[#author · #date-format(date)]
  body
}

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

  // Make info available globally - ADD THIS LINE
  // state("homework-info", info).update(info)

  // Apply page and text settings
  set page(paper: "us-letter", margin: 2cm, header: context [#text(fill: black)[*#hydra(2)*]])
  set text(size: 13pt)
  set heading(numbering: "1.1")

  // Heading styles
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
  set math.equation(numbering: "(1)")

  // Header
  show: common.with()
  heading(level: 1, numbering: none)[#title \ #university #course]
  align(center)[
    #author (#email)
    #sym.dot #date-format(date) \
    Collaborators: #collaborators #sym.dot Resources Used: #resources
  ]

  // Content
  body
}

// Helper to access info
// #let get-info() = context state("homework-info", none).get()
