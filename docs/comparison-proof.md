# Straight-line comparison proof: target and verification frontier

## Target, conventions, and milestones

The current goal is to verify the user's proposed proof for the Black--Scholes
American put with constant continuous dividend yield:

```text
K > 0, sigma > 0, r > 0, 0 <= q <= r,
a = sigma^2 / 2, t = a tau,
b(t) = log(B(t/a) / K),
k = r/a, h = q/a, alpha = k-h-1.

Target: b''(t) >= 0 for every t > 0.
Consequence, once b'(t)<0 is established: B''(tau) > 0.
```

Time is time REMAINING, and arguments of prices are `(x,t)`. This is not
convexity of a price in stock price. No smoothness at expiry is asserted.

The user also requests the weaker parameter regimes as instructive milestones.
We retain the published-proof development; a specialization of the new proof
will not be described as an independent verification of a published proof.

| Milestone | Required conclusion | Current status |
| --- | --- | --- |
| New proof at zero dividends | `b'' >= 0`, with `h=0` | Open; comparison, initial shape, normalized PDE, tail and coefficient bounds checked; named initial-shape and tail theorems use the old CCJZ contract |
| Published CCJZ theorem | `b'' > 0` at `h=0`, hence stock-boundary positive curvature | Open; previous initial-data construction retained and checked |
| Liu parameter range | New proof's `b'' >= 0` when `h+1 <= k` | Open; payoff bound specialized, physical condition checked; general initial-shape/PDE/tail/coefficient results apply |
| Full proposed extension | `b'' >= 0` for `0 <= h <= k`, `k>0` | Open; comparison, payoff domination, initial shape, normalized PDE, corner/boundary signs, tail and coefficient bounds checked |

CCJZ Theorem 1.1 explicitly proves positive logarithmic curvature at zero
dividends. The proposed weak logarithmic conclusion is not new at `q=0`.
Liu's introduction identifies the then-open range `0<q<r<q+sigma^2/2`.
Neither observation is a present-day priority determination.

