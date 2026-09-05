# Verified initial-data construction (CCJZ Lemma 3.4)

**The main boundary-curvature theorem is still not proved.** This development
completes the initial-data construction used by the published proof. It does not
propagate those initial properties through a Stefan evolution.

## Statements actually proved

For the explicit family `appendixProfile k epsilon` and each `k > 0`:

| Source condition | Lean evidence |
| --- | --- |
| (2.3), smoothness, integrability, positivity, decay and compatibility | `appendixProfile_initialData` in `Boundary/Profiles.lean` |
| (2.6), total mass tends to 1 and mass below every fixed positive threshold tends to 1 | `appendixProfile_concentration` in `Boundary/ProfileConcentration.lean` |
| (3.1), positive derivative before one peak, negative afterwards, strictly negative second derivative at the peak | `scaledProfile_peak_geometry`, instantiated by `appendixProfile_sign_conditions` |
| (3.2), one downward crossing of the spatial operator before the peak, with the required signs and negative derivative | `scaledProfile_operator_geometry`, instantiated by `appendixProfile_sign_conditions` |
| (3.8), strictly negative derivative of the operator/slope quotient up to that crossing | `operator_quotient_deriv_neg`, instantiated by `appendixProfile_sign_conditions` |

The final sign-condition theorem is for the actual `spatialOperator k q / deriv q`,
not just an unrelated polynomial expression. Its proof transfers the quotient
identity on a neighborhood with nonzero denominator before differentiating.

The finite-upper-limit mass integral is Lean's interval integral `0..z`, for
`z > 0`; the total mass is the integral over `(0, infinity)`. Both limits use the
right-neighborhood filter at `epsilon = 0`, so negative and zero epsilon do not
enter the approximation. All individual profile conditions hold for every
positive epsilon, which is stronger than the sufficiently-small-epsilon scope
needed in the source.

These statements collectively establish the initial-data assertion of CCJZ
Lemma 3.4. They assert no Stefan existence, zero-number principle, boundary
convergence, or curvature theorem.

## Exact replacement for the appendix sign estimates

Write `b = a*epsilon > 0`, `c = epsilon^(-2) > 0`, `y = c*x`, and

```text
H(y) = b*y + y^2/2
A(y) = b + (1-b)*y - y^2/2
B(y) = 1-2*b - (2-b)*y + y^2/2
q(x) = c*H(y)*exp(-y).
```

The unique positive zero of `A` is
`y1 = 1-b + sqrt(1+b^2)`. Factorization proves its sign on either side.
The spatial operator, after removing its positive factor `c*exp(-y)`, is a
quadratic. Compatibility makes its initial value positive; at `y1` it is
negative. `quadratic_downward_crossing` proves that such a quadratic has one
downward zero inside the interval, with strict signs on both sides.

Where `A(y) > 0`, the quotient has the exact derivative

```text
d/dx [(Lq)(x)/q'(x)]
  = [-c^2*(A(y) + (1-b-y)^2) - k*(b^2+b*y+y^2/2)] / A(y)^2
  < 0,                         for x >= 0, k >= 0.
```

This removes the need to interpret the source's `O(epsilon)` remainder in (3.8).
Lean checks the identity, cancellation of the exponential, nonzero denominator,
and strict sign. It is not a numerical check or a small-parameter conjecture.

## Exact concentration proof

The tail antiderivative is

```text
Tail(b,y) = [y^2/2 + (b+1)*y + b+1] * exp(-y).
```

The fundamental theorem of calculus gives

```text
integral from z to infinity q(x) dx = Tail(b,c*z)    (z >= 0)
integral from 0 to infinity q(x) dx = 1+b
integral from 0 to z q(x) dx = 1+b-Tail(b,c*z).
```

Continuity of the explicitly constructed coefficient gives `a -> sqrt(k)` and
therefore `b -> 0`. For fixed `z > 0`, `c*z -> infinity`; each polynomial times
exponential term in the tail tends to zero. These facts prove both limits (2.6).

## Why this does not close Theorem 1.1

No proof term has been constructed for `NormalizedCurvatureClaim` or
`NormalizedExistenceClaim`. The following independent obligations remain:

1. Existence and uniqueness of suitable Stefan and obstacle solutions, with the
   boundary and corner regularity required downstream.
2. Parabolic zero-number and Hopf arguments that propagate the initial sign
   geometry (Lemmas 3.1--3.2).
3. The strong maximum-principle/Robin-boundary argument for the quotient in
   Lemma 3.3, giving positive curvature of the approximating boundaries.
4. Convergence of boundaries and derivatives, and the strictness argument in
   the final passage to the limit. Initial-data concentration alone proves none
   of these convergence statements.
5. Identification with the finite-horizon GBM optimal-stopping value.

The pinned dependencies have not supplied the needed parabolic results in the
searches performed. MathFin's European Black--Scholes PDE results concern an
explicit European formula, not this free-boundary problem. No new MathFin result
is used in these profile proofs.

The main theorem has deliberately not been replaced by a theorem that assumes
these curvature or convergence conclusions. The original target and its open
status remain unchanged.
