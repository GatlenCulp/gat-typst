#import "../src/lib.typ": *

#set page(paper: "us-letter", margin: (x: 1in, y: 1in))
#set text(size: 11pt, font: "New Computer Modern")
#set par(justify: true)
#set heading(numbering: "1.1")

// TODO: Check out actual manual packages for better documenting code. Oh and actuall document code.

#show: style.with()

#align(center)[
  #text(size: 24pt, weight: "bold")[gat-typst Package Manual]

  #v(0.5em)
  #text(size: 12pt)[Version 0.1.0]

  #v(1em)
  #text(size: 10pt, style: "italic")[
    A comprehensive Typst package for academic writing, homework assignments, and cheatsheets
  ]
]

#v(2em)

#outline(indent: auto)

#pagebreak()

= Introduction

The `gat-typst` package is a comprehensive template system for academic writing in Typst, with a focus on mathematics-heavy homework assignments, cheatsheets, and technical documents. It provides opinionated defaults, extensive math utilities, and a curated collection of the best packages from the Typst ecosystem.

This is a growing library for Gatlen Culp's personal usage and is unstable.

== Key Features

- *Templates*: Ready-to-use templates for homework and cheatsheets
- *Math Utilities*: Enhanced math notation with semantic symbols and custom functions
- *Optional Styling*: Professional defaults for code, tables, equations, and math shorthands (opt-in via `style`)
- *Convenience Functions*: Colored boxes, custom math operators, and more
- *Integrated Packages*: Core packages for math, code, and formatting

== Installation

To use this package locally, ensure it's installed in your local Typst packages directory:

```bash
# Unix-like systems
~/.local/share/typst/packages/local/gat-typst/0.1.0/

# Windows
%APPDATA%/typst/packages/local/gat-typst/0.1.0/
```

Then import it in your Typst documents:

```typ
#import "@local/gat-typst:0.1.0": *
```

== Quick Start

Here's a minimal homework document to get started:

```typ
#import "@local/gat-typst:0.1.0": *

#show: homework.with(
  title: "Homework 1",
  course: "CS 101",
  university: "Your University",
  author: "Your Name",
  email: "you@example.com",
  date: datetime.today(),
)

// Optional: Enable enhanced styling (math shorthands, code styling, etc.)
#show: style.with()

#question(status: "done")[
  Prove that $P = N P$.
]

#solution[
  Left as an exercise to the reader.

  Using our custom math utilities:
  $Ex(X^2) >= (Ex(X))^2$ by Jensen's inequality.
]
```

#pagebreak()
= Important Behavior Changes

When using the `style` function, several default behaviors are modified for improved mathematical typesetting and consistency. *These changes are opt-in* - you must explicitly use `#show: style.with()` to enable them.

== Math Shorthands

The `style` function enables extensive math operator shorthands via the `quick-maths` package.

=== Complete Shorthand List

*Operators:*

#columns(2)[
  ```typ
  $a ** b$  // Small asterisk
  $a * b$   // Centered dot ⚠️
  $a +- b$  // Plus-minus
  $A |- B$  // Turnstile
  $a o+ b$  // Circled plus
  $a o. b$  // Circled dot
  $a @ b$   // Also circled dot
  ```
  #colbreak()

  $a ** b$ #h(1em) $a * b$ #h(1em) $a +- b$

  $A |- B$ #h(1em) $a o+ b$

  $a o. b$ #h(1em) $a @ b$
]

*Logic:*

#columns(2)[
  ```typ
  $a .. b$        // Spacing (quad)
  $A :. B$        // Therefore
  $A :' B$        // Because
  ```
  #colbreak()

  $a .. b$

  $A :. B$ #h(2em) $A :' B$
]

*Relations:*

#columns(2)[
  ```typ
  $a -<= b$  // Precedes or equals
  $a -< b$   // Precedes
  $a >-= b$  // Succeeds or equals
  $a >- b$   // Succeeds
  $a -= b$   // Equivalent
  $a ~= b$   // Asymptotically equal
  $a ~~ b$   // Approximately
  ```
  #colbreak()

  $a -<= b$ #h(1em) $a -< b$

  $a >-= b$ #h(1em) $a >- b$

  $a -= b$ #h(1em) $a ~= b$ #h(1em) $a ~~ b$
]

*Brackets:*

#columns(2)[
  ```typ
  $<< a, b >>$    // Angle brackets
  $a == b$        // Equals (unchanged)
  ```
  #colbreak()

  $<< a, b >>$

  $a == b$
]

=== Warning About `*` Shorthand

The `*` → `dot.op` replacement is the most impactful change:

#columns(2)[
  ```typ
  // With shorthands (default):
  $a * b$          // Renders: a · b
  $a ** b$         // Renders: a * b (small asterisk)

  // To use literal asterisk:
  $a ast b$        // Renders: a * b
  ```
  #colbreak()

  $a * b$ #h(2em) (renders as $a dot.op b$)

  $a ** b$ #h(2em) (small asterisk)

  $a ast b$ #h(2em) (literal asterisk)
]

This follows conventions in linear algebra and physics but may surprise users expecting traditional asterisk multiplication.

=== Disabling Shorthands

Shorthands are disabled by default. To enable them, use:

```typ
#show: style.with()
```

