import Mathlib.MeasureTheory.Integral.DominatedConvergence
import Mathlib.MeasureTheory.Integral.Bochner.Set

/-! # Continuity of a jointly continuous integral on a fixed compact interval -/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Metric
open scoped Topology

theorem integral_Ioo_continuousAt_of_joint_continuous
    {F : ℝ → ℝ → ℝ} {a b t : ℝ} {U : Set ℝ}
    (hU : IsOpen U) (ht : t ∈ U)
    (hF : ∀ r ∈ U, ∀ s ∈ Icc a b, ContinuousAt (fun z : ℝ × ℝ => F z.1 z.2) (r,s)) :
    ContinuousAt (fun r => ∫ s in Ioo a b, F r s) t := by
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp (hU.mem_nhds ht)
  have hKU : closedBall t (ε/2) ⊆ U := by
    intro r hr
    apply hball
    exact mem_ball.mpr ((mem_closedBall.mp hr).trans_lt (by linarith))
  have hc : ContinuousOn (fun z : ℝ × ℝ => F z.1 z.2) (closedBall t (ε/2) ×ˢ Icc a b) :=
    fun z hz => (hF z.1 (hKU hz.1) z.2 hz.2).continuousWithinAt
  obtain ⟨M,hM⟩ := ((isCompact_closedBall t (ε/2)).prod isCompact_Icc).image_of_continuousOn hc
    |>.isBounded.exists_norm_le
  have hnear : closedBall t (ε/2) ∈ 𝓝 t := closedBall_mem_nhds t (by linarith)
  have hmeas : ∀ᶠ r in 𝓝 t, AEStronglyMeasurable (F r) (volume.restrict (Ioo a b)) := by
    filter_upwards [hnear] with r hr
    have hs : ContinuousOn (F r) (Ioo a b) := by
      intro s hs
      exact ((hF r (hKU hr) s ⟨hs.1.le,hs.2.le⟩).comp
        (x := s) (f := fun z : ℝ => (r,z)) (by fun_prop)).continuousWithinAt
    exact hs.aestronglyMeasurable measurableSet_Ioo
  have hbound : ∀ᶠ r in 𝓝 t, ∀ᵐ s ∂volume.restrict (Ioo a b), ‖F r s‖ ≤ M := by
    filter_upwards [hnear] with r hr
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    exact hM (F r s) (mem_image_of_mem (fun z : ℝ × ℝ => F z.1 z.2)
      (show (r,s) ∈ closedBall t (ε/2) ×ˢ Icc a b from ⟨hr,hs.1.le,hs.2.le⟩))
  have hlim : ∀ᵐ s ∂volume.restrict (Ioo a b), Tendsto (fun r => F r s) (𝓝 t) (𝓝 (F t s)) := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    exact ((hF t ht s ⟨hs.1.le,hs.2.le⟩).comp
      (x := t) (f := fun r : ℝ => (r,s)) (by fun_prop)).tendsto
  exact tendsto_integral_filter_of_dominated_convergence (fun _ => M) hmeas hbound
    (integrableOn_const (hs := measure_Ioo_lt_top.ne)) hlim

end AmericanPutConvexity.Stopping
