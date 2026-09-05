# Building on formal-mathfin

## Use a downstream Lake package

Our project depends on MathFin via Git; our source stays in `AmericanConvexity/`.
Lake fetches upstream sources into `.lake/packages/MathFin/` and builds the imported
modules. We reuse upstream definitions directly, so our theorems are about the
same mathematical objects rather than look-alike definitions in a copied library.

```lean
import MathFin.Binomial.American

namespace AmericanConvexity

example {u d r : ℝ} (h : MathFin.BinomialNoArb u d r)
    (g : ℝ → ℝ) (n : ℕ) (S : ℝ) :
    MathFin.binomialPrice u d r g n S ≤ MathFin.americanPrice u d r g n S := by
  exact MathFin.binomialPrice_le_americanPrice h g n S

end AmericanConvexity
```

`AmericanConvexity/Finance.lean` contains build-checked applications, not claims of
new mathematical contributions. Add new theorems in our namespace, importing them
from `AmericanConvexity.lean` so `lake build` checks them.

No Docker, Python pipeline, Git submodule, or upstream contributor tooling is
required for this downstream workflow. If we later need to change upstream code,
we can make a separate fork/checkout and contribute a PR; never edit the disposable
copy in `.lake/packages/` as our source of record.

## Exact compatibility pins

| Component | Pin |
| --- | --- |
| MathFin | `784a8311f75a1519a23717856df9982bd6a9a370` |
| Lean | `leanprover/lean4:v4.32.0` |
| Mathlib | `81a5d257c8e410db227a6665ed08f64fea08e997` |
| BrownianMotion (transitive) | `4d52fa776130a29d4ad7d6eda2035a919c0b4696` |

MathFin is pinned to the inspected upstream HEAD, not a moving branch. All 14
transitive package revisions were compared with its committed `lake-manifest.json`
and match. Our explicit Mathlib requirement is last, following upstream's
resolution convention. Lean 4.33.1 remains installed, but this directory uses
4.32.0 automatically; do not force the newer toolchain for this project.

`lake exe cache get` restores Mathlib artifacts. `lake build` builds our library
and the MathFin modules it actually imports. This is **not** a claim that we have
locally built or audited every theorem in the entire upstream repository.

## Useful entry points and their scope

Links below are pinned to the version we consume.

- [`MathFin.Binomial.Model`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/Model.lean):
  `BinomialNoArb`, risk-neutral up-probability, European backward pricing, replication.
- [`MathFin.Binomial.American`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/American.lean):
  `americanPrice`, its Bellman recursion, immediate-exercise bound, European-price bound.
- [`MathFin.Binomial.SnellEnvelope`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/Binomial/SnellEnvelope.lean):
  minimal dominating supermartingale, scalar and coin-flip path-space versions.
