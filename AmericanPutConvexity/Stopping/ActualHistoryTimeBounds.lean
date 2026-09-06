import AmericanPutConvexity.Stopping.HeatHistoryTimeKernel
import AmericanPutConvexity.Stopping.HeatHistoryTimeMajorant
import AmericanPutConvexity.Stopping.ActualStefanVelocity

/-! # Actual-graph hypotheses for history time regularization

The actual heat-coordinate graph is C1 at positive times. On each compact
positive-time window its derivative and displacements have a common bound,
so both the size and observation-time estimates for the history kernel
apply with no additional boundary regularity premise.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology

theorem exists_C1_window_motion_bound {b : ℝ → ℝ} {a T : ℝ}
    (hd : ∀ t ∈ Icc a T, DifferentiableAt ℝ b t)
    (hc : ContinuousOn (deriv b) (Icc a T)) :
    ∃ L : ℝ, 0 ≤ L ∧ (∀ t ∈ Icc a T, ‖deriv b t‖ ≤ L) ∧
      ∀ s ∈ Icc a T, ∀ t ∈ Icc a T, s ≤ t → ‖b t-b s‖ ≤ L*(t-s) := by
  obtain ⟨C,hC⟩ := (isCompact_Icc.image_of_continuousOn hc.norm).bddAbove
  let L := max C 0
  have hL : 0 ≤ L := le_max_right _ _
  have hbound : ∀ t ∈ Icc a T, ‖deriv b t‖ ≤ L :=
    fun t ht => (hC ⟨t,ht,rfl⟩).trans (le_max_left _ _)
  refine ⟨L,hL,hbound,?_⟩
  intro s hs t ht hst
  have he := (convex_Icc a T).norm_image_sub_le_of_norm_deriv_le hd hbound hs ht
  simpa only [Real.norm_of_nonneg (sub_nonneg.mpr hst)] using he

theorem canonicalHeatGraph_hasDerivAt {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    HasDerivAt (fun u => canonicalLogBoundary k h (u/2))
      (deriv (canonicalLogBoundary k h) (s/2)/2) s := by
  have hd := (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk (half_pos hs)).differentiableAt.hasDerivAt
  convert! hd.comp s ((hasDerivAt_id s).div_const 2) using 1
  simp [div_eq_mul_inv]

theorem canonicalHeatGraph_deriv_continuousAt {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    ContinuousAt (deriv (fun u => canonicalLogBoundary k h (u/2))) s := by
  have hc : ContinuousAt (fun u => deriv (canonicalLogBoundary k h) (u/2)/2) s :=
    ((canonicalLogBoundary_deriv_continuousAt hk hh hhk (half_pos hs)).comp
      (x := s) (f := fun u : ℝ => u/2) (by fun_prop)).div_const 2
  apply hc.congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds hs] with u hu
  exact (canonicalHeatGraph_hasDerivAt hk hh hhk hu).deriv

theorem exists_canonicalHeatGraph_C1_window_bound {k h a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧
      (∀ t ∈ Icc a T, ‖deriv (fun u => canonicalLogBoundary k h (u/2)) t‖ ≤ L) ∧
      ∀ s ∈ Icc a T, ∀ t ∈ Icc a T, s ≤ t →
        ‖canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2)‖ ≤ L*(t-s) :=
  exists_C1_window_motion_bound
    (fun _ ht => (canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans_le ht.1)).differentiableAt)
    (fun _ ht => (canonicalHeatGraph_deriv_continuousAt hk hh hhk (ha.trans_le ht.1)).continuousWithinAt)

theorem exists_canonicalHeatHistory_time_bounds {k h a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧
      (∀ s ∈ Icc a T, ∀ t ∈ Icc a T, s < t →
        ‖movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t s‖ ≤
          3*L/Real.sqrt (2*Real.pi*(t-s))) ∧
      ∀ s ∈ Icc a T, ∀ t₁ ∈ Icc a T, ∀ t₂ ∈ Icc a T, s < t₁ → t₁ ≤ t₂ →
        ‖movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₂ s-
          movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₁ s‖ ≤
          (8*L/((t₁-s)*Real.sqrt (2*Real.pi*(t₁-s))))*(t₂-t₁) := by
  obtain ⟨L,hL,hv,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := T) hk hh hhk ha
  refine ⟨L,hL,?_,?_⟩
  · intro s hs t ht hst
    exact heatBoundaryKernel_motion_bound (sub_pos.mpr hst) (hm s hs t ht hst.le)
  · intro s hs t₁ ht₁ t₂ ht₂ hst htt
    have hsub : Icc t₁ t₂ ⊆ Icc a T := fun _ ht => ⟨ht₁.1.trans ht.1,ht.2.trans ht₂.2⟩
    exact movingHeatHistoryKernel_time_sub_bound hst htt hL
      (fun t ht => (canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans_le (hsub ht).1)).differentiableAt)
      (fun t ht => hv t (hsub ht)) (fun t ht => hm s hs t (hsub ht) (hst.le.trans ht.1))

theorem exists_canonicalHeatHistory_overlap_bound {k h a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t₁ t₂, a < t₁ → t₁ < t₂ → t₂ ≤ T →
      ∀ (f : ℝ → ℝ) (C : ℝ), 0 ≤ C → (∀ s, ‖f s‖ ≤ C) →
      ‖∫ u in Ioo 0 (t₁-a),
        (movingHeatHistoryKernel (fun s => canonicalLogBoundary k h (s/2)) t₂ (t₁-u)-
          movingHeatHistoryKernel (fun s => canonicalLogBoundary k h (s/2)) t₁ (t₁-u))*f (t₁-u)‖ ≤
        (28*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
  obtain ⟨L,hL,hv,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := T) hk hh hhk ha
  refine ⟨L,hL,?_⟩
  intro t₁ t₂ hat htt htT f C hC hf
  have hsub : Icc t₁ t₂ ⊆ Icc a T := fun _ ht => ⟨hat.le.trans ht.1,ht.2.trans htT⟩
  apply movingHeatHistoryKernel_overlap_bound htt hL hC
    (fun t ht => (canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans_le (hsub ht).1)).differentiableAt)
    (fun t ht => hv t (hsub ht)) ?_ hf
  intro u hu t ht
  apply hm (t₁-u) ⟨by linarith [hu.2],by linarith [hu.1]⟩ t (hsub ht)
  linarith [hu.1,ht.1]

end AmericanPutConvexity.Stopping
