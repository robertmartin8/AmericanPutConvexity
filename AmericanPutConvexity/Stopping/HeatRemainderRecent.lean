import AmericanPutConvexity.Stopping.HeatHistoryRemainderTime
import AmericanPutConvexity.Stopping.HeatHistorySourceTime

/-! # The new-source frozen remainder has a linear time bound

The reference time precedes these sources, so it need not lie between each
source and observation. A uniform velocity deviation over the new interval
gives an error A*sqrt(delta)*u; integration cancels the remaining sqrt(delta).
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory

theorem firstOrder_remainder_of_deriv_deviation {b : ℝ → ℝ} {s t v M : ℝ}
    (hst : s ≤ t) (hb : ∀ r ∈ Icc s t, DifferentiableAt ℝ b r)
    (hv : ∀ r ∈ Icc s t, ‖deriv b r-v‖ ≤ M) :
    ‖b t-b s-v*(t-s)‖ ≤ M*(t-s) := by
  have hd (r : ℝ) (hr : r ∈ Icc s t) :
      HasDerivWithinAt (fun z => b z-v*z) (deriv b r-v) (Icc s t) r := by
    simpa only [mul_one] using! ((hb r hr).hasDerivAt.sub ((hasDerivAt_id r).const_mul v)).hasDerivWithinAt
  have he := Convex.norm_image_sub_le_of_norm_hasDerivWithin_le hd hv (convex_Icc s t)
    (left_mem_Icc.mpr hst) (right_mem_Icc.mpr hst)
  rw [Real.norm_of_nonneg (sub_nonneg.mpr hst)] at he
  convert! he using 1
  congr 1
  ring

theorem heatHistory_recent_linear_remainder_bound {u δ x v A L C D fs c : ℝ}
    (hu : 0 < u) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hrem : ‖x-v*u‖ ≤ A*Real.sqrt δ*u) (hv : ‖v‖ ≤ L)
    (hfs : ‖fs‖ ≤ C) (hmod : ‖fs-c‖ ≤ D*Real.sqrt δ) :
    ‖heatBoundaryKernel u x*fs-heatBoundaryKernel u (v*u)*c‖ ≤
      (3*(A*C+L*D)*Real.sqrt δ/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
  have hs : 0 < Real.sqrt u := Real.sqrt_pos.mpr hu
  have hr : ‖x-v*u‖ ≤ (A*Real.sqrt δ/Real.sqrt u)*u*Real.sqrt u := by
    convert! hrem using 1
    field_simp
  have hm : ‖fs-c‖ ≤ (D*Real.sqrt δ/Real.sqrt u)*Real.sqrt u := by
    convert! hmod using 1
    field_simp
  have he := heatHistory_integrand_linear_remainder_bound hu
    (by positivity : 0 ≤ A*Real.sqrt δ/Real.sqrt u) hL hr hv hfs hm
  convert! he using 1
  field_simp

theorem frozenHeatHistoryRemainder_recent_bound {b f : ℝ → ℝ} {t δ v c A L C D : ℝ}
    (hδ : 0 < δ) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hb : Continuous b) (hf : Continuous f) (hv : ‖v‖ ≤ L)
    (hrem : ∀ u ∈ Ioo 0 δ, ‖b t-b (t-u)-v*u‖ ≤ A*Real.sqrt δ*u)
    (hfs : ∀ u ∈ Ioo 0 δ, ‖f (t-u)‖ ≤ C)
    (hmod : ∀ u ∈ Ioo 0 δ, ‖f (t-u)-c‖ ≤ D*Real.sqrt δ) :
    IntegrableOn (fun u => frozenHeatHistoryRemainder b f v c t (t-u)) (Ioo 0 δ) ∧
      ‖∫ u in Ioo 0 δ, frozenHeatHistoryRemainder b f v c t (t-u)‖ ≤
        (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*δ := by
  have hcont := frozenHeatHistoryRemainder_source_continuousOn
    (t := t) (r := t) (T := δ) (v := v) (c := c) le_rfl hb.continuousOn hf.continuousOn
  have hi := (integrableOn_inverse_sqrt hδ).const_mul
    (3*(A*C+L*D)*Real.sqrt δ/Real.sqrt (2*Real.pi))
  have hbound : ∀ᵐ u ∂volume.restrict (Ioo 0 δ),
      ‖frozenHeatHistoryRemainder b f v c t (t-u)‖ ≤
        (3*(A*C+L*D)*Real.sqrt δ/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    simpa only [frozenHeatHistoryRemainder,movingHeatHistoryKernel,sub_sub_cancel] using
      heatHistory_recent_linear_remainder_bound hu.1 hA hL (hrem u hu) hv (hfs u hu) (hmod u hu)
  refine ⟨hi.mono' (hcont.aestronglyMeasurable measurableSet_Ioo) hbound,?_⟩
  calc
    _ ≤ ∫ u in Ioo 0 δ,
        (3*(A*C+L*D)*Real.sqrt δ/Real.sqrt (2*Real.pi))*(Real.sqrt u)⁻¹ :=
      norm_integral_le_of_norm_le hi hbound
    _ = (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*δ := by
      rw [integral_const_mul,integral_inverse_sqrt hδ]
      calc
        _ = (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*(Real.sqrt δ)^2 := by ring
        _ = _ := by rw [Real.sq_sqrt hδ.le]

end AmericanPutConvexity.Stopping
