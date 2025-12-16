# gat-typst

<div align="center">Version 0.1.0</div>

A personal Typst template collection for academic writing, featuring homework and cheatsheet templates with extensive math notation support and optional enhanced styling.

> **Note:** This is a personal library for Gatlen Culp's usage and is unstable. Feel free to use it, but expect breaking changes.

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./thumbnail-dark.svg">
  <img src="./thumbnail-light.svg">
</picture>


## Features

- **Templates**: Professional homework and cheatsheet layouts
- **Math Utilities**: Custom notation for statistics, ML/RL, and physics
- **Optional Styling**: Enhanced code highlighting, table formatting, and math shorthands (opt-in)
- **Custom Boxes**: Color-coded question/solution boxes with status tracking
- **Package Integration**: Carefully selected packages from the Typst ecosystem (equate, physica, codly, booktabs)

## Installation

### Local Installation

Clone this repository to your local Typst packages directory:

```bash
# Unix-like systems (macOS, Linux)
git clone https://github.com/yourusername/gat-typst ~/.local/share/typst/packages/local/gat-typst/0.1.0

# Windows
git clone https://github.com/yourusername/gat-typst %APPDATA%\typst\packages\local\gat-typst\0.1.0
```

Or use the provided justfile:

```bash
just install
```

## Quick Start

### Homework Template

```typ
#import "@local/gat-typst:0.1.0": *

#show: homework.with(
  title: "Problem Set 1",
  course: "Linear Algebra",
  university: "Your University",
  author: "Your Name",
  email: "you@example.com",
  date: datetime.today(),
)

// Optional: Enable enhanced styling
#show: style.with()

#question(status: "done")[
  Compute the determinant of $A = mat(1, 2; 3, 4)$.
]

#solution[
  $det(A) = 1 dot 4 - 2 dot 3 = -2$
]
```

### Cheatsheet Template

```typ
#import "@local/gat-typst:0.1.0": *

#show: cheatsheet.with(
  title: "Midterm Cheatsheet",
  course: "Probability Theory",
  author: "Your Name",
)

#show: style.with()

#let gatbox = gatbox.with(color-cycle: true)

= Key Formulas

#gatbox(title: [#fa-icon("calculator") Expectation])[
  $ Ex(X) = sum_x x Pr(X = x) $
]

#gatbox(title: [#fa-icon("chart-line") Variance])[
  $ Var(X) = Ex(X^2) - (Ex(X))^2 $
]
```

## Optional Styling

The `style` function provides enhanced features (opt-in via `#show: style.with()`):

- **Math Shorthands**: `*` → dot product, `~~` → approx, `..` → spacing
- **Code Styling**: Syntax highlighting with zebra striping
- **Table Styling**: Professional booktabs-style tables
- **Superscript Transforms**: `^T` → transpose, `^+` → dagger, `^*` → star

## Math Utilities

Custom functions available without requiring `style`:

```typ
$Ex(X)$        // Expectation
$Var(X)$       // Variance
$Pr(A)$        // Probability
$KL(p, q)$     // KL divergence
```

Plus all functions from the `physica` package: `vb()`, `dd()`, `dv()`, `iprod()`, `norm()`, etc.

## Custom Boxes & Icons

**Color-cycling boxes** with optional FontAwesome icons:

```typ
#show: style.with()  // Required for fa-icon

#let gatbox = gatbox.with(color-cycle: true)

#gatbox(title: [#fa-icon("lightbulb") Important])[
  Content automatically cycles through colors: blue → red → green → orange → purple
]

#gatbox(title: [#fa-icon("triangle-exclamation") Warning])[
  Second box gets a different color automatically.
]
```

Or specify colors manually:

```typ
#gatbox(color: red, title: "Critical")[
  Fixed red color box.
]
```

## Documentation

See [docs/manual.typ](docs/manual.typ) for comprehensive documentation including:
- Detailed template parameters
- Complete math utilities reference
- All available packages and their usage
- Style behavior changes
- Tips and best practices

Compile the manual:

```bash
typst compile --root . docs/manual.typ docs/manual.pdf
```

## Development

```bash
# Run tests
just test

# Update test references
just update

# Generate documentation
just doc

# Full CI suite
just ci
```

## License

This is a personal project. Use at your own risk.

## Acknowledgments

Built with packages from the Typst community including physica, equate, codly, booktabs, showybox, and many others.