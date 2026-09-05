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
Consequence, using the now-proved b'(t)<0: B''(tau) > 0.
```

Time is time REMAINING, and arguments of prices are `(x,t)`. This is not
convexity of a price in stock price. No smoothness at expiry is asserted.

The user also requests the weaker parameter regimes as instructive milestones.
We retain the published-proof development; a specialization of the new proof
will not be described as an independent verification of a published proof.

| Milestone | Required conclusion | Current status |
| --- | --- | --- |
| New proof at zero dividends | `b'' >= 0`, with `h=0` | Proved on the original normalized classical contract |
| Published CCJZ theorem | `b'' > 0` at `h=0`, hence stock-boundary positive curvature | Open; previous initial-data construction retained and checked |
| Liu parameter range | New proof's `b'' >= 0` when `h+1 <= k` | Proved on the dividend classical contract; physical parameter correspondence checked |
| Full proposed extension | `b'' >= 0` for `0 <= h <= k`, `k>0` | Proved on the dividend classical contract; that contract is now identified with the actual raw-filtration stopping value |
| Strict stock-boundary consequence | `B'' > 0` for the full regime, including zero dividends and Liu's range | Proved on the classical contracts, with no additional speed premise; both time conventions checked |

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

The three weak curvature targets are named proposition definitions, now proved
by the corresponding theorems in `ComparisonConclusion.lean`. The published
strict log-curvature target remains open. Identification with the constructed
continuous-time GBM stopping value is now proved from the contract. Existence
of a pair satisfying that contract remains unproved.

### Exercise-boundary calculus and obstacle comparison

`ExerciseGeometry.lean` proves ordinary spatial differentiability at contact
by joining the exercise payoff's left derivative to right-sided smooth fit.
It then proves `b(t)<0` for every positive time: otherwise the nonnegative
price would attain zero at the strike with derivative minus one. Consequently
`k-h*exp(b(t))>0`, including when `h=k`. These conclusions do not assume
negative boundary speed or convexity. In the open exercise region, local
equality to the payoff gives smoothness and the classical supersolution
inequality; the continuation PDE gives the same inequality on the other side.

`OneSidedContact.lean` proves that a stationary maximum on the left gives a
nonpositive second derivative. Applying it to a smooth test minus the exercise
payoff shows that at a spatial maximum of test minus price, the test's first
derivative is `-exp(b(t))` and its second derivative is at most `-exp(b(t))`.
Only local test smoothness is needed. No second price derivative across the
boundary is asserted.

`BoundaryTest.lean` differentiates the test minus payoff along the moving
boundary at a backward contact maximum. Smooth fit cancels the boundary-speed
term, leaving a nonnegative test time derivative. The strict forcing above
then rules out a nonnegative contact maximum for a pricing subsolution.

`ObstacleComparison.lean` assembles a comparison theorem on compact strips
with two continuous moving endpoints, which may coincide at expiry. A positive
maximum is excluded separately in the continuation region, exercise interior,
and on the free boundary. The first two use classical derivatives; the third
uses the proved boundary test. Compactness is proved by a unit-interval
parameterization, including zero-width slices. There is a named zero-dividend
specialization on the original normalized pricing contract. The local-test
version requires smoothness and the subsolution inequality only where the
candidate exceeds the price, allowing a candidate with its own exercise obstacle.

### First-order inputs from delayed-price comparison

`DelayedPrice.lean` defines `D(x,t)=p(x,max(t-a,0))` for a nonnegative delay `a`.
It is continuous and has initial payoff. Wherever it exceeds the payoff,
`t>a` and `x>b(t-a)`, so its local smoothness and pricing PDE are checked.

`LocalizationBarrier.lean` proves that
`W(x,t)=exp((2+|k-h-1|)*t)*(1+x^2)` is a positive pricing supersolution and is
at least `1+x^2` for nonnegative time. `TimeMonotonicity.lean` compares
`D-epsilon*W` with `p` on a sufficiently large finite rectangle. At a potential
positive contact, `D` exceeds the payoff, so the local-test comparison applies.
Boundedness of the price and the explicit quadratic lower bound control both
spatial endpoints. Removing the positive penalty pointwise proves `D<=p`, hence
`p(x,s)<=p(x,t)` whenever `0<=s<=t`. No uniform decay estimate or financial
optimal-stopping representation is used for this proof.

`BoundaryMonotonicity.lean` then proves `b(t)<=b(s)` for `0<=s<=t`: otherwise a
point exercised at the later time would have had price strictly above payoff
at the earlier time, contradicting price monotonicity. This yields `b'(t)<=0`.
At any hypothetical point with `b''(t)<0`, one must have `b'(t)<0`; if instead
`b'(t)=0`, that would be a local maximum of the nonpositive function `b'`, forcing
`b''(t)=0`. This supplies exactly the speed needed for the negative-curvature
tangent contradiction. **It does not prove `b'(t)<0` at every positive time.**
Named zero-dividend price and boundary monotonicity checkpoints use the original
normalized pricing contract.

