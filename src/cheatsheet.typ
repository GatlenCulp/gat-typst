#import "common.typ": *

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
