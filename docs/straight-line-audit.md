# Audit of the straight-line proof and its formal replacement steps

This is an author-side audit of the checked development, not an independent
referee report. The result under review is C2 regularity and

\[
\frac{d^2}{d\tau^2}\log(B(\tau)/K)\ge0,\qquad B''(\tau)>0
\]

for every positive maturity, assuming only positive strike, interest rate and
volatility, and `0 <= q <= r`. The final boundary is constructed from the
Brownian optimal-stopping value on its completed usual filtration.

## What was actually formalized

The comparison construction is retained. The finished argument is not a
line-for-line transcription of all the supplied commentary. In particular,
it replaces the proposed Sturm application and the differentiable tangent
selection with direct arguments. These substitutions were permitted by the
request to use a cleaner formalization path if available.

| Supplied proof component | Checked realization | Audit finding |
| --- | --- | --- |
| Exact comparison solution and smooth fit on `x=d-c*t` | `Boundary/Comparison.lean`: `straightPrice_equation`, `straightPrice_fit` | The two ODE profiles are constructed, not assumed to exist |
| Excess identity (8) and payoff domination | `excess_equation`, `excess_nonneg`, `straightPrice_dominates` | The sign condition is `0<=h<=k`; integrating factors handle both sides of the line |
| Identity (16), `J'=c` at a zero | `slope_gap_crosses_up`; `ComparisonShape.lean` | A genuine derivative identity yields interval-shaped initial superlevels |
| Right truncation | `ComparisonTail.lean`: `straightDifference_uniform_tail` | The limit `v -> -1` is uniform over all nonnegative times; no initial derivative trace is needed |
| Propagation of the single interval | `ParabolicValley.lean`, `ParabolicUnimodality.lean`, `ComparisonUnimodality.lean` | A proved three-point maximum argument replaces Sturm entirely |
| Terminal Hopf contradiction | `ParabolicHopf.lean`, `ComparisonHopf.lean`, `Tangency.lean` | A stationary exponential barrier works in a backward rectangle, including its terminal corner |
| Selecting a concave tangent with negative intercept | `Stopping/ActualComparisonIntervals.lean`, `Boundary/LineIntervalConvexity.lean` | First contact and chord geometry replace differentiating the boundary |
| Near-expiry input | `Stopping/ActualNearExpiry.lean` | A proved square-root barrier gives `b(t)/t -> -infinity`, without assuming the quoted European asymptotic |
| Literal second derivatives | `Stopping/ActualBoundaryC2.lean`, `ActualBoundaryCurvature.lean`, `PhysicalBoundaryCurvature.lean` | C2 is established after convexity; the conclusion is not a totalized derivative at a nonsmooth point |

Here module paths are relative to `AmericanPutConvexity/`. The comparison lemmas
are in `AmericanPutConvexity.Boundary.Comparison`; the actual-value theorems are
in `AmericanPutConvexity.Stopping`.

## The central propagation argument, without a zero-count theorem

Write the normalized comparison difference as U. On continuation it satisfies

\[
U_t=U_{xx}+D(x,t)U_x.
\]

On a finite strip `b(t) <= x <= R`, both boundary values are nonpositive.
The initial profile obeys

\[
\min(U(x,0),U(z,0))\le\max(U(y,0),0),\qquad x\le y\le z.
\]

This inequality is exactly what is needed to propagate all nonnegative strict
superlevels, not just the set where U is positive. Define smooth functions

\[
\phi_\delta(v)=\tfrac12(v+\sqrt{v^2+\delta^2}),\qquad
m_\delta(u,w)=u-\phi_\delta(u-w),\quad\delta>0.
\]

Their relevant partial derivatives are strictly positive. Also

\[
\min(u,w)-\max(v,0)-\delta
\le m_\delta(u,w)-\phi_\delta(v)
\le\min(u,w)-\max(v,0).
\]

Suppose a positive valley develops. Choose small positive delta and eta so
that `m_delta(U(x,t),U(z,t))-phi_delta(U(y,t))-eta*t` is positive somewhere.
Maximize this continuous expression over all ordered equal-time triples in
the compact moving strip, including time zero and the terminal slice.

At a positive maximum, time cannot be zero, neither outer point can be on a
spatial boundary, and neither pair of points can coincide. Varying each spatial
point independently shows that U has local maxima at x and z and a local
minimum at y. Thus all three first spatial derivatives vanish, and the PDE gives

\[
U_t(x,t)\le0,\qquad U_t(z,t)\le0,\qquad U_t(y,t)\ge0.
\]

