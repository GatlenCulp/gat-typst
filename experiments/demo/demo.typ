#import "./preamble.typ": *

// Diagramming
#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/lilaq:0.5.0" as lq
// Math
#import "@preview/matset:0.1.0"
// Compatibility
#import "@preview/mitex:0.2.5": mitex, mitex-convert, mitext
// Display
#import "@preview/frame-it:1.2.0": *
// Code
#import "@preview/callisto:0.2.4"
#import "@preview/lovelace:0.3.0": pseudocode-list
#import "@preview/cmarker:0.1.6"
// Color
#import "@preview/splash:0.5.0": xcolor
#import "@preview/typpuccino:0.1.0": frappe, latte, macchiato, mocha


#show: homework.with(
  // title: "HW02",
  // date: datetime(year: 2025, month: 9, day: 22),
  cols: 2,
)
#show: style.with()

#let solution = solution.with(cols: 2)
#solution[

  $
    grad_theta V_mu (pi_theta)
    = EE_(tau ~ P) [
      R(tau)
      sum_(t=0)^oo
      grad_theta log pi_theta (a_t | s_t)
    ]
    \
    = EE_(tau ~ P) [
      (sum_(t=0)^oo gamma^t r(s_t, a_t))
      (sum_(t'=0)^oo grad_theta log pi_theta (a_(t') | s_(t')))
    ]
    \
    = EE_(tau ~ P) [
      sum_(t=0)^oo sum_(t'=0)^oo
      gamma^t r(s_t, a_t)
      grad_theta log pi_theta (a_(t') | s_(t'))
    ]
    \
    = EE_(tau ~ P) [
      sum_(t'=0)^oo
      grad_theta log pi_theta (a_(t') | s_(t'))
      sum_(t=0)^oo
      gamma^t r(s_t, a_t)
    ]
    \
    = EE_(tau ~ P) [
      sum_(t'=0)^oo
      grad_theta log pi_theta (a_(t') | s_(t'))
      (
        sum_(t=0)^(t'-1)
        gamma^t r(s_t, a_t)
        + sum_(t=t')^(oo)
        gamma^t r(s_t, a_t)
      )
    ]
  $
  - List test
  - List test
  - List test
    - List test
  #lorem(500)


  #link("https://colab.research.google.com/drive/11VOd7wX0xWXFR4uUfNZWP8fDIygM-QmR?usp=sharing")
]

// #set text(size: 13pt)

$a * b * c^* @ v ~~ u o. v * Pr(X) * Var(Y) .. "test"$
= Other packages of interest:

== Scribe (High likelihood)
Uses (mostly) ascii math to simplify the look of operators

With scribe you can write
`$Ff * (f @ g)(x) \\ {0} -= +-1 .. (mod n)$`

instead of
`$cal(F) dot.op (f compose g)(x) without {0} equiv plus.minus 1 quad (mod n)$`

== Math Shorthands

Interesting process of looking for and replacing elements inside of your body. Could probably steal from this. See:
https://github.com/EpicEricEE/typst-quick-maths/blob/master/src/quick-maths.typ#L46

== Eqalc: Convert Math equations to functions
https://typst.app/universe/package/eqalc

Along a similar vein, numty (like numpy):
https://typst.app/universe/package/numty

Fitch-style proofs?? Prob not but interesting.
https://typst.app/universe/package/derive-it

== Prismath

Seems cool but also doesn't seem to work well lol. May need to add with `show` to be better.
https://typst.app/universe/package/prismath

// #let dracula-theme = read("../Dracula.tmTheme")
// #set raw(theme: "../Dracula.tmTheme")

// Access info anywhere (Will fix later)
// #let info = get-info()
// #solution[Due date: #info]

// #cycle-a()
// #cycle-a()
// #cycle-b()
// #cycle-b()
// #cycle-b()
// #cycle-a()


// #cycle-b
// #cycle-a
// #cycle-a
// #cycle-a()
// #cycle-a()
// #cycle-b()
// #cycle-b()
// #cycle-a()


= Default Typst Stuff

*Defining a Math Operator*

https://typst.app/docs/reference/math/class/


#let cong = math.class("normal", "≌")
$cong$

For math symbols (note: single letters cannot be overridden)\
#let V = math.class("normal")[$mark(sum, color: #blue)$]
$V$

#let Va = math.class("normal")[$mark(sum, color: #blue)$]
$Va$

#let loves = math.class(
  "relation",
  sym.suit.heart,
)

$x loves y and y loves 5$

For macros:
#let P = $ mark(P, color: #red) $

$#P$

$Ex_X [X^2]$



#pagebreak()
= My Macros

#question()[Question]
#question(status: "done")[Done]
#question(status: "partial")[Partially complete]
#question(status: "todo")[todo]


#gatbox(color-cycle: false)[Hey team]
#gatbox(color-cycle: true)[Hey team]
#gatbox(color-cycle: true)[Hey team]
#gatbox(color-cycle: true)[Hey team]

#pagebreak()
= Diagramming

== #link("https://typst.app/universe/package/cetz")[CeTZ] (Drawing)

- #link("https://cetz-package.github.io/docs/")[Manual]
- #link(
    "https://www.notion.so/gatlen/Typst-CeTZ-Fletcher-Cursor-Rule-1ee803bca4198028b5fed6717778c412?source=copy_link",
  )[My Personal Notes]

#[
  #import draw: circle, content, line, rect

  #canvas({
    let layer-sep = 2 // Horizontal separation between layers
    let node-sep = 1.4 // Vertical separation between nodes
    let arrow-style = (stroke: .5pt, mark: (end: "stealth", fill: black, scale: .3))

    // Helper function to draw a layer of nodes
    let draw-layer(x, nodes, prefix: "") = {
      let top-y = nodes / 2
      let bottom-y = nodes / 2 - node-sep * (nodes - 1)

      for ii in range(nodes) {
        circle(
          (x, nodes / 2 - node-sep * ii),
          radius: 0.3,
          name: prefix + str(ii + 1),
        )
      }
      // Create named points for the layer bounds
      circle((x, top-y), radius: 0, name: prefix + "-top", fill: none)
      circle((x, bottom-y), radius: 0, name: prefix + "-bottom", fill: none)
    }

    // Helper to connect all nodes between layers
    let connect-layers(from-prefix, to-prefix, from-nodes, to-nodes) = {
      for ii in range(from-nodes) {
        for jj in range(to-nodes) {
          line(
            (from-prefix + str(ii + 1)),
            (to-prefix + str(jj + 1)),
            ..arrow-style,
          )
        }
      }
    }

    // Draw encoder
    draw-layer(0, 5, prefix: "e1") // Input layer
    draw-layer(layer-sep, 4, prefix: "e2") // Hidden layer
    draw-layer(layer-sep * 2, 3, prefix: "e3") // Output layer

    // Connect encoder layers
    connect-layers("e1", "e2", 5, 4)
    connect-layers("e2", "e3", 4, 3)

    // Draw mu nodes
    let mu-x = layer-sep * 3
    for ii in range(3) {
      circle((mu-x, 1.5 + ii), radius: 0.4, name: "mu" + str(ii + 1), fill: rgb(100%, 100%, 0%, 20%))
    }

    // Draw sigma nodes
    for ii in range(3) {
      circle((mu-x, -1.5 - ii), radius: 0.4, name: "sigma" + str(ii + 1), fill: rgb(0%, 0%, 100%, 10%))
    }

    // Draw sample nodes
    let sample-x = mu-x + layer-sep
    for ii in range(3) {
      circle((sample-x, ii - 1), radius: 0.4, name: "sample" + str(ii + 1), fill: rgb(0%, 100%, 0%, 10%))
    }

    // Draw boxes around mu, sigma, sample nodes
    rect(
      (mu-x - 0.5, 1),
      (mu-x + 0.5, 4),
      fill: rgb(100%, 100%, 0%, 45%),
      name: "mu-box",
      stroke: .1pt,
    )
    content("mu-box.north", $mu$, anchor: "south", padding: 3pt)

    rect(
      (mu-x - 0.5, -4),
      (mu-x + 0.5, -1),
      fill: rgb(0%, 0%, 100%, 30%),
      name: "sigma-box",
      stroke: .1pt,
    )
    content("sigma-box.north", $sigma$, anchor: "south", padding: 3pt)

    rect(
      (sample-x - 0.5, -1.5),
      (sample-x + 0.5, 1.5),
      fill: rgb(0%, 100%, 0%, 30%),
      name: "sample-box",
      stroke: .1pt,
    )
    content("sample-box.north", text(size: 0.8em)[Sample], anchor: "south", padding: 3pt)

    // Connect encoder to mu and sigma
    for ii in range(3) {
      for jj in range(3) {
        line(("e3" + str(ii + 1)), ("mu" + str(jj + 1)), ..arrow-style)
        line(("e3" + str(ii + 1)), ("sigma" + str(jj + 1)), ..arrow-style)
      }
    }

    // Connect mu and sigma nodes to sample nodes
    line("mu-box", "sample-box", ..arrow-style)
    line("sigma-box", "sample-box", ..arrow-style)

    // Draw decoder (mirrored structure of encoder)
    let decoder-x = sample-x + layer-sep
    draw-layer(decoder-x, 3, prefix: "d1")
    draw-layer(decoder-x + layer-sep, 4, prefix: "d2")
    draw-layer(decoder-x + layer-sep * 2, 5, prefix: "d3")

    // Connect decoder layers
    connect-layers("d1", "d2", 3, 4)
    connect-layers("d2", "d3", 4, 5)

    // Connect sample to decoder
    for ii in range(3) {
      for jj in range(3) {
        line(("sample" + str(ii + 1)), ("d1" + str(jj + 1)), ..arrow-style)
      }
    }

    // Add input and output labels
    for ii in range(5) {
      content(
        "e1" + str(ii + 1) + ".west",
        $x_#(ii + 1)$,
        anchor: "east",
        padding: 3pt,
      )
      content(
        "d3" + str(ii + 1) + ".east",
        $hat(x)_#(ii + 1)$,
        anchor: "west",
        padding: 3pt,
      )
    }

    content("e11.north", text(weight: "regular")[Input], anchor: "south", padding: 5pt)
    content("d31.north", text(weight: "regular")[Output], anchor: "south", padding: 5pt)
  })
]

#pagebreak()
== #link("https://typst.app/universe/package/fletcher")[Fletcher] (Arrow Diagrams)

- #link("https://github.com/typst/packages/blob/main/packages/preview/fletcher/0.5.8/docs/manual.pdf")[Manual]

#diagram(
  node-stroke: .1em,
  node-fill: gradient.radial(blue.lighten(80%), blue, center: (30%, 20%), radius: 80%),
  spacing: 4em,
  edge((-1, 0), "r", "-|>", `open(path)`, label-pos: 0, label-side: center),
  node((0, 0), `reading`, radius: 2em),
  edge(`read()`, "-|>"),
  node((1, 0), `eof`, radius: 2em),
  edge(`close()`, "-|>"),
  node((2, 0), `closed`, radius: 2em, extrude: (-2.5, 0)),
  edge((0, 0), (0, 0), `read()`, "--|>", bend: 130deg),
  edge((0, 0), (2, 0), `close()`, "-|>", bend: -40deg),
)

