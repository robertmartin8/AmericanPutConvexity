import AmericanConvexity.Stopping.ThreeQuarterRemainderDerivative

/-! # Dominated continuity of an integral with a moving upper endpoint

An integrable inverse-three-quarter majorant controls the origin. The only
exception in pointwise convergence is the single moving endpoint, a null
set for Lebesgue measure. The resulting integral is genuinely integrable.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem integral_Ioo_moving_right_continuousAt
    {F : ℝ → ℝ → ℝ} {L : ℝ → ℝ} {t T M : ℝ} {U : Set ℝ}
    (hT : 0 < T) (hM : 0 ≤ M) (hU : U ∈ 𝓝 t)
    (hL : ContinuousAt L t) (hLT : L t < T)
    (hf : ∀ r ∈ U, ContinuousOn (F r) (Ioo 0 T))
    (hp : ∀ u ∈ Ioo 0 T, ContinuousAt (fun r => F r u) t)
    (hb : ∀ r ∈ U, ∀ u ∈ Ioo 0 T, ‖F r u‖ ≤ M*u^(-3/4 : ℝ)) :
    ContinuousAt (fun r => ∫ u in Ioo 0 (L r), F r u) t := by
  let G := fun r => (Iio (L r)).indicator (F r)
  have hi : IntegrableOn (fun u : ℝ => M*u^(-3/4 : ℝ)) (Ioo 0 T) :=
    ((intervalIntegral.integrableOn_Ioo_rpow_iff hT).mpr (by norm_num)).const_mul M
  have hmeas : ∀ᶠ r in 𝓝 t, AEStronglyMeasurable (G r) (volume.restrict (Ioo 0 T)) := by
    filter_upwards [hU] with r hr
    exact ((hf r hr).aestronglyMeasurable measurableSet_Ioo).indicator measurableSet_Iio
  have hbound : ∀ᶠ r in 𝓝 t, ∀ᵐ u ∂volume.restrict (Ioo 0 T), ‖G r u‖ ≤ M*u^(-3/4 : ℝ) := by
    filter_upwards [hU] with r hr
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    by_cases huL : u < L r
    · simpa only [G,indicator_of_mem (show u ∈ Iio (L r) from huL)] using hb r hr u hu
    · simp only [G,indicator_of_notMem (show u ∉ Iio (L r) from huL),norm_zero]
      exact mul_nonneg hM (Real.rpow_nonneg hu.1.le _)
  have hlim : ∀ᵐ u ∂volume.restrict (Ioo 0 T), Tendsto (fun r => G r u) (𝓝 t) (𝓝 (G t u)) := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo,ae_restrict_of_ae (volume.ae_ne (L t))] with u hu hne
    rcases lt_or_gt_of_ne hne with hlt | hgt
    · have hn : ∀ᶠ r in 𝓝 t, u < L r := hL.preimage_mem_nhds (Ioi_mem_nhds hlt)
      have he : (fun r => G r u) =ᶠ[𝓝 t] (fun r => F r u) := by
        filter_upwards [hn] with r hr
        exact indicator_of_mem (show u ∈ Iio (L r) from hr) _
      simpa only [G,indicator_of_mem (show u ∈ Iio (L t) from hlt)] using (hp u hu).tendsto.congr' he.symm
    · have hn : ∀ᶠ r in 𝓝 t, L r < u := hL.preimage_mem_nhds (Iio_mem_nhds hgt)
      have he : (fun r => G r u) =ᶠ[𝓝 t] (fun _ => (0 : ℝ)) := by
        filter_upwards [hn] with r hr
        exact indicator_of_notMem (show u ∉ Iio (L r) from not_lt.mpr hr.le) _
      simpa only [G,indicator_of_notMem (show u ∉ Iio (L t) from not_lt.mpr hgt.le)] using
        tendsto_const_nhds.congr' he.symm
  have hd := tendsto_integral_filter_of_dominated_convergence
    (fun u : ℝ => M*u^(-3/4 : ℝ)) hmeas hbound hi hlim
  have he (r : ℝ) (hr : L r < T) :
      (∫ u in Ioo 0 T, G r u) = ∫ u in Ioo 0 (L r), F r u := by
    have hs : Iio (L r) ∩ Ioo 0 T = Ioo 0 (L r) := by
      ext u
      constructor
      · intro hu
        exact ⟨hu.2.1,hu.1⟩
      · intro hu
        exact ⟨hu.2,hu.1,hu.2.trans hr⟩
    dsimp [G]
    rw [integral_indicator measurableSet_Iio,Measure.restrict_restrict measurableSet_Iio,hs]
  rw [he t hLT] at hd
  apply hd.congr'
  filter_upwards [hL.preimage_mem_nhds (Iio_mem_nhds hLT)] with r hr
  exact he r hr

end AmericanConvexity.Stopping