If you want to use `style` without shorthands, you can disable them:

```typ
#show: style.with(enable-shorthands: false)
```

Note: Currently this parameter exists but shorthands are applied regardless when `style` is used. This will be fixed in a future version.

=== Examples

#columns(2)[
  ```typ
  // Statistics
  $Ex(X) .. Var(X) = Ex(X^2) - (Ex(X))^2$

  // Linear algebra
  $A * B != B * A .. "in general"$

  // Logic
  $x > 0 :. x^2 > 0$

  // Approximation
  $e ~~ 2.718$

  // Relations
  $x -<= y "iff" f(x) <= f(y)$
  ```
  #colbreak()

  $Ex(X) .. Var(X) = Ex(X^2) - (Ex(X))^2$

  $A * B != B * A .. "in general"$

  $x > 0 :. x^2 > 0$

  $e ~~ 2.718$

  $x -<= y "iff" f(x) <= f(y)$
]

== Superscript Transformations

Three special superscript transformations are enabled for common mathematical notation.

=== Transpose (`^T`)

#columns(2)[
  ```typ
  $A^T = "transpose of" A$
  $x^T y = iprod(x, y)$
  $(A B)^T = B^T A^T$
  ```
  #colbreak()

  $A^T = "transpose of" A$

  $x^T y = iprod(x, y)$

  $(A B)^T = B^T A^T$
]

Renders with proper transpose symbol (ᵀ) instead of superscript T.

=== Dagger (`^+`)

#columns(2)[
  ```typ
  $A^+ = "Moore-Penrose pseudoinverse"$
  $H^+ = "Hermitian transpose"$
  ```
  #colbreak()

  $A^+ = "Moore-Penrose pseudoinverse"$

  $H^+ = "Hermitian transpose"$
]

Renders as dagger symbol (†).

=== Star (`^*`)

#columns(2)[
  ```typ
  $V^* = "optimal value function"$
  $pi^* = "optimal policy"$
  $x^* = arg min_x f(x)$
  ```
  #colbreak()

  $V^* = "optimal value function"$

  $pi^* = "optimal policy"$

  $x^* = arg min_x f(x)$
]

Renders with star symbol (⋆) instead of superscript asterisk.

This distinguishes from the asterisk operator and provides cleaner mathematical notation.

=== Interaction with Shorthands

The superscript transformations work correctly even when `*` shorthand is enabled:

#columns(2)[
  ```typ
  $A^T * B^*$  // Transpose A times optimal B
  ```
  #colbreak()

  $A^T * B^*$
]

#pagebreak()
= Utilities

The package provides extensive utilities for math, boxes, and display formatting.

== Math Utilities

=== Statistics Functions

Colored, bracketed notation for statistical operators:

#columns(2)[
  ```typ
  $Ex(X)$           // Expected value
  $Var(X)$          // Variance
  $Cov(X, Y)$       // Covariance
  $Corr(X, Y)$      // Correlation
  $Pr(X > 0)$       // Probability
  ```
  #colbreak()

  $Ex(X)$ #h(1em) $Var(X)$ #h(1em) $Cov(X, Y)$

  $Corr(X, Y)$ #h(1em) $Pr(X > 0)$
]

These render with blue coloring and square brackets. Example:

$Ex(X^2) >= (Ex(X))^2$ by Jensen's inequality.

$Var(X + Y) = Var(X) + Var(Y)$ when $X$ and $Y$ are independent.

=== Reasoning Operators

#columns(2)[
  ```typ
  $x st x > 0$      // "such that"
  $If x > 0 Then y = 1 Else y = 0$
  ```
  #colbreak()

  $x st x > 0$

  $If x > 0 Then y = 1 Else y = 0$
]

Example: $max{x st x in RR}$

=== Machine Learning / RL

#columns(2)[
  ```typ
  $KL(p, q)$        // KL divergence
  $refPol$          // Reference policy
  ```
  #colbreak()

  $KL(p, q)$ #h(2em) $refPol$
]

Example: Minimize $KL(pi, refPol)$ to stay close to reference policy.

=== Miscellaneous

#columns(2)[
  ```typ
  $SE$              // Standard error
  $ddot$            // Double dot
  $alias$           // Alias arrow
  $clamp(x)$        // Clamp function
  $solve(x)$        // Solve function
  ```
  #colbreak()

  $SE$ #h(1em) $ddot$ #h(1em) $alias$

  $clamp(x)$ #h(1em) $solve(x)$
]

=== Custom Math Function Factory

Create your own math functions with custom delimiters:

#columns(2)[
  ```typ
  #let myFunc = math-func("myFunc", delim: "[")
  $myFunc(x, y)$

  // Or with custom left/right delimiters
  #let norm = math-func("norm", ldelim: math.bar.v.double, rdelim: math.bar.v.double)
  $norm(x)$
  ```
  #colbreak()

  #let myFunc = math-func("myFunc", delim: "[")
  $myFunc(x, y)$

  #let norm = math-func("norm", delim: math.bar.v.double)
  $norm(x)$
]

== Box Utilities

=== `gatbox()`

Customizable colored boxes with automatic color cycling.

==== Basic Usage