== #link("https://typst.app/universe/package/cetz-plot")[CeTZ Plot] (Plotting)
#[
  #let style = (stroke: black, fill: rgb(0, 0, 200, 75))

  #let f1(x) = calc.sin(x)
  #let fn = (
    ($ x - x^3"/"3! $, x => x - calc.pow(x, 3) / 6),
    ($ x - x^3"/"3! - x^5"/"5! $, x => x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120),
    (
      $ x - x^3"/"3! - x^5"/"5! - x^7"/"7! $,
      x => x - calc.pow(x, 3) / 6 + calc.pow(x, 5) / 120 - calc.pow(x, 7) / 5040,
    ),
  )

  #set text(size: 10pt)

  #canvas({
    import draw: *

    // Set-up a thin axis style
    set-style(
      axes: (stroke: .5pt, tick: (stroke: .5pt)),
      legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%),
    )

    plot.plot(
      size: (12, 8),
      x-tick-step: calc.pi / 2,
      x-format: plot.formats.multiple-of,
      y-tick-step: 2,
      y-min: -2.5,
      y-max: 2.5,
      legend: "inner-north",
      {
        let domain = (-1.1 * calc.pi, +1.1 * calc.pi)

        for (title, f) in fn {
          plot.add-fill-between(f, f1, domain: domain, style: (stroke: none), label: title)
        }
        plot.add(f1, domain: domain, label: $ sin x $, style: (stroke: black))
      },
    )
  })
]

