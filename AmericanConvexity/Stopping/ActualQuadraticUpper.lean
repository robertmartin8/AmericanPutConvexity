import AmericanConvexity.Stopping.ActualSpatialSecondBound
import AmericanConvexity.Stopping.QuadraticUpper

/-! # Quadratic upper growth of the actual intrinsic premium

The PDE curvature bound and spatial smooth fit give locally uniform quadratic
upper growth away from exercise. No boundary derivative is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalIntrinsicPremium_upper_of_deriv2_upper {k h t R C : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hR : canonicalLogBoundary k h t ≤ R)
    (hupper : ∀ x ∈ Ioo (canonicalLogBoundary k h t) R,
      deriv (deriv (fun y => canonicalIntrinsicPremium k h y t)) x ≤ C) :
    ∀ x ∈ Icc (canonicalLogBoundary k h t) R,
      deriv (fun y => canonicalIntrinsicPremium k h y t) x ≤ C*(x-canonicalLogBoundary k h t) ∧
      canonicalIntrinsicPremium k h x t ≤ C/2*(x-canonicalLogBoundary k h t)^2 := by
  apply quadratic_upper_of_deriv2_upper hR
  · exact ((canonicalIntrinsicPremium_continuous (h := h) hk.le).comp
      (show Continuous (fun x : ℝ => (x,t)) by fun_prop)).continuousOn
  · intro x _
    have hm : ContinuousAt (fun y : ℝ => (y,t)) x := by fun_prop
    exact ((canonicalIntrinsicPremium_gradient_continuousAt (x := x) hk hh hhk ht).comp
      (f := fun y : ℝ => (y,t)) hm).continuousWithinAt
  · intro x hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact ⟨ht,hx.1⟩
    exact (canonicalIntrinsicPremium_contDiffAt hk.le hz).differentiableAt (by norm_num)
  · intro x hx
    have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact ⟨ht,hx.1⟩
    have hd : ContDiffAt ℝ 1 (deriv (fun y => canonicalIntrinsicPremium k h y t)) x :=
      (canonicalIntrinsicPremium_contDiffAt hk.le hz).derivWithin (by norm_num)
    exact hd.differentiableAt (by norm_num)
  · exact hupper
  · exact canonicalIntrinsicPremium_boundary_zero hk hh hhk ht
  · exact canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht

theorem canonicalIntrinsicPremium_upper_near_boundary {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ δ C : ℝ, 0 < δ ∧ 0 < C ∧ ∀ s : ℝ, dist s t < δ → 0 < s ∧
      ∀ x ∈ Icc (canonicalLogBoundary k h s) (canonicalLogBoundary k h s+δ),
        deriv (fun y => canonicalIntrinsicPremium k h y s) x ≤ C*(x-canonicalLogBoundary k h s) ∧
        canonicalIntrinsicPremium k h x s ≤ C/2*(x-canonicalLogBoundary k h s)^2 := by
  obtain ⟨C,hC,hnear⟩ := canonicalIntrinsicPremium_deriv2_upper_near
    (x := canonicalLogBoundary k h t) hk hh hhk ht
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp hnear
  have hbnear : ∀ᶠ s in 𝓝 t,
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h t) < ε/2 :=
    Metric.tendsto_nhds.mp (canonicalLogBoundary_continuousAt hk hh hhk ht.le)
      (ε/2) (half_pos hε)
  have hpos : ∀ᶠ s in 𝓝 t, 0 < s := Ioi_mem_nhds ht
  obtain ⟨ρ,hρ,hρball⟩ := Metric.mem_nhds_iff.mp (hbnear.and hpos)
  let δ := min ρ (ε/4)
  have hδ : 0 < δ := lt_min hρ (by positivity)
  have hδρ : δ ≤ ρ := min_le_left _ _
  have hδε : δ ≤ ε/4 := min_le_right _ _
  refine ⟨δ,C,hδ,hC,?_⟩
  intro s hs
  obtain ⟨hbs,hs0⟩ := hρball (show s ∈ Metric.ball t ρ from hs.trans_le hδρ)
  refine ⟨hs0,?_⟩
  apply canonicalIntrinsicPremium_upper_of_deriv2_upper hk hh hhk hs0 (by linarith)
  intro y hy
  have hyδ : dist y (canonicalLogBoundary k h s) < δ := by
    rw [Real.dist_eq,abs_of_pos (sub_pos.mpr hy.1)]
    linarith [hy.2]
  have hspace : dist y (canonicalLogBoundary k h t) < ε :=
    (dist_triangle y (canonicalLogBoundary k h s) (canonicalLogBoundary k h t)).trans_lt
      ((add_lt_add hyδ hbs).trans_le (by linarith))
  have htime : dist s t < ε := hs.trans_le (by linarith)
  have hz : (y,s) ∈ Metric.ball (canonicalLogBoundary k h t,t) ε := by
    rw [Metric.mem_ball,Prod.dist_eq]
    exact max_lt hspace htime
  apply hball hz
  rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
  exact ⟨hs0,hy.1⟩

end AmericanConvexity.Stopping
