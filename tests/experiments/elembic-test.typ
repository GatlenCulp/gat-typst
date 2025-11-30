#import "@preview/elembic:1.1.1" as e: field, types

#let bigbox = e.element.declare(
  "bigbox",
  prefix: "@preview/my-package,v1",
  doc: "A fancy and customizable box.",
  display: it => block(fill: it.fill, stroke: it.stroke, inset: 5pt, it.body),
  fields: (
    field("body", types.option(content), doc: "Box contents", required: true),
    field("fill", types.option(types.paint), doc: "Box fill"),
    field("stroke", types.option(stroke), doc: "Box border", default: red),
  ),
)

#bigbox[abc]

#show: e.set_(bigbox, fill: "hello")

#bigbox(stroke: blue + 2pt)[def]