The detector's time derivative is therefore at most `-eta < 0`. But its
maximum over preceding times makes its left-time derivative nonnegative.
Continuity of b ensures these fixed spatial points stay inside the strip
for sufficiently close preceding times. This is a contradiction.

Removing delta and eta proves the three-point inequality at every time,
and hence the superlevel interval property. No bound on `b'(0+)`, small-time
C1 convergence, simplicity of initial zeros, or moving-boundary Sturm theorem
occurs. In this argument the drift cancels at each spatial extremum, so even
a drift bound is unnecessary. The later Hopf argument does use a proved
lower bound for the transformed comparison drift.

## The terminal corner is handled directly

In coordinates `y=x-(d-c*t)`, the difference u satisfies a parabolic equation
with drift depending only on y. At contact `(0,T)`, value matching and right
smooth fit give `u(0,T)=0` and the right spatial derivative zero.

Later positivity forces a positive interior point at T by weak comparison.
Continuity preserves a positive right edge in a short backward rectangle.
The line is strictly in continuation before T, so the interval invariant gives
strict positivity on the entire compact bottom edge, including y=0. On the
left edge throughout the rectangle the difference is nonnegative.

Choose `lambda>0` with `lambda+D>=0` and a sufficiently small `eta>0`.
Compactness of the bottom and right edges makes

\[
\psi(y)=\eta(e^{\lambda y}-1)
\]

lie below u there. It vanishes on the left edge and is a subsolution.
Weak comparison gives `u(y,T)>=psi(y)>=eta*lambda*y`. The existing right
derivative of u at zero must consequently be positive, contradicting smooth
fit. No open ball extending beyond T or extension of the PDE across exercise
is assumed.

## Why the regularity proof is not circular

The comparison invariant and terminal contact argument use the
`ContinuousBoundaryPutSolution` contract, which has no boundary smoothness
field. `ActualContinuousContract.lean` supplies its fields for the actual
stopping price. The derivative-free line/chord argument first proves convexity.
That convexity supplies local Lipschitz control used later to derive the
Stefan velocity identity. The flux regularity argument then gives C2. Only
afterward are classical second-derivative conclusions assembled. The final
theorem does not assume the boundary curvature that it concludes.

## An admissibility convention made explicit during this audit

`Rules.lean` originally uses stopping times bounded by maturity pointwise.
The usual almost-sure convention is now represented by `AEBoundedRule` in
`Stopping/AEHorizonValue.lean`, permitting infinite times on a null set.
Clipping a rule at maturity is still a stopping time, is bounded pointwise,
and agrees almost everywhere with the original rule. Conversely, every
pointwise bounded rule is almost surely bounded.

The module proves equality of the sets of expected rewards, equality of the
supremum values, and equality of exercise thresholds. Reward integrability
and nonempty bounded reward sets are established under the financial
hypotheses, so these are not comparisons of undefined expectations.
`AEHorizonCurvature.lean` transfers the actual C2 and curvature conclusion to
this almost-sure convention. It includes zero-dividend and equal-rate cases,
and an exact example with `r=1/20`, `q=1/40`, `sigma=2/5` lying strictly in
`0<q<r<q+sigma^2/2`. The example is a theorem instantiation, not a numerical
experiment or an independent proof of the general theorem.

## Boundaries of this audit

- The proof establishes weak logarithmic curvature and strict stock curvature.
  It does not establish strict logarithmic curvature throughout this regime.
- The zero-dividend and Liu milestones specialize this proof. The separately
  retained published CCJZ proof track is not complete.
- The quoted near-expiry asymptotic, fifth-order tangency expansion, reported
  PDE numerics, and claims about behavior for `q>r` are not certified by this
  formalization. None is needed by its dependency chain. The named numerical
  scripts were not found in the checked feature worktree during this audit.
- Current publication priority and the state of subsequent literature are not
  established by a Lean build. No new priority claim follows from this audit.
- Kernel checking and the local definition review are strong evidence, but
  they are not an independent review of the full Brownian, filtration, or
  analytic development. That distinction remains important for publication.

## Verification record

The full project build passed with 9,088 jobs after adding the almost-sure
stopping convention. Twelve new transitive axiom guards cover reward
integrability, reward-set/value/threshold equality, the transferred classical
curvature theorem and its explicit parameter examples. They report only
`propext`, `Classical.choice`, and `Quot.sound`. The known upstream
unfinished-proof warnings do not occur in those dependency lists.

The prior classical-curvature checkpoint is commit `e213b68`; it passed the
full 9,086-job build with 38 new guards. The present audit does not invalidate
or replace that theorem: it clarifies its proof path and verifies an additional
financial modeling convention.