== #link("https://lilaq.org/")[Lilaq] (Data Visualization, Slightly better than CeTZ Plot)
- Very well-maintained
- #link("https://lilaq.org/docs/quickstart")[Quickstart]

#[
  #let xs = (0, 1, 2, 3, 4)

  #lq.diagram(
    title: [Precious data],
    xlabel: $x$,
    ylabel: $y$,

    lq.plot(xs, (3, 5, 4, 2, 3), mark: "s", label: [A]),
    lq.plot(
      xs,
      x => 2 * calc.cos(x) + 3,
      mark: "o",
      label: [B],
    ),
  )
]

#pagebreak()
= Math
== MiTeX
#mitex(
  ```latex
  $$z = \begin{bmatrix} x_{0:T} \\ u_{0:T-1} \\ \lambda_{0:T-1} \end{bmatrix}$$
  ```,
)

== #link("https://quadnucyard.github.io/pavemat/")[Pavemat]
- Not imported since rare. Can define paths within matrix cells or fills of cells.

== #link("https://typst.app/universe/package/great-theorems")[Great Theorems]
- Again not imported, used for keeping track of various theorems

== #link("https://typst.app/universe/package/mannot/")[mannot]

$
  markul(p_i, tag: #<p>)
  = markrect(
    exp(- mark(beta, tag: #<beta>, color: #red) mark(E_i, tag: #<E>, color: #green)),
    tag: #<Boltzmann>, color: #blue,
  ) / markhl(sum_j exp(- beta E_j), tag: #<Z>)
  #annot(<p>, pos: bottom + left)[Probability of \ state $i$]
  #annot(<beta>, pos: top + left, dy: -1.5em, leader-connect: "elbow")[Inverse temperature]
  #annot(<E>, pos: top + right, dy: -1em)[Energy]
  #annot(<Boltzmann>, pos: top + left)[Boltzmann factor]
  #annot(<Z>)[Partition function]
$

#pagebreak()
= Display

== #link("https://html-preview.github.io/?url=https://github.com/marc-thieme/frame-it/blob/assets/README.html")[frame-it] (Custom Frames)

- Don't fully understand how these are used

#[
  #let (example, feature, variant, syntax) = frames(
    feature: "Feature",
    // For each frame kind, you have to provide its supplement title to be displayed
    variant: ("Variant",),
    // You can provide a color or leave it out and it will be generated
    example: ("Example", gray),
    // You can add as many as you want
    syntax: ("Syntax",),
  )
  #let definition = frame(kind: "not-the-default", "Definition", blue)

  // This is necessary. Don't forget this!
  #show: frame-style(styles.boxy)


  How to use it is explained below. Here is a quick example:

  #example[Title][Optional Tag][
    Body, i.e. large content block for the frame.
  ]

  #definition[Hi there]

  #example[Title][Optional Tag][
    Body, i.e. large content block for the frame.
  ]

  #feature[Title][Optional Tag][
    Body, i.e. large content block for the frame.
  ]

  #show: frame-style(styles.hint)

  #variant[Title][Optional Tag][
    Body, i.e. large content block for the frame.
  ]

  #syntax[Title][Optional Tag][
    Body, i.e. large content block for the frame.
  ]
]

