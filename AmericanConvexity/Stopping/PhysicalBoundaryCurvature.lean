import AmericanConvexity.Stopping.ActualBoundaryCurvature
import AmericanConvexity.Stopping.PhysicalBoundaryConvexity

/-! # Classical curvature in physical units for the actual American put

These are the completed-usual-filtration optimal-stopping boundaries, not
arbitrary classical pricing solutions. Positive strike, rate and volatility,
and 0 ≤ q ≤ r are the only hypotheses. C2 regularity is included explicitly
so the derivative conclusions are not statements about totalized derivatives
at nondifferentiability points.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem brownianUsualLogBoundary_contDiffOn_two {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    ContDiffOn ℝ 2
      (fun τ : ℝ => Real.log (brownianUsualExerciseBoundary K r q σ τ.toNNReal/K)) (Ioi 0) := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  intro τ hτ
  have ht : 0 < σ^2/2*τ := mul_pos (div_pos (sq_pos_of_pos hσ) (by norm_num)) hτ
  have hc : ContDiffAt ℝ 2 (fun s => canonicalLogBoundary (normalizedRate r σ)
      (normalizedRate q σ) (σ^2/2*s)) τ :=
    ((canonicalLogBoundary_contDiffOn_two hk hh hhk).contDiffAt (Ioi_mem_nhds ht)).comp τ
      (contDiffAt_const.mul contDiffAt_id)
  have he : (fun s : ℝ => Real.log (brownianUsualExerciseBoundary K r q σ s.toNNReal/K)) =ᶠ[𝓝 τ]
      (fun s => canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ) (σ^2/2*s)) := by
    filter_upwards [Ioi_mem_nhds hτ] with s hs
    exact brownianUsualLogBoundary_normalization hK hr hq hqr hσ hs
  exact (hc.congr_of_eventuallyEq he).contDiffWithinAt

theorem brownianUsualStockBoundary_contDiffOn_two {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    ContDiffOn ℝ 2 (fun τ : ℝ => brownianUsualExerciseBoundary K r q σ τ.toNNReal) (Ioi 0) := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  intro τ hτ
  have ht : 0 < σ^2/2*τ := mul_pos (div_pos (sq_pos_of_pos hσ) (by norm_num)) hτ
  have hc : ContDiffAt ℝ 2 (fun s => K*Real.exp (canonicalLogBoundary (normalizedRate r σ)
      (normalizedRate q σ) (σ^2/2*s))) τ :=
    contDiffAt_const.mul (((canonicalLogBoundary_contDiffOn_two hk hh hhk).contDiffAt
      (Ioi_mem_nhds ht)).comp τ (contDiffAt_const.mul contDiffAt_id)).exp
  have he : (fun s : ℝ => brownianUsualExerciseBoundary K r q σ s.toNNReal) =ᶠ[𝓝 τ]
      (fun s => K*Real.exp (canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ) (σ^2/2*s))) := by
    filter_upwards [Ioi_mem_nhds hτ] with s hs
    exact brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hs
  exact (hc.congr_of_eventuallyEq he).contDiffWithinAt

theorem brownianUsualLogBoundary_deriv2_nonneg {K r q σ τ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 ≤ deriv (deriv (fun s : ℝ => Real.log (brownianUsualExerciseBoundary K r q σ s.toNNReal/K))) τ := by
  have hc := brownianUsualLogBoundary_contDiffOn_two hK hr hq hqr hσ
  have hm := (brownianUsualLogBoundary_convexOn hK hr hq hqr hσ).monotoneOn_deriv
    (fun s hs => (hc.contDiffAt (Ioi_mem_nhds hs)).differentiableAt (by norm_num))
  have hn := hm.derivWithin_nonneg (x := τ)
  rw [derivWithin_of_isOpen isOpen_Ioi hτ] at hn
  exact hn

theorem brownianUsualStockBoundary_deriv2_pos {K r q σ τ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < deriv (deriv (fun s : ℝ => brownianUsualExerciseBoundary K r q σ s.toNNReal)) τ := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  have he : (fun s : ℝ => brownianUsualExerciseBoundary K r q σ s.toNNReal) =ᶠ[𝓝 τ]
      remainingTimeBoundary K σ (canonicalLogBoundary (normalizedRate r σ) (normalizedRate q σ)) := by
    filter_upwards [Ioi_mem_nhds hτ] with s hs
    exact brownianUsualExerciseBoundary_normalization hK hr hq hqr hσ hs
  rw [he.deriv.deriv_eq]
  exact canonicalRemainingTimeBoundary_deriv2_pos hk hh hhk hK hσ hτ

/-- The proposed conclusions, with actual-boundary C2 regularity included. -/
theorem brownianUsualBoundary_classical_curvature {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    ContDiffOn ℝ 2 (fun τ : ℝ => Real.log (brownianUsualExerciseBoundary K r q σ τ.toNNReal/K)) (Ioi 0) ∧
    ContDiffOn ℝ 2 (fun τ : ℝ => brownianUsualExerciseBoundary K r q σ τ.toNNReal) (Ioi 0) ∧
    (∀ τ : ℝ, 0 < τ → 0 ≤ deriv (deriv (fun s : ℝ =>
      Real.log (brownianUsualExerciseBoundary K r q σ s.toNNReal/K))) τ) ∧
    (∀ τ : ℝ, 0 < τ → 0 < deriv (deriv (fun s : ℝ =>
      brownianUsualExerciseBoundary K r q σ s.toNNReal)) τ) :=
  ⟨brownianUsualLogBoundary_contDiffOn_two hK hr hq hqr hσ,
    brownianUsualStockBoundary_contDiffOn_two hK hr hq hqr hσ,
    fun _ ht => brownianUsualLogBoundary_deriv2_nonneg hK hr hq hqr hσ ht,
    fun _ ht => brownianUsualStockBoundary_deriv2_pos hK hr hq hqr hσ ht⟩

theorem zeroDividend_brownianUsualStockBoundary_deriv2_pos {K r σ τ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < deriv (deriv (fun s : ℝ => brownianUsualExerciseBoundary K r 0 σ s.toNNReal)) τ :=
  brownianUsualStockBoundary_deriv2_pos hK hr le_rfl hr.le hσ hτ

theorem liuRange_brownianUsualStockBoundary_deriv2_pos {K r q σ τ : ℝ}
    (hK : 0 < K) (hq : 0 ≤ q) (hσ : 0 < σ) (hliu : q+σ^2/2 ≤ r) (hτ : 0 < τ) :
    0 < deriv (deriv (fun s : ℝ => brownianUsualExerciseBoundary K r q σ s.toNNReal)) τ := by
  have ha : 0 < σ^2/2 := by positivity
  exact brownianUsualStockBoundary_deriv2_pos hK (by linarith) hq (by linarith) hσ hτ

end AmericanConvexity.Stopping
