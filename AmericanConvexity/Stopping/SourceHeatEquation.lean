import AmericanConvexity.Stopping.SmoothHeatSource
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

/-! # The inhomogeneous heat equation for smooth compact sources

The zero elapsed-time endpoint contributes the source itself. The opposite
endpoint disappears on the first causal window. Coordinates are (space,time).
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology ContDiff

theorem heatPartial_pair (Q : ℝ × ℝ → ℝ) (z : ℝ × ℝ) (a b : ℝ) :
    heatPartial Q (a,b) z = a*heatPartial Q (1,0) z+b*heatPartial Q (0,1) z := by
  have he : (a,b) = a • ((1,0) : ℝ × ℝ)+b • ((0,1) : ℝ × ℝ) := by ext <;> simp
  rw [heatPartial,he,map_add,map_smul,map_smul]
  rfl

theorem heatSource_scaled_hasDeriv {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hu : 0 < u) (x t y : ℝ) :
    HasDerivAt (fun v => Q (x+Real.sqrt v*y,t-v))
      ((2*Real.sqrt u)⁻¹*y*heatPartial Q (1,0) (x+Real.sqrt u*y,t-u)
        -heatPartial Q (0,1) (x+Real.sqrt u*y,t-u)) u := by
  have hi := (((Real.hasDerivAt_sqrt hu.ne').mul_const y).const_add x).prodMk
    ((hasDerivAt_const u t).sub (hasDerivAt_id u))
  have hd := (hQ.differentiable (by simp)).differentiableAt.hasFDerivAt.comp_hasDerivAt u hi
  convert! hd using 1
  change _ = heatPartial Q (1/(2*Real.sqrt u)*y,0-1) (x+Real.sqrt u*y,t-u)
  conv_rhs => rw [heatPartial_pair]
  simp only [one_div]
  ring

theorem heatKernel_integral_one : (∫ y, heatKernel 1 y) = 1 := by
  have he : heatKernel 1 = ProbabilityTheory.gaussianPDFReal 0 1 := by
    funext y
    rw [heatKernel,ProbabilityTheory.gaussianPDFReal_def]
    norm_num
  rw [he]
  exact ProbabilityTheory.integral_gaussianPDFReal_eq_one 0 one_ne_zero

theorem heatSourceAverage_zero (Q : ℝ × ℝ → ℝ) (z : ℝ × ℝ) :
    heatSourceAverage Q 0 z = Q z := by
  simp only [heatSourceAverage,heatSourceMoment,Real.sqrt_zero,zero_mul,add_zero,sub_zero]
  rw [integral_mul_const,heatKernel_integral_one,one_mul]

theorem smooth_heatSourceAverage_hasDeriv_elapsed_raw {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hu : 0 < u) (z : ℝ × ℝ) :
    HasDerivAt (fun v => heatSourceAverage Q v z)
      (∫ y, heatKernel 1 y*((2*Real.sqrt u)⁻¹*y*
        heatPartial Q (1,0) (z.1+Real.sqrt u*y,z.2-u)
        -heatPartial Q (0,1) (z.1+Real.sqrt u*y,z.2-u))) u := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hx := heatPartial_contDiff hQ (1,0)
  have ht := heatPartial_contDiff hQ (0,1)
  obtain ⟨Cx,hCx⟩ := (heatPartial_hasCompactSupport hc (1,0)).exists_bound_of_continuous hx.continuous
  obtain ⟨Ct,hCt⟩ := (heatPartial_hasCompactSupport hc (0,1)).exists_bound_of_continuous ht.continuous
  let A := (2*Real.sqrt (u/2))⁻¹
  have hA : 0 ≤ A := by dsimp [A]; positivity
  have hG := integrable_heatKernel (by norm_num : (0 : ℝ) < 1)
  have hY := integrable_id_mul_heatKernel (by norm_num : (0 : ℝ) < 1)
  have hbound : Integrable (fun y => ‖heatKernel 1 y‖*(A*‖y‖*Cx+Ct)) := by
    convert! ((hY.norm.const_mul (A*Cx)).add (hG.norm.mul_const Ct)) using 1
    funext y
    simp only [Pi.add_apply,norm_mul]
    ring
  have hint (v : ℝ) : Integrable (fun y => heatKernel 1 y*((2*Real.sqrt v)⁻¹*y*
      heatPartial Q (1,0) (z.1+Real.sqrt v*y,z.2-v)
      -heatPartial Q (0,1) (z.1+Real.sqrt v*y,z.2-v))) := by
    have h1 := (heatSourceMoment_integrable hY hx.continuous hCx v z).const_mul ((2*Real.sqrt v)⁻¹)
    have h2 := heatSourceMoment_integrable hG ht.continuous hCt v z
    convert! h1.sub h2 using 1
    funext y
    dsimp only [Pi.sub_apply]
    ring
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun v y => heatKernel 1 y*Q (z.1+Real.sqrt v*y,z.2-v))
    (F' := fun v y => heatKernel 1 y*((2*Real.sqrt v)⁻¹*y*
      heatPartial Q (1,0) (z.1+Real.sqrt v*y,z.2-v)
      -heatPartial Q (0,1) (z.1+Real.sqrt v*y,z.2-v)))
    (bound := fun y => ‖heatKernel 1 y‖*(A*‖y‖*Cx+Ct))
    (s := Ioi (u/2)) (Ioi_mem_nhds (by linarith))
    (Eventually.of_forall (fun v => (heatSourceMoment_integrable hG hQ.continuous hC v z).aestronglyMeasurable))
    (heatSourceMoment_integrable hG hQ.continuous hC u z)
    (hint u).aestronglyMeasurable ?_ hbound ?_).2
  · apply Eventually.of_forall
    intro y v hv
    have hv0 : 0 < v := by change u/2 < v at hv; linarith
    have hi : (2*Real.sqrt v)⁻¹ ≤ A := by
      apply (inv_le_inv₀ (by positivity : 0 < 2*Real.sqrt v)
        (by positivity : 0 < 2*Real.sqrt (u/2))).mpr
      exact mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hv.le) (by norm_num)
    rw [norm_mul]
    apply mul_le_mul_of_nonneg_left _ (norm_nonneg _)
    calc
      _ ≤ ‖(2*Real.sqrt v)⁻¹*y*heatPartial Q (1,0) (z.1+Real.sqrt v*y,z.2-v)‖+
          ‖heatPartial Q (0,1) (z.1+Real.sqrt v*y,z.2-v)‖ := norm_sub_le _ _
      _ ≤ A*‖y‖*Cx+Ct := by
        rw [norm_mul,norm_mul,Real.norm_of_nonneg (by positivity : 0 ≤ (2*Real.sqrt v)⁻¹)]
        exact add_le_add (mul_le_mul
          (mul_le_mul_of_nonneg_right hi (norm_nonneg _)) (hCx _)
          (norm_nonneg _) (mul_nonneg hA (norm_nonneg _))) (hCt _)
  · exact Eventually.of_forall (fun y v hv =>
      (heatSource_scaled_hasDeriv hQ (by change u/2 < v at hv; linarith) z.1 z.2 y).const_mul _)

