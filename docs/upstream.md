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
