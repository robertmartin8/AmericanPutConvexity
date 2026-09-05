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
| Actual normalized log boundary | `ConvexOn` on positive maturities, for the entire parameter regime | Proved directly for the usual-filtration stopping boundary without a classical contract or boundary smoothness; zero-dividend and Liu-range checkpoints included |
| Actual normalized stock boundary | Strict decrease and `StrictConvexOn` on positive maturities | Proved without boundary smoothness, with zero-dividend and Liu-range checkpoints; both actual boundaries are locally Lipschitz away from expiry |
| Actual physical-unit boundary | Log convexity, strict stock convexity, strict decrease and local Lipschitz continuity | Proved for the completed usual-filtration stopping threshold under only physical parameter assumptions; exact financial normalization and zero-dividend/Liu-range checkpoints included |
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

### Actual-value convexity without boundary smoothness

The stronger dependency audit in `ContinuousBoundaryProblem.lean` isolates a
pricing contract with **no boundary-smoothness field**. The original classical
contract is unchanged, and their equivalence after adding that field is proved.
`ActualContinuousContract.lean` establishes every weaker field from the actual
usual-filtration stopping value. The normalized comparison PDE, payoff
domination, initial profile, tails, three-point interval invariant and terminal
Hopf argument all work with the weaker contract.

`ActualComparisonIntervals.lean` consequently proves the proposed single-spatial-
interval invariant for the **actual** price. It also rules out a decreasing
line of nonpositive intercept that lies strictly above the boundary on a past
interval, reaches contact, and lies above it again at some later time. A
continuous first-contact selection turns this into the statement that
`{t>0 | b(t)<d-c*t}` is an interval whenever `c>0` and `d<=0`.

The remaining expiry input is proved directly, not assumed. A convex spatial
subsolution cannot have a maximum over the actual price in exercise: spatial
smooth fit and the exercise-side test force its second derivative to be at most
`-exp(x)`. In continuation the PDE excludes a positive space-time maximum.
`ActualConvexLowerComparison.lean` therefore applies the existing shrinking
square-root barrier to the actual price. `ActualNearExpiry.lean` proves
`b(t)<-sqrt(t)/64` for sufficiently small positive time, and hence `b(t)/t -> -infinity`.

`LineIntervalConvexity.lean` replaces the differentiable tangent reduction:

1. The expiry condition and line-interval property force `b(t)/t` to be
   nondecreasing. Otherwise a line through the origin would have a negative
   value of `b(t)+c*t` both before and after a zero value, contradicting the
   interval property at a slightly negative level.
2. Monotonicity of that ratio makes every chord's intercept nonpositive.
   Monotonicity of `b` makes its slope nonpositive.
3. For a strictly decreasing chord with negative intercept, shift it slightly
   upward. Its endpoints are in the strict line sublevel set, so every point
   between them is too. This excludes a point above the original chord.
   Zero-intercept chords follow from the ratio monotonicity, and horizontal
   chords from boundary monotonicity.

`canonicalLogBoundary_convexOn` in `ActualLogConvexity.lean` (namespace
`AmericanConvexity.Stopping`) assembles these results. Its only hypotheses are
`k>0`, `h>=0`, and `h<=k`. Named zero-dividend and Liu-range versions use the
same actual stopping-value definition. The statement is convexity of the
normalized log boundary as a function, not an assertion that classical second
derivatives exist. The literal differential conclusions for the
actual value remain separate obligations, as
does the retained independent CCJZ proof track.

### Actual strict decrease and strict stock convexity

`ActualIncrementPositivity.lean` normalizes the actual-price time increment
`p(x,t+delta)-p(x,t)` by the positive stationary profile. The normalized
increment solves a zero-order-free parabolic equation, is nonnegative by the
stopping value's time monotonicity, and is strictly positive above strike.
On a hypothetical flat boundary tail, the proved positive-propagation barrier
makes it strictly positive throughout continuation. At the shared exercise
boundary both its value and spatial derivative vanish by actual smooth fit.
`ActualNoFlatTail.lean` applies the terminal Hopf barrier in a slanted backward
strip to contradict those vanishing data. It never differentiates the boundary
in time.

