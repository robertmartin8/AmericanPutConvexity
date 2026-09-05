import AmericanConvexity.Stopping.HeatHistoryTimeKernel
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals

/-! # The integrable near/far majorant for history time increments

Near the diagonal use twice the size bound. Away from it use the time
derivative bound times the time increment. Splitting at that increment
gives an exact square-root integral bound. The value at the splitting
point is immaterial to integration and is explicitly excluded in the
pointwise comparison.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem inverse_mul_sqrt_eq_rpow {u : ℝ} (hu : 0 < u) :
    (u*Real.sqrt u)⁻¹ = u^(-3/2 : ℝ) := by
  rw [show (-3/2 : ℝ) = -(1+1/2) by norm_num,Real.rpow_neg hu.le,
    Real.rpow_add hu,Real.rpow_one,← Real.sqrt_eq_rpow]

theorem integrableOn_inverse_mul_sqrt_tail {δ : ℝ} (hδ : 0 < δ) :
    IntegrableOn (fun u => (u*Real.sqrt u)⁻¹) (Ioi δ) := by
  apply (integrableOn_Ioi_rpow_of_lt (by norm_num : (-3/2 : ℝ) < -1) hδ).congr_fun
    (fun u hu => (inverse_mul_sqrt_eq_rpow (hδ.trans hu)).symm) measurableSet_Ioi

theorem integral_inverse_mul_sqrt_tail {δ : ℝ} (hδ : 0 < δ) :
    (∫ u in Ioi δ, (u*Real.sqrt u)⁻¹) = 2/Real.sqrt δ := by
  have he : (∫ u in Ioi δ, (u*Real.sqrt u)⁻¹) = ∫ u in Ioi δ, u^(-3/2 : ℝ) :=
    setIntegral_congr_fun measurableSet_Ioi (fun u hu => inverse_mul_sqrt_eq_rpow (hδ.trans hu))
  rw [he,integral_Ioi_rpow_of_lt (by norm_num : (-3/2 : ℝ) < -1) hδ]
  rw [show (-3/2 : ℝ)+1 = -(1/2) by ring,Real.rpow_neg hδ.le,← Real.sqrt_eq_rpow]
  ring

noncomputable def heatHistoryTimeMajorant (δ u : ℝ) : ℝ :=
  (Ioo 0 δ).indicator (fun u => 6*(Real.sqrt u)⁻¹) u+
    (Ioi δ).indicator (fun u => (8*δ)*(u*Real.sqrt u)⁻¹) u

theorem heatHistoryTimeMajorant_integrable {δ : ℝ} (hδ : 0 < δ) :
    Integrable (heatHistoryTimeMajorant δ) :=
  (((integrable_indicator_iff measurableSet_Ioo).mpr
    ((integrableOn_inverse_sqrt hδ).const_mul 6))).add
    ((integrable_indicator_iff measurableSet_Ioi).mpr
      ((integrableOn_inverse_mul_sqrt_tail hδ).const_mul (8*δ)))

theorem heatHistoryTimeMajorant_nonneg {δ u : ℝ} (hδ : 0 ≤ δ) :
    0 ≤ heatHistoryTimeMajorant δ u := by
  apply add_nonneg
  · exact indicator_nonneg (fun _ _ => by positivity) _
  · apply indicator_nonneg _ _
    intro v hv
    have hv0 : 0 < v := hδ.trans_lt hv
    positivity

theorem heatHistoryTimeMajorant_integral {δ : ℝ} (hδ : 0 < δ) :
    (∫ u, heatHistoryTimeMajorant δ u) = 28*Real.sqrt δ := by
  have hn := (integrable_indicator_iff measurableSet_Ioo).mpr
    ((integrableOn_inverse_sqrt hδ).const_mul 6)
  have hf := (integrable_indicator_iff measurableSet_Ioi).mpr
    ((integrableOn_inverse_mul_sqrt_tail hδ).const_mul (8*δ))
  unfold heatHistoryTimeMajorant
  rw [integral_add hn hf,integral_indicator measurableSet_Ioo,
    integral_indicator measurableSet_Ioi,integral_const_mul,integral_const_mul,
    integral_inverse_sqrt hδ,integral_inverse_mul_sqrt_tail hδ]
  have hs : 0 < Real.sqrt δ := Real.sqrt_pos.mpr hδ
  have hsq := Real.sq_sqrt hδ.le
  field_simp
  nlinarith

theorem heatHistoryTimeMajorant_near {δ u : ℝ} (hu : 0 < u) (hud : u < δ) :
    heatHistoryTimeMajorant δ u = 6*(Real.sqrt u)⁻¹ := by
  simp only [heatHistoryTimeMajorant,indicator_of_mem (show u ∈ Ioo 0 δ from ⟨hu,hud⟩),
    indicator_of_notMem (show u ∉ Ioi δ from not_lt.mpr hud.le),add_zero]

theorem heatHistoryTimeMajorant_far {δ u : ℝ} (hud : δ < u) :
    heatHistoryTimeMajorant δ u = (8*δ)*(u*Real.sqrt u)⁻¹ := by
  simp only [heatHistoryTimeMajorant,indicator_of_notMem (show u ∉ Ioo 0 δ from fun h => (not_lt.mpr hud.le) h.2),
    indicator_of_mem (show u ∈ Ioi δ from hud),zero_add]

