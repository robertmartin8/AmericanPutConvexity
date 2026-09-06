import AmericanPutConvexity.Stopping.HeatHistoryRemainderTime
import AmericanPutConvexity.Stopping.HeatRemainderInterpolation

/-! # Three-quarter time bound for the common-past frozen remainder

Both observations use the same frozen slope and density value. The source
time is t1-u. A bounded difference near u=0 and an inverse-u increment bound
away from zero give a genuine integrable three-quarter-power estimate.
-/

namespace AmericanPutConvexity.Stopping

open Set MeasureTheory

theorem frozenHeatHistoryRemainder_overlap_threeQuarter
    {b f : ℝ → ℝ} {t₁ t₂ T v c A L C D : ℝ}
    (htt : t₁ < t₂) (hT : 0 < T) (hspan : t₂-t₁+T ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hb : ∀ r ∈ Icc t₁ t₂, DifferentiableAt ℝ b r) (hv : ‖v‖ ≤ L)
    (hx : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t₁ t₂, ‖b r-b (t₁-u)‖ ≤ L*(r-(t₁-u)))
    (hrem : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t₁ t₂,
      ‖b r-b (t₁-u)-v*(r-(t₁-u))‖ ≤ A*(r-(t₁-u))*Real.sqrt (r-(t₁-u)))
    (hw : ∀ u ∈ Ioo 0 T, ∀ r ∈ Icc t₁ t₂,
      ‖deriv b r-v‖ ≤ A*Real.sqrt (r-(t₁-u)))
    (hfs : ∀ u ∈ Ioo 0 T, ‖f (t₁-u)‖ ≤ C)
    (hmod : ∀ u ∈ Ioo 0 T, ‖f (t₁-u)-c‖ ≤ D*Real.sqrt u)
    (hF : AEStronglyMeasurable
      (fun u => frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
        frozenHeatHistoryRemainder b f v c t₁ (t₁-u)) (volume.restrict (Ioo 0 T))) :
    IntegrableOn (fun u => frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
      frozenHeatHistoryRemainder b f v c t₁ (t₁-u)) (Ioo 0 T) ∧
    ‖∫ u in Ioo 0 T, frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
      frozenHeatHistoryRemainder b f v c t₁ (t₁-u)‖ ≤
      (4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
        (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*T^(1/4 : ℝ))*(t₂-t₁)^(3/4 : ℝ) := by
  have hδ : 0 < t₂-t₁ := sub_pos.mpr htt
  have hR (u : ℝ) (hu : u ∈ Ioo 0 T) (r : ℝ) (hr : r ∈ Icc t₁ t₂) :
      ‖frozenHeatHistoryRemainder b f v c r (t₁-u)‖ ≤ 3*(A*C+L*D)/Real.sqrt (2*Real.pi) := by
    apply heatHistory_integrand_linear_remainder_bound
      (by linarith [hu.1,hr.1] : 0 < r-(t₁-u)) hA hL (hrem u hu r hr) hv (hfs u hu)
    exact (hmod u hu).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith [hr.1])) hD)
  have hNear (u : ℝ) (hu : u ∈ Ioo 0 T) :
      ‖frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
        frozenHeatHistoryRemainder b f v c t₁ (t₁-u)‖ ≤ 6*(A*C+L*D)/Real.sqrt (2*Real.pi) := by
    calc
      _ ≤ ‖frozenHeatHistoryRemainder b f v c t₂ (t₁-u)‖+
          ‖frozenHeatHistoryRemainder b f v c t₁ (t₁-u)‖ := norm_sub_le _ _
      _ ≤ 3*(A*C+L*D)/Real.sqrt (2*Real.pi)+3*(A*C+L*D)/Real.sqrt (2*Real.pi) :=
        add_le_add (hR u hu t₂ (right_mem_Icc.mpr htt.le)) (hR u hu t₁ (left_mem_Icc.mpr htt.le))
      _ = _ := by ring
  have hFar (u : ℝ) (hu : u ∈ Ioo 0 T) :
      ‖frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
        frozenHeatHistoryRemainder b f v c t₁ (t₁-u)‖ ≤
        (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*((t₂-t₁)/u) := by
    have he := frozenHeatHistoryRemainder_time_sub_bound
      (by linarith [hu.1] : t₁-u < t₁) htt.le (by linarith [hu.2] : t₂-(t₁-u) ≤ 1)
      hA hL hD hb (hx u hu) hv (hrem u hu) (hw u hu) (hfs u hu)
      (by simpa only [sub_sub_cancel] using hmod u hu)
    simpa only [sub_sub_cancel,div_mul_eq_mul_div,mul_div_assoc,div_div,mul_comm] using he
  exact integrable_and_integral_threeQuarter_of_near_far (by positivity) hδ hT hF
    (fun u hu _ => hNear u hu) (fun u hu _ => hFar u hu)

end AmericanPutConvexity.Stopping