`ConvexStrictMonotonicity.lean` supplies two derivative-free scalar facts:
a nonincreasing convex function without flat tails is strictly decreasing;
the exponential of an injective convex function is strictly convex.
`ActualStockConvexity.lean` therefore proves `StrictAntiOn` for both actual
boundaries and `StrictConvexOn` for the actual normalized stock boundary.
Zero-dividend and Liu-range checkpoints are explicit. Mathlib's convex-function
regularity also gives local Lipschitz continuity of both boundaries on `t>0`,
improving the preceding half-power bound. All these results have guarded
transitive axiom audits. Strict convexity as a function is not the stronger
assertion that a classical second derivative exists and is everywhere positive.

### Actual financial normalization and physical-unit conclusions

`ShrinkingGrids.lean` extends exercise-grid convergence to every positive mesh
sequence tending to zero. Rounding any bounded stopping rule upward changes its
time by at most the mesh; path continuity and bounded convergence then give the
American stopping supremum in the limit. No nesting of grids is needed.

`GridNormalization.lean` proves exact scaling of the deterministic Bellman
recursion. Multiplying times by `a=sigma^2/2`, replacing rates by `r/a,q/a`,
volatility by `sqrt(2)`, and log spot by `log(S/K)` preserves every drift and
Gaussian variance increment. Payoffs and values scale by `K`, and the capped
grid and its number of steps scale exactly. `ActualNormalization.lean` passes
this identity to the limits, proving price normalization for both raw and usual
Brownian stopping values without a classical solution or dividend restriction.

For `0<=q<=r`, `ActualBoundaryNormalization.lean` then identifies the usual
exercise threshold from price/payoff contact. This is a proved identity between
actual financial thresholds, not a definition of a replacement boundary.
`PhysicalBoundaryConvexity.lean` establishes, on positive remaining maturities,
convexity of `log(B(tau)/K)`, strict convexity and strict decrease of `B`, and
local Lipschitz continuity of both profiles. Only `K>0`, `r>0`, `sigma>0`, and
`0<=q<=r` are assumed. Named zero-dividend and Liu-range specializations and
26 guarded transitive axiom checks cover the new chain. Boundary smoothness and
the literal everywhere second-derivative conclusions remain unfinished.

### First differentiability at actual contact

`LipschitzContactDifferentiability.lean` proves a general estimate: a function
vanishing on a locally Lipschitz graph has zero full derivative at a contact
point if its spatial derivative is continuous and zero there. The proof uses
the spatial mean-value inequality and the graph's displacement bound; it never
differentiates the graph. `ActualContactDifferentiability.lean` applies this to
the intrinsic premium `u=p-(1-exp(x))`. At contact `Du=0`, hence the actual
price has spatial derivative `-exp(b(t))` and time derivative zero. Together
with the exercise and continuation regions, the actual price is jointly
differentiable at every positive-time point. Continuity of its time derivative
and higher boundary regularity are not inferred from this first derivative.

`ActualBoundaryOneSided.lean` gives finite left/right speeds with
`b'_-(t)<=b'_+(t)<0`, monotonicity of both one-sided speed functions, and the
exact equivalence between boundary differentiability and equality of the two
speeds. It does not prove that equality. Explicit zero-dividend and Liu-range
checkpoints and seventeen guarded transitive audits cover these new results.

### Quadratic upper contact estimates

`ActualSpatialSecondBound.lean` uses the premium PDE and the already proved
time-derivative bound to bound `u_xx` above locally in continuation.
`QuadraticUpper.lean` integrates an upper second-derivative bound from a flat
contact point. `ActualQuadraticUpper.lean` applies it uniformly at nearby
maturities, yielding `u_x<=C*(x-b(s))` and `u<=C/2*(x-b(s))^2`.

