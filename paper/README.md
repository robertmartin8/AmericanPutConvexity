# Manuscript

**[Log-convexity of the exercise boundary of an American put option](log-convexity.pdf)**  
Robert Martin, Dianoa Labs

Source: [log-convexity.tex](log-convexity.tex). References:
[references.bib](references.bib). The paper uses the standard `article` class,
11-point Latin Modern type, one-inch margins, and BibTeX.

## Build

From this directory, use either:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error log-convexity.tex
```

or:

```sh
tectonic log-convexity.tex
```

No numerical scripts are needed to build the manuscript.

## Relationship to the formalization

The paper presents geometric log-convexity first, followed by a separate
classical-curvature corollary. Its comparison, analytic three-point lemma,
backward-rectangle barrier, and derivative-free chord argument follow the
Lean development. Nonincrease suffices for convexity; a no-flat-tail argument
then gives strict decrease and strict convexity of the stock-price boundary.

The main differences are explicit: the paper uses a European-price expiry
asymptotic and published positive-time regularity, whereas Lean proves an
expiry bound by a square-root subsolution and derives the required $C^2$
regularity from the stopping construction. Lean also supplies explicit
barrier proofs for positivity propagation.

- [Geometric theorem](../AmericanConvexity/Stopping/PhysicalBoundaryConvexity.lean)
- [Classical curvature](../AmericanConvexity/Stopping/PhysicalBoundaryCurvature.lean)
- [Proof correspondence audit](../docs/straight-line-audit.md)
- [Dependency and kernel-replay audit](../docs/dependency-audit.md)
- [Semantic dependency spine](review/semantic-spine.md)
- [Elaborated value and boundary audit](review/value-elaborated-audit.md)

The manuscript cites mathematical source snapshot `61e3cf5`. Audit packets
record the scope and provenance of their checks; a local build is not evidence
of a fresh hosted CI run. Appendix I records the author-supplied AI workflow
and distinguishes model review from independent human review.

## Archived numerical illustration

The numerical illustration is not included in the paper or used as a proof
premise. Its script evaluates exact initial comparison profiles; it is not
a PDE solver or a numerical extraction of the exercise boundary.

To regenerate the archived outputs:

```sh
python3 -m venv .venv
.venv/bin/python -m pip install -r numerics/requirements.txt
.venv/bin/python numerics/initial_profiles.py
```

This writes the figure in `figures/` and the sampled profiles and checks in
`numerics/`. Those checks are numerical evidence, not interval-arithmetic
certificates or Lean proofs.
