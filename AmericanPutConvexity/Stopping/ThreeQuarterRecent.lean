import AmericanPutConvexity.Stopping.ThreeQuarterRemainderDerivative
import AmericanPutConvexity.Stopping.HeatRemainderRecent

/-! # The new-source remainder is smaller than a first-order time increment

A three-quarter graph-velocity and density modulus yields an order-5/4
integrated remainder. Its difference-quotient contribution tends to zero.
The reference slope and value are not differentiated.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem heatHistory_recent_threeQuarter_bound {u δ x v A L C D fs c : ℝ}
    (hu : 0 < u) (hδ : 0 < δ) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hr : ‖x-v*u‖ ≤ A*δ^(3/4 : ℝ)*u) (hv : ‖v‖ ≤ L)
    (hfs : ‖fs‖ ≤ C) (hm : ‖fs-c‖ ≤ D*δ^(3/4 : ℝ)) :
    ‖heatBoundaryKernel u x*fs-heatBoundaryKernel u (v*u)*c‖ ≤
      (3*(A*C+L*D)*δ^(3/4 : ℝ)/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
  have heq := threeQuarter_eq_quarter_mul_sqrt hδ
  have hr' : ‖x-v*u‖ ≤ (A*δ^(1/4 : ℝ))*Real.sqrt δ*u := by
    simpa only [heq,mul_assoc] using hr
  have hm' : ‖fs-c‖ ≤ (D*δ^(1/4 : ℝ))*Real.sqrt δ := by
    simpa only [heq,mul_assoc] using hm
  have he := heatHistory_recent_linear_remainder_bound hu
    (by positivity : 0 ≤ A*δ^(1/4 : ℝ)) hL hr' hv hfs hm'
  convert! he using 1
  rw [heq]
  ring

theorem frozenHeatHistoryRemainder_recent_threeQuarter
    {b f : ℝ → ℝ} {t δ v c A L C D : ℝ}
    (hδ : 0 < δ) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hb : ContinuousOn b (Ioo (t-δ) t)) (hf : ContinuousOn f (Ioo (t-δ) t)) (hv : ‖v‖ ≤ L)
    (hr : ∀ u ∈ Ioo 0 δ, ‖b t-b (t-u)-v*u‖ ≤ A*δ^(3/4 : ℝ)*u)
    (hfs : ∀ u ∈ Ioo 0 δ, ‖f (t-u)‖ ≤ C)
    (hm : ∀ u ∈ Ioo 0 δ, ‖f (t-u)-c‖ ≤ D*δ^(3/4 : ℝ)) :
    IntegrableOn (fun u => frozenHeatHistoryRemainder b f v c t (t-u)) (Ioo 0 δ) ∧
      ‖∫ u in Ioo 0 δ, frozenHeatHistoryRemainder b f v c t (t-u)‖ ≤
        (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*δ^(5/4 : ℝ) := by
  have hcont := frozenHeatHistoryRemainder_source_continuousOn
    (t := t) (r := t) (T := δ) (v := v) (c := c) le_rfl hb hf
  have hi := (integrableOn_inverse_sqrt hδ).const_mul
    (3*(A*C+L*D)*δ^(3/4 : ℝ)/Real.sqrt (2*Real.pi))
  have hbound : ∀ᵐ u ∂volume.restrict (Ioo 0 δ),
      ‖frozenHeatHistoryRemainder b f v c t (t-u)‖ ≤
        (3*(A*C+L*D)*δ^(3/4 : ℝ)/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    simpa only [frozenHeatHistoryRemainder,movingHeatHistoryKernel,sub_sub_cancel] using
      heatHistory_recent_threeQuarter_bound hu.1 hδ hA hL (hr u hu) hv (hfs u hu) (hm u hu)
  refine ⟨hi.mono' (hcont.aestronglyMeasurable measurableSet_Ioo) hbound,?_⟩
  calc
    _ ≤ ∫ u in Ioo 0 δ,
        (3*(A*C+L*D)*δ^(3/4 : ℝ)/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ :=
      norm_integral_le_of_norm_le hi hbound
    _ = (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*(δ^(3/4 : ℝ)*Real.sqrt δ) := by
      rw [integral_const_mul,integral_inverse_sqrt hδ]
      ring
    _ = _ := by
      rw [Real.sqrt_eq_rpow δ,← Real.rpow_add hδ]
      norm_num

theorem quotient_tendsto_zero_of_fiveQuarter_bound {F : ℝ → ℝ} {M : ℝ}
    (hb : ∀ᶠ δ in 𝓝[>] (0 : ℝ), ‖F δ‖ ≤ M*δ^(5/4 : ℝ)) :
    Tendsto (fun δ => F δ/δ) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
  have hlim : Tendsto (fun δ : ℝ => M*δ^(1/4 : ℝ)) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
    have hc := (continuousAt_const (y := M)).mul
      (Real.continuousAt_rpow_const 0 (1/4) (Or.inr (by norm_num)))
    have hc' : ContinuousAt (fun δ : ℝ => M*δ^(1/4 : ℝ)) 0 := hc
    simpa only [Real.zero_rpow (by norm_num : (1/4 : ℝ) ≠ 0),mul_zero] using
      hc'.tendsto.mono_left (nhdsWithin_le_nhds : 𝓝[>] (0 : ℝ) ≤ 𝓝 0)
  apply squeeze_zero_norm' ?_ hlim
  filter_upwards [hb,self_mem_nhdsWithin] with δ hδ hpos
  change 0 < δ at hpos
  rw [norm_div,Real.norm_of_nonneg hpos.le]
  calc
    _ ≤ (M*δ^(5/4 : ℝ))/δ := div_le_div_of_nonneg_right hδ hpos.le
    _ = M*δ^(1/4 : ℝ) := by
      rw [mul_div_assoc,← Real.rpow_sub_one hpos.ne']
      norm_num

end AmericanPutConvexity.Stopping