`ActualContactIncrement.lean` combines this with the proved local pairwise
Lipschitz bound on `b`. For nearby `s<=v`, it proves
`0<=p(b(s),v)-p(b(s),s)<=A*(v-s)^2`. A smaller fixed neighborhood gives the
uniform contact difference-quotient bound `0<delta<eta` implies
`0<=(p(b(s),s+delta)-p(b(s),s))/delta<=A*delta`.
The zero-dividend and Liu-range contact-increment checkpoints are explicit.
`DiscountedMaximum.lean` also proves the moving-strip maximum principle with
positive discounting, intended for the next time-increment comparison.

Thirteen guarded transitive axiom checks cover this addition. The propagation
of small left-boundary data into continuation is now proved in the next stage.

### Joint time-derivative and spatial-curvature traces

`StationaryBarrier.lean` uses `phi(x)=1-exp(-rho*(x-beta))`, with
`rho=|k-h-1|+1`. On `x>=beta` it is nonnegative, at most `rho*(x-beta)`,
and a stationary pricing supersolution. `ActualIncrementComparison.lean`
compares actual time increments with positive affine multiples of this profile
on the earlier continuation region. No boundary derivative is used.

`ActualTemporalTraceBound.lean` supplies all the comparison data from proved
actual-price properties. A fixed earlier time `a` and strict boundary decrease
give a uniform positive gap from `b(a)` to every nearby terminal boundary
`beta=b(s)`. Compact spatial/time intervals give a uniform increment bound
`M*delta`, and the preceding contact estimate gives `A*delta^2` on the left.
After comparison and division by `delta`, taking `delta` down to zero proves
`0<=p_t(x,s)<=N*(x-b(s))`, with one `N` for all nearby `s` and `b(s)<=x<=0`.

`ActualTimeDerivativeContinuity.lean` combines this with zero time derivative
in exercise and continuous boundary motion to obtain joint continuity of
`p_t` at contact, where its value is zero. `ActualSpatialSecondTrace.lean`
then uses the pricing PDE and the existing premium/gradient traces to prove
`u_xx -> k-h*exp(b(t))` within continuation. This limit is positive by the
already proved boundary-forcing theorem. It is not a second derivative across
exercise, and it does not yet prove boundary smoothness or equality of the
boundary's one-sided speeds. Zero-dividend and Liu-range trace checkpoints
and twenty new guarded transitive axiom checks cover this stage.

### Joint C1 price and the normal derivative at contact

`ActualPriceC1.lean` extends the time-derivative continuity statement from
contact to all positive-time points. In exercise the derivative vanishes
locally; in continuation it is a smooth directional derivative of the jointly
smooth price. Together with spatial-gradient continuity, the coordinate
representation of the full derivative gives genuine `ContDiffOn` of order one
for the actual price on `{(x,t) | t>0}`. No boundary-smoothness premise enters.

`ActualCurvatureExtension.lean` defines the PDE expression
`p_t+k-h*exp(x)-(k-h-1)*u_x+k*u`. It is continuous at every positive-time point,
equals `u_xx` in continuation, and equals `k-h*exp(b(t))` at contact. On the
exercise side it is only an extension, not the second derivative of `u`.
Continuity of `u_x`, interior differentiability, and the curvature trace now
give `HasDerivWithinAt` for `u_x` on the right half-line at contact. In
particular `u_x(x,t)/(x-b(t))` tends to `k-h*exp(b(t))` from the right.

Fifteen new guarded transitive checks and explicit zero-dividend/Liu-range
checkpoints cover these results. A contact mixed-derivative/flux argument is
still needed to deduce boundary differentiability; joint C1 price regularity
and a nonzero normal derivative do not alone justify an implicit-function
argument for the gradient's zero set.

### The actual time derivative as a positive Dirichlet solution

