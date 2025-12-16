# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is `gat-typst`, a personal Typst template collection providing homework and cheatsheet templates with extensive math notation support, custom styling, and utility functions. It's structured as a Typst package that can be installed locally or as a preview package.

**Package name:** `gat-typst`
**Version:** 0.1.0
**Entrypoint:** `src/lib.typ`

## Development Commands

### Building and Testing
```bash
# Run test suite
just test

# Update test cases
just update

# Generate documentation and thumbnails
just doc

# Run full CI suite (tests + docs)
just ci
```

### Package Management
```bash
# Install to local namespace (@local/gat-typst:0.1.0)
just install

# Install to preview namespace for pre-release testing (@preview/gat-typst:0.1.0)
just install-preview

# Uninstall from local namespace
just uninstall

# Uninstall from preview namespace
just uninstall-preview
```

### Compiling Typst Files
```bash
# Compile a specific Typst file to PDF
typst compile path/to/file.typ output.pdf

# Watch and auto-recompile on changes
typst watch path/to/file.typ output.pdf
```

## Architecture

### Core Structure

**`src/lib.typ`** - Main entrypoint that imports and re-exports:
- `src/style/style.typ` - Math shorthand operators, code styling, table styling
- `src/templates/homework.typ` - Homework template with question/solution boxes
- `src/templates/cheatsheet.typ` - Compact 3-column cheatsheet template

**`src/utils/utils.typ`** - Utility functions including:
- Math notation helpers (statistics functions, ML/RL notation)
- Custom box components (`gatbox`, wrapping `showybox`)
- Math font configuration in `gat-fonts` dictionary
- Show rules for transpose (`^T`), dagger (`^+`), and star (`^*`) notation

**`src/style/style.typ`** - Centralized styling that applies:
- Math shorthands via `quick-maths` (e.g., `*` → dot product, `~~` → approx)
- Code highlighting via `codly` with zebra striping
- Custom table styling via `booktabs`
- Physics notation via `physica` package
- Equation numbering via `equate`

### Template System

Templates are stored in two locations:
1. **`src/templates/`** - Source template functions exported by the library
2. **`template/`** - Example usage files that demonstrate the templates

Each template folder in `template/` contains a `.typ` file that:
- Imports from `../preamble.typ` (common imports)
- Applies the template with `#show: template-name.with(...)`
- Applies styling with `#show: style.with()`

### Key Dependencies

External packages used extensively:
- `@preview/showybox` - Colored boxes for questions/solutions
- `@preview/physica` - Physics and math notation
- `@preview/quick-maths` - Math operator shorthands
- `@preview/codly` - Code syntax highlighting
- `@preview/equate` - Enhanced equation numbering
- `@preview/hydra` - Page headers with section context
- `@preview/booktabs` - Professional table styling

## Template Usage

### Homework Template

The `homework` template provides:
- Customizable header with course info, author, collaborators, resources
- `question(status: "done"|"partial"|"todo")` - Color-coded question boxes
- `solution(cols: 1)` - Solution container with column support
- `notes` - Purple note boxes
- `sub-solution` - Blue nested solution boxes
- Automatic equation numbering and section numbering

**Status colors:**
- `"done"` → green
- `"partial"` → yellow
- `"todo"` → red
- `"none"` → black (default)

### Cheatsheet Template

The `cheatsheet` template provides:
- 3-column layout with 0.5cm margins
- 6pt base font size
- Compact spacing optimized for reference sheets

## Important Notes

### Performance Considerations
The codebase imports many packages which causes notable performance issues. The author is aware and has commented on this in README.md line 8.

### Math Font Configuration
Custom math fonts are defined in `src/utils/utils.typ` in the `gat-fonts` dictionary:
- Code fonts: FiraCode Nerd Font Mono
- Math fonts: New Computer Modern Math (default), Fira Math (sans), GFS Neohellenic Math (light)

Use `RV(x)` function to render random variables in the sans math font.

### Style Show Rules
The `style()` function applies several show rules that transform notation:
- `^T` → transpose symbol
- `^+` → dagger symbol
- `^*` → star symbol
- Various operator shorthands (see `src/style/style.typ` lines 38-63)

### Template Structure Pattern
When creating new template examples:
1. Import from `../preamble.typ`
2. Apply template: `#show: template-name.with(...)`
3. Apply styling: `#show: style.with()`
4. Content follows

### Testing
Tests use the `tt` (typst-test or tytanic) test framework. Test files are in `tests/` directory with subdirectories for different test suites.