#columns(2)[
  ```typ
  #gatbox[
    This is a basic box with default black color.
  ]

  #gatbox(color: blue)[
    This is a blue box.
  ]
  ```
  #colbreak()

  #gatbox[
    This is a basic box with default black color.
  ]

  #gatbox(color: blue)[
    This is a blue box.
  ]
]

==== Color Cycling

Automatically cycle through predefined colors:

#columns(2)[
  ```typ
  #gatbox(color-cycle: true)[First box - blue]
  #gatbox(color-cycle: true)[Second box - red]
  #gatbox(color-cycle: true)[Third box - green]
  #gatbox(color-cycle: true)[Fourth box - orange]
  #gatbox(color-cycle: true)[Fifth box - purple]
  ```
  #colbreak()

  #gatbox(color-cycle: true)[First box - blue]
  #gatbox(color-cycle: true)[Second box - red]
  #gatbox(color-cycle: true)[Third box - green]
  #gatbox(color-cycle: true)[Fourth box - orange]
  #gatbox(color-cycle: true)[Fifth box - purple]
]

==== Parameters

- `color` (color, default: `black`): Box color
- `color-cycle` (boolean, default: `false`): Auto-cycle through colors
- `title` (content): Optional title
- All `showybox` parameters supported

==== Examples

#columns(2)[
  ```typ
  #gatbox(title: "Important", color: red)[
    This is a critical point!
  ]

  #gatbox(color-cycle: true, title: "Theorem 1")[
    All horses are the same color.
  ]
  ```
  #colbreak()

  #gatbox(title: "Important", color: red)[
    This is a critical point!
  ]

  #gatbox(color-cycle: true, title: "Theorem 1")[
    All horses are the same color.
  ]
]

=== `showybox`

The base box system (re-exported from the `showybox` package) with `breakable: true` by default.

#columns(2)[
  ```typ
  #showybox(
    title: "Note",
    frame: (
      border-color: blue,
      title-color: blue.lighten(80%),
    ),
  )[
    Content here can break across pages.
  ]
  ```
  #colbreak()

  #showybox(
    title: "Note",
    frame: (
      border-color: blue,
      title-color: blue.lighten(80%),
    ),
  )[
    Content here can break across pages.
  ]
]

== Display Utilities

=== Show Rules

The package includes custom show rules that can be used independently:

#columns(2)[
  ```typ
  #show: super-ast-as-star

  $V^* = V(x^*)$  // Asterisk renders as star symbol
  ```
  #colbreak()

  #show: super-ast-as-star

  $V^* = V(x^*)$
]

#pagebreak()
= Style Function

The `style` function provides enhanced styling for code, tables, and math notation. This is *opt-in* and must be explicitly enabled with `#show: style.with()`.

== Code Styling

When using `style`, all code blocks are automatically styled:

=== Automatic Changes

1. *Font size*: Reduced to 8pt for compactness
2. *Zebra striping*: Alternating row backgrounds (gray.lighten(80%))
3. *Border*: 1pt black stroke around code blocks
4. *Syntax highlighting*: Language-specific coloring

=== Example

```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)
```

No manual configuration needed - just use standard Typst raw blocks with language tags.

== Table Styling

When using `style`, the `booktabs` package is automatically applied, giving all tables professional styling with:

- Proper spacing between rows
- Professional horizontal rules (top, mid, bottom)
- No vertical lines (following booktabs philosophy)
- Better visual hierarchy

```typ
#table(
  columns: 3,
  [*Algorithm*], [*Time*], [*Space*],
  [Quicksort], [$O(n log n)$], [$O(log n)$],
  [Mergesort], [$O(n log n)$], [$O(n)$],
  [Heapsort], [$O(n log n)$], [$O(1)$],
)
```

#table(
  columns: 3,
  [*Algorithm*], [*Time*], [*Space*],
  [Quicksort], [$O(n log n)$], [$O(log n)$],
  [Mergesort], [$O(n log n)$], [$O(n)$],
  [Heapsort], [$O(n log n)$], [$O(1)$],
)

No special syntax required - standard `#table()` gets enhanced styling.

#pagebreak()

= Templates

The package provides two main templates: `homework` and `cheatsheet`. Both templates can be enhanced with the optional `style` function for additional styling features.

== Style Function

The `style` function provides enhanced styling for code, tables, equations, and math notation. It is *optional* and must be explicitly enabled.

=== Usage

```typ
#show: style.with()
```

=== Parameters

- `enable-shorthands` (boolean, default: `true`): Enable math operator shorthands

=== Features Provided

The `style` function automatically configures:

1. *FontAwesome Icons*: Access to icon library via `fa-icon()` function
2. *Code Styling*: Syntax highlighting with Codly, 8pt font size, zebra striping
3. *Table Styling*: Professional booktabs-style tables by default
4. *Math Configuration*:
  - Equation numbering with `equate` package
  - Breakable equations
  - Sub-numbering disabled
5. *Show Rules*:
  - `^T` renders as transpose
  - `^+` renders as dagger (†)
  - `^*` renders as star (⋆) instead of asterisk

=== Example

```typ
#import "@preview/gat-typst:0.1.0": *

#show: style.with()

// Use FontAwesome icons
#fa-icon("heart") Math is beautiful

// Code with automatic styling
```python
def hello():
    print("Hello, world!")