`PlanePricingDerivative.lean` proves directional-derivative commutation and
the third-order interchange needed to differentiate a constant-coefficient
pricing equation in time. It uses smooth Fréchet calculus, not a formal
interchange assumption. `ActualTheta.lean` defines `theta=p_t` from the actual
stopping price and proves that it is smooth and solves
`theta_t=theta_xx+(k-h-1)*theta_x-k*theta` inside continuation. It also records
joint continuity, nonnegativity, zero exercise values, and the interior
identity `p_xt=theta_x`. The maturity variable is time remaining.

`ActualThetaPositivity.lean` proves strict positivity throughout continuation.
Since `p(x,t)>p(x,0)` there, the mean value theorem gives a positive theta at
an earlier time `a`. This point must already be in continuation. Dividing
theta by the positive stationary profile removes the discount term, and the
existing explicit positivity barrier propagates the source to the target
time on the half-line above `b(a)`. Boundary antitonicity keeps this half-line
inside continuation; no boundary velocity is assumed.

The theta PDE and strict positivity have explicit zero-dividend and Liu-range
checkpoints. Twenty-two new guarded transitive checks cover this stage.
Existence and continuity of `theta_x` at contact remain open. Thus this is the
positive Dirichlet input for the boundary-flux argument, not a proof of that
flux or of boundary smoothness.

### Quantitative theta growth without a flux-existence assumption

`QuantitativeHopf.lean` extracts the linear lower bound from the existing
exponential barrier argument before the step that uses a terminal derivative.
Positive compact bottom/right data supplies a barrier scale; comparison gives
`m*x<=U(x,T)` for some `m>0`, with no derivative at `(0,T)` assumed.

`ActualThetaContactGrowth.lean` chooses a decreasing line through `(b(t),t)`
with speed larger than the proved local Lipschitz constant of `b`. Before
terminal contact this line lies strictly in continuation. In moving-line
coordinates the normalized theta is a nonnegative PDE solution, positive on
the bottom and right edges, with bounded drift. The quantitative Hopf estimate
gives linear lower growth at the terminal slice. The positive normalizing
profile is at least one, so the bound transfers back to actual theta.

