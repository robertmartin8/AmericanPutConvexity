import AmericanConvexity.Stopping.ActualBoundaryNormalization
import AmericanConvexity.Stopping.AEHorizonValue

/-! Review-only specializations of existing project theorems. No new hypotheses
about the PDE or boundary are introduced. This is not a production module. -/

namespace AmericanConvexity.Review

open Set MeasureTheory ProbabilityTheory Stopping Boundary
open scoped NNReal

theorem actualMeasure_probability :
    @IsProbabilityMeasure (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
      (completedMeasure gaussianLimit) := inferInstance

theorem actualValue_contact_iff {K r q σ S : ℝ} {τ : ℝ≥0}
    (hK : 0 < K) (hr : 0 ≤ r) (hσ : 0 < σ) (hS : 0 < S) (hτ : 0 < τ) :
    brownianUsualAmericanPut K r q σ S τ = max (K-S) 0 ↔
      S ≤ brownianUsualExerciseBoundary K r q σ τ := by
  let μ := completedMeasure gaussianLimit
  have hz : ∀ᵐ ω ∂μ, brownian 0 ω = 0 := isBrownianReal_brownian.eval_zero_ae_eq_zero
  have hp (s : ℝ) (hs : 0 < s) := brownianUsualAmericanPut_pos
    (K := K) (r := r) (q := q) (σ := σ) hK hr hσ hs hτ
  letI : MeasurableSpace (ℝ≥0 → ℝ) := completedMeasurableSpace gaussianLimit
  exact value_contact_iff_le_threshold (P := μ) (𝓕 := brownianUsualFiltration)
    brownian_completed_measurable hz hK hr hp hS.le

theorem actualBoundary_strict_bounds {K r q σ : ℝ} {τ : ℝ≥0}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r)
    (hσ : 0 < σ) (hτ : 0 < τ) :
    0 < brownianUsualExerciseBoundary K r q σ τ ∧
      brownianUsualExerciseBoundary K r q σ τ < K := by
  obtain ⟨hk,hh,hhk⟩ := normalized_rates_admissible hr hq hqr hσ
  have ht : 0 < σ^2/2*(τ : ℝ) := mul_pos (by positivity) (by exact_mod_cast hτ)
  have he := brownianUsualExerciseBoundary_eq_scaled_canonical hK hr hq hqr hσ
    (τ := (τ : ℝ)) (by exact_mod_cast hτ)
  simp only [Real.toNNReal_coe] at he
  rw [he]
  refine ⟨mul_pos hK (canonicalStockBoundary_pos hk hh hhk ht.le), ?_⟩
  simpa only [mul_one] using
    mul_lt_mul_of_pos_left (canonicalStockBoundary_lt_one hk.le ht) hK

theorem actualValue_bounds {K r q σ S : ℝ} (τ : ℝ≥0)
    (hK : 0 ≤ K) (hr : 0 ≤ r) (hS : 0 ≤ S) :
    max (K-S) 0 ≤ brownianUsualAmericanPut K r q σ S τ ∧
      brownianUsualAmericanPut K r q σ S τ ≤ K := by
  let μ := completedMeasure gaussianLimit
  have hz : ∀ᵐ ω ∂μ, brownian 0 ω = 0 := isBrownianReal_brownian.eval_zero_ae_eq_zero
  letI : MeasurableSpace (ℝ≥0 → ℝ) := completedMeasurableSpace gaussianLimit
  exact ⟨payoff_le_value (P := μ) (𝓕 := brownianUsualFiltration)
    brownian_completed_measurable hz hK hr hS,
    value_le_strike (P := μ) (𝓕 := brownianUsualFiltration)
    brownian_completed_measurable hK hr hS⟩

theorem actualBoundary_eq_sup_positive_contact {K r q σ : ℝ} {τ : ℝ≥0}
    (hK : 0 < K) (hr : 0 < r) (hq : 0 ≤ q) (hqr : q ≤ r)
    (hσ : 0 < σ) (hτ : 0 < τ) :
    brownianUsualExerciseBoundary K r q σ τ =
      sSup {S : ℝ | 0 < S ∧ brownianUsualAmericanPut K r q σ S τ = max (K-S) 0} := by
  let B := brownianUsualExerciseBoundary K r q σ τ
  let E := {S : ℝ | 0 < S ∧ brownianUsualAmericanPut K r q σ S τ = max (K-S) 0}
  have hB : 0 < B := (actualBoundary_strict_bounds hK hr hq hqr hσ hτ).1
  have hmem : B ∈ E := ⟨hB, (actualValue_contact_iff hK hr.le hσ hB hτ).mpr le_rfl⟩
  have hupper : ∀ S ∈ E, S ≤ B := fun S hS =>
    (actualValue_contact_iff hK hr.le hσ hS.1 hτ).mp hS.2
  exact le_antisymm (le_csSup ⟨B,hupper⟩ hmem) (csSup_le ⟨B,hmem⟩ hupper)

theorem actualValue_eq_ae_value (K r q σ S : ℝ) (τ : ℝ≥0) :
    brownianUsualAmericanPut K r q σ S τ =
      @aeAmericanPutValue (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit)
        (completedMeasure gaussianLimit) brownianUsualFiltration brownian K r q σ S τ :=
  (@aeAmericanPutValue_eq (ℝ≥0 → ℝ) (completedMeasurableSpace gaussianLimit) (completedMeasure gaussianLimit)
    brownianUsualFiltration brownian K r q σ S τ).symm

theorem actualUsualFiltration_eq_iInf (t : ℝ≥0) :
    brownianUsualFiltration t =
      ⨅ s > t, (ambientNullAugmentation
        (mΩ := completedMeasurableSpace gaussianLimit)
        (completedAmbientFiltration gaussianLimit brownianFiltration)
        (completedMeasure gaussianLimit)) s :=
  Filtration.rightCont_eq _ t

end AmericanConvexity.Review
