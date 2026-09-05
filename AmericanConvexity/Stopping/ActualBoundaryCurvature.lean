import AmericanConvexity.Stopping.ActualBoundaryC2
import AmericanConvexity.Boundary.StockConclusion

/-! # Classical curvature of the actual stopping boundary

The C2 theorem supplies genuine second derivatives. Convexity gives weak
logarithmic curvature, and strictly negative speed gives strict curvature
after exponentiation and physical time rescaling.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalLogBoundary_hasDerivAt_deriv {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivAt (deriv (canonicalLogBoundary k h))
      (deriv (deriv (canonicalLogBoundary k h)) t) t :=
  ((canonicalLogBoundary_deriv_contDiffAt_one hk hh hhk ht).differentiableAt (by norm_num)).hasDerivAt

theorem canonicalLogBoundary_deriv2_nonneg {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    0 ≤ deriv (deriv (canonicalLogBoundary k h)) t := by
  have hm := (canonicalLogBoundary_convexOn hk hh hhk).monotoneOn_deriv
    (fun s hs => (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk hs).differentiableAt)
  have hn := hm.derivWithin_nonneg (x := t)
  rw [derivWithin_of_isOpen isOpen_Ioi ht] at hn
  exact hn

theorem canonicalRemainingTimeBoundary_deriv2_pos {k h K σ τ : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hK : 0 < K) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < deriv (deriv (remainingTimeBoundary K σ (canonicalLogBoundary k h))) τ := by
  have hfun : remainingTimeBoundary K σ (canonicalLogBoundary k h) =
      fun s => stockBoundary K σ 0 (canonicalLogBoundary k h) (-s) := by
    funext s
    simp [remainingTimeBoundary,stockBoundary,normalizedTime]
  rw [hfun,deriv2_comp_neg]
  have ht := normalizedTime_pos hσ (neg_neg_of_pos hτ)
  exact deriv2_stockBoundary_pos_of_nonneg hK hσ (neg_neg_of_pos hτ)
    (fun s hs => (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk hs).differentiableAt.hasDerivAt)
    (canonicalLogBoundary_hasDerivAt_deriv hk hh hhk ht)
    (canonicalLogBoundary_deriv2_nonneg hk hh hhk ht)
    (canonicalLogBoundary_deriv_neg hk hh hhk ht).ne

theorem zeroDividend_canonicalLogBoundary_deriv2_nonneg {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) : 0 ≤ deriv (deriv (canonicalLogBoundary k 0)) t :=
  canonicalLogBoundary_deriv2_nonneg hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_deriv2_nonneg {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    0 ≤ deriv (deriv (canonicalLogBoundary k h)) t :=
  canonicalLogBoundary_deriv2_nonneg (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