Combining this with the earlier linear upper estimate proves
`0<m<=theta(x,t)/(x-b(t))<=M` on a right neighborhood of contact. There are
explicit zero-dividend and Liu-range versions and seven new transitive axiom
checks. The quotient's convergence is **not** proved. In fact theta's
two-sided spatial derivative at contact is proved not to exist: theta is zero
on the exercise side but has strictly positive right slope lower bounds.
This does not contradict C1 price regularity, and confirms that the missing
flux must be specified as a continuation-side derivative/limit.

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
   stopping value, with joint continuity, initial payoff, bounds and tail decay proved
   without a classical-solution premise. Classical existence/regularity remains open; see
   [the financial verification frontier](stopping-value.md).
   Strict price positivity, separation of the stock threshold from strike, and
   exact contact/strict-continuation characterization are also now proved from
   the stopping value. The resulting continuation domain is open. Its interior
   smoothness and pricing PDE are now proved without a classical premise.
   A constructed stationary supersolution also proves a uniform positive lower
   bound on the stock threshold and supplies a finite actual logarithmic
   boundary with value matching. Actual-price one-sided smooth fit is now proved
   using optimality and dominated convergence of bounded payoff quotients.
   The continuation-side gradient trace is now proved using stock convexity and
   a secant squeeze. Assembly of the actual classical contract now needs only
   positive-time boundary smoothness, which remains open.
   Toward that remaining obligation, joint spatial-gradient continuity across
   the actual boundary and a locally uniform positive second-spatial-derivative
   lower bound for the intrinsic premium in continuation are now proved.
   This now yields uniform quadratic separation from contact and quantitative
   control of boundary increments by price/gradient time increments. The
   actual temporal comparison now controls all price increments by the at-strike
   short-maturity price. An explicit expiry supersolution now supplies a
   square-root temporal price bound and a local quarter-power boundary bound.
   A subsequent parabolic-dilation comparison proves local temporal Lipschitz
   regularity of the actual price away from expiry and upgrades the local
   boundary modulus to a half power. Each has explicit zero-dividend and
   Liu-range specializations. Convexity now further upgrades both actual
   boundaries to local Lipschitz continuity away from expiry. The stronger regularity needed to complete
   boundary smoothness remains open.
   Full continuity of the normalized stock and log boundaries, including expiry,
   is now proved: the interior PDE and maturity monotonicity exclude downward
   jumps, complementing the earlier upper semicontinuity. An actual-price first-contact
   rule is now constructed with attained contact and pre-contact continuation;
   its optimality is now proved below without a classical pair. The full dynamic
   programming principle remains open.
   Finite exercise-grid stopping suprema now converge to the actual American
   value in the same model, providing a checked approximation step toward those
   obligations. General finite discrete-time Bellman identification and optimal
   first contact are now proved. Physical-time grid reindexing, Bellman
   identification and attainment are also proved, with optimal-grid expected
   payoffs converging to the American price. Both filtrations' conditional
   grid Bellman values are now identified with the same deterministic Gaussian
   log-spot recursion; its convergence proves raw/usual value equality without
   a classical solution. Delayed-grid optimality and dominated convergence now
   prove the deterministic waiting inequality and bounded continuous actual-price
   supermartingality on both filtrations. A vanishing-gap subsequence argument,
   compactness, and ordered optional sampling now prove actual first-contact
   optimality using the optimal-grid rules. Event-pasted stopping rules now also
   prove the stopped-martingale characterization and a mean-value identity at
   every bounded observation rule capped at actual contact. Backward rectangles
   inside continuation and their bounded exit rules are now constructed. Their
   exits precede contact, yielding the exact discounted local mean-value identity
   for the actual price, without a PDE premise. Bounded stopped Dynkin identities
   for smooth tests now give expected generator-integral inequalities for tests
   bounding the actual price above or below on these rectangles. Strict drift
   and shrinking rectangles now prove pointwise upper/lower generator tests;
   cutoff localization removes compact support. The exact normalized pricing
   inequalities for jointly C3 tests are proved. A time-weighted maximum argument
   now derives local smooth comparison from those tests, including terminal time.
   This identifies the actual price with any supplied continuous, interior-C3
   solution with matching initial/lateral data. The initial-data contribution is
   now constructed from merely continuous compact data, with all-order heat
   smoothing and exact pricing PDE; a cutoff matches the actual initial price
   on any finite interval. The lateral correction, full local solution and
   interior differentiability remain open, as do full continuous-time dynamic
   programming, smooth fit and boundary regularity.
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

### Smooth-source heat potential

`SmoothHeatSource.lean` proves that derivatives of a smooth compact space-time
source commute with Gaussian averaging and the finite elapsed-time potential.
It also gives spatial regularity of every finite order. `SourceHeatEquation.lean`
then proves, in (space, heat-time) coordinates,

`F_t = F_xx/2 + Q - heatSourceAverage Q D`.

The proof differentiates the rescaled Gaussian average in elapsed time, uses
uniqueness of its two already-proved spatial derivative formulas to identify
the first Gaussian moment, and applies the fundamental theorem of calculus.
The Gaussian average at elapsed time zero is exactly `Q`. If `Q` vanishes at
source times at most `a` and the evaluation time is at most `a+D`, the other
endpoint term is zero, giving `F_t = F_xx/2 + Q`.

`LocalHeatSource.lean` now constructs that smooth compact source near any point
of an open smoothness region. It agrees with the original source locally and
preserves its zero values, hence causality. The compact continuous remainder
vanishes on a neighborhood of the evaluation point. The actual localized theta
source has a checked open smoothness region on both sides of the exercise graph.

