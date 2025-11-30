#import "@preview/tidy:0.4.3"
#{
  import "gat-typing.typ"
  let module = tidy.parse-module(
    read("gat-typing.typ"),
    name: "gat-typing",
    scope: (gat-typing: gat-typing),
    preamble: "#import gat-typing: *\n",
  )
  tidy.show-module(
    module,
    style: tidy.styles.default,
  )
}

// $RV(X)$
