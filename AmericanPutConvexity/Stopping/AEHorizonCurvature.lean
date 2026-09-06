import AmericanPutConvexity.Stopping.AEHorizonValue
import AmericanPutConvexity.Stopping.PhysicalBoundaryCurvature

/-! # Actual curvature with the almost-sure horizon convention

This spells out the usual financial convention: all stopping times bounded
by maturity almost surely are admissible, including times infinite on a null
set. Equality of thresholds transfers the existing actual curvature theorem.
-/

namespace AmericanPutConvexity.Stopping

open Set MeasureTheory ProbabilityTheory
open scoped NNReal

noncomputable def brownianAEExerciseBoundary (K r q σ : ℝ) (T : ℝ≥0) : ℝ :=
  @aeExerciseThreshold (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
    (completedMeasure gaussianLimit) brownianUsualFiltration brownian K r q σ T

theorem brownianAEExerciseBoundary_eq (K r q σ : ℝ) (T : ℝ≥0) :
    brownianAEExerciseBoundary K r q σ T = brownianUsualExerciseBoundary K r q σ T :=
  @aeExerciseThreshold_eq (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
    (completedMeasure gaussianLimit) brownianUsualFiltration brownian K r q σ T

theorem brownianAEBoundary_classical_curvature {K r q σ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r) (hσ : 0 < σ) :
    ContDiffOn ℝ 2 (fun τ : ℝ => Real.log (brownianAEExerciseBoundary K r q σ τ.toNNReal/K)) (Ioi 0) ∧
    ContDiffOn ℝ 2 (fun τ : ℝ => brownianAEExerciseBoundary K r q σ τ.toNNReal) (Ioi 0) ∧
    (∀ τ : ℝ, 0 < τ → 0 ≤ deriv (deriv (fun s : ℝ =>
      Real.log (brownianAEExerciseBoundary K r q σ s.toNNReal/K))) τ) ∧
    (∀ τ : ℝ, 0 < τ → 0 < deriv (deriv (fun s : ℝ =>
      brownianAEExerciseBoundary K r q σ s.toNNReal)) τ) := by
  simpa only [brownianAEExerciseBoundary_eq] using
    brownianUsualBoundary_classical_curvature hK hr hq hqr hσ

theorem zeroDividend_brownianAEBoundary_deriv2_pos {K r σ τ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < deriv (deriv (fun s : ℝ => brownianAEExerciseBoundary K r 0 σ s.toNNReal)) τ :=
  (brownianAEBoundary_classical_curvature hK hr le_rfl hr.le hσ).2.2.2 τ hτ

theorem equalRates_brownianAEBoundary_deriv2_pos {K r σ τ : ℝ}
    (hK : 0 < K) (hr : 0 < r) (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < deriv (deriv (fun s : ℝ => brownianAEExerciseBoundary K r r σ s.toNNReal)) τ :=
  (brownianAEBoundary_classical_curvature hK hr hr.le le_rfl hσ).2.2.2 τ hτ

/-- A nonempty parameter example strictly outside Liu's sufficient range.
This is an exact theorem instantiation, not numerical evidence for curvature. -/
theorem openRange_brownianAEBoundary_example :
    (0 : ℝ) < 1/40 ∧ (1/40 : ℝ) < 1/20 ∧ (1/20 : ℝ) < 1/40+(2/5)^2/2 ∧
    ∀ τ : ℝ, 0 < τ →
      0 < deriv (deriv (fun s : ℝ => brownianAEExerciseBoundary 1 (1/20) (1/40) (2/5) s.toNNReal)) τ := by
  refine ⟨by norm_num,by norm_num,by norm_num,?_⟩
  exact (brownianAEBoundary_classical_curvature (by norm_num : (0 : ℝ) < 1)
    (by norm_num : (0 : ℝ) < 1/20) (by norm_num : (0 : ℝ) ≤ 1/40)
    (by norm_num : (1/40 : ℝ) ≤ 1/20) (by norm_num : (0 : ℝ) < 2/5)).2.2.2

end AmericanPutConvexity.Stopping