```

// Professional tables
#table(
  columns: 3,
  [*Name*], [*Age*], [*City*],
  [Alice], [25], [Boston],
  [Bob], [30], [Seattle],
)

// Math with special superscripts
$ A^T dot B^+ = C^* $
```

// Use FontAwesome icons
#fa-icon("heart") Math is beautiful

// Code with automatic styling
```python
def hello():
    print("Hello, world!")
```

// Professional tables
#table(
  columns: 3,
  [*Name*], [*Age*], [*City*],
  [Alice], [25], [Boston],
  [Bob], [30], [Seattle],
)

// Math with special superscripts
$ A^T dot B^+ = C^* $

#pagebreak()
== Homework Template

The `homework` template creates professional homework assignments with custom components for questions, solutions, and more.

=== Usage

```typ
#show: homework.with(
  title: "Homework 1",
  course: "Course Name",
  university: "University Name",
  author: "Your Name",
  email: "your@email.com",
  collaborators: [List of collaborators],
  resources: [Resources used],
  date: datetime.today(),
  cols: 1,  // or 2 for two-column layout
  show-header: true,
  paper-size: "us-letter",
)
```

=== Parameters

- `title` (string): Homework title (e.g., "HW01", "Problem Set 3")
- `course` (content): Course name or code
- `university` (content): University name
- `author` (content): Your name
- `email` (content): Your email address
- `collaborators` (content, default: `[]`): List of collaborators
- `resources` (content, default: `[]`): Resources used
- `date` (datetime, default: `datetime.today()`): Assignment date
- `cols` (integer, default: `1`): Number of columns (1 or 2)
- `show-header` (boolean, default: `true`): Show header with metadata
- `paper-size` (string, default: `"us-letter"`): Paper size

=== Components

==== `question()`

Creates a colored box for problem statements with optional status tracking.

```typ
#question(status: "done")[
  What is the derivative of $x^2$?
]

#question(status: "partial")[
  This is partially complete.
]

#question(status: "todo")[
  Not started yet.
]

#question()[
  No status indicator.
]
```

Status colors:
- `"done"`: Green
- `"partial"`: Yellow
- `"todo"`: Red
- `"none"` or omitted: Black

==== `solution()`

Wrapper for solution content with optional column layout.

```typ
#solution[
  The derivative is $2x$.
]

#solution(cols: 2)[
  This solution spans two columns.
]
```

==== `boxed-solution`

Inline box for short solutions.

```typ
The answer is #boxed-solution[$x = 5$].
```

==== `sub-solution`

Nested solution box for multi-part problems.

```typ
#sub-solution[
  For part (a), we first note that...
]
```

==== `notes`

Purple box for additional notes or remarks.

```typ
#notes[
  Remember to check edge cases!
]
```

=== Complete Example

```typ
#import "@local/gat-typst:0.1.0": *

#show: homework.with(
  title: "HW02",
  course: "Linear Algebra",
  university: "MIT",
  author: "Student Name",
  email: "student@mit.edu",
  collaborators: [Alice, Bob],
  resources: [Textbook Chapter 3],
  date: datetime(year: 2025, month: 1, day: 15),
  cols: 1,
)

= Matrix Operations

#question(status: "done")[
  Let $A = mat(1, 2; 3, 4)$. Compute $A^T A$.
]

#solution[
  We compute:
  $
    A^T A = mat(1, 3; 2, 4) mat(1, 2; 3, 4)
    = mat(10, 14; 14, 20)
  $

  #sub-solution[
    Note that $A^T A$ is always symmetric.
  ]
]
```

#pagebreak()
== Cheatsheet Template

The `cheatsheet` template creates compact, three-column cheatsheets perfect for exams.

=== Usage

```typ
#show: cheatsheet.with(
  title: "Midterm",
  course: "Course Name",
  university: "University Name",
  author: "Your Name",
  email: "your@email.com",
  date: datetime.today(),
)
```

=== Parameters

Similar to `homework` but without `cols`, `show-header`, and `paper-size` (fixed to 3-column layout on US Letter with 0.5cm margins).

=== Features

- *3-column layout* with 0.3cm gutter
- *Compact spacing*: 6pt base font, 7pt level-1 headings, 6pt level-2/3
- *No page numbers*: Maximizes space
- *Centered headings*: Better visual organization

=== Example

```typ
#import "@local/gat-typst:0.1.0": *

#show: cheatsheet.with(
  title: "Final Exam Cheatsheet",
  course: "Calculus I",
  author: "Your Name",
  date: datetime(year: 2025, month: 5, day: 10),
)

= Derivatives

== Power Rule
$ dv(, x) x^n = n x^(n-1) $

== Product Rule
$ dv(, x) (f g) = f' g + f g' $

== Chain Rule
$ dv(, x) f(g(x)) = f'(g(x)) g'(x) $

= Integrals

== Power Rule
$ integral x^n dd(x) = x^(n+1)/(n+1) + C $
```

#pagebreak()
= Dependencies & Imports

The package integrates carefully selected external packages. The `style` function automatically imports core packages for math, code, and formatting.

== Overview

Active imports from `src/style/style.typ` (when using `#show: style.with()`):

