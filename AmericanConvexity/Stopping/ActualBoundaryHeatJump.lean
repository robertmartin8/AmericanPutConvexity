import AmericanConvexity.Stopping.ActualContactDifferentiability
import AmericanConvexity.Stopping.MovingHeatJump

/-! # The heat normal-kernel jump along the actual exercise boundary

Heat time is twice normalized pricing time, so an elapsed heat time s
looks back to pricing time t-s/2. The actual boundary's proved local
Lipschitz property supplies the moving-kernel domination without assuming
that the boundary has a classical derivative.

This is a kernel theorem for arbitrary continuous bounded local densities;
it does not yet identify the actual theta with a layer potential.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology

theorem canonicalLogBoundary_heat_displacement {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ T L : ℝ, 0 < T ∧ T < t ∧ 0 ≤ L ∧
      ContinuousOn (fun s => canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2))
        (Ioo 0 T) ∧
      ∀ s ∈ Ioo 0 T,
        ‖canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2)‖ ≤ L*s := by
  obtain ⟨L,hL,hLip⟩ := canonicalLogBoundary_local_pointwise_lipschitz hk hh hhk ht
  obtain ⟨η,hη,hball⟩ := Metric.mem_nhds_iff.mp hLip
  let T := min (t/2) η
  have hT : 0 < T := lt_min (half_pos ht) hη
  have hTt : T < t := (min_le_left _ _).trans_lt (half_lt_self ht)
  refine ⟨T,L,hT,hTt,hL,?_,?_⟩
  · intro s hs
    have hst : 0 ≤ t-s/2 := by linarith [hs.2]
    exact continuousWithinAt_const.sub
      ((canonicalLogBoundary_continuousAt hk hh hhk hst).comp_continuousWithinAt
        (f := fun u : ℝ => t-u/2)
        (continuousWithinAt_const.sub (continuousWithinAt_id.div_const (2 : ℝ))))
  · intro s hs
    have hdist : dist (t-s/2) t < η := by
      rw [Real.dist_eq,show t-s/2-t = -(s/2) by ring,abs_neg,abs_of_pos (half_pos hs.1)]
      have hTη : T ≤ η := min_le_right _ _
      linarith [hs.2]
    have he := hball hdist
    change ‖canonicalLogBoundary k h (t-s/2)-canonicalLogBoundary k h t‖ ≤
      L*‖t-s/2-t‖ at he
    rw [norm_sub_rev,show t-s/2-t = -(s/2) by ring,norm_neg,Real.norm_of_nonneg
      (half_pos hs.1).le] at he
    exact he.trans (mul_le_mul_of_nonneg_left (by linarith [hs.1]) hL)

theorem canonicalLogBoundary_heatKernel_jump {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      Tendsto (fun x => ∫ s in Ioo 0 T,
        heatBoundaryKernel s (x+(canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2)))*g s)
        (𝓝[>] (0 : ℝ))
        (𝓝 (g 0 + ∫ s in Ioo 0 T,
          heatBoundaryKernel s (canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2))*g s)) := by
  obtain ⟨T,L,hT,hTt,hL,hd,hmove⟩ := canonicalLogBoundary_heat_displacement hk hh hhk ht
  exact ⟨T,hT,hTt,fun _ _ hg hC hs => movingHeatBoundaryKernel_jump hT hL hd hmove hg hC hs⟩

theorem zeroDividend_canonicalLogBoundary_heatKernel_jump {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      Tendsto (fun x => ∫ s in Ioo 0 T,
        heatBoundaryKernel s (x+(canonicalLogBoundary k 0 t-canonicalLogBoundary k 0 (t-s/2)))*g s)
        (𝓝[>] (0 : ℝ))
        (𝓝 (g 0 + ∫ s in Ioo 0 T,
          heatBoundaryKernel s (canonicalLogBoundary k 0 t-canonicalLogBoundary k 0 (t-s/2))*g s)) :=
  canonicalLogBoundary_heatKernel_jump hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_heatKernel_jump {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ T : ℝ, 0 < T ∧ T < t ∧ ∀ (g : ℝ → ℝ) (C : ℝ),
      Continuous g → (∀ s, ‖g s‖ ≤ C) → (∀ s, T ≤ s → g s = 0) →
      Tendsto (fun x => ∫ s in Ioo 0 T,
        heatBoundaryKernel s (x+(canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2)))*g s)
        (𝓝[>] (0 : ℝ))
        (𝓝 (g 0 + ∫ s in Ioo 0 T,
          heatBoundaryKernel s (canonicalLogBoundary k h t-canonicalLogBoundary k h (t-s/2))*g s)) :=
  canonicalLogBoundary_heatKernel_jump (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
