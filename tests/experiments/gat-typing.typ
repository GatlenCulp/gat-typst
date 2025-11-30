#import "@preview/elembic:1.1.1" as e: field, types

// - https://ewfrees.github.io/StyleGuideLDA/S-NotationConvention.html
// - https://www.shearsoneditorial.com/2012/07/typographical-conventions-for-mathematics/
// - https://mathvault.ca/hub/higher-math/math-symbols/probability-statistics-symbols/
// 
// 
// Pretty Gold: https://mathvault.ca/product/comprehensive-list-of-mathematical-symbols/

#let gat-fonts = (
  "code": ("default": "FiraCode Nerd Font Mono"),
  "math": (
    "default": "New Computer Modern Math",
    "sans": "Fira Math",
    "light": "GFS Neohellenic Math",
  ),
)


#let math-typing-font = gat-fonts.at("math").at("sans")


Hello

/// Defines a Random Variable
///
/// ```example
/// $RV(X)$
/// $RV(Y)$
/// $RV(Z)$
/// $RV(W)$
/// ```
///
/// -> content
#let RV(
  /// Symbol to use for the Random Variable. Should be single capital letter.
  /// -> content
  X,
) = text(
  font: math-typing-font,
  $#X$,
)

// $RV(X)$

/// Defines a Constant Variable
///
/// -> content | text
#let CONSTANT(
  /// Symbol to use for the Random Variable. Should be single capital letter
  /// str | symbol
  X,
) = text(
  font: math-typing-font,
  $#X$,
)

/// Defines a Scalar Variable
///
/// -> content | text
#let SCALAR(
  /// Symbol to use for the Random Variable. Should be single capital letter
  /// str | symbol
  X,
) = text(
  font: math-typing-font,
  $#X$,
)

/// Defines a Set Variable
///
/// -> content | text
#let SET(
  /// Symbol to use for the Random Variable. Should be single capital letter
  /// str | symbol
  X,
) = text(
  font: math-typing-font,
  $#X$,
)

/// Defines a Distribution Variable
///
/// -> content | text
#let DISTRIBUTION(
  /// Symbol to use for the Random Variable. Should be single capital letter
  /// str | symbol
  X,
) = text(
  font: math-typing-font,
  $#X$,
)