theorem smooth_heatSourceAverage_hasDeriv_elapsed {Q : ℝ × ℝ → ℝ} {u : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hu : 0 < u) (z : ℝ × ℝ) :
    HasDerivAt (fun v => heatSourceAverage Q v z)
      ((1/2)*heatSourceAverage (heatPartial (heatPartial Q (1,0)) (1,0)) u z
        -heatSourceAverage (heatPartial Q (0,1)) u z) u := by
  have hx := heatPartial_contDiff hQ (1,0)
  have ht := heatPartial_contDiff hQ (0,1)
  obtain ⟨Cx,hCx⟩ := (heatPartial_hasCompactSupport hc (1,0)).exists_bound_of_continuous hx.continuous
  obtain ⟨Ct,hCt⟩ := (heatPartial_hasCompactSupport hc (0,1)).exists_bound_of_continuous ht.continuous
  have h1 := heatSourceMoment_integrable (heatBoundaryKernel_integrable_space (by norm_num : (0 : ℝ) < 1)) hx.continuous hCx u z
  have h2 := heatSourceMoment_integrable (integrable_heatKernel (by norm_num : (0 : ℝ) < 1)) ht.continuous hCt u z
  have he (y : ℝ) : heatKernel 1 y*((2*Real.sqrt u)⁻¹*y*
      heatPartial Q (1,0) (z.1+Real.sqrt u*y,z.2-u)
      -heatPartial Q (0,1) (z.1+Real.sqrt u*y,z.2-u)) =
      ((1/2)*(Real.sqrt u)⁻¹)*(heatBoundaryKernel 1 y*
        heatPartial Q (1,0) (z.1+Real.sqrt u*y,z.2-u))
      -heatKernel 1 y*heatPartial Q (0,1) (z.1+Real.sqrt u*y,z.2-u) := by
    unfold heatBoundaryKernel
    simp only [div_one,mul_inv_rev]
    ring
  have hd := smooth_heatSourceAverage_hasDeriv_elapsed_raw hQ hc hu z
  simp_rw [he] at hd
  rw [integral_sub (h1.const_mul _) h2,integral_const_mul] at hd
  have heq := smooth_heatSourceSpatial_eq_average_partial hx
    (heatPartial_hasCompactSupport hc (1,0)) hu z
  change (Real.sqrt u)⁻¹*heatSourceMoment (heatBoundaryKernel 1) (heatPartial Q (1,0)) u z = _ at heq
  convert! hd using 1
  change (1/2)*_ - _ = ((1/2)*(Real.sqrt u)⁻¹)*heatSourceMoment (heatBoundaryKernel 1) (heatPartial Q (1,0)) u z-_
  rw [mul_assoc,heq]
  rfl

