#import "../src/lib.typ": *

// Overwrites for class
#let personal-info = (
  university: "MIT",
  author: "Gatlen Culp",
  email: "gculp@mit.edu",
  collaborators: [Claude 4.5 Sonnet (Questions, not Solving)],
  resources: [None],
)

#let course-info = (
  course: link("https://web.mit.edu/6.7920/www/schedule.html")[6.792 Reinforcement Learning],
)

#let info = personal-info + course-info

#let homework = homework.with(
  ..info,
)
#let cheatsheet = cheatsheet.with(
  ..info,
)
