# Solution definitions and statement review

Current status: the classical-contract curvature proof and stochastic
identification are proved. Convexity of the actual normalized log boundary is
now proved without the classical contract in `Stopping/ActualLogConvexity.lean`.
Full positive-time boundary smoothness and the independent published strict-log
proof remain open. The early statement review below records the original CCJZ
track; historical frontier statements are superseded by the current README.
A predicate alone is not a proof that a solution exists.

`ContinuousBoundaryProblem.lean` adds a separate predicate deleting only
`boundary_smooth` from `DividendPutSolution`; the latter is unchanged. Their
exact equivalence after restoring that field is proved. The actual stopping
price satisfies the weaker predicate without additional analytic hypotheses.

## Mathematical target and proof-route choice

The target remains the known zero-dividend Black--Scholes result, for positive
strike, rate, volatility and maturity. CCJZ Theorem 1.1 includes positive second
derivatives of both the log boundary for positive time remaining and the stock
boundary before expiry. Smoothness at expiry is not required.

The proof route is not fixed. The present solution predicate can support either
CCJZ's approximation argument or an alternative analytic argument. The first
concrete construction uses CCJZ's profiles because their initial conditions can
be verified with existing calculus and integration infrastructure.

On 2026-09-04, a focused search found Ekstrom's alternative:
[Convexity of the optimal stopping boundary for the American put option](https://doi.org/10.1016/j.jmaa.2004.06.018).
Its published abstract describes parabolic level-curve methods. CCJZ p. 187 also
compares the two approaches and notes their shared free-boundary methods. We have
not audited Ekstrom's full proof or established that it is shorter in Lean. The
focused local search did not find ready-made Stefan, parabolic Hopf, or zero-number
theorems. This does not rule out other library formulations or proof routes.

Source verification used rendered pages 186, 188, 189 and 195 of the
[CCJZ paper](https://sites.pitt.edu/~chadam/papers/3CCJW9-28-05.pdf), including the
theorem, equations (1.1), (2.1)--(2.3), and the appendix profile and coefficient.
The downloaded PDF SHA-256 was
`c1d282f63034690300f2dd507e0531bad94ccd844877b0539c3e10298ca18815`.

## Statement correspondence

`Boundary/Problem.lean` uses `p x t`: log spot first, normalized time remaining
second. `normalizedRate r sigma = 2*r/sigma^2` is positive under the physical
parameter assumptions. `NormalizedPutSolution k p s` specifies:

| Formal condition | Intended meaning and scope |
| --- | --- |
| `initial` | Put payoff at time zero for every real log price |
| `dominates`, `bounded`, `decay` | Value above payoff, at most normalized strike, and tending to zero as spot tends to infinity |
| `exercise`, `continuation` | Coincidence below the candidate threshold and strict premium above it, only at positive times |
| `equation` | `p_t = p_xx + (k-1)*p_x - k*p` in the continuation region |
| `smooth_fit`, `gradient_trace` | Right derivative and interior gradient limit equal to `-exp(s(t))` |
| `price_continuous`, `price_smooth` | Joint continuity including expiry; joint smoothness only in the open continuation region |
| `boundary_initial`, `boundary_continuous`, `boundary_smooth` | Boundary starts at zero, is continuous on nonnegative times, and smooth on positive times |

The predicate assumes a threshold-shaped exercise region as part of the classical
free-boundary characterization. Proving that the optimal-stopping value admits
this characterization is outstanding. Its geometry has not been independently
derived from optimal stopping in this milestone.

Neither monotonicity nor convexity is a field. Price or derivative convergence,
maximum principles and curvature conclusions are not fields either. `ContDiff`
uses the scoped order `infinity` (`∞`), not `top` (`⊤`): in this pinned Mathlib,
the latter would demand analytic regularity rather than merely smoothness.

Checked consequences include the exact stock-unit payoff identity, equivalence of
contact with `S <= E*exp(s(t))` for positive stock and time remaining, recovery of
`s(t)` as the supremum of the log-price contact set, and uniqueness of the boundary
for a fixed price. This is not uniqueness of the PDE solution. At expiry the
contact set is instead all of log-price space; the separate initial boundary
condition gives the terminal strike convention.

`NormalizedCurvatureClaim` and `NormalizedExistenceClaim` are **unproved proposition
definitions**, not theorem declarations, axioms, or assumptions used by the
implemented proofs. The former is an analytic target. It is not yet the complete
financial theorem. `stock_curvature_of_log_curvature` is explicitly a reduction:
it still requires the positive log-curvature input.

## Stefan problem and profile construction

`Boundary/Stefan.lean` defines `StefanInitialData` using derivatives within the
initial half-line, so compatibility at zero does not depend on an arbitrary left
extension. `StefanSolution` states the smooth-data evolution, zero extension and
one-sided flux condition. The singular Dirac initial condition of the limiting
problem is not represented as an ordinary function here.

The solution interface specifies continuity and interior smoothness, and a
positive-time right gradient trace. It does not yet specify or prove all higher
corner/Hölder regularity needed in a well-posedness or approximation theorem.
There is no strict-speed assumption at time zero, and no positive-speed/slope
conclusion is smuggled into the interface. A positive right slope implies negative
speed by the flux equation; establishing that slope sign remains a Hopf-lemma task.

`Boundary/Profiles.lean` constructs the appendix coefficient explicitly as

```text
d = k*(2*epsilon - (k-1)*epsilon^3)
a = (sqrt(d^2 + 4*k) - d)/2
Q(y) = (a*epsilon*y + y^2/2)*exp(-y)
q0(x) = epsilon^(-2)*Q(epsilon^(-2)*x).
```

For every positive `k` and `epsilon`, Lean checks positivity of `a`, its defining
quadratic equation, all initial-data conditions (2.3), and positive initial slope.
The proof uses a general scaled profile, explicit first and second derivatives,
Gamma-integral integrability and exponential decay. These results concern initial
data, not the existence or curvature of their evolving boundaries.

The earlier flat-slope profile `x^3*exp(-x)` also satisfies `StefanInitialData`.
This verifies that the new intrinsic formulation preserves the endpoint issue
found in the printed auxiliary lemma instead of silently strengthening (2.3).

The subsequent development completes the initial-data assertion of Lemma 3.4:
`ProfileConcentration.lean` proves (2.6); `ProfileGeometry.lean` and
`ProfileOperator.lean` prove (3.1), (3.2), and (3.8). See the
[exact appendix proof](appendix-proof.md). The estimates are proved for the
explicit family, not assumed in a solution interface.

## Remaining obligations and next proof work

1. Prove analytic existence/uniqueness and required boundary regularity, including
   that the proposed solution class is inhabited for each positive rate.
2. Prove the parabolic zero-number and maximum-principle results propagating the
   now-verified initial sign conditions to the Stefan evolution.
3. Define the admissible GBM stopping problem and prove the solution/value
   identification, including threshold geometry. The payoff/coordinate lemmas
   alone do not supply this verification theorem.
4. Prove boundary convergence and curvature by the most tractable valid route.
   Passing to a limit yields only ordinary convexity; strict curvature requires
   a further argument.

The new proofs import Mathlib and local boundary modules, not MathFin finance
results. The existing provisional MathFin audit policy remains applicable to any
future stochastic results imported from that library.

All modules are included in the library build. Selected new results have
build-enforced axiom guards allowing only `propext`, `Classical.choice`, and
`Quot.sound`. Compilation validates the stated propositions; the correspondence
review above does not replace the outstanding financial verification theorem.