- [CCJZ, Theorem 1.1](https://sites.pitt.edu/~chadam/papers/3CCJW9-28-05.pdf)
- [Liu, introduction](https://arxiv.org/pdf/1304.5337)

## What is kernel-checked

### Solution statement and parameter normalization

`DividendProblem.lean` specifies the classical dividend-paying PDE, payoff,
exercise/continuation conditions, regularity, boundedness, decay, and right-sided
smooth fit. It does NOT assume boundary monotonicity or convexity, any zero-count
invariant, or a maximum principle. The rate conditions are explicit.

`dividendPutSolution_zero_iff` proves exact equivalence with the preexisting
`NormalizedPutSolution` at `h=0`. `normalized_dividend_regime` checks the physical
parameter inequalities; `liu_condition_normalization` proves that `h+1<=k`
is equivalent to `q+sigma^2/2<=r`.

The curvature targets are named **proposition definitions**, not asserted
theorems. Their elementary specialization implications are proved, without
asserting any of the open premises. Existence and identification with the
continuous-time GBM stopping value are still separate, unproved obligations.

### Step 2: explicit comparison construction

`Comparison.lean` constructs the elementary ODE profiles explicitly. At positive
killing rate it uses the two real characteristic roots; at zero killing rate it
uses the constant function one, including the double-root case.

Checked results include global smoothness, the ODE, value one and slope zero
at zero, and `F(z)>=1` for ALL real `z`. The last fact uses the exponential's
tangent inequality, not an assumption about the unknown option price.

`straightPrice_equation` proves the actual partial-derivative pricing equation
for the explicit comparison. `straightPrice_fit` proves both value matching and
smooth fit along `x=d-ct`. These theorems do not leave existence of `f,g` as an
assumption. In particular the killing rate in the second ODE is `h`, not `k`.

### Step 3: domination below strike

`excess_equation` checks identity (8) with actual first and second derivatives:

```text
H'' + (alpha-c) H' - k H
  = k - h exp(ell+z) + c exp(ell+z)(g(z)-1).
```

`ODEComparison.lean` replaces the Cauchy-kernel integral by a proved two-sided
integrating-factor comparison. For real roots `u,v`, set

```text
W(x) = exp(-u*x) [H'(x)-v*H(x)],
U(x) = exp(-v*x) H(x).
W'(x) = exp(-u*x) [H''(x)-(u+v)H'(x)+u*v*H(x)].
```

Nonnegative forcing makes `W` nondecreasing. Its value at zero is zero, so
`U'` is nonpositive to the left and nonnegative to the right. Hence `U>=0`,
and thus `H>=0`, on both sides of zero. The lemma is proved from ordinary
derivative monotonicity and has no integral-representation or PDE assumptions.

`straightPrice_dominates` concludes the payoff bound for `x<=0`, `t>=0`,
`d<=0`, `c>=0`, `0<=h<=k`. Named zero-dividend and Liu-range specializations
are also checked. These are comparison lemmas, not curvature theorems.

### Step 4: initial shape and normalized PDE (not propagation)

The Riccati derivative of `F'/F`, the derivative of `R=exp(-z)f/g`, and
`J(0)=-1` are checked. `slope_gap_crosses_up` proves the actual derivative
identity `J'(z)=c` whenever `J(z)=0`. `positive_root_gap` proves
`lambda>mu+1` from the two characteristic equations when `c>0`; it also
allows `mu=0` for the constant zero-dividend profile.

`SingleCrossing.lean` proves that a differentiable function with a positive
derivative at each zero stays nonnegative once nonnegative, and has at most
one zero. This uses Mathlib's scalar fencing theorem, not a parabolic principle.
With `R'=R*J` and `R>0`, `R(y)<=max(R(x),R(z))` whenever `x<=y<=z`.
Thus every strict sublevel set of `R` is an interval or empty. A stationary
point is a global minimum; Rolle's theorem excludes three points at one level.

`ComparisonShape.lean` applies these results to the explicit initial profile.
It checks equation (15), proves that each level set is covered by two points
(so infinite zero sets are excluded), and proves that levels below a higher
initial value have nonzero derivatives at all their roots. This supplies the
simple-root condition at noncritical levels without assuming a unique peak.

`normalizedDifference_initial_superlevel` identifies the shape theorem with
the actual pricing-solution difference, restricted to `x>0`, where the initial
payoff is zero. No zero-payoff assertion is made for negative log prices.
The explicit-profile shape theorem needs `k>0`, `h>=0`, `c>0`; `h<=k` and
negative line intercept are needed elsewhere, not for this algebraic shape.

`GaugeTransform.lean` proves equation (12) by differentiating the actual
quotient, with only LOCAL smoothness assumptions. The application derives
those assumptions from `DividendPutSolution`: continuity of the boundary
makes a continuation point interior, and the price's local regularity suffices.
There is no extra assumption that the normalized difference solves a PDE.

The epsilon-shift is checked to satisfy the same no-zero-order equation.
The actual moving-boundary value is strictly negative for `epsilon>0`,
`c>=0`, `d<=0`. Continuity holds up to expiry; the shifted difference is
strictly negative in a relative neighborhood of `(0,0)` in `t>=0`.

### Step 4: right truncation and coefficient bounds

`ComparisonTail.lean` proves an explicit estimate, using only `0<=p<=1`
from the pricing solution and the exponential profiles:

```text
|v(x,t)+1| <= C [exp(-lambda*x) + exp(-delta*x)],
C>0, lambda>0, delta>0, x>=0, t>=0, c>0, d<=0.
```

Consequently `v(x,t)->-1` uniformly over ALL nonnegative times, not just a
fixed finite horizon. A single positive right endpoint makes `v<0` for every
nonnegative time. No uniform price-decay assumption is introduced. At `h=0`,
the second profile's growth exponent is zero because that profile is constant;
the proof does not substitute an unrelated positive characteristic root.
`zeroDividend_uniform_tail` states the result with the original CCJZ contract.

`ComparisonCoefficients.lean` bounds `f'/f` between the two characteristic
roots and bounds its derivative using the proved Riccati identity. It follows
that the normalized drift `alpha+2f'/f`, its spatial derivative, and its time
derivative have a common bound on the entire space-time plane. No derivative
of the exercise boundary is used, and the estimates include zero dividends.

Derivative convergence near the initial roots and positive-time zero-count
initialization/propagation remain open. An initial shape theorem does NOT
assert that the evolution preserves the shape.

## Analytic dependencies still to prove

1. **Step 1.** Near-expiry `b(t)/t -> -infinity`, tangent-intercept selection,
   and the geometric consequences of a strictly negative second derivative.
2. **Step 4, initialization.** Initial shape, the at-most-two-root bound,
   simplicity at noncritical levels, the relative corner sign, and uniform
   tail control are checked. Prove derivative convergence near the simple
   initial zeros and stability of the count at small positive times.
3. **Step 4, propagation.** Prove the necessary parabolic maximum/zero-number
   results and connect their exact hypotheses to the checked coefficient and
   truncation bounds. Pass from positive levels to the positivity set. Do not
   assume the desired invariant as a field of the pricing-solution contract.
4. **Step 5.** Formalize the existence of a positive point at tangency and the
   backward-strip comparison barrier giving the smooth-fit contradiction.
5. **Financial applicability.** Establish the properties needed for the
   actual American value, including boundary regularity and monotonicity,
   rather than only proving a conditional theorem for an uninhabited contract.
6. **Conclusions.** Prove the curvature claims and their parameter specializations;
   transfer to stock units. Preserve the distinction between weak and strict
   logarithmic curvature. Retain the separate CCJZ route and its stronger target.

For the informal audit, [Lou's Theorem 1.2 and Lemma 2.1](https://arxiv.org/pdf/1809.00309)
provide an appropriate moving-boundary zero-number statement: with nonzero
boundary values, continuous boundary curves suffice. This avoids introducing
`b'(0+)` through a coordinate change, but does not by itself initialize the
zero count. **A literature citation is not an imported Lean theorem.**

The suggested final barrier is in coordinates `y=x-ell(t)`:

```text
w_t = w_yy + beta(y) w_y,
beta(y) = alpha-c+2 f'(y)/f(y),
psi(y) = exp(lambda*y)-1,
psi''+beta psi' = lambda exp(lambda*y)(lambda+beta) > 0.
```

On a small backward rectangle, a small multiple of `psi` is bounded above by
`w` on its initial and lateral edges. Weak comparison would give a strictly
positive right derivative at the terminal tangency, contradicting smooth fit.
This is an audited informal route, not yet a checked lemma.

## Verification boundaries

All new proof modules use Mathlib, not MathFin's pricing theorems. No `sorry`,
new axiom, numerical output, or purported review is used as a proof premise.
Selected new declarations have build-enforced axiom guards.

The pasted numerical reports have not been reproduced. The named solver/test
scripts and figure were not supplied in this repository at the initial audit.
No novelty claim is certified by either these reports or the current Lean build.