- [`MathFin.BlackScholes.SpotConvexity`](https://github.com/formal-applied-math/formal-mathfin/blob/784a8311f75a1519a23717856df9982bd6a9a370/MathFin/BlackScholes/SpotConvexity.lean):
  European call payoff/price convexity in spot. Not imported or built by our current examples.

Important distinctions before choosing our first theorem:

1. **Convexity of price in spot is not convexity of the exercise boundary in time.**
   A proof of the former does not establish the latter.
2. The current American model is a **finite-step binomial recursion**. It is not
   already a continuous-time optimal-stopping/free-boundary formulation.
3. The Snell module explicitly lists identification with the supremum over stopping
   times as downstream work; its proved path-space characterization alone should
   not be described as having completed that identification.
4. `BinomialNoArb u d r` means `0 < d` and `d < exp r < u`; `r` is the per-step
   continuously compounded rate. `crrUpProb` is a probability, **not a dividend yield**.
   Adding dividends requires checking/modifying the model, not just renaming a parameter.

The exact theorem statements and assumptions are authoritative, not README labels.
`AmericanConvexity/AxiomAudit.lean` guards the three upstream facts used by our
examples against extra axioms or `sorryAx`; their allowed axioms are `propext`,
`Classical.choice`, and `Quot.sound`. This checks proof dependencies, not whether a
statement faithfully represents the finance question we intend to ask.

## Stochastic bridge: Ito dependency

The stopping/PDE bridge now also imports
`MathFin.Foundations.ItoFormulaUnrestrictedLocMart`. The local adapter
`Stopping/PlaneIto.lean` derives its partial-derivative hypotheses from joint C3
regularity. `Stopping/LocalPriceIto.lean` applies it to compact smooth extensions
of the classical discounted price inside continuation. This is substantive
reuse of MathFin stochastic calculus, not reuse of an American pricing theorem.
The completed classical boundary-convexity proof itself remains independent of
these new stochastic modules.

Fresh or replayed builds emit upstream `sorry` warnings for unrelated declarations
in `BrownianMotion.StochasticIntegral.UniformIntegrable` (line 311),
`OptionalSampling` (line 258), and `LocalMartingale` (line 94), at the pin above.
These files are in the import graph. The build-enforced axiom guards for our
final local Ito conclusions check the transitive **proof** graph and permit
only `propext`, `Classical.choice`, and `Quot.sound`; no imported unfinished
declaration is accepted as part of those conclusions. Importing a file and
depending on every theorem in it are different claims.

`Stopping/ContactMartingale.lean` now also uses the upstream proved martingale
stopping-stability chain (`isStable_martingale`, continuous-time martingale
optional sampling, and martingale uniform integrability). Its submartingale
counterparts are the unfinished declarations noted above and are not used.
The contact-martingale and final conditional curvature guards also permit only
the three standard axioms. Mathlib's smooth partition-of-unity construction is
used to extend the price around compact interior regions; no global smoothness
of the price across the free boundary is assumed.

The global-upper-bound development also uses
`MathFin.Foundations.FeynmanKacHeatEquation`: its kernel differentiation and
Gaussian-law integral transfer, not merely its algebraic kernel PDE identity.
`CompactHeatFlow.lean` proves the actual heat-flow derivative equation after
scaling arbitrary compact data to the upstream exponential-growth hypothesis.
Mathlib's parameter-dependent convolution supplies joint regularity.
`LinearPriceComparison.lean` then combines this with our obstacle comparison.
Mathlib's support-preserving smooth approximation supplies the approximants in
`SmoothMinorants.lean`; the local construction makes them compact minorants with
a uniform bound. Dominated convergence in `ClassicalHeatComparison.lean` then
extends the inequality to the continuous price slice. Both final guarded proof
chains use only the three standard axioms.

`IndependentKernel.lean` proves the conditional-expectation step from Mathlib's
independent product laws, Fubini, and uniqueness of conditional expectation.
`BrownianTransition.lean` uses the constructed Brownian increment law and its
independence from the raw past, with Mathlib's Gaussian scaling theorem.
`ClassicalTransition.lean` checks the physical normalization;
`ClassicalSupermartingale.lean` then proves global supermartingality, price
identification and the actual boundary curvature conclusions. These final
proof chains, including the zero-dividend and Liu-range specializations, have
guarded audits allowing only the three standard axioms. Classical-solution
existence remains unproved. The raw/usual-filtration comparison is now checked
in `UsualBrownianValue.lean`.

`FiltrationExtension.lean` uses MathFin's proved `condExp_sup_nulls` to transfer
supermartingality under ambient-null augmentation. Its right-continuation
argument uses bounded dominated convergence on past-measurable sets, not an
upstream unfinished submartingale optional-sampling result. `CompletedSpace.lean`
uses Mathlib's actual measure completion and integral-trimming theorem to move
to the complete ambient space. The completed filtration in `UsualBrownianValue.lean`
has proved `IsComplete` and `IsRightContinuous` instances. Its value equality
and final boundary conclusions are guarded against any nonstandard axiom.

`MaturityTruncation.lean` and `MaturityContinuity.lean` use Mathlib's dominated
convergence and order properties of the real supremum to prove maturity
continuity directly from admissible stopping rules. `JointPriceContinuity.lean`
uses `ConvexOn.lipschitzOnWith_of_abs_le` to obtain a spot bound uniform in
maturity. The resulting normalized `canonicalPrice` has checked joint continuity,
initial payoff and bounds without assuming a classical PDE solution. These new
proof chains also have guarded audits allowing only the three standard axioms.
