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
| New proof at zero dividends | `b'' >= 0`, with `h=0` | Open; full implication from three analytic inputs checked using the old CCJZ contract; those inputs remain unproved |
| Published CCJZ theorem | `b'' > 0` at `h=0`, hence stock-boundary positive curvature | Open; previous initial-data construction retained and checked |
| Liu parameter range | New proof's `b'' >= 0` when `h+1 <= k` | Open; physical condition checked; the full conditional assembly applies, but its three analytic inputs remain unproved |
| Full proposed extension | `b'' >= 0` for `0 <= h <= k`, `k>0` | Open; full implication from three analytic inputs, including strict stock-curvature consequence, checked; those inputs remain unproved |

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

### Step 4: exact roots, confinement, and the initialization bridge

`InitialRoots.lean` proves more than an initial interval shape: for each positive
level below some initial continuation value there are exactly two roots, both
strictly inside `x>0`, and both are simple. The intermediate value theorem
supplies them, the initial two-point cover excludes others, and the previously
proved simple-level result applies. Equality with the algebraic initial profile
on a neighborhood identifies the actual initial spatial derivatives as nonzero.

`RootConfinement.lean` proves, from the pricing contract alone, that every
small-positive-time root lies in any chosen open neighborhood of those two
initial roots. The uniform tail provides a fixed right truncation. Continuity
of `b` at expiry gives a fixed left truncation. Below strike, the actual initial
difference is nonpositive by payoff domination; the proof does not use the
zero-payoff formula there. Relative joint continuity and compactness exclude
roots on the rest of the truncated interval, including the expiry corner.

`RootStability.lean` proves the precise remaining initialization implication:
if the spatial derivative of the actual normalized difference extends
continuously from `t>=0` to each initial root, its nonzero value gives a small
spatial interval on which every sufficiently early time slice is injective.
Confinement to two such intervals then gives an at-most-two-root cover.
Overlapping neighborhoods and empty root subsets are allowed. If no initial
value exceeds the level, the proved maximum principle instead keeps the entire
evolution below it; critical peak levels need no simple-root argument.

The combined level-initialization split has a named zero-dividend specialization
using the original CCJZ contract. **The derivative-trace premise is still open.**
It was not added to the solution contract or proved by the compactness argument.
This checkpoint neither asserts that confinement bounds the number of roots
inside a neighborhood nor propagates a count to arbitrary later times.

### Step 4: spatial root-count consequences and passage to zero level

`ZeroCountGeometry.lean` proves that a continuous spatial profile with endpoint
values strictly below a level has an interval-shaped strict superlevel set if
its level set has at most two points. Two positive points separated by a value
at or below the level would produce three distinct roots by the intermediate
value theorem. This also rules out an isolated zero separating positive pieces;
merely counting sign changes would need additional care there.

`ComparisonIntervals.lean` applies this result to the actual normalized
comparison. Its boundary sign, continuity, and fixed negative right truncation
are discharged from already proved results. The two-root premise remains
explicit and unproved at general positive times. Levels with no value above
them give the empty set, so no root-count premise is needed in that branch.

Finally, interval superlevel sets at every positive level imply that `{v>0}`
is an interval: for two positive endpoints, choose half their minimum value
as the level. This avoids any regularity or simple-root claim at level zero.
The zero-dividend specialization uses the original normalized solution
contract; it is not an independent published-proof verification. These results
finish the spatial and epsilon-to-zero implications, **not Sturm propagation**.

### Steps 4 and 5: maximum principle and the earlier positive point

`ParabolicMaximum.lean` proves the weak maximum principle for
`u_t <= u_xx + D(x,t) u_x` on a compact moving strip, INCLUDING its terminal
time. The strip is compact by a proved unit-interval parameterization; its left
boundary need only be continuous. At a positive maximum, the spatial derivative
vanishes, the second derivative is nonpositive, and the time derivative is
nonnegative (using a left-hand time neighborhood). Subtracting
`epsilon*(t-a+1)` reduces the weak inequality to a strict contradiction.
No maximum-principle axiom or literature theorem is assumed. This elementary
principle does not need coefficient bounds, since the drift term vanishes at
the maximum; zero-number propagation is a separate, stronger theorem.

`ComparisonMaximum.lean` applies it to the actual normalized difference on the
unbounded moving continuation region, using the checked tail bound to truncate.
`straightDifference_le_of_initial_le` says that an entire time slice bounded
above by a nonnegative level remains so at all later times. Its starting time
may be expiry. Thus the no-positive-data branch of Step 4 is proved without
initial derivative convergence. There is a named zero-dividend specialization
with the original CCJZ contract and the constant second profile.

`straightDifference_positive_at_earlier_time` proves the contrapositive needed
for Step 5: a positive value later forces a strictly positive point inside the
continuation region at every earlier time slice. In particular it supplies
the claimed `x_1` at tangency once a later positive line value is supplied.
Neither theorem assumes or proves the single-positive-interval invariant.

### Step 5: terminal-time barrier and smooth-fit contradiction

`ParabolicHopf.lean` proves a terminal boundary-point lemma using the stationary
barrier `eta*(exp(lambda*y)-1)`. On a backward rectangle, positive bottom and
right edges provide a positive barrier scale by compactness. The left edge is
nonnegative. A lower bound on the drift allows a positive `lambda` for which
the barrier is a subsolution. The proved weak maximum principle then bounds
the solution below by the barrier, including at the terminal time. A slope
limit gives the strictly positive RIGHT derivative. This does not require an
extension past the terminal time or differentiability across the left boundary.