```typ
// === Math ===
#import "@preview/equate:0.3.2": equate
#import "@preview/physica:0.9.6": *
#import "@preview/quick-maths:0.2.1": shorthands

// === Code ===
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": codly-languages

// === Display & Formatting ===
#import "@preview/fontawesome:0.6.0": *
#import "@preview/booktabs:0.0.4": *

// === Utilities ===
// Available through gat-typst but not auto-imported by style:
// #import "@preview/showybox:2.0.4": showybox
// #import "@preview/hydra:0.6.2": hydra

// === Diagramming === (not included in style, must import separately)
// #import "@preview/cetz:0.4.2": canvas, draw
// #import "@preview/cetz-plot:0.1.2": plot
// #import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
// #import "@preview/lilaq:0.5.0" as lq

// === Additional Math === (not included in style)
// #import "@preview/matset:0.1.0"
// #import "@preview/mannot:0.3.0": *

// === Additional Code === (not included in style)
// #import "@preview/callisto:0.2.4"
// #import "@preview/lovelace:0.3.0": pseudocode-list
// #import "@preview/cmarker:0.1.6"

// === Additional Display === (not included in style)
// #import "@preview/frame-it:1.2.0": *

// === Compatibility === (not included in style)
// #import "@preview/mitex:0.2.5": mitex, mitex-convert, mitext

// === Color === (not included in style)
// #import "@preview/splash:0.5.0": xcolor
// #import "@preview/typpuccino:0.1.0": frappe, latte, macchiato, mocha
```

== Diagramming

*Note: Diagramming packages are not included in `style`. Import them explicitly if needed.*

=== CeTZ (v0.4.2)

Comprehensive drawing library for creating custom diagrams.

```typ
#import "@preview/cetz:0.4.2": canvas, draw

#canvas({
  import draw: *
  circle((0, 0), radius: 1)
  line((0, 0), (1, 1))
  content((0, 0), $x$)
})
```

Use for: Custom diagrams, network architectures, geometric figures.

=== CeTZ Plot (v0.1.2)

Plotting extension for CeTZ.

```typ
#import "@preview/cetz-plot:0.1.2": plot

#canvas({
  plot.plot(
    size: (8, 6),
    x-tick-step: 1,
    y-tick-step: 1,
    {
      plot.add(x => x * x, domain: (-2, 2))
    }
  )
})
```

Use for: Function plots, data visualization.

=== Fletcher (v0.5.8)

Arrow diagrams and state machines.

```typ
#diagram(
  node((0, 0), $A$, radius: 2em),
  node((1, 0), $B$, radius: 2em),
  edge((0, 0), (1, 0), "->", $f$),
)
```

Use for: State machines, flowcharts, commutative diagrams.

=== Lilaq (v0.5.0)

Modern data visualization library.

```typ
#lq.diagram(
  title: [Data Plot],
  xlabel: $x$,
  ylabel: $y$,
  lq.plot((0, 1, 2, 3), (1, 4, 2, 3), mark: "o"),
)
```

Use for: Scientific plots, cleaner syntax than CeTZ Plot.

== Math

*Note: Equate, Physica, and Quick-maths are automatically imported by `style`. Other math packages must be imported explicitly.*

=== Matset (v0.1.0)

*Not included in `style` - import explicitly if needed.*

Set notation support.

Use for: Mathematical set operations and notation.

=== Equate (v0.3.2)

*Included in `style` - automatically available.*

Advanced equation numbering with breakable equations.

#columns(2)[
  ```typ
  $
    f(x) = x^2
  $ <eq:quadratic>

  Reference: @eq:quadratic
  ```
  #colbreak()

  $
    f(x) = x^2
  $ <eq:quadratic-example>

  // Reference: @eq:quadratic-example
]

Use for: Equation numbering and cross-referencing.

=== Physica (v0.9.6)

*Included in `style` - automatically available.*

Comprehensive physics notation package.

Key functions:

#columns(2)[
  ```typ
  $vb(x)$             // Vector bold
  $vu(u)$             // Unit vector
  $dd(x)$             // Differential
  $dv(f, x)$          // Derivative
  $pdv(f, x, y)$      // Partial
  $grad f$, $div vb(F)$, $curl vb(F)$
  $iprod(u, v)$       // Inner product
  $norm(x)$           // Norm
  $abs(x)$            // Absolute value
  $Set(x, x > 0)$     // Set builder
  $dmat(1, 2, 3)$     // Diagonal matrix
  $evaluated(f)_a^b$  // Evaluation bar
  ```
  #colbreak()

  $vb(x)$ #h(1em) $vu(u)$ #h(1em) $dd(x)$

  $dv(f, x)$ #h(1em) $pdv(f, x, y)$

  $grad f$ #h(1em) $div vb(F)$ #h(1em) $curl vb(F)$

  $iprod(u, v)$ #h(1em) $norm(x)$ #h(1em) $abs(x)$

  $Set(x, x > 0)$

  $dmat(1, 2, 3)$

  $evaluated(f)_a^b$
]

Example:

#columns(2)[
  ```typ
  $
    dv(vb(x), t) = vb(v), quad
    pdv(f, x, y, [2, 1]) = 0, quad
    iprod(vb(u), vb(v)) = norm(vb(u)) norm(vb(v)) cos theta
  $
  ```
  #colbreak()

  $
    dv(vb(x), t) = vb(v), quad
    pdv(f, x, y, [2, 1]) = 0, quad
    iprod(vb(u), vb(v)) = norm(vb(u)) norm(vb(v)) cos theta
  $
]

