import AmericanConvexity.Boundary.ComparisonAssembly
import AmericanConvexity.Boundary.ComparisonUnimodality

/-!
# Weak logarithmic boundary curvature for the classical pricing contract

The comparison interval invariant is now supplied by the direct three-point
maximum principle. This proves the normalized classical-solution claim, with
no extra expiry, speed, interval, zero-count, or derivative-trace premise.

Identification of this classical contract with the actual continuous-time
American value is separate. Strict logarithmic curvature is not asserted.
The strict stock-curvature consequence below still assumes strict speed.
-/

namespace AmericanConvexity.Boundary.Comparison

open Set
open scoped Topology

theorem dividend_log_curvature {k h : ℝ} {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ}
    (hp : DividendPutSolution k h p b) : ∀ t, 0 < t → 0 ≤ deriv (deriv b) t :=
  dividend_curvature_of_comparison_inputs hp
    (fun _ _ hc hd _ ht => straightDifference_positive_interval hp hc hd.le ht)

theorem dividend_curvature_claim : DividendCurvatureClaim := by
  intro k h p b hp
  exact dividend_log_curvature hp

/-- Zero-dividend milestone: weak log curvature on the original contract.
This is the new proof specialized, not an independent CCJZ proof and not the
strict logarithmic curvature statement of that paper. -/
theorem zeroDividend_weak_curvature_claim : ZeroDividendWeakCurvatureClaim :=
  (dividendCurvature_specializations dividend_curvature_claim).1

/-- Liu-range milestone for the weak logarithmic conclusion of this proof. -/
theorem liuRange_curvature_claim : LiuRangeCurvatureClaim :=
  (dividendCurvature_specializations dividend_curvature_claim).2

theorem stock_curvature_of_strict_speed {k h : ℝ} {p : ℝ → ℝ → ℝ} {b : ℝ → ℝ}
    (hp : DividendPutSolution k h p b) (hspeed : ∀ t, 0 < t → deriv b t < 0)
    {E σ expiry T : ℝ} (hE : 0 < E) (hσ : 0 < σ) (hT : T < expiry) :
    0 < deriv (deriv (stockBoundary E σ expiry b)) T :=
  stock_curvature_of_comparison_inputs hp hspeed
    (fun _ _ hc hd _ ht => straightDifference_positive_interval hp hc hd.le ht) hE hσ hT

end AmericanConvexity.Boundary.Comparison