theorem movingHeatHistoryKernel_time_majorant {b : ℝ → ℝ} {s t₁ t₂ L : ℝ}
    (hst : s < t₁) (htt : t₁ < t₂) (hL : 0 ≤ L) (hne : t₁-s ≠ t₂-t₁)
    (hb : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hv : ∀ t ∈ Icc t₁ t₂, ‖deriv b t‖ ≤ L)
    (hmove : ∀ t ∈ Icc t₁ t₂, ‖b t-b s‖ ≤ L*(t-s)) :
    ‖movingHeatHistoryKernel b t₂ s-movingHeatHistoryKernel b t₁ s‖ ≤
      (L/Real.sqrt (2*Real.pi))*heatHistoryTimeMajorant (t₂-t₁) (t₁-s) := by
  have hu : 0 < t₁-s := sub_pos.mpr hst
  have hδ : 0 < t₂-t₁ := sub_pos.mpr htt
  have hsqrt : Real.sqrt (2*Real.pi*(t₁-s)) = Real.sqrt (2*Real.pi)*Real.sqrt (t₁-s) :=
    Real.sqrt_mul (by positivity) _
  rcases lt_or_gt_of_ne hne with hnear | hfar
  · rw [heatHistoryTimeMajorant_near hu hnear]
    have hsize₁ := heatBoundaryKernel_motion_bound hu (hmove t₁ ⟨le_rfl,htt.le⟩)
    have hsize₂ := heatBoundaryKernel_motion_bound (sub_pos.mpr (hst.trans htt))
      (hmove t₂ ⟨htt.le,le_rfl⟩)
    have hsize₂' : ‖movingHeatHistoryKernel b t₂ s‖ ≤ 3*L/Real.sqrt (2*Real.pi*(t₁-s)) := by
      apply hsize₂.trans
      apply div_le_div_of_nonneg_left (by positivity) (by positivity)
      exact Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left (by linarith) (by positivity))
    calc
      _ ≤ ‖movingHeatHistoryKernel b t₂ s‖+‖movingHeatHistoryKernel b t₁ s‖ := norm_sub_le _ _
      _ ≤ 3*L/Real.sqrt (2*Real.pi*(t₁-s))+3*L/Real.sqrt (2*Real.pi*(t₁-s)) :=
        add_le_add hsize₂' hsize₁
      _ = _ := by rw [hsqrt]; ring
  · rw [heatHistoryTimeMajorant_far hfar]
    apply (movingHeatHistoryKernel_time_sub_bound hst htt.le hL hb hv hmove).trans_eq
    rw [hsqrt]
    field_simp

/-- Integrating the common-past difference needs only a pointwise bound on
the density. The integral exists in the total Bochner sense; no derivative
or modulus of continuity of the density is assumed. -/
theorem movingHeatHistoryKernel_overlap_bound {b f : ℝ → ℝ} {t₁ t₂ D L C : ℝ}
    (htt : t₁ < t₂) (hL : 0 ≤ L) (hC : 0 ≤ C)
    (hb : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hv : ∀ t ∈ Icc t₁ t₂, ‖deriv b t‖ ≤ L)
    (hmove : ∀ u ∈ Ioo 0 D, ∀ t ∈ Icc t₁ t₂, ‖b t-b (t₁-u)‖ ≤ L*(t-(t₁-u)))
    (hf : ∀ s, ‖f s‖ ≤ C) :
    ‖∫ u in Ioo 0 D,
      (movingHeatHistoryKernel b t₂ (t₁-u)-movingHeatHistoryKernel b t₁ (t₁-u))*f (t₁-u)‖ ≤
      (28*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
  have hδ : 0 < t₂-t₁ := sub_pos.mpr htt
  let M := fun u => (L*C/Real.sqrt (2*Real.pi))*heatHistoryTimeMajorant (t₂-t₁) u
  have hMi : Integrable M := (heatHistoryTimeMajorant_integrable hδ).const_mul _
  have hMn : ∀ u, 0 ≤ M u := fun u => mul_nonneg (by positivity) (heatHistoryTimeMajorant_nonneg hδ.le)
  calc
    _ ≤ ∫ u in Ioo 0 D, M u := by
      apply norm_integral_le_of_norm_le hMi.integrableOn
      filter_upwards [ae_restrict_mem measurableSet_Ioo,
        (volume.restrict (Ioo 0 D)).ae_ne (t₂-t₁)] with u hu hne
      have hk := movingHeatHistoryKernel_time_majorant (by linarith [hu.1] : t₁-u < t₁)
        htt hL (by simpa only [sub_sub_cancel] using hne) hb hv (hmove u hu)
      rw [sub_sub_cancel] at hk
      rw [norm_mul]
      calc
        _ ≤ ((L/Real.sqrt (2*Real.pi))*heatHistoryTimeMajorant (t₂-t₁) u)*C :=
          mul_le_mul hk (hf _) (norm_nonneg _) (mul_nonneg (by positivity) (heatHistoryTimeMajorant_nonneg hδ.le))
        _ = M u := by dsimp [M]; ring
    _ ≤ ∫ u, M u := setIntegral_le_integral hMi (Eventually.of_forall hMn)
    _ = _ := by
      dsimp [M]
      rw [integral_const_mul,heatHistoryTimeMajorant_integral hδ]
      ring

end AmericanConvexity.Stopping