Use for: Almost all physics and advanced math notation.

=== Quick-maths (v0.2.1)

*Included in `style` - automatically available.*

Math shorthand system (powers the operator replacements).

See "Important Behavior Changes" section for details.

=== Mannot (v0.3.0)

*Not included in `style` - import explicitly if needed.*

Math annotations and labels.

#columns(2)[
  TODO: FIX
  ```typ
  $
    p_i = exp(-beta E_i) / sum_j exp(-beta E_j)
    #annot(<beta>, pos: top)[Inverse temperature]
  $
  ```
  #colbreak()


  // $
  //   p_i = exp(-beta E_i) / sum_j exp(-beta E_j)
  //   #annot(<beta>, pos: top)[Inverse temperature]
  // $
]

Use for: Annotating complex equations, teaching materials.

== Code

*Note: Codly and Codly Languages are automatically imported by `style`. Other code packages must be imported explicitly.*

=== Callisto (v0.2.4)

*Not included in `style` - import explicitly if needed.*

Jupyter notebook rendering.

```typ
#let (render, Cell, In, Out) = callisto.config(
  nb: json("notebook.ipynb"),
)

#In("cell-tag")   // Show input cell
#Out("cell-tag")  // Show output cell
#Cell("cell-tag") // Show both
```

Use for: Including Jupyter notebook code/output in documents.

=== Lovelace (v0.3.0)

*Not included in `style` - import explicitly if needed.*

Pseudocode formatting.

```typ
#pseudocode-list[
  + *Input:* Array $A$ of length $n$
  + *Output:* Sorted array
  + *for* $i = 1$ *to* $n$ *do*
    + Process element $A[i]$
]
```

Use for: Algorithm descriptions.

=== Codly (v1.3.0) + Codly Languages (v0.1.1)

*Included in `style` - automatically available.*

Modern syntax highlighting for code blocks.

When using `style`, automatically configured with:
- 8pt font size
- 1pt black stroke
- Zebra striping (gray.lighten(80%))

```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

Supports: Python, Rust, JavaScript, TypeScript, Java, C++, and 50+ more languages.

Use for: All code snippets. Automatically applied to raw blocks.

=== Cmarker (v0.1.6)

*Not included in `style` - import explicitly if needed.*

CommonMark (Markdown) support.

Use for: Converting Markdown to Typst.

== Display & Formatting

*Note: FontAwesome and Booktabs are automatically imported by `style`. Other display packages must be imported explicitly.*

=== Frame-it (v1.2.0)

*Not included in `style` - import explicitly if needed.*

Custom frame styles for content boxes.

```typ
#let (example, definition) = frames(
  example: ("Example", blue),
  definition: ("Definition", green),
)

#example[Title][Tag][
  Body content here.
]
```

Use for: Theorem environments, examples, definitions.

=== FontAwesome (v0.6.0)

*Included in `style` - automatically available.*

Font Awesome icon support (version 6).

```typ
#fa-icon("heart")
#fa-icon("calculator")
#fa-icon("robot")
```

Use for: Visual indicators, status icons. Note: Requires Font Awesome fonts installed.

=== Showybox (v2.0.4)

*Available through gat-typst utilities (base for `gatbox`).*

Styled, breakable boxes.

```typ
#showybox(
  title: "Title",
  frame: (border-color: blue),
  breakable: true,
)[
  Content
]
```

Use for: Custom boxes, callouts, highlighted content.

=== Hydra (v0.6.2)

*Available through gat-typst but not included in `style`.*

Context-aware page headers showing current section.

```typ
#import "@preview/hydra:0.6.2": hydra

#set page(header: context [
  #text(fill: gray)[*#hydra(2)*]
])
```

Use for: Displaying current section in headers. Used by the `homework` template.

=== Booktabs (v0.0.4)

*Included in `style` - automatically available.*

Publication-quality table styling.

When using `style`, automatically applied to all tables. Creates professional spacing and rules.

Use for: All tables. No manual configuration needed when using `style`.

== Compatibility

*Note: Compatibility packages are not included in `style`. Import them explicitly if needed.*

=== MiTeX (v0.2.5)

*Not included in `style` - import explicitly if needed.*

LaTeX compatibility layer for including LaTeX code.

```typ
#mitex(`
  \begin{bmatrix}
    1 & 2 \\
    3 & 4
  \end{bmatrix}
`)
```

Use for: Converting existing LaTeX, complex LaTeX-only constructs.

== Color

*Note: Color packages are not included in `style`. Import them explicitly if needed.*

=== Splash (v0.5.0)

*Not included in `style` - import explicitly if needed.*

Extended color support including xcolor names.

```typ
#text(fill: xcolor("red!50!blue"))[Mixed color]
```

Use for: Advanced color specifications.

=== Typpuccino (v0.1.0)

*Not included in `style` - import explicitly if needed.*

Catppuccin color schemes (frappe, latte, macchiato, mocha).

```typ
#import "@preview/typpuccino:0.1.0": mocha

#text(fill: mocha.red)[Catppuccin red]
```

Use for: Consistent color theming.


#pagebreak()

= Complete Examples

== Simple Homework Document