== #link("https://github.com/typst/packages/blob/main/packages/preview/hydra/0.6.2/assets/manual.pdf")[Hydra]

- Query and display headings in your documents
- Single function

#pagebreak()
== Physica
- Inner product `iprod` -- $iprod(u, v)$
- Vector Bold `vb` -- $vb(v)$
- Vector Unit `vu` -- $vu(u)$
- Diagonal Matrix `dmat` -- $dmat(1, RR)$ (mdet, zmat, imat, jmat, rot2mat, rot3{xyz}mat, ) = (determinant, zero mat, identity, jacboian)
- Differential `dd` -- $dd(x)$
- Hessian `hmat(function; var1, var2)` -- $hmat(f; x, y)$
- Set `Set(item, condition)` -- $Set(x_i, i in {1:3})$
- My template has superscript $T$ become transpose
- See manual #link("https://github.com/Leedehai/typst-physics/blob/master/physica-manual.pdf")

$
  A^T, curl vb(E) = - pdv(vb(B), t),
  quad
  tensor(Lambda, +mu, -nu) = dmat(1, RR),
  quad
  f(x,y) dd(x, y),
  quad
  dd(vb(x), y, [3]),
  quad
  dd(x, y, 2, d: Delta, p: and),
  quad
  dv(phi, t, d: upright(D)) = pdv(phi, t) + vb(u) grad phi \
  H(f) = hmat(f; x, y; delim: "[", big: #true),
  quad
  vb(v^a) = sum_(i=1)^n alpha_i vu(u^i),
  quad
  Set((x, y), pdv(f, x, y, [2,1]) + pdv(f, x, y, [1,2]) < epsilon) \
  -1/c^2 pdv(, t, 2)psi + laplacian psi = (m^2c^2) / hbar^2 psi,
  quad
  ket(n^((1))) = sum_(k in.not D) mel(k^((0)), V, n^((0))) / (E_n^((0)) - E_k^((0))) ket(k^((0))),
  quad
  integral_V dd(V) (pdv(cal(L), phi) - partial_mu (pdv(cal(L), (partial_mu phi)))) = 0 \
  dd(s, 2) = -(1-(2G M)/r) dd(t, 2) + (1-(2G M)/r)^(-1) dd(r, 2) + r^2 dd(Omega, 2)
$

$
  "clk:" & signals("|1....|0....|1....|0....|1....|0....|1....|0..", step: #0.5em) \
  "bus:" & signals(" #.... X=... ..... ..... X=... ..... ..... X#.", step: #0.5em)
$

#pagebreak()
= Code
== #link("https://typst.app/universe/package/codly/")[Codly]

Should just work by default, is initialized at the start to style code blocks

#show: codly-init.with()

#codly(languages: codly-languages)
```rust
pub fn main() {
    println!("Hello, world!");
}
```

#pagebreak()
== #link("https://typst.app/universe/package/callisto/")[Callisto]
// Whole notebook
// #callisto.render(nb: json("./demo.ipynb"))

// Get functions preconfigured to use this notebook
#let (render, Cell, In, Out) = callisto.config(
  nb: json("demo.ipynb"),
)

- `In` = Code or markdown of cell
- `Out` = Output of a cell (Can't handle HTML)
- `Cell` = `In` + `Out`
- `Render` = Not sure how this differs from `Cell`

All of these can take a few arguments
- Main positional - Index, list of indices, OR a string representing the tag of the cell(s).
  - Tag is probably the best usage.

```python
x = 5
y = 10
x + y
```

// #render("test-tag")
#In("test-tag")
