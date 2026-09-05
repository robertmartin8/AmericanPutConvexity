import AmericanConvexity.Stopping.HeatHistoryOperator

/-! # A three-quarter time modulus from bounded and inverse-time estimates

The elementary bound min(1,delta/u) <= (delta/u)^(3/4) avoids a logarithmic
majorant. Its integral is finite at zero. Measurability and the majorant
prove genuine integrability before the integral estimate is asserted.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory

theorem integral_inverse_threeQuarter {T : ℝ} (hT : 0 < T) :
    (∫ u in Ioo 0 T, u^(-3/4 : ℝ)) = 4*T^(1/4 : ℝ) := by
  rw [← integral_Ioc_eq_integral_Ioo,← intervalIntegral.integral_of_le hT.le,
    integral_rpow (Or.inl (by norm_num : (-1 : ℝ) < -3/4))]
  norm_num only [show (-3/4 : ℝ)+1 = 1/4 by ring,
    Real.zero_rpow (by norm_num : (1/4 : ℝ) ≠ 0),sub_zero]
  ring

theorem near_far_threeQuarter_bound {F : ℝ → ℝ} {B C δ u : ℝ}
    (hB : 0 ≤ B) (hδ : 0 < δ) (hu : 0 < u)
    (hnear : u ≤ δ → ‖F u‖ ≤ B) (hfar : δ < u → ‖F u‖ ≤ C*(δ/u)) :
    ‖F u‖ ≤ (max B C*δ^(3/4 : ℝ))*u^(-3/4 : ℝ) := by
  have hM : 0 ≤ max B C := hB.trans (le_max_left _ _)
  have he : (δ/u)^(3/4 : ℝ) = δ^(3/4 : ℝ)*u^(-3/4 : ℝ) := by
    rw [Real.div_rpow hδ.le hu.le,show (-3/4 : ℝ) = -(3/4) by ring,Real.rpow_neg hu.le]
    rfl
  have hbnd : ‖F u‖ ≤ max B C*(δ/u)^(3/4 : ℝ) := by
    rcases le_or_gt u δ with hle | hlt
    · calc
        _ ≤ max B C := (hnear hle).trans (le_max_left _ _)
        _ = max B C*1 := (mul_one _).symm
        _ ≤ _ := mul_le_mul_of_nonneg_left
          (Real.one_le_rpow ((one_le_div hu).mpr hle) (by norm_num : (0 : ℝ) ≤ 3/4)) hM
    · have hp : δ/u ≤ (δ/u)^(3/4 : ℝ) := by
        simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_ge
          (div_pos hδ hu) ((div_le_one hu).mpr hlt.le) (by norm_num : (3/4 : ℝ) ≤ 1)
      exact (hfar hlt).trans ((mul_le_mul_of_nonneg_right (le_max_right B C)
        (div_nonneg hδ.le hu.le)).trans (mul_le_mul_of_nonneg_left hp hM))
  rw [he,← mul_assoc] at hbnd
  exact hbnd

theorem integrable_and_integral_threeQuarter_of_near_far
    {F : ℝ → ℝ} {B C δ T : ℝ} (hB : 0 ≤ B) (hδ : 0 < δ) (hT : 0 < T)
    (hF : AEStronglyMeasurable F (volume.restrict (Ioo 0 T)))
    (hnear : ∀ u ∈ Ioo 0 T, u ≤ δ → ‖F u‖ ≤ B)
    (hfar : ∀ u ∈ Ioo 0 T, δ < u → ‖F u‖ ≤ C*(δ/u)) :
    IntegrableOn F (Ioo 0 T) ∧
      ‖∫ u in Ioo 0 T, F u‖ ≤ (4*max B C*T^(1/4 : ℝ))*δ^(3/4 : ℝ) := by
  have hi : IntegrableOn (fun u : ℝ => u^(-3/4 : ℝ)) (Ioo 0 T) :=
    (intervalIntegral.integrableOn_Ioo_rpow_iff hT).mpr (by norm_num)
  have hmajor := hi.const_mul (max B C*δ^(3/4 : ℝ))
  have hbnd : ∀ᵐ u ∂volume.restrict (Ioo 0 T),
      ‖F u‖ ≤ (max B C*δ^(3/4 : ℝ))*u^(-3/4 : ℝ) := by
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with u hu
    exact near_far_threeQuarter_bound hB hδ hu.1 (hnear u hu) (hfar u hu)
  refine ⟨hmajor.mono' hF hbnd,?_⟩
  calc
    _ ≤ ∫ u in Ioo 0 T, (max B C*δ^(3/4 : ℝ))*u^(-3/4 : ℝ) :=
      norm_integral_le_of_norm_le hmajor hbnd
    _ = _ := by rw [integral_const_mul,integral_inverse_threeQuarter hT]; ring

end AmericanConvexity.Stopping
