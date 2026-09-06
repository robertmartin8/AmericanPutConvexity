# Final-theorem dependency and kernel-replay audit

## Scope and method

`tools/ProofDependencyAudit.lean` is a standalone audit program, not an axiom
or a component of the mathematical proof. It imports the final built module
with private declaration data available, then walks declaration **types and
proof/definition bodies**, starting at:

- `brownianUsualBoundary_classical_curvature`;
- `brownianAEBoundary_classical_curvature`;
- `canonicalStraightDifference_superlevel_interval`.

All three names are in `AmericanPutConvexity.Stopping`. Mutual declaration blocks
and inductive constructors are included, so the result is a sufficient closed
dependency set, not a claim of a minimal proof term. Missing declarations,
unsafe/partial declarations, and axioms other than `propext`, `Classical.choice`,
and `Quot.sound` cause failure. This does not rely on cached `#print axioms`
summaries or on the larger import graph.

With `--replay`, the program sends the collected declarations to an initially
empty kernel environment using Lean's `Environment.replay`. The implementation
in Lean 4.32.0 calls `addDeclCore` at trust level zero and checks generated
constructors and recursors against their stored versions. The audit first runs
negative controls: a missing declaration, `sorryAx`, and a deliberately invalid
proof of `False` must all be rejected.

This uses Lean's own kernel, not an independently implemented verifier. It
does not remove trust in Lean, its runtime, or the three standard axioms.

## Reproduce

From the feature worktree at the pinned toolchain and dependency revisions:

```sh
lake build
lake env lean --run tools/ProofDependencyAudit.lean docs/audits/final-proof-dependencies.json --replay
```

The machine-readable report records roots, revisions, the declaration count,
axioms, replay status, negative-control status, module counts, every MathFin
and BrownianMotion declaration in the collected set, and direct edges from
project declarations to those two packages. The Git revision identifies the
proof snapshot; the audit tool/report may be added in the next commit without
changing those mathematical declarations.

The first fresh replay passed for 74,785 declarations. Of these, 498 belong to
MathFin and 750 to BrownianMotion, determined by declaring module rather than
name prefix. Generated helper declarations are counted; these numbers are not
counts of separate mathematical assumptions or a percentage of trust.

## Direct upstream interface review

The collected project-to-upstream edges contain 26 distinct MathFin targets
and 22 distinct BrownianMotion targets, including definitions, typeclass
instances, and generated helpers. The following source-level checks focus on
the mathematical interfaces. The complete underlying proof terms are covered
by replay, but this is not a claim of an independent human review of every
upstream lemma.

| Interface | Source and local consumer | What was checked |
| --- | --- | --- |
| Dividend-paying GBM | MathFin `Foundations/ItoLemma2D.lean`, `gbmValue`; local `Stopping/Reward.lean` | Stock is `S*exp((r-q-sigma^2/2)*t+sigma*W_t)` and discounting is `exp(-r*t)` |
| Time measure | MathFin `Foundations/ItoIntegralL2.lean`, `timeMeasure`, `timeMeasure_Ioc` | It is Lebesgue measure pulled back to nonnegative real time; `(a,b]` has mass `b-a` for `a<=b` |
| Itô local martingale | MathFin `Foundations/ItoFormulaUnrestrictedLocMart.lean`, `ito_formula_unrestricted`; local `Stopping/PlaneIto.lean` | Six genuine derivative hypotheses and their continuity are supplied from joint C3; the conclusion is a local martingale, not automatically a true martingale |
| Null augmentation | MathFin `Foundations/ItoIntegralProcessLocalMartingaleGeneral.lean`, `nullsAlg`, `condExp_sup_nulls`; local `Stopping/FiltrationExtension.lean` | The auxiliary sigma algebra adds ambient-measurable null sets; conditional expectation equality requires and receives integrability and finite measure |
| Gaussian kernel | MathFin `Foundations/FeynmanKacHeatEquation.lean`, `heatKernel` | Kernel has variance parameter t and solves the half-Laplacian heat equation; all analytic uses gate on positive t |
| Convolution derivatives | Same module, `hasDerivAt_feynmanU_t`, `_x`, `_xx`; local `Stopping/CompactHeatFlow.lean` | The upstream growth bound is not silently assumed for arbitrary data: compactness supplies a positive scaling constant, and the scaled data meet the bound |
| Kernel PDE identity | Same module, `feynmanU_heat_equation` | This theorem equates two integrals; our local proof separately identifies them with actual derivatives before concluding the PDE |
| Gaussian-law transfer | Same module, `feynmanU_eq_integral_of_map` | Uses an explicit Gaussian pushforward law and measurable evaluation; not an assumption about an option-price process |
| Constructed Brownian motion | BrownianMotion `Gaussian/BrownianMotion.lean`, `brownian`, `isBrownianReal_brownian`, evaluation/increment laws | It is a constructed continuous modification on the Gaussian probability space, with normal variance t and increment variance the time distance |
| Brownian germ law | Same module, `IsBrownianReal.indep_zero`; local `Stopping/BrownianGerm.lean` | Applies to an event proved measurable in the natural-filtration germ; the overlapping probes are not assumed independent |
| Stopping stability | BrownianMotion `StochasticIntegral/LocalMartingale.lean`, `isStable_martingale` | Uses the proved martingale branch, not the unfinished submartingale branch in that file |

The null-augmented filtration in the Itô theorem is not yet the completed
usual filtration. Local `CompletedSpace.lean`, `FiltrationExtension.lean` and
`UsualBrownianValue.lean` handle those distinctions explicitly. The final
stopping value uses the completed ambient measure and a right-continuous,
complete filtration. The almost-sure horizon equivalence is proved separately
in `AEHorizonValue.lean`.

## What this does and does not establish

- The selected actual-curvature and interval-invariant proof terms, with their
  collected dependencies, passed a fresh kernel replay. They do not depend on
  `sorryAx` or a project-added axiom.
- The direct interface check found no imported American-boundary convexity
  theorem or hypothesis supplying the desired conclusion. MathFin's financial
  contribution here is stochastic-calculus infrastructure and the explicit
  GBM/kernel definitions, not its separate binomial American pricing examples.
- An import can contain an unfinished theorem without that theorem entering
  the selected proof. The report makes this distinction inspectable rather
  than relying on the absence of warnings in a build log.
- Replaying all collected proof terms is not a full audit of either upstream
  repository; declarations outside this set were not checked by this run.
- The interface inspection is author-side. It does not establish publication
  priority or substitute for an independent mathematical referee's reading.

The [straight-line audit](straight-line-audit.md) separately explains how the
mathematical comparison argument differs from the original proposed write-up.
