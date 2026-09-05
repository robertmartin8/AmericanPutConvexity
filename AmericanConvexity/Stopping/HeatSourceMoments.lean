import AmericanConvexity.Stopping.HeatLayerPotential

/-! # Gaussian rescaling for bounded continuous space-time sources

The fixed Gaussian moments yield joint continuity without differentiating
the source. The first moment gives the integrable inverse-square-root bound
needed for the spatial derivative of the Duhamel potential.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

noncomputable def heatSourceMoment (M : ℝ → ℝ) (Q : ℝ × ℝ → ℝ)
    (u : ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ y, M y*Q (z.1+Real.sqrt u*y,z.2-u)

theorem heatSourceMoment_integrable {M : ℝ → ℝ} {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hM : Integrable M) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C)
    (u : ℝ) (z : ℝ × ℝ) :
    Integrable (fun y => M y*Q (z.1+Real.sqrt u*y,z.2-u)) := by
  apply (hM.norm.mul_const C).mono'
    (hM.aestronglyMeasurable.mul ((hQ.comp (by fun_prop)).aestronglyMeasurable))
  exact Eventually.of_forall (fun y => by
    dsimp only [Pi.mul_apply,Function.comp_apply]
    rw [norm_mul]
    exact mul_le_mul_of_nonneg_left (hC _) (norm_nonneg _))

theorem heatSourceMoment_bound {M : ℝ → ℝ} {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hM : Integrable M) (hC : ∀ z, ‖Q z‖ ≤ C) (u : ℝ) (z : ℝ × ℝ) :
    ‖heatSourceMoment M Q u z‖ ≤ (∫ y, ‖M y‖)*C := by
  unfold heatSourceMoment
  calc
    _ ≤ ∫ y, ‖M y‖*C := norm_integral_le_of_norm_le (hM.norm.mul_const C)
      (Eventually.of_forall fun y => by
        rw [norm_mul]
        exact mul_le_mul_of_nonneg_left (hC _) (norm_nonneg _))
    _ = _ := integral_mul_const C _

theorem heatSourceMoment_continuous {M : ℝ → ℝ} {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hM : Integrable M) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) :
    Continuous (fun p : ℝ × (ℝ × ℝ) => heatSourceMoment M Q p.1 p.2) := by
  apply continuous_of_dominated (bound := fun y => ‖M y‖*C)
  · intro p
    exact (heatSourceMoment_integrable hM hQ hC p.1 p.2).aestronglyMeasurable
  · intro p
    exact Eventually.of_forall (fun y => by
      rw [norm_mul]
      exact mul_le_mul_of_nonneg_left (hC _) (norm_nonneg _))
  · exact hM.norm.mul_const C
  · apply Eventually.of_forall
    intro y
    exact continuous_const.mul (hQ.comp (by fun_prop))