```typ
#import "@local/gat-typst:0.1.0": *

#show: homework.with(
  title: "Problem Set 1",
  course: "Calculus II",
  university: "Your University",
  author: "Your Name",
  email: "you@example.com",
  date: datetime(year: 2025, month: 2, day: 1),
)

#show: style.with()

= Integration by Parts

#question(status: "done")[
  Evaluate $integral x e^x dd(x)$.
]

#solution[
  Using integration by parts with $u = x$ and $dv(, x) = e^x dd(x)$:

  $
    integral x e^x dd(x)
    &= x e^x - integral e^x dd(x) \
    &= x e^x - e^x + C \
    &= e^x (x - 1) + C
  $
]
```

== Math-Heavy Solution with Custom Functions

```typ
#import "@local/gat-typst:0.1.0": *

#show: homework.with(
  title: "Statistics Assignment",
  course: "Probability Theory",
  author: "Student",
  email: "student@school.edu",
)

#show: style.with()

= Random Variables

#question(status: "done")[
  Let $X$ and $Y$ be independent random variables.
  Show that $Var(X + Y) = Var(X) + Var(Y)$.
]

#solution[
  By definition:
  $
    Var(X + Y) &= Ex((X + Y)^2) - (Ex(X + Y))^2 \
    &= Ex(X^2 + 2X Y + Y^2) - (Ex(X) + Ex(Y))^2 \
    &= Ex(X^2) + 2Ex(X Y) + Ex(Y^2) - (Ex(X))^2 - 2Ex(X)Ex(Y) - (Ex(Y))^2
  $

  Since $X$ and $Y$ are independent, $Ex(X Y) = Ex(X) * Ex(Y)$:
  $
    Var(X + Y) &= Ex(X^2) - (Ex(X))^2 + Ex(Y^2) - (Ex(Y))^2 \
    &= Var(X) + Var(Y)
  $

  #sub-solution[
    *Note:* This result generalizes: for independent $X_1, ..., X_n$,
    $
      Var(sum_(i=1)^n X_i) = sum_(i=1)^n Var(X_i)
    $
  ]
]
```

== Compact Cheatsheet

```typ
#import "@local/gat-typst:0.1.0": *

#show: cheatsheet.with(
  title: "Midterm Cheatsheet",
  course: "Linear Algebra",
  author: "Your Name",
  date: datetime(year: 2025, month: 3, day: 15),
)

#show: style.with()

#let gatbox = gatbox.with(color-cycle: true)

= Matrix Operations

#gatbox(title: [Transpose])[
  $(A^T)_(i j) = A_(j i)$

  $(A B)^T = B^T A^T$
]

#gatbox(title: [Determinant])[
  $det(A B) = det(A) * det(B)$

  $det(A^T) = det(A)$

  $det(A^(-1)) = 1/det(A)$
]

= Eigenvalues

#gatbox(title: [Definition])[
  $A vb(v) = lambda vb(v)$

  $det(A - lambda I) = 0$
]

#gatbox(title: [Properties])[
  $product_(i=1)^n lambda_i = det(A)$

  $sum_(i=1)^n lambda_i = "tr"(A)$
]

= Vector Spaces

#gatbox(title: [Subspaces])[
  *Null space:* $cal(N)(A) = Set(vb(x), A vb(x) = vb(0))$

  *Column space:* $cal(C)(A) = Set(A vb(x), vb(x) in RR^n)$

  *Row space:* $cal(C)(A^T)$
]

#gatbox(title: [Fundamental Theorem])[
  $dim cal(C)(A) + dim cal(N)(A) = n$

  $cal(C)(A)^perp = cal(N)(A^T)$
]
```

#pagebreak()

= Tips & Best Practices

Based on conventions and optimal usage of this package:

== Math Notation

1. *Use semantic symbols* instead of generic ones:
  ```typ
  // Good
  $grad f$              // Gradient
  $product_(i=1)^n x_i$ // Product

  // Avoid
  $nabla f$
  $Pi_(i=1)^n x_i$
  ```

2. *Space before subscripts with functions:*
  ```typ
  // Good
  $V_pi (s)$   // Value function of policy π at state s
  $Q_theta (s, a)$

  // Bad (no space before parenthesis)
  $V_pi(s)$
  $Q_theta(s, a)$
  ```

3. *Use physica utilities for common notation:*
  ```typ
  $vb(x)$          // Vector bold
  $vu(n)$          // Unit vector
  $cal(A)$         // Mathcal letters (script)
  $dd(x)$          // Differential
  $dv(f, x)$       // Derivative
  $pdv(f, x, y)$   // Partial derivative
  $iprod(u, v)$    // Inner product (not angle brackets)
  $norm(x)$        // Norm (not ||x||)
  $abs(x)$         // Absolute value
  $eval(f)_a^b$    // Evaluation bar
  ```

4. *Leverage custom statistics functions:*
  ```typ
  // These are colored and use square brackets
  $Ex(X)$      // Expectation
  $Var(X)$     // Variance
  $Pr(A)$      // Probability
  ```

== Layout

1. *Two-column homework* for dense problems:
  ```typ
  #show: homework.with(
    cols: 2,
    // ... other params
  )

  // Override for specific solutions
  #solution(cols: 1)[
    This needs full width.
  ]
  ```

