import AmericanPutConvexity.Stopping.ActualGradientTrace
import AmericanPutConvexity.Boundary.DividendProblem

/-! # Exact remaining hypothesis for the actual classical pricing contract

All fields except positive-time boundary smoothness have now been proved for
the actual stopping price and its constructed boundary. This assembly makes
that remaining hypothesis explicit; it does not prove it.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalPrice_dividendPutSolution_of_boundary_smooth {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hb : ContDiffOn ℝ ∞ (canonicalLogBoundary k h) (Ioi 0)) :
    DividendPutSolution k h (canonicalPrice k h) (canonicalLogBoundary k h) := by
  have hregion : canonicalContinuationRegion k h = continuationRegion (canonicalLogBoundary k h) :=
    canonicalContinuationRegion_eq_logBoundary hk hh hhk
  refine {
    rate_pos := hk
    dividend_nonneg := hh
    dividend_le_rate := hhk
    boundary_initial := canonicalLogBoundary_initial hk
    boundary_continuous := canonicalLogBoundary_continuousOn hk hh hhk
    boundary_smooth := hb
    price_continuous := (canonicalPrice_continuous hk.le).continuousOn
    price_smooth := ?_
    initial := canonicalPrice_initial hk.le
    dominates := fun x t _ => (canonicalPrice_bounds hk.le x t).1
    bounded := fun x t _ => (canonicalPrice_bounds hk.le x t).2
    exercise := ?_
    continuation := ?_
    equation := ?_
    smooth_fit := fun _ ht => canonicalPrice_smooth_fit hk hh hhk ht
    gradient_trace := fun _ ht => canonicalPrice_gradient_trace hk hh hhk ht
    decay := fun t _ => canonicalPrice_decay hk.le t }
  · rw [← hregion]
    exact canonicalPrice_contDiffOn hk.le
  · intro x t ht hx
    rw [(canonicalPrice_contact_iff_logBoundary hk hh hhk ht).mpr hx]
    exact putPayoff_of_nonpos (hx.trans (canonicalLogBoundary_neg hk hh hhk ht).le)
  · intro x t ht hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [hregion]
      exact ⟨ht,hx⟩
    exact hz.2
  · intro x t ht hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [hregion]
      exact ⟨ht,hx⟩
    exact canonicalPrice_continuation_pde hk.le hz

/-- This zero-dividend checkpoint retains the same explicitly unproved
boundary-smoothness hypothesis; it is not an independent published proof. -/
theorem zeroDividend_canonicalPrice_solution_of_boundary_smooth {k : ℝ} (hk : 0 < k)
    (hb : ContDiffOn ℝ ∞ (canonicalLogBoundary k 0) (Ioi 0)) :
    DividendPutSolution k 0 (canonicalPrice k 0) (canonicalLogBoundary k 0) :=
  canonicalPrice_dividendPutSolution_of_boundary_smooth hk le_rfl hk.le hb

theorem liuRange_canonicalPrice_solution_of_boundary_smooth {k h : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k)
    (hb : ContDiffOn ℝ ∞ (canonicalLogBoundary k h) (Ioi 0)) :
    DividendPutSolution k h (canonicalPrice k h) (canonicalLogBoundary k h) :=
  canonicalPrice_dividendPutSolution_of_boundary_smooth (by linarith) hh (by linarith) hb

end AmericanPutConvexity.Stopping
