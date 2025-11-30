#import "preamble.typ": *

#show: common.with()

Docs according to Tidy style: https://github.com/Mc-Zen/tidy

= Notes on Physica Package and Typst Programming

- Private Functions: `__func_name`
- `lr` is pretty helpful
- `zwj` is zero-width joiner
- Take in `..sink` and break into `(arg, kwargs) = (sink.pos(), sink.named())`

And many more

== Content Type

- `has` will see if a content has a given field. #link("https://typst.app/docs/reference/scripting/#fields")[Fields] on content can be many things
