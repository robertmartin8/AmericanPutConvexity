import AmericanConvexity.Boundary.Tangency
import AmericanConvexity.Boundary.TangentIntercept
import AmericanConvexity.Boundary.NearExpiry
import AmericanConvexity.Boundary.BoundaryMonotonicity

/-!
# Conditional assembly of the straight-line comparison proof

This is NOT the completed American-put curvature theorem. The positive-interval
invariant remains an explicit unproved premise for log curvature. The expiry
ratio limit and nonpositive boundary speed are proved from the contract; the
latter gives strict negative speed at any hypothetical negative-curvature point.
Strict stock curvature still has a separate global strict-speed premise.
-/

namespace AmericanConvexity.Boundary.Comparison

open Set Filter
open scoped Topology

/-- The proposed log-curvature conclusion, conditional only on the remaining
interval invariant. In particular this invariant is not claimed as a
consequence of an unformalized zero-number theorem. -/
theorem dividend_curvature_of_comparison_inputs {k h : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : DividendPutSolution k h p b)
    (hinterval : ∀ c d : ℝ, 0 < c → d < 0 → ∀ t, 0 < t →
      OrdConnected {x | b t < x ∧ 0 < straightDifference p k h c d x t}) :
    ∀ t, 0 < t → 0 ≤ deriv (deriv b) t := by
  apply curvature_nonneg_of_negative_intercepts hp.boundary_smooth hp.boundary_ratio_tendsto_atBot
  intro t ht hd
  by_contra hn
  have hspeed := hp.boundary_deriv_neg_of_curvature_neg ht (lt_of_not_ge hn)
  exact hn (curvature_nonneg_of_tangent_intervals hp ht hspeed hd.le
    (hinterval (-deriv b t) (b t - t * deriv b t) (neg_pos.mpr hspeed) hd))

/-- Zero dividends with the original CCJZ contract. The interval invariant
remains OPEN, and the conclusion is weak log curvature, not CCJZ's
strict log curvature theorem. -/
theorem zeroDividend_curvature_of_comparison_inputs {k : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : NormalizedPutSolution k p b)
    (hinterval : ∀ c d : ℝ, 0 < c → d < 0 → ∀ t, 0 < t →
      OrdConnected {x | b t < x ∧ 0 < straightDifference p k 0 c d x t}) :
    ∀ t, 0 < t → 0 ≤ deriv (deriv b) t :=
  dividend_curvature_of_comparison_inputs (dividendPutSolution_zero_iff.mpr hp) hinterval

/-- The requested STRICT stock-boundary curvature consequence of the same
conditional proof. `stockBoundary` uses the existing calendar-time convention;
time reversal does not change the second-derivative sign. This is still not
an identification with a continuous-time optimal-stopping value. -/
theorem stock_curvature_of_comparison_inputs {k h : ℝ}
    {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ} (hp : DividendPutSolution k h p b)
    (hspeed : ∀ t, 0 < t → deriv b t < 0)
    (hinterval : ∀ c d : ℝ, 0 < c → d < 0 → ∀ t, 0 < t →
      OrdConnected {x | b t < x ∧ 0 < straightDifference p k h c d x t})
    {E σ expiry T : ℝ} (hE : 0 < E) (hσ : 0 < σ) (hT : T < expiry) :
    0 < deriv (deriv (stockBoundary E σ expiry b)) T := by
  have ht := normalizedTime_pos hσ hT
  have hs : ContDiffAt ℝ 2 b (normalizedTime σ expiry T) :=
    (hp.boundary_smooth.contDiffAt (Ioi_mem_nhds ht)).of_le (WithTop.coe_le_coe.mpr le_top)
  apply deriv2_stockBoundary_pos_of_nonneg hE hσ hT
    (fun t ht => ((hp.boundary_smooth.contDiffAt (Ioi_mem_nhds ht)).differentiableAt (by simp)).hasDerivAt)
    (((hs.derivWithin (m := 1) (by norm_num)).differentiableAt (by norm_num)).hasDerivAt)
    (dividend_curvature_of_comparison_inputs hp hinterval _ ht)
  exact (hspeed _ ht).ne

end AmericanConvexity.Boundary.Comparison