theorem smooth_heatSourcePotential_equation_with_endpoint {Q : ℝ × ℝ → ℝ} {D : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hD : 0 < D) (x t : ℝ) :
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x
        +Q (x,t)-heatSourceAverage Q D (x,t) := by
  obtain ⟨C,hC⟩ := hc.exists_bound_of_continuous hQ.continuous
  have hxx := heatPartial_contDiff (heatPartial_contDiff hQ (1,0)) (1,0)
  have ht := heatPartial_contDiff hQ (0,1)
  obtain ⟨Cxx,hCxx⟩ := (heatPartial_hasCompactSupport (heatPartial_hasCompactSupport hc (1,0)) (1,0)).exists_bound_of_continuous hxx.continuous
  obtain ⟨Ct,hCt⟩ := (heatPartial_hasCompactSupport hc (0,1)).exists_bound_of_continuous ht.continuous
  have hA : Continuous (fun u => heatSourceAverage Q u (x,t)) :=
    (heatSourceAverage_continuous hQ.continuous hC).comp (continuous_id.prodMk continuous_const)
  have hAx : Continuous (fun u => heatSourceAverage (heatPartial (heatPartial Q (1,0)) (1,0)) u (x,t)) :=
    (heatSourceAverage_continuous hxx.continuous hCxx).comp (continuous_id.prodMk continuous_const)
  have hAt : Continuous (fun u => heatSourceAverage (heatPartial Q (0,1)) u (x,t)) :=
    (heatSourceAverage_continuous ht.continuous hCt).comp (continuous_id.prodMk continuous_const)
  have hB : Continuous (fun u => (1/2)*
      heatSourceAverage (heatPartial (heatPartial Q (1,0)) (1,0)) u (x,t)
      -heatSourceAverage (heatPartial Q (0,1)) u (x,t)) :=
    (continuous_const.mul hAx).sub hAt
  have he := intervalIntegral.integral_eq_sub_of_hasDerivAt_of_le hD.le hA.continuousOn
    (fun u hu => smooth_heatSourceAverage_hasDeriv_elapsed hQ hc hu.1 (x,t))
    (hB.intervalIntegrable 0 D)
  rw [intervalIntegral.integral_of_le hD.le,integral_Ioc_eq_integral_Ioo,
    integral_sub ((heatSourceAverage_integrable_time hxx.continuous hCxx (x,t)).const_mul _)
      (heatSourceAverage_integrable_time ht.continuous hCt (x,t)),integral_const_mul,
    heatSourceAverage_zero] at he
  rw [(smooth_heatSourcePotential_hasDeriv_time hQ hc D x t).deriv,
    smooth_heatSourcePotential_deriv2_space hQ hc D x t]
  change (1/2)*heatSourcePotential (heatPartial (heatPartial Q (1,0)) (1,0)) D (x,t)
    -heatSourcePotential (heatPartial Q (0,1)) D (x,t) = _ at he
  linarith

theorem smooth_heatSourcePotential_equation {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : ContDiff ℝ ∞ Q) (hc : HasCompactSupport Q) (hD : 0 < D)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (x t : ℝ) (ht : t ≤ a+D) :
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x+Q (x,t) := by
  rw [smooth_heatSourcePotential_equation_with_endpoint hQ hc hD,
    heatSourceAverage_zero_of_past hcausal (x,t) (by dsimp; linarith),sub_zero]

end AmericanConvexity.Stopping
