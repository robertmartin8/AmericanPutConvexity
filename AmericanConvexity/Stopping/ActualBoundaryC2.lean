import AmericanConvexity.Stopping.ActualHeatFluxC1
import AmericanConvexity.Stopping.ActualVelocityHolder

/-! # C2 regularity of the actual American put boundary

The actual heat flux is C1. The C1 pricing gauge transfers this to pricing
flux, and the Stefan identity with positive denominator makes the actual
boundary velocity C1. Consequently the actual boundary is C2 at positive times.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalThetaRightFlux_contDiffAt_one {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContDiffAt ℝ 1 (canonicalThetaRightFlux k h) t := by
  have hheat : ContDiffAt ℝ 1 (fun s => canonicalHeatThetaRightFlux k h (2*s)) t :=
    (canonicalHeatThetaRightFlux_contDiffAt_one hk hh hhk ht).comp t
      (contDiffAt_const.mul contDiffAt_id)
  apply ((inverseThetaHeatGauge_boundary_contDiffAt hk hh hhk ht).mul hheat).congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds ht] with s hs
  exact canonicalThetaRightFlux_eq_gauged_heat hk hh hhk hs

theorem canonicalLogBoundary_deriv_contDiffAt_one {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContDiffAt ℝ 1 (deriv (canonicalLogBoundary k h)) t := by
  have hb := (canonicalLogBoundary_contDiffOn_one hk hh hhk).contDiffAt (Ioi_mem_nhds ht)
  have hv := (canonicalThetaRightFlux_contDiffAt_one hk hh hhk ht).neg.div
    (contDiffAt_const.sub (contDiffAt_const.mul hb.exp))
    (canonicalBoundary_forcing_pos hk hh hhk ht).ne'
  apply hv.congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds ht] with s hs
  exact canonicalLogBoundary_deriv_eq_velocity hk hh hhk hs

theorem canonicalLogBoundary_contDiffOn_two {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContDiffOn ℝ 2 (canonicalLogBoundary k h) (Ioi 0) := by
  rw [show (2 : ℕ∞ω) = 1+1 by norm_num,contDiffOn_succ_iff_deriv_of_isOpen isOpen_Ioi]
  refine ⟨(canonicalLogBoundary_contDiffOn_one hk hh hhk).differentiableOn (by norm_num),?_,?_⟩
  · norm_num
  · exact fun t ht => (canonicalLogBoundary_deriv_contDiffAt_one hk hh hhk ht).contDiffWithinAt

theorem zeroDividend_canonicalLogBoundary_contDiffOn_two {k : ℝ} (hk : 0 < k) :
    ContDiffOn ℝ 2 (canonicalLogBoundary k 0) (Ioi 0) :=
  canonicalLogBoundary_contDiffOn_two hk le_rfl hk.le

theorem liuRange_canonicalLogBoundary_contDiffOn_two {k h : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) :
    ContDiffOn ℝ 2 (canonicalLogBoundary k h) (Ioi 0) :=
  canonicalLogBoundary_contDiffOn_two (by linarith) hh (by linarith)

end AmericanConvexity.Stopping