`SupportedKernelIntegral.lean` allows differentiation of a compact continuous
source's integral when the kernel is regular only on the source support.
`SeparatedSourceEquation.lean` applies this to the causal heat kernel, proving
the source-time integral's homogeneous heat equation and spatial regularity
away from the source support. `SeparatedSourceBridge.lean` proves integrability,
uses Fubini, and changes from source time to elapsed time. Causality gives exact
agreement with `heatSourcePotential` on the first causal window, including local
agreement sufficient to transfer derivatives and spatial regularity.

`LocalSourceEquation.lean` combines the smooth and separated parts, using proved
linearity of the potential. `actualHeatSourcePotential_regular` now establishes
spatial C2 regularity, time differentiability, and `F_t = F_xx/2 + Q` for the
actual source off the exercise graph at positive times strictly before `a+D`.
The cutoff hypotheses are precisely those already constructed for actual theta;
no source smoothness across contact is assumed. Zero-dividend and Liu-range
PDE specializations are explicit.

### Actual heat-theta representation and continuous one-sided derivative

`HeatRepresentationCandidate.lean` assembles `U=F-V/2`, proves continuity,
boundedness, causal initial data and the source PDE, and computes both shifted
normal derivatives. The density equation makes the left derivative zero and
the right derivative equal to the density. `HeatRepresentationExterior.lean`
transfers these statements to the original spatial coordinate and applies the
proved exterior Neumann uniqueness theorem, giving `U=0` on the exercise side,
including the moving boundary.

`Boundary/DirichletHalfLine.lean` proves bounded Dirichlet uniqueness on a
continuous moving half-line, including terminal time. A quadratic barrier
justifies truncation without a decay hypothesis. No boundary velocity is used.
`HeatRepresentationIdentification.lean` applies this to solutions with the
same source, initial data, and boundary values, and transfers the candidate's
right derivative to the identified solution.

`ActualHeatRepresentation.lean` discharges these premises for localized actual
heat theta. Compact-window Lipschitz bounds for the clamped actual graph follow
from the already-proved local Lipschitz property; the density history is shown
to be the actual-graph history throughout the causal window.
`ActualHeatFlux.lean` supplies the previously constructed cutoff and density,
then removes the cutoff near contact. The result is a continuous function `F`
such that, for every heat time `s` in a neighborhood of any positive contact,

`HasDerivWithinAt (fun x => canonicalHeatTheta k h (x,s)) (F s)`
`  (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2))`.

Only `k>0` and `0<=h<=k` are assumed. The zero-dividend and Liu-range local
continuous-flux results are explicit, as is existence at every positive heat
time. This is a boundary one-sided derivative, not a two-sided derivative or
an assertion of joint continuity of the interior gradient up to the boundary.
The actual Stefan velocity identity, subsequent regularity bootstrap, and
classical boundary-curvature conclusions remain unfinished.

All new proof modules use Mathlib, not MathFin's pricing theorems. No `sorry`,
new axiom, numerical output, or purported review is used as a proof premise.
Selected new declarations have build-enforced axiom guards.

The pasted numerical reports have not been reproduced. The named solver/test
scripts and figure were not supplied in this repository at the initial audit.
No novelty claim is certified by either these reports or the current Lean build.

### Regularity update: C1 forcing and one-half Holder actual heat flux

The actual boundary is now proved C1 with its Stefan velocity identity
(`ActualStefanVelocity.lean`). The full history integral along its heat graph
has a one-half Holder time estimate for continuous bounded density
(`ActualHistoryHolder.lean`). The next step is also checked:

- `SeparatedSourceCurve.lean` differentiates the source integral along a C1
  graph separated from the source, differentiating only the heat kernel.
- `HeatSourceSeparation.lean` proves that the localization source vanishes
  near any point where the cutoff is constant.
- `SeparatedSourceForcing.lean` and `ActualForcingRegularity.lean` identify
  the forcing and prove it C1, hence locally Lipschitz, near actual contact.
- `ActualDensityHolder.lean` uses `density=forcing+history` to prove the
  density one-half Holder, without a density derivative assumption.
