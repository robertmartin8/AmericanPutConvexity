import AmericanConvexity.Stopping.IndependentKernel
import AmericanConvexity.Stopping.BrownianHeatFlow

/-! # Conditional Brownian transitions in the raw natural filtration -/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory ProbabilityTheory
open scoped NNReal Topology

theorem brownian_scaled_increment_heatFlow {f : ℝ → ℝ} (hf : Continuous f)
    {i j : ℝ≥0} (hij : i ≤ j) (σ x : ℝ) :
    (∫ ω, f (x+σ*(brownian j ω-brownian i ω)) ∂gaussianLimit) =
      brownianHeatFlow f (σ^2*((j : ℝ)-(i : ℝ))).toNNReal x := by
  have hΔ : 0 ≤ (j : ℝ)-(i : ℝ) := sub_nonneg.mpr (by exact_mod_cast hij)
  have hv : (NNReal.mk (σ^2) (sq_nonneg σ))*nndist j i =
      (σ^2*((j : ℝ)-(i : ℝ))).toNNReal := by
    apply NNReal.eq
    simp only [NNReal.coe_mul,coe_nndist,NNReal.dist_eq,
      abs_of_nonneg hΔ,Real.coe_toNNReal _ (mul_nonneg (sq_nonneg σ) hΔ)]
    rfl
  have hl := gaussianReal_const_mul (hasLaw_brownian_sub (s := j) (t := i)) σ
  simp only [mul_zero,hv] at hl
  have hm : Continuous (fun y => f (x+y)) := hf.comp (continuous_const.add continuous_id)
  have he := hl.integral_comp hm.aestronglyMeasurable
  have he' := (hasLaw_brownian_eval (t := (σ^2*((j : ℝ)-(i : ℝ))).toNNReal)).integral_comp
    hm.aestronglyMeasurable
  exact he.trans he'.symm

theorem brownian_condExp_transition {f : ℝ → ℝ} (hf : Continuous f) {C : ℝ}
    (hb : ∀ x, ‖f x‖ ≤ C) {i j : ℝ≥0} (hij : i ≤ j)
    {X : (ℝ≥0 → ℝ) → ℝ} (hX : Measurable[brownianFiltration i] X) (σ : ℝ) :
    gaussianLimit[fun ω => f (X ω+σ*(brownian j ω-brownian i ω)) | brownianFiltration i] =ᵐ[gaussianLimit]
      fun ω => brownianHeatFlow f (σ^2*((j : ℝ)-(i : ℝ))).toNNReal (X ω) := by
  have hY : Measurable (fun ω => brownian j ω-brownian i ω) :=
    (measurable_brownian j).sub (measurable_brownian i)
  have hH : Continuous (fun z : ℝ × ℝ => f (z.1+σ*z.2)) := by fun_prop
  have he := condExp_independent_kernel (brownianFiltration.le i) hX hY
    (brownian_filtered.indep i j hij) hH.measurable (fun z => hb (z.1+σ*z.2))
  filter_upwards [he] with ω hω
  rw [hω]
  have hmap := integral_map (μ := gaussianLimit) hY.aemeasurable
    (hf.comp (show Continuous (fun y : ℝ => X ω+σ*y) by fun_prop)).aestronglyMeasurable
  exact hmap.trans (brownian_scaled_increment_heatFlow hf hij σ (X ω))

end AmericanConvexity.Stopping