2. *Color-cycle boxes* for organizing content:
  ```typ
  #gatbox(color-cycle: true, title: "Theorem 1")[...]
  #gatbox(color-cycle: true, title: "Theorem 2")[...]
  #gatbox(color-cycle: true, title: "Theorem 3")[...]
  // Automatically cycles: blue → red → green → orange → purple
  ```

3. *Status tracking* for homework progress:
  ```typ
  #question(status: "done")[Completed problem]
  #question(status: "partial")[Work in progress]
  #question(status: "todo")[Not started]
  ```

== Organization

1. *Use sub-solutions* for complex multi-part problems:
  ```typ
  #solution[
    Main solution approach...

    #sub-solution[
      For part (a), we have...
    ]

    #sub-solution[
      For part (b), note that...
    ]
  ]
  ```

2. *Add notes* for clarifications or caveats:
  ```typ
  #notes[
    This assumes the matrix is invertible.
    For singular matrices, use pseudoinverse.
  ]
  ```

3. *Label equations* for cross-referencing:
  ```typ
  $
    f(x) = x^2 + 2x + 1
  $ <eq:quadratic>

  From @eq:quadratic, we see that...
  ```

== Code

1. *Always specify language* for proper highlighting:
  ```python
  def example():
      pass
  ```

  Not just:
  ````
  def example():
      pass
  ````

2. *Use Callisto for notebook integration:*
  ```typ
  #let (render, Cell, In, Out) = callisto.config(
    nb: json("notebook.ipynb"),
  )

  // Tag cells in notebook, then reference them
  #In("data-loading")
  #Out("plot-results")
  ```

== Performance

1. *Compile time*: Heavy imports may slow compilation. Consider splitting large documents.

2. *Font Awesome*: Requires fonts installed system-wide. If icons don't render, install Font Awesome fonts.

3. *Cheatsheet margins*: 0.5cm is very tight. Adjust if printing issues occur:
  ```typ
  #set page(margin: 0.7cm)  // Before cheatsheet.with()
  ```

== Common Pitfalls

1. *Shorthand conflicts*: If you need literal `*` for multiplication:
  ```typ
  $a ast b$  // Use 'ast' explicitly
  ```

2. *Superscript confusion*: Remember `^*` becomes star:
  ```typ
  $x^*$      // Renders as x⋆ (star)
  $x^ast$    // Renders as x* (asterisk if needed)
  ```

3. *Column overrides*: Don't forget to override `solution` for full-width content in 2-column layouts:
  ```typ
  #let solution = solution.with(cols: 1)
  ```

#pagebreak()

= Reference

== Quick Import Guide

```typ
// Full import
#import "@local/gat-typst:0.1.0": *

// Selective import
#import "@local/gat-typst:0.1.0": homework, question, solution, gatbox

// Import specific utilities
#import "@local/gat-typst:0.1.0": Ex, Var, KL, vb, cal
```

== Template Comparison

#table(
  columns: 4,
  [*Feature*], [*style*], [*homework*], [*cheatsheet*],
  [Columns], [N/A], [1 or 2], [3 (fixed)],
  [Font size], [N/A], [13pt (1-col) / 10pt (2-col)], [6pt],
  [Headers], [None], [Optional], [None],
  [Margins], [N/A], [~1 inch], [0.5cm],
  [Question boxes], [No], [Yes], [No (manual)],
  [Equation numbers], [Yes (when used)], [Yes], [Yes],
)

== Function Reference

=== Styling
- `style(enable-shorthands: true, body)`

=== Templates
- `homework(title, course, university, author, email, ...)`
- `cheatsheet(title, course, university, author, email, ...)`

=== Components
- `question(status: "none", ...)`
- `solution(cols: 1, body)`
- `boxed-solution`
- `sub-solution(...)`
- `notes(...)`

=== Boxes
- `gatbox(color: black, color-cycle: false, ...)`
- `showybox(...)`

=== Math (Statistics)
- `Ex()` - Expectation
- `Var()` - Variance
- `Cov()` - Covariance
- `Corr()` - Correlation
- `Pr()` - Probability

=== Math (Other)
- `KL(p, q)` - KL divergence
- `refPol` - Reference policy
- `st`, `If`, `Else`, `Then` - Logic
- `clamp(x)`, `solve(x)` - Functions

=== Utilities
- `date-format(date)` - Format datetime
- `math-func(name, ...)` - Create custom math function
- `super-ast-as-star` - Show rule for `^*`

== Further Reading

For detailed package documentation:

- *Physica*: https://github.com/Leedehai/typst-physics
- *CeTZ*: https://cetz-package.github.io/docs/
- *Fletcher*: https://github.com/typst/packages/blob/main/packages/preview/fletcher/
- *Codly*: https://typst.app/universe/package/codly
- *Typst Documentation*: https://typst.app/docs/

== Version History

*v0.1.0* (Current)
- Initial release
- Templates: homework, cheatsheet
- Optional styling function with math shorthands, code highlighting, and table formatting
- Math utilities and custom box system
- Core package integrations (equate, physica, codly, booktabs, fontawesome)

---

#align(center)[
  #text(size: 10pt, style: "italic")[
    For issues, suggestions, or contributions, see the project repository.
  ]
]

