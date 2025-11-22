#import "@preview/showybox:2.0.4": showybox
#import "@preview/mannot:0.3.0": *


// 14.04 PS03 has some spicier math funcs
// ------ MATH UTILS --------
// Reasoning
#let st = $"s.t."$
#let If = $#strong("if")$
#let Else = $#strong("else")$
#let Then = $#strong("then")$
// Statistics
#let Var = $"Var"$
#let Cov = $"Cov"$
#let Corr = $"Corr"$
#let Ex = $limits(EE)$
#let Pr = $Pr$
// #let stdev
// ML/RL
#let KL(u, v) = $D_"KL" (#u mid(||) #v)$
#let refPol = $overline(pi)$
// Misc
#let SE = $"SE"$
#let ddot = sym.dot.double
#let alias = $<-^"alias"$

// ------ MISC UTILS --------
#let llm = text.with(fill: green.darken(30%))

// ------ BOX UTILS --------

#let showybox = showybox.with(
  breakable: true,
)

#let gatbox-color-counter = counter("gatbox-color-counter")
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

// Stolen from physica
// A show rule, should be used like:
//   #show: super-ast-as-star
//   V^* = V(x^*)
// or in scope:
//   #[
//     #show: super-ast-as-star
//     V^* = V(x^*)
//   ]
// Pairs well with replacing `*` with `dot.op`
#let super-ast-as-star(document) = {
  show math.attach: elem => {
    let __eligible(e) = {
      if e.func() == math.limits or e.func() == math.scripts { return false }
      if e.func() == math.lr {
        let last = e.at("body").at("children").at(-1)
        return __eligible(last)
      }
      if e.func() == math.equation {
        return __eligible(e.at("body"))
      }
      true
    }

    if __eligible(elem.base) and elem.at("t", default: none) == [#math.ast] {
      $attach(elem.base, t: star, b: elem.at("b", default: #none))$
    } else {
      elem
    }
  }

  document
}

#let _delim-map(delim) = {
  if delim == "(" {
    (math.paren.l, math.paren.r)
  } else if delim == "[" {
    (math.bracket.l, math.bracket.r)
  } else if delim == "{" {
    (math.brace.l, math.brace.r)
  } else if delim == "|" {
    (math.bar.v, math.bar.v)
  } else if delim == "||" {
    (math.bar.v.double, math.bar.v.double)
  } else {
    (delim, delim)
  }
}

#let math-func(..sink) = {
  let (args, kwargs) = (sink.pos(), sink.named()) // array, dictionary
  // The exact thing I'm looking for is not available unless I use some show command which is a lot of work https://github.com/typst/typst/issues/2698

  // Referencing physica package helps
  let name = args.at(0, default: none)
  let delim = kwargs.at("delim", default: "(")
  let ldelim = kwargs.at("ldelim", default: none)
  let rdelim = kwargs.at("rdelim", default: none)
  let color = kwargs.at("color", default: black)
  let attachStyle = kwargs.at("attach-style", default: math.scripts)

  if not (delim == none or (ldelim == none and rdelim == none)) {
    panic("math-func: must define delimeter (delim or (ldelim and rdelim)")
  }
  let (ldelim, rdelim) = if (not delim == none) {
    _delim-map(delim)
  } else {
    (ldelim, rdelim)
  }
  // panic(ldelim)

  let func(..sink) = {
    let (args, kwargs) = (sink.pos(), sink.named())
    let content = args.at(0, default: none)

    if content == none {
      return $ attachStyle(mark(#name, color: #color)) $
    } else {
      return $
        mark(
          #name""lr(
            #ldelim
            mark(#content, color: #black)
            #rdelim
          ),
          color: #color
        )
      $
    }
  }
  return func
}
#let stats-color = blue.darken(20%)
#let stats-func = math-func.with(color: stats-color, delim: "[")
#let Var = stats-func("Var")
#let Cov = stats-func("Cov")
#let Corr = stats-func("Corr")
#let Ex = stats-func($EE$, attach-style: math.limits)
#let Pr = stats-func("Pr")
