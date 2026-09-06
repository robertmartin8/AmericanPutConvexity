import AmericanPutConvexity.Stopping.CompactKernelDerivative

/-! # Differentiating a plane-source integral away from its singular support

Only the kernel needs derivatives, and only where the compact continuous
source is supported. The kernel can be singular elsewhere.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Metric
open scoped Topology

theorem supported_kernelProduct_continuousOn {P : Type*} [TopologicalSpace P]
    {Q : ℝ × ℝ → ℝ} {F : P → (ℝ × ℝ) → ℝ} {U : Set P}
    (hQ : Continuous Q)
    (hF : ∀ p ∈ U, ∀ w ∈ tsupport Q,
      ContinuousAt (fun v : P × (ℝ × ℝ) => F v.1 v.2) (p,w)) :
    ContinuousOn (fun v : P × (ℝ × ℝ) => F v.1 v.2*Q v.2) (U ×ˢ univ) := by
  intro v hv
  by_cases hw : v.2 ∈ tsupport Q
  · exact ((hF v.1 hv.1 v.2 hw).mul (hQ.continuousAt.comp continuousAt_snd)).continuousWithinAt
  · apply ContinuousAt.continuousWithinAt
    apply (continuousAt_const (y := (0 : ℝ))).congr_of_eventuallyEq
    filter_upwards [continuousAt_snd.preimage_mem_nhds (notMem_tsupport_iff_eventuallyEq.mp hw)] with w hw
    change Q w.2 = 0 at hw
    simp [hw]

theorem supported_planeIntegral_hasDeriv {Q : ℝ × ℝ → ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    {F F' : ℝ → (ℝ × ℝ) → ℝ} {U : Set ℝ} (hU : IsOpen U)
    (hF : ∀ p ∈ U, ∀ w ∈ tsupport Q,
      ContinuousAt (fun v : ℝ × (ℝ × ℝ) => F v.1 v.2) (p,w))
    (hF' : ∀ p ∈ U, ∀ w ∈ tsupport Q,
      ContinuousAt (fun v : ℝ × (ℝ × ℝ) => F' v.1 v.2) (p,w))
    (hd : ∀ p ∈ U, ∀ w ∈ tsupport Q, HasDerivAt (fun p => F p w) (F' p w) p)
    {p : ℝ} (hp : p ∈ U) :
    HasDerivAt (fun p => ∫ w, F p w*Q w) (∫ w, F' p w*Q w) p := by
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp (hU.mem_nhds hp)
  have hKU : closedBall p (ε/2) ⊆ U := by
    intro y hy
    exact hball (mem_ball.mpr ((mem_closedBall.mp hy).trans_lt (by linarith)))
  have hcompact := (isCompact_closedBall p (ε/2)).prod hc
  have hDc : ContinuousOn (fun v : ℝ × (ℝ × ℝ) => F' v.1 v.2)
      (closedBall p (ε/2) ×ˢ tsupport Q) :=
    fun v hv => (hF' v.1 (hKU hv.1) v.2 hv.2).continuousWithinAt
  obtain ⟨C,hC⟩ := (hcompact.image_of_continuousOn hDc).isBounded.exists_norm_le
  have hfc : ∀ u ∈ U, Continuous (fun w => F u w*Q w) := by
    intro u hu
    exact (supported_kernelProduct_continuousOn hQ hF).comp_continuous
      (continuous_const.prodMk continuous_id) (fun _ => ⟨hu,mem_univ _⟩)
  have hdc : ∀ u ∈ U, Continuous (fun w => F' u w*Q w) := by
    intro u hu
    exact (supported_kernelProduct_continuousOn hQ hF').comp_continuous
      (continuous_const.prodMk continuous_id) (fun _ => ⟨hu,mem_univ _⟩)
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun u w => F u w*Q w) (F' := fun u w => F' u w*Q w)
    (bound := fun w => C*‖Q w‖) (closedBall_mem_nhds p (by linarith : 0 < ε/2))
    (by filter_upwards [hU.mem_nhds hp] with u hu using (hfc u hu).aestronglyMeasurable)
    ((hfc p hp).integrable_of_hasCompactSupport hc.mul_left)
    (hdc p hp).aestronglyMeasurable
    (by
      apply Eventually.of_forall
      intro w u hu
      by_cases hw : Q w = 0
      · simp [hw]
      · rw [norm_mul]
        apply mul_le_mul_of_nonneg_right _ (norm_nonneg _)
        exact hC (F' u w) (mem_image_of_mem _
          (show (u,w) ∈ closedBall p (ε/2) ×ˢ tsupport Q from ⟨hu,subset_tsupport Q hw⟩)))
    ((hQ.integrable_of_hasCompactSupport hc).norm.const_mul C) ?_).2
  apply Eventually.of_forall
  intro w u hu
  by_cases hw : w ∈ tsupport Q
  · exact (hd u (hKU hu) w hw).mul_const (Q w)
  · simp only [image_eq_zero_of_notMem_tsupport hw,mul_zero]
    exact hasDerivAt_const u 0

end AmericanPutConvexity.Stopping