### Step 1: near-expiry input, now proved

`ExpiryBarrier.lean` constructs
`U(x,t)=(sqrt(t)-x)^2/(16*sqrt(t))` on `|x|<=sqrt(t)` for `t>0`.
Its derivatives are checked:

```text
U_x = (x-sqrt(t))/(8*sqrt(t)),
U_xx = 1/(8*sqrt(t)),
U_t = (1-x^2/t)/(32*sqrt(t)).
```

On the strip, `0<=U<=sqrt(t)/4`; this also proves relative continuity at the
collapsing initial slice. The right edge is zero. The left edge is `sqrt(t)/4`,
below the intrinsic payoff when `t<=1`. The pricing subsolution inequality is
proved when `(|k-h-1|+k)*sqrt(t)<=1/4` and `t<=1`. Continuity constructs a
strictly positive time window with these properties. Applying the proved
obstacle comparison gives `U<=p` on that entire strip.

`NearExpiry.lean` evaluates the bound at `x=-sqrt(t)/64`. There `U>=sqrt(t)/16`,
whereas `1-exp(x)<=sqrt(t)/64`. That point cannot be exercised, so
`b(t)<-sqrt(t)/64` on the positive time window. This deliberately non-sharp
bound implies `b(t)<-M*t` eventually for every fixed real `M`, and hence
`b(t)/t -> -infinity` as `t -> 0+`.

The ratio-limit theorem depends only on `DividendPutSolution`, not negative
boundary speed, convexity, a European asymptotic, or a new analytic axiom. The
zero-dividend specialization uses the original normalized pricing contract.
This proves the expiry input required by Step 1, not the sharp published
near-expiry asymptotic; it supplies one input to the completed curvature proof.

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
initialization/propagation remain open in the retained Sturm route. They are
not needed by the direct propagation proof below. An initial shape theorem
alone does NOT assert that the evolution preserves the shape.

### Step 4: completed direct three-point propagation

`SmoothValley.lean` defines, for `delta>0`,

```text
phi(a) = (a + sqrt(a^2 + delta^2))/2,
psi(a,c) = a - phi(a-c),
V(a,b,c) = psi(a,c) - phi(b).
```

The derivative of `phi` lies strictly between zero and one. Consequently `V`
is strictly increasing in its endpoint arguments and strictly decreasing in
its middle argument. It approximates `min(a,c)-max(b,0)` from below, with
error at most `delta`.

`OrderedTriples.lean` proves compactness of the ordered equal-time triples in
a compact moving strip. `ParabolicValley.lean` maximizes
`V(U(x,t),U(y,t),U(z,t))-eta*t`, for `eta>0`, on those triples. The initial
three-point bound and nonpositive boundary values exclude a positive maximum
at the initial time, a spatial boundary, or a collision `x=y` or `y=z`.
Strict monotonicity of `V` makes `U` attain spatial local maxima at `x,z` and
a local minimum at `y`. The equation `U_t=U_xx+D*U_x` therefore gives
nonpositive endpoint time derivatives and a nonnegative middle time derivative.
The time derivative of `V-eta*t` is strictly negative, contradicting the
one-sided time derivative inequality at a maximum. This includes a maximum
at the terminal time.

