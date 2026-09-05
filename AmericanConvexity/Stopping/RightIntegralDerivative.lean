import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Analysis.Calculus.Deriv.Slope

/-! # Right differentiation under an integral with a dominated slope

This one-sided form allows a source interval ending at the observation
time. Integrability of the original functions is explicit, so the integral
of their difference is a genuine difference of integrals.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem hasDerivWithinAt_integral_Ici_of_dominated_slope
    {α : Type*} [MeasurableSpace α] {μ : Measure α}
    {F : ℝ → α → ℝ} {G B : α → ℝ} {t : ℝ}
    (hFt : Integrable (F t) μ)
    (hF : ∀ᶠ r in 𝓝[>] t, Integrable (F r) μ)
    (hB : Integrable B μ)
    (hb : ∀ᶠ r in 𝓝[>] t, ∀ᵐ a ∂μ, ‖F r a-F t a‖ ≤ B a*(r-t))
    (hd : ∀ᵐ a ∂μ, HasDerivAt (fun r => F r a) (G a) t) :
    HasDerivWithinAt (fun r => ∫ a, F r a ∂μ) (∫ a, G a ∂μ) (Ici t) t := by
  have hmeas : ∀ᶠ r in 𝓝[>] t, AEStronglyMeasurable (fun a => (F r a-F t a)/(r-t)) μ := by
    filter_upwards [hF] with r hr
    exact ((hr.sub hFt).div_const (r-t)).aestronglyMeasurable
  have hbound : ∀ᶠ r in 𝓝[>] t, ∀ᵐ a ∂μ, ‖(F r a-F t a)/(r-t)‖ ≤ B a := by
    filter_upwards [hb,self_mem_nhdsWithin] with r hr hrt
    change t < r at hrt
    filter_upwards [hr] with a ha
    rw [norm_div,Real.norm_of_nonneg (sub_nonneg.mpr hrt.le)]
    exact (div_le_iff₀ (sub_pos.mpr hrt)).mpr ha
  have hlim : ∀ᵐ a ∂μ, Tendsto (fun r => (F r a-F t a)/(r-t)) (𝓝[>] t) (𝓝 (G a)) := by
    filter_upwards [hd] with a ha
    have he : slope (fun r => F r a) t = fun r => (F r a-F t a)/(r-t) :=
      funext (fun r => slope_def_field _ _ r)
    simpa only [he] using ha.tendsto_slope.mono_left (nhdsGT_le_nhdsNE t)
  have hi := tendsto_integral_filter_of_dominated_convergence B hmeas hbound hB hlim
  apply HasDerivWithinAt.Ici_of_Ioi
  apply (hasDerivWithinAt_iff_tendsto_slope' (by simp : t ∉ Ioi t)).mpr
  apply hi.congr'
  filter_upwards [hF] with r hr
  rw [slope_def_field,integral_div,integral_sub hr hFt]

end AmericanConvexity.Stopping
