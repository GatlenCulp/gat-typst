// preamble.typ
#import "utils.typ": *
// Diagramming
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.5.0" as lq
// Math
#import "@preview/matset:0.1.0"
#import "@preview/equate:0.3.2": equate
#import "@preview/physica:0.9.5": *
#import "@preview/quick-maths:0.2.1": shorthands
// Compatibility
#import "@preview/mitex:0.2.5": mitex, mitex-convert, mitext
// Display
#import "@preview/frame-it:1.2.0": *
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


// Date formatter
#let date-format = date => if type(date) == type(datetime.today()) {
  date.display("[weekday], [year] [month repr:short] [day]")
} else { date }


#let common(enable-shorthands: true, body) = {
  fa-version("6")

  // Perhaps import many of these: https://asciimath.org/
  // Personally, I find `*`, `..`, and `~~` to come up frequently
  // if enable-shorthands {}
  show: shorthands.with(
    // Operators
    ($**$, $ast.small$),
    ($*$, $dot.op$), // Very devisive!
    ($+-$, $plus.minus$),
    ($|-$, math.tack),
    ($o+$, $plus.o$),
    ($o.$, $dot.o$), // Element-wise multiplication
    ($@$, $dot.o$),
    // Logic
    ($..$, $quad$),
    ($:.$, $therefore$),
    ($:'$, $because$),
    // Relations
    ($-<=$, $prec.eq$),
    ($-<$, $prec$),
    ($>-=$, $succ.eq$),
    ($>-$, $succ$),
    ($-=$, $equiv$),
    ($~=$, $tilde.equiv$),
    ($~~$, $approx$),
    // Brackets
    ($<<$, $chevron.l$),
    ($>>$, $chevron.r$),
    ($==$, $eq$),
  )

  // Code
  show: codly-init.with()
  codly(languages: codly-languages, stroke: 1pt + black, zebra-fill: gray.lighten(80%))
  show raw: it => {
    set text(size: 8pt)
    it
  }

  // Math
  show: equate.with(breakable: true, sub-numbering: false)
  show: super-T-as-transpose // Render "..^T" as transposed matrix
  show: super-plus-as-dagger // Render "..^+" as dagger
  show: super-ast-as-star // Render "..^+" as dagger


  body
}
