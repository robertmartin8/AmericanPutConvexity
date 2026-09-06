import AmericanPutConvexity.Stopping.HeatHistoryRemainderTime
import AmericanPutConvexity.Stopping.HeatRemainderInterpolation

/-! # An integrable singularity for the frozen-history time derivative

Three-quarter moduli improve the inverse-time bound to elapsed time to the
power -3/4. This is locally integrable at the source/observation diagonal.
The reference slope and density value stay fixed in the derivative.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory

theorem threeQuarter_eq_quarter_mul_sqrt {u : ℝ} (hu : 0 < u) :
    u^(3/4 : ℝ) = u^(1/4 : ℝ)*Real.sqrt u := by
  rw [Real.sqrt_eq_rpow,← Real.rpow_add hu]
  norm_num

theorem quarter_div_eq_inverse_threeQuarter {u : ℝ} (hu : 0 < u) :
    u^(1/4 : ℝ)/u = u^(-3/4 : ℝ) := by
  rw [← Real.rpow_sub_one hu.ne']
  norm_num

theorem frozenHeatHistoryRemainder_deriv_threeQuarter_bound
    {b f : ℝ → ℝ} {t s w v c A L C D : ℝ}
    (hst : s < t) (hu1 : t-s ≤ 1) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hb : HasDerivAt b w t) (hx : ‖b t-b s‖ ≤ L*(t-s)) (hv : ‖v‖ ≤ L)
    (hrem : ‖b t-b s-v*(t-s)‖ ≤ A*(t-s)*(t-s)^(3/4 : ℝ))
    (hw : ‖w-v‖ ≤ A*(t-s)^(3/4 : ℝ)) (hfs : ‖f s‖ ≤ C)
    (hmod : ‖f s-c‖ ≤ D*(t-s)^(3/4 : ℝ)) :
    ‖deriv (fun r => frozenHeatHistoryRemainder b f v c r s) t‖ ≤
      (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*(t-s)^(-3/4 : ℝ) := by
  have hu := sub_pos.mpr hst
  have heq := threeQuarter_eq_quarter_mul_sqrt hu
  have hr : ‖b t-b s-v*(t-s)‖ ≤
      (A*(t-s)^(1/4 : ℝ))*(t-s)*Real.sqrt (t-s) := by
    convert! hrem using 1
    rw [heq]
    ring
  have hw' : ‖w-v‖ ≤ (A*(t-s)^(1/4 : ℝ))*Real.sqrt (t-s) := by
    simpa only [heq,mul_assoc] using hw
  have hf' : ‖f s-c‖ ≤ (D*(t-s)^(1/4 : ℝ))*Real.sqrt (t-s) := by
    simpa only [heq,mul_assoc] using hmod
  have he := frozenHeatHistoryRemainder_deriv_bound hst hu1
    (by positivity : 0 ≤ A*(t-s)^(1/4 : ℝ)) hL hb hx hv hr hw' hfs hf'
  calc
    _ ≤ _ := he
    _ = (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*((t-s)^(1/4 : ℝ)/(t-s)) := by
      rw [div_mul_eq_div_div]
      ring
    _ = _ := by rw [quarter_div_eq_inverse_threeQuarter hu]

theorem integrable_and_integral_of_inverse_threeQuarter_bound
    {F : ℝ → ℝ} {M T : ℝ} (hT : 0 < T)
    (hF : AEStronglyMeasurable F (volume.restrict (Ioo 0 T)))
    (hb : ∀ u ∈ Ioo 0 T, ‖F u‖ ≤ M*u^(-3/4 : ℝ)) :
    IntegrableOn F (Ioo 0 T) ∧ ‖∫ u in Ioo 0 T, F u‖ ≤ 4*M*T^(1/4 : ℝ) := by
  have hi : IntegrableOn (fun u : ℝ => u^(-3/4 : ℝ)) (Ioo 0 T) :=
    (intervalIntegral.integrableOn_Ioo_rpow_iff hT).mpr (by norm_num)
  have hb' : ∀ᵐ u ∂volume.restrict (Ioo 0 T), ‖F u‖ ≤ M*u^(-3/4 : ℝ) := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    exact hb u hu
  refine ⟨(hi.const_mul M).mono' hF hb',?_⟩
  calc
    _ ≤ ∫ u in Ioo 0 T, M*u^(-3/4 : ℝ) := norm_integral_le_of_norm_le (hi.const_mul M) hb'
    _ = _ := by rw [integral_const_mul,integral_inverse_threeQuarter hT]; ring

end AmericanPutConvexity.Stopping