`ParabolicUnimodality.lean` removes both positive perturbations and concludes
`min(U(x,t),U(z,t)) <= max(U(y,t),0)` whenever `x<=y<=z`. It requires continuity
at initial time, not initial derivative traces. No zero-count theorem or
bounded-drift assumption is used in this compact maximum argument.

`ComparisonUnimodality.lean` supplies the actual comparison's PDE, regularity,
boundary signs, fixed negative right truncation, and initial three-point bound
from the initial superlevel geometry. It proves that every nonnegative strict
superlevel is an interval, including the positive set needed for tangency.
The named zero-dividend theorem uses the original normalized contract.

The following root-count modules are retained as an alternative development;
their open premises are not dependencies of the completed curvature theorem.

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
terminal-rectangle lemma. `ComparisonUnimodality.lean` now supplies the interval
hypothesis for the actual comparison.

### Step 1 and the global curvature conclusion

`TangentGeometry.lean` proves that negative second derivative gives strict
inequality below the tangent in a punctured neighborhood. It uses local strict
concavity and secant-slope inequalities, with positive-time smoothness only.

`TangentIntercept.lean` verifies the derivatives of `d(t)=b(t)-t*b'(t)` and
`b(t)/t`. Given the near-expiry ratio limit, the mean value theorem gives a
negative intercept before every positive time. If curvature is nonnegative at
negative-intercept tangents, then `d'<=0` wherever `d<0`. A proved scalar fencing
argument applied to `exp(t)*d(t)` shows negative intercepts persist forward.
Thus curvature control at negative-intercept tangents implies it everywhere.
`NearExpiry.lean` now supplies the ratio limit for the actual pricing contract.

`ComparisonAssembly.lean` retains the modular implication:

```text
DividendPutSolution k h p b
+ for every c>0,d<0,t>0, the positive continuation set of v is an interval
  ==> b''(t)>=0 for every t>0.
```

The zero-dividend version uses the original CCJZ contract. The log-curvature
assembly does not assume global strict speed: it uses the proved speed result
only at a hypothetical negative-curvature point. Its modular strict stock-curvature
lemma retains a strict-speed argument, now supplied by `StrictBoundarySpeed.lean`.
That conclusion uses positivity of `b''+(b')^2`, not just nonnegativity.
`ComparisonConclusion.lean` discharges that interval premise and proves:

```text
DividendPutSolution k h p b ==> forall t>0, b''(t)>=0.
```

`dividend_curvature_claim`, `zeroDividend_weak_curvature_claim`, and
`liuRange_curvature_claim` inhabit the three named weak-curvature targets.
No interval, speed, expiry, zero-count, or derivative-trace assumption was added
to the pricing contract. The weaker parameter cases specialize this proof;
they are not independent verifications of the published proofs.

### Strict boundary speed and the stock-curvature consequence

`FlatTail.lean` proves that the boundary derivative is nondecreasing, using
the completed weak log-curvature theorem. Since it is also nonpositive, zero
speed at a positive time would force zero speed and a constant boundary at
every subsequent time. This reduction does not use strictness in the weak
log-curvature proof and creates no circular dependency.

`PositiveBump.lean` constructs `Q(x)=x^2*(L-x)^2`. For `L>0` and `|D|<=M`,

```text
Q'' + D*Q' + (M^2+16/L^2)*Q >= 0.
```

The proof rewrites the expression as a sum of squares and a nonnegative term.
Multiplying `Q` by `eta*exp(-(M^2+16/L^2)*(t-a))` gives a positive interior
subsolution vanishing at both spatial endpoints. `PositivePropagation.lean`
chooses `eta>0` below a compact positive bottom edge and applies the proved
weak maximum principle. Moving-line coordinates carry the positive patch
along a straight tube, with drift bound increased by the tube's absolute speed.

`StrongPositivity.lean` starts from one positive point, uses continuity to
choose a positive bottom patch, and constructs a tube to any specified
interior point at a strictly later time. This proves a strong positivity
principle for a nonnegative solution on a spatial half-line with bounded drift.
It is not an imported PDE axiom and needs no derivative trace at initial time.

