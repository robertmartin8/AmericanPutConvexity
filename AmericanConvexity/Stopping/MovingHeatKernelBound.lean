import AmericanConvexity.Stopping.HeatBoundaryKernel
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.Calculus.MeanValue

/-! # Integrable perturbations of the heat boundary kernel

A displacement of size O(t) changes the boundary kernel by O(t^(-1/2)),
uniformly in the spatial evaluation point. This is the domination needed
for the single-layer normal-derivative jump on a Lipschitz moving graph.
The diffusivity here is 1/2, as in `heatBoundaryKernel`.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

theorem heatBoundaryKernel_deriv_bound {t : ℝ} (ht : 0 < t) (x : ℝ) :
    ‖deriv (heatBoundaryKernel t) x‖ ≤ 3/(t*Real.sqrt (2*Real.pi*t)) := by
  have he : Real.exp (-(x^2)/(2*t)) ≤ 1 := Real.exp_le_one_iff.mpr
    (div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (sq_nonneg x)) (by positivity))
  have hex : x^2*Real.exp (-(x^2)/(2*t)) ≤ 2*t := by
    have h := (Real.mul_exp_neg_le_exp_neg_one (x^2/(2*t))).trans
      (Real.exp_le_one_iff.mpr (by norm_num : (-1 : ℝ) ≤ 0))
    have hp := mul_le_mul_of_nonneg_left h (by positivity : 0 ≤ 2*t)
    have heq : 2*t*(x^2/(2*t)*Real.exp (-(x^2/(2*t)))) =
        x^2*Real.exp (-(x^2)/(2*t)) := by
      rw [neg_div]
      field_simp
    rw [heq] at hp
    linarith
  have hab : |t-x^2| ≤ t+x^2 := abs_le.mpr ⟨by nlinarith [sq_nonneg x],by nlinarith [sq_nonneg x]⟩
  have hp := mul_le_mul_of_nonneg_right hab (Real.exp_pos (-(x^2)/(2*t))).le
  have hte := mul_le_mul_of_nonneg_left he ht.le
  have hnum : |t-x^2| * Real.exp (-(x^2)/(2*t)) ≤ 3*t := by nlinarith
  have hs : 0 < Real.sqrt (2*Real.pi*t) := Real.sqrt_pos.mpr (by positivity)
  rw [(heatBoundaryKernel_hasDeriv_space ht x).deriv]
  simp only [heatKernel,Real.norm_eq_abs,abs_mul,abs_div,abs_inv,abs_of_nonneg (sq_nonneg t),
    abs_of_pos hs,abs_of_pos (Real.exp_pos _)]
  calc
    |t-x^2| /t^2*((Real.sqrt (2*Real.pi*t))⁻¹*Real.exp (-(x^2)/(2*t))) =
        (|t-x^2| * Real.exp (-(x^2)/(2*t)))/(t^2*Real.sqrt (2*Real.pi*t)) := by ring
    _ ≤ (3*t)/(t^2*Real.sqrt (2*Real.pi*t)) :=
      div_le_div_of_nonneg_right hnum (by positivity)
    _ = 3/(t*Real.sqrt (2*Real.pi*t)) := by field_simp

theorem heatBoundaryKernel_sub_bound {t : ℝ} (ht : 0 < t) (x y : ℝ) :
    ‖heatBoundaryKernel t y-heatBoundaryKernel t x‖ ≤
      (3/(t*Real.sqrt (2*Real.pi*t)))*‖y-x‖ := by
  exact convex_univ.norm_image_sub_le_of_norm_deriv_le
    (fun z _ => (heatBoundaryKernel_hasDeriv_space ht z).differentiableAt)
    (fun z _ => heatBoundaryKernel_deriv_bound ht z) (mem_univ x) (mem_univ y)

theorem heatBoundaryKernel_lipschitz_motion_bound {t L d : ℝ}
    (ht : 0 < t) (hd : ‖d‖ ≤ L*t) (x : ℝ) :
    ‖heatBoundaryKernel t (x+d)-heatBoundaryKernel t x‖ ≤
      (3*L/Real.sqrt (2*Real.pi))/Real.sqrt t := by
  have hs : Real.sqrt (2*Real.pi*t) = Real.sqrt (2*Real.pi)*Real.sqrt t :=
    Real.sqrt_mul (by positivity) _
  calc
    ‖heatBoundaryKernel t (x+d)-heatBoundaryKernel t x‖ ≤
        (3/(t*Real.sqrt (2*Real.pi*t)))*‖d‖ := by
      simpa only [add_sub_cancel_left] using heatBoundaryKernel_sub_bound ht x (x+d)
    _ ≤ (3/(t*Real.sqrt (2*Real.pi*t)))*(L*t) :=
      mul_le_mul_of_nonneg_left hd (by positivity)
    _ = (3*L/Real.sqrt (2*Real.pi))/Real.sqrt t := by
      rw [hs]
      field_simp

theorem integrableOn_inverse_sqrt {T : ℝ} (hT : 0 < T) :
    IntegrableOn (fun t : ℝ => (Real.sqrt t)⁻¹) (Ioo 0 T) := by
  have hi : IntegrableOn (fun t : ℝ => t^(-1/2 : ℝ)) (Ioo 0 T) :=
    (intervalIntegral.integrableOn_Ioo_rpow_iff hT).mpr (by norm_num)
  apply hi.congr_fun _ measurableSet_Ioo
  intro t ht
  change t^(-1/2 : ℝ) = (Real.sqrt t)⁻¹
  rw [show (-1/2 : ℝ) = -(1/2) by ring,Real.rpow_neg ht.1.le,Real.sqrt_eq_rpow]

end AmericanConvexity.Stopping
