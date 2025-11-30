#import "preamble.typ": *

#show: homework.with(
  // title: "HW02",
  // date: datetime(year: 2025, month: 9, day: 22),
  cols: 2,
)
#let solution = solution.with(cols: 2)

Can open up font-book on Mac and search "math"

- https://www.tug.org/FontCatalogue/mathfonts.html
- https://fred-wang.github.io/MathFonts/

#let scr(it) = text(
  stylistic-set: 1,
  $cal(it)$,
)


$
  sans(sigma Sigma theta Theta vb(theta) A B C) \
  serif(sigma Sigma A B C) \
  frak(sigma Sigma a b C D) \
  bb(a b c D)\
  cal(A B C d e f theta Theta L)\
  scr(A B C d e f theta Theta L)\
$

You want OpenType Math Fonts, not just Unicode whic hahve limited support

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


Inline: $sqrt(2) + x_1$, $frac(pi^8, 2)$, $root(n, cal(L)')$,
$sum_(i=1)^n hat(f)(i)$, $cal(A)$ vs $script(A)$.

$
  vb(E) = cases(
    0 hat(vb(k))"," & z > d\/2,
    -frac(sigma, 2 epsilon_0) hat(vb(k))"," & d\/2 > z > -d\/2,
    0 hat(vb(k))"," & z < -d\/2
  )
$

$
  integral_(-oo)^(+oo)
  frac(16 sin(2x + pi), 5(x^2 + 2x + 5)^2)
  dd(x)
  = frac(pi sin(2), e^4)
$

Inline: $root(p, frac(x + y + z, alpha_2^1 - beta_0 - frac(sqrt(zeta), 3)))$,
$frak(g l)(RR)$.

$
  V(R) & = integral_(phi=0)^(2pi)
         integral_(theta=0)^pi
         integral_(r=0)^R
         r^2 sin(theta) dd(r) dd(theta) dd(phi) \
       & = (integral_(phi=0)^(2pi) dd(phi))
         (integral_(theta=0)^pi sin(theta) dd(theta))
         (integral_(r=0)^R r^2 dd(r)) \
       & = evaluated([phi])_(phi=0)^(2pi)
         evaluated([-cos(theta)])_(theta=0)^pi
         evaluated([frac(r^3, 3)])_(r=0)^R \
       & = frac(4, 3) pi R^3
$

$
  det(A)
  = sum_(sigma in S_n) epsilon(sigma)
  product_(i=1)^n a_(i, sigma(i))
$

$
  I_n = bb(1)_n
  = mat(
    1, 0, 0, dots, 0;
    0, 1, 0, dots, 0;
    0, 0, dots.down, , 0;
    dots.v, , , , dots.v;
    0, 0, dots, 0, 1
  )
$

#pagebreak()

#let math-block(font: "TeX Gyre Bonum Math", color: black) = gatbox(color: color)[
  #show math.equation: set text(font: font)
  Name: #font
  $
    sans(sigma Sigma theta Theta vb(theta) A B C) \
    serif(sigma Sigma A B C) \
    frak(sigma Sigma a b C D) \
    bb(a b c D)\
    cal(A B C d e f theta Theta L)\
    scr(A B C d e f theta Theta L)\
  $
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
]

#let math-block-2(font: "TeX Gyre Bonum Math", color: black) = gatbox(color: color)[
  #show math.equation: set text(font: font)
  Name: #font

  Inline: $sqrt(2) + x_1$, $frac(pi^8, 2)$, $root(n, cal(L)')$,
  $sum_(i=1)^n hat(f)(i)$, $cal(A)$ vs $script(A)$.

  $
    vb(E) = cases(
      0 hat(vb(k))"," & z > d\/2,
      -frac(sigma, 2 epsilon_0) hat(vb(k))"," & d\/2 > z > -d\/2,
      0 hat(vb(k))"," & z < -d\/2
    )
  $

  $
    integral_(-oo)^(+oo)
    frac(16 sin(2x + pi), 5(x^2 + 2x + 5)^2)
    dd(x)
    = frac(pi sin(2), e^4)
  $

  Inline: $root(p, frac(x + y + z, alpha_2^1 - beta_0 - frac(sqrt(zeta), 3)))$,
  $frak(g l)(RR)$.

  $
    V(R) & = integral_(phi=0)^(2pi)
           integral_(theta=0)^pi
           integral_(r=0)^R
           r^2 sin(theta) dd(r) dd(theta) dd(phi) \
         & = (integral_(phi=0)^(2pi) dd(phi))
           (integral_(theta=0)^pi sin(theta) dd(theta))
           (integral_(r=0)^R r^2 dd(r)) \
         & = evaluated([phi])_(phi=0)^(2pi)
           evaluated([-cos(theta)])_(theta=0)^pi
           evaluated([frac(r^3, 3)])_(r=0)^R \
         & = frac(4, 3) pi R^3
  $

  $
    det(A)
    = sum_(sigma in S_n) epsilon(sigma)
    product_(i=1)^n a_(i, sigma(i))
  $

  $
    I_n = bb(1)_n
    = mat(
      1, 0, 0, dots, 0;
      0, 1, 0, dots, 0;
      0, 0, dots.down, , 0;
      dots.v, , , , dots.v;
      0, 0, dots, 0, 1
    )
  $
]

// Ordered by decreasing preference
#let math-fonts = (
  // SERIF
  "New Computer Modern Math", // Default
  "STIX Two Math", // Extremely nice. Mix of serif and non-serif.
  // "XITS Math", // Alos extremely nice damn
  // "TeX Gyre Schola Math", // Very nice, crisp. Mix of serif and non serif. No double strike?
  // "TeX Gyre Pagella Math", // Decent
  // "TeX Gyre Termes Math", // Also nice. Compact, thin.
  // "Libertinus Math", // Pretty nice. Crisp, compact.
  //
  // SANS SERIF
  "Fira Math", // Very serif, slightly odd looking.
  // "TeX Gyre DejaVu Math", // More of a sans-serif font. No double strike :/ Looks good tho
  // "TeX Gyre Bonum Math", // Very wide, sort-of-serif
  //
  // Italics of Math Fonts
  "GFS Neohellenic Math", // Super thin, easy to read though.
  //
  // "Asana Math", // Looks fine, lots of errors though :/
  // NOT SHOWING
  // "Lete Sans Math", // Not showing still
  // "Latin Modern Math", // Not showing still
)

// Fonts that are not available/not working on this system
#let unavailable-fonts = (
  // "Cambria Math",
  // "DejaVu Math TeX Gyre", // Detected by linter
  // "Garamond Math",
  // "GFS Neohellenic Math", // Detected by linter
  // "InaiMathi", // Appears to not be a proper math font
  // "Latin Modern Math",
  // "Lete Sans Math",
  // "Libertinus Math", // Detected by linter
  // "Lucida Bright Math",
  // "NewComputerModernMath", // Detected by linter
  // "New Computer Modern Sans Math",
  // "Minion Math",
  // "XITS Math", // Detected by linter
)

#let get-font-color(font) = {
  if font in unavailable-fonts {
    red
  } else {
    black
  }
}

#for value in math-fonts {
  math-block(font: value, color: get-font-color(value))
}

#pagebreak()

#for value in math-fonts {
  math-block-2(font: value, color: get-font-color(value))
}