`TimeIncrement.lean` applies the stationary positive-profile gauge to
`p(x,t+delta)-p(x,t)`. The earlier continuation region is contained in the
later one by the already-proved boundary monotonicity. The gauged increment
satisfies a no-zero-order equation with bounded drift and is nonnegative by
price monotonicity. It is initially positive above strike.
`IncrementPositivity.lean` propagates this positivity above strike, then to
every later interior point on any hypothetical flat boundary tail. At a
boundary shared by the two time slices, it proves both zero value and zero
spatial derivative from value matching and smooth fit.

`StrictBoundarySpeed.lean` excludes a flat tail. A decreasing straight line
lies strictly above the constant boundary before its terminal contact. A
backward rectangle to its right therefore has strictly positive bottom and
right edges for the gauged increment. The checked terminal Hopf lemma gives
a positive spatial derivative at contact, contradicting the zero derivative.
Together with `FlatTail.lean`, this proves `b'(t)<0` at every positive time.

Finally `StockConclusion.lean` supplies the proved strict speed to the coordinate
formula and obtains strict stock curvature with no additional premise. It
defines `remainingTimeBoundary E sigma b tau = E*exp(b(sigma^2/2*tau))` and
checks that time reversal preserves the second derivative. Named zero-dividend
and Liu-range theorems specialize the strict stock conclusion. The combined
`dividend_boundary_conclusions` theorem states negative speed, weak log curvature,
and strict stock curvature together. It does not assert strict log curvature.

## Analytic dependencies still to prove

1. **Financial applicability.** Establish existence of a pair satisfying the
   classical contract, including the required boundary regularity and smooth
   fit. Monotonicity is already derived from
   the contract; it is not a separate contract assumption.
   The stopping value is now defined on a constructed Brownian space with
   natural filtration, and its payoff bounds, spot shape, joint price continuity,
   and contact threshold
   are proved independently of the classical contract. Contact martingality and
   global supermartingality now prove price identification, boundary identification,
   and both actual-boundary curvature conclusions from the contract. Equality
   with the completed usual-filtration value and its boundary curvature are
   also proved. A normalized candidate is now defined directly from the usual
   stopping value, with joint continuity, initial payoff and bounds proved
   without a classical-solution premise. Classical existence/regularity remains open; see
   [the financial verification frontier](stopping-value.md).
2. **Independent published proof and strictness.** Retain the separate CCJZ
   route and its stronger strict log-curvature target. The three checked weak
   claims do not prove that strict result or independently verify its proof.
3. **Optional Sturm route.** Initial derivative traces and general positive-time
   zero-count propagation remain unproved. These would complete the retained
   root-count approach, but are not prerequisites of the direct proof.

For the original informal Sturm audit, [Lou's Theorem 1.2 and Lemma 2.1](https://arxiv.org/pdf/1809.00309)
provide an appropriate moving-boundary zero-number statement: with nonzero
boundary values, continuous boundary curves suffice. This avoids introducing
`b'(0+)` through a coordinate change, but does not by itself initialize the
zero count. This citation is not used by the direct three-point proof.
**A literature citation is not an imported Lean theorem.**

The now-checked terminal barrier is in coordinates `y=x-ell(t)`:

```text
w_t = w_yy + beta(y) w_y,
beta(y) = alpha-c+2 f'(y)/f(y),
psi(y) = exp(lambda*y)-1,
psi''+beta psi' = lambda exp(lambda*y)(lambda+beta) > 0.
```

On a backward rectangle satisfying the stated edge hypotheses, the checked
comparison gives a strictly positive right derivative at terminal contact,
contradicting smooth fit. The rectangle construction and the single-interval
property supplying its premise are now both checked.

## Verification boundaries

All new proof modules use Mathlib, not MathFin's pricing theorems. No `sorry`,
new axiom, numerical output, or purported review is used as a proof premise.
Selected new declarations have build-enforced axiom guards.

The pasted numerical reports have not been reproduced. The named solver/test
scripts and figure were not supplied in this repository at the initial audit.
No novelty claim is certified by either these reports or the current Lean build.