`MovingLine.lean` checks the exact space-time chain rule for
`w(y,t)=v(y+d-c*t,t)`: its drift is the original drift MINUS `c`.
`ComparisonHopf.lean` applies it to the actual normalized price difference,
obtaining `w_t=w_yy+(alpha-c+2f'/f)w_y`. The drift's lower bound is derived from
the explicit profile's characteristic-root bounds.

`lineDifference_fit` derives value zero and one-sided derivative zero at line
contact directly from value matching and the pricing contract's RIGHT smooth
fit. `lineDifference_no_positive_rectangle` then rules out a backward rectangle
whose straight left edge is at or above the actual boundary, touches it at the
terminal time, and has positive bottom and right edges. The nonnegative left
edge follows automatically from payoff domination. A named zero-dividend
version uses the original CCJZ solution contract.

`Tangency.lean` now constructs the rectangle. A future point of strict line
inclusion gives a positive value, hence an earlier positive point at contact.
In moving coordinates, continuity keeps a fixed positive right endpoint positive
near the contact time. The explicit interval hypothesis fills in the bottom edge
between that endpoint and the positive line value. This contradicts the checked
terminal-rectangle lemma. The interval hypothesis is still unproved.

### Step 1 and the conditional global curvature implication

`TangentGeometry.lean` proves that negative second derivative gives strict
inequality below the tangent in a punctured neighborhood. It uses local strict
concavity and secant-slope inequalities, with positive-time smoothness only.

`TangentIntercept.lean` verifies the derivatives of `d(t)=b(t)-t*b'(t)` and
`b(t)/t`. Given the near-expiry ratio limit, the mean value theorem gives a
negative intercept before every positive time. If curvature is nonnegative at
negative-intercept tangents, then `d'<=0` wherever `d<0`. A proved scalar fencing
argument applied to `exp(t)*d(t)` shows negative intercepts persist forward.
Thus curvature control at negative-intercept tangents implies it everywhere.
The near-expiry ratio limit itself has not been proved for the pricing solution.

`ComparisonAssembly.lean` proves the exact remaining implication:

```text
DividendPutSolution k h p b
+ b'(t)<0 for every t>0
+ b(t)/t -> -infinity as t -> 0+
+ for every c>0,d<0,t>0, the positive continuation set of v is an interval
  ==> b''(t)>=0 for every t>0.
```

The zero-dividend version uses the original CCJZ contract. The strict
stock-curvature consequence is also checked: weak log curvature plus nonzero
log speed makes `b''+(b')^2` strictly positive under the exact coordinate map.
**This is a conditional assembly, not the completed theorem.** The three inputs
are explicit theorem premises, not new fields of the pricing-solution contract,
not axioms, and not asserted results. The interval input is precisely the main
unresolved propagation claim, not something proved merely by this assembly.

## Analytic dependencies still to prove

1. **First-order and expiry inputs.** Prove negative boundary speed and
   near-expiry `b(t)/t -> -infinity` from the pricing problem. Intercept selection
   and the negative-curvature tangent geometry are now checked conditionally.
2. **Step 4, initialization.** Initial shape, the at-most-two-root bound,
   exact two-simple-root characterization, corner/tail control, and compact
   confinement are checked. The count-stability implication from initial
   derivative traces is checked. Derive those traces from the pricing PDE
   (for example by proving the required initial-time derivative convergence).
3. **Step 4, propagation.** Prove the necessary parabolic zero-number result
   and connect its exact hypotheses to the checked coefficient
   and truncation bounds. The weak maximum principle, the spatial implication
   from root counts to interval superlevels, and the positive-level to zero-level
   passage are proved. Do not assume the desired invariant as a field of the
   pricing-solution contract.
4. **Step 5.** The earlier-positive-point argument, terminal-rectangle
   smooth-fit contradiction, and geometric assembly are checked. Discharge
   their single-interval premise through the missing Step 4 propagation proof.
5. **Financial applicability.** Establish the properties needed for the
   actual American value, including boundary regularity and monotonicity,
   rather than only proving a conditional theorem for an uninhabited contract.
6. **Conclusions.** Discharge the three inputs of the checked global assembly
   to prove the curvature claims and their parameter specializations. Stock
   transfer is checked. Retain the separate CCJZ route and its stronger target.

For the informal audit, [Lou's Theorem 1.2 and Lemma 2.1](https://arxiv.org/pdf/1809.00309)
provide an appropriate moving-boundary zero-number statement: with nonzero
boundary values, continuous boundary curves suffice. This avoids introducing
`b'(0+)` through a coordinate change, but does not by itself initialize the
zero count. **A literature citation is not an imported Lean theorem.**

The now-checked terminal barrier is in coordinates `y=x-ell(t)`:

```text
w_t = w_yy + beta(y) w_y,
beta(y) = alpha-c+2 f'(y)/f(y),
psi(y) = exp(lambda*y)-1,
psi''+beta psi' = lambda exp(lambda*y)(lambda+beta) > 0.
```

On a backward rectangle satisfying the stated edge hypotheses, the checked
comparison gives a strictly positive right derivative at terminal contact,
contradicting smooth fit. The rectangle construction is now checked conditional
on the single-interval property; that property remains an open obligation.

## Verification boundaries

All new proof modules use Mathlib, not MathFin's pricing theorems. No `sorry`,
new axiom, numerical output, or purported review is used as a proof premise.
Selected new declarations have build-enforced axiom guards.

The pasted numerical reports have not been reproduced. The named solver/test
scripts and figure were not supplied in this repository at the initial audit.
No novelty claim is certified by either these reports or the current Lean build.