theorem heatKernel_sqrt_scale {u : ℝ} (hu : 0 < u) (y : ℝ) :
    Real.sqrt u*heatKernel u (Real.sqrt u*y) = heatKernel 1 y := by
  have hs : Real.sqrt u ≠ 0 := (Real.sqrt_pos.mpr hu).ne'
  have he : -(Real.sqrt u*y)^2/(2*u) = -(y^2)/2 := by
    rw [mul_pow,Real.sq_sqrt hu.le]
    field_simp
  unfold heatKernel
  rw [he,Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
  simp only [mul_one,mul_inv_rev]
  field_simp

theorem heatBoundaryKernel_sqrt_scale {u : ℝ} (hu : 0 < u) (y : ℝ) :
    Real.sqrt u*heatBoundaryKernel u (Real.sqrt u*y) =
      (Real.sqrt u)⁻¹*heatBoundaryKernel 1 y := by
  have he := heatKernel_sqrt_scale hu y
  unfold heatBoundaryKernel
  rw [div_one,← he]
  have hs : Real.sqrt u ≠ 0 := (Real.sqrt_pos.mpr hu).ne'
  field_simp
  rw [Real.sq_sqrt hu.le]
  ring

theorem heatKernel_integral_rescale {u : ℝ} (hu : 0 < u) (f : ℝ → ℝ) (x : ℝ) :
    (∫ y, heatKernel u (y-x)*f y) =
      ∫ y, heatKernel 1 y*f (x+Real.sqrt u*y) := by
  have hs : 0 < Real.sqrt u := Real.sqrt_pos.mpr hu
  have hc := Measure.integral_comp_mul_left (fun y => heatKernel u y*f (x+y)) (Real.sqrt u)
  rw [abs_of_pos (inv_pos.mpr hs),smul_eq_mul] at hc
  have ht := integral_add_left_eq_self (μ := volume) (fun y => heatKernel u (y-x)*f y) x
  simp only [add_sub_cancel_left] at ht
  rw [← ht]
  have he : (fun y => heatKernel 1 y*f (x+Real.sqrt u*y)) =
      (fun y => Real.sqrt u*(heatKernel u (Real.sqrt u*y)*f (x+Real.sqrt u*y))) := by
    funext y
    rw [← heatKernel_sqrt_scale hu y,mul_assoc]
  rw [he]
  rw [integral_const_mul,hc,← mul_assoc,mul_inv_cancel₀ hs.ne',one_mul]

theorem heatBoundaryKernel_integral_rescale {u : ℝ} (hu : 0 < u) (f : ℝ → ℝ) (x : ℝ) :
    (∫ y, heatBoundaryKernel u (y-x)*f y) =
      (Real.sqrt u)⁻¹*∫ y, heatBoundaryKernel 1 y*f (x+Real.sqrt u*y) := by
  have hs : 0 < Real.sqrt u := Real.sqrt_pos.mpr hu
  have hc := Measure.integral_comp_mul_left (fun y => heatBoundaryKernel u y*f (x+y)) (Real.sqrt u)
  rw [abs_of_pos (inv_pos.mpr hs),smul_eq_mul] at hc
  have ht := integral_add_left_eq_self (μ := volume) (fun y => heatBoundaryKernel u (y-x)*f y) x
  simp only [add_sub_cancel_left] at ht
  rw [← ht,← integral_const_mul]
  have he : (fun y => (Real.sqrt u)⁻¹*(heatBoundaryKernel 1 y*f (x+Real.sqrt u*y))) =
      (fun y => Real.sqrt u*(heatBoundaryKernel u (Real.sqrt u*y)*f (x+Real.sqrt u*y))) := by
    funext y
    rw [← mul_assoc,← heatBoundaryKernel_sqrt_scale hu y,mul_assoc]
  rw [he]
  rw [integral_const_mul,hc,← mul_assoc,mul_inv_cancel₀ hs.ne',one_mul]

theorem heatBoundaryKernel_integrable_space {u : ℝ} (hu : 0 < u) :
    Integrable (heatBoundaryKernel u) := by
  convert! (integrable_id_mul_heatKernel hu).const_mul (1/u) using 1
  funext y
  unfold heatBoundaryKernel
  ring

noncomputable def heatSourceGradientConstant : ℝ := ∫ y, ‖heatBoundaryKernel 1 y‖

theorem heatSourceGradientConstant_nonneg : 0 ≤ heatSourceGradientConstant :=
  integral_nonneg (fun _ => norm_nonneg _)

noncomputable def heatSourceAverage (Q : ℝ × ℝ → ℝ) (u : ℝ) (z : ℝ × ℝ) : ℝ :=
  heatSourceMoment (heatKernel 1) Q u z

noncomputable def heatSourceSpatial (Q : ℝ × ℝ → ℝ) (u : ℝ) (z : ℝ × ℝ) : ℝ :=
  (Real.sqrt u)⁻¹*heatSourceMoment (heatBoundaryKernel 1) Q u z

theorem heatSourceAverage_continuous {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) :
    Continuous (fun p : ℝ × (ℝ × ℝ) => heatSourceAverage Q p.1 p.2) :=
  heatSourceMoment_continuous (integrable_heatKernel (by norm_num)) hQ hC

theorem heatSourceSpatial_continuousAt {Q : ℝ × ℝ → ℝ} {C u : ℝ} {z : ℝ × ℝ}
    (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) (hu : 0 < u) :
    ContinuousAt (fun p : ℝ × (ℝ × ℝ) => heatSourceSpatial Q p.1 p.2) (u,z) := by
  have hc : ContinuousAt (fun p : ℝ × (ℝ × ℝ) => Real.sqrt p.1) (u,z) := by fun_prop
  exact (hc.inv₀
    (Real.sqrt_pos.mpr hu).ne').mul
      (heatSourceMoment_continuous (heatBoundaryKernel_integrable_space (by norm_num)) hQ hC).continuousAt

theorem heatSourceSpatial_bound {Q : ℝ × ℝ → ℝ} {C : ℝ}
    (hC : ∀ z, ‖Q z‖ ≤ C) (u : ℝ) (z : ℝ × ℝ) :
    ‖heatSourceSpatial Q u z‖ ≤ (heatSourceGradientConstant*C)*(Real.sqrt u)⁻¹ := by
  rw [heatSourceSpatial,norm_mul,Real.norm_of_nonneg (by positivity : 0 ≤ (Real.sqrt u)⁻¹)]
  calc
    _ ≤ (Real.sqrt u)⁻¹*((∫ y, ‖heatBoundaryKernel 1 y‖)*C) :=
      mul_le_mul_of_nonneg_left (heatSourceMoment_bound
        (heatBoundaryKernel_integrable_space (by norm_num)) hC u z) (by positivity)
    _ = _ := by unfold heatSourceGradientConstant; ring

end AmericanConvexity.Stopping