- `ActualHeatFluxHolder.lean` uses the actual layer representation to transfer
  the bound to the intrinsic one-sided heat flux. Zero-dividend and Liu-range
  checkpoints are explicit.

This supersedes the earlier statements that the actual flux was only known
continuous. Sixteen build-enforced transitive axiom guards cover the new
steps. The pricing-gauge/velocity modulus transfer and higher bootstrap
remain unfinished. These results do not assert actual-boundary C2 regularity
or the literal classical second-derivative conclusion.

### Further update: actual velocity is locally one-half Holder

`ActualVelocityHolder.lean` now transfers the heat-flux modulus through the
exact inverse pricing gauge and the proved Stefan identity. Both multiplier
functions are C1 along the actual boundary; the Stefan denominator has the
proved positive value `k-h*exp(b(t))`. Thus pricing flux and `b'` are locally
one-half Holder, with explicit zero-dividend and Liu-range checkpoints. The
actual boundary is locally C1,1/2, without a new regularity premise.

The mean-value inequality then gives a uniform order-3/2 first-order remainder
for the actual heat graph, using any derivative anchor between its endpoints
(`HalfHolderRemainder.lean`, `ActualGraphRemainder.lean`). The kernel's spatial
Lipschitz bound turns that graph error into a bounded difference from the
corresponding straight-line history kernel (`HeatHistoryLinearization.lean`).
The density-weighted version has a bounded remainder when the density has
the proved square-root modulus.

Twenty-one new transitive axiom guards cover this stage. The bounded remainder
does not by itself establish its time regularity. Improving the time modulus
beyond one-half, then obtaining C2 and the literal classical curvature
formulation for the actual boundary, remain unfinished.

### Frozen-remainder time estimate and improved common-past modulus

The bounded linearization remainder now has a checked time estimate.
`HeatHistoryRemainderDerivative.lean` holds source time and reference slope
fixed and bounds its observation-time derivative by a constant divided by
elapsed time. `HeatHistoryRemainderTime.lean` includes a frozen density value
without differentiating the density, then proves the time-increment bound.
`ActualRemainderTime.lean` supplies the actual graph hypotheses, with explicit
zero-dividend and Liu-range results.

Near the source diagonal the remainder difference is bounded; away from it
the increment is bounded by a constant times `delta/u`. The elementary
majorant `(delta/u)^(3/4)` is integrable at zero. Its exact integral and
genuine integrability are checked in `HeatRemainderInterpolation.lean`.
`HeatRemainderOverlap.lean` assembles these bounds into a three-quarter time
estimate for the common-past frozen remainder. Eighteen new transitive axiom
guards cover this stage.

The reference term, new-source contribution and older sources outside the
local Holder window are not included in that estimate. They still need to
be assembled before the actual flux modulus can be improved beyond one-half.
No C2 or classical second-derivative claim is made at this stage.

### Complete local-history three-quarter estimate

The frozen reference and new-source terms are now assembled with the
common-past estimate. `HeatHistoryReference.lean` proves the reference
integral's time difference by varying only its upper limit.
`HeatRemainderRecent.lean` handles sources later than the frozen reference
time, giving an O(delta) integrated remainder. The decomposition and every
subtraction are justified with genuine integrability in
`HeatHistoryFrozenDecomposition.lean`.

`HeatHistoryThreeQuarter.lean` proves the complete local-history bound, and
`HalfHolderHistory.lean` derives its comparison hypotheses from a C1,1/2 graph
and one-half Holder density. `ActualHistoryThreeQuarter.lean` supplies the actual graph
and removes a clamp placed strictly before the source window. Explicit
zero-dividend and Liu checkpoints and sixteen transitive axiom guards are
included.

Older sources outside the local Holder window and the final density-equation
application still remain. The new estimate's coefficient is explicit and
requires staying away from the local source start for a uniform neighborhood
bound. Thus the verified actual flux and velocity exponent is still one-half,
not yet three-quarters; actual-boundary C2 remains unfinished.
