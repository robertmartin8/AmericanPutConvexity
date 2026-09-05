import AmericanConvexity.Stopping.HeatKernelGradientMotion
import AmericanConvexity.Stopping.HeatHistoryLinearization

/-! # Time derivative of the frozen-line history remainder

The derivative holds the source time and reference slope fixed. A square-root
velocity error and order-3/2 graph error cancel the leading singularity:
the remainder derivative is bounded by a constant divided by elapsed time.
Neither the density nor the reference slope is differentiated.
-/

namespace AmericanConvexity.Stopping

open Set

noncomputable def heatBoundaryMotionDerivative (u x w : ℝ) : ℝ :=
  -heatBoundaryKernel u x/u+(w-x/(2*u))*deriv (heatBoundaryKernel u) x

theorem movingHeatHistoryKernel_hasDerivAt_motion {b : ℝ → ℝ} {t s w : ℝ}
    (hst : s < t) (hb : HasDerivAt b w t) :
    HasDerivAt (fun r => movingHeatHistoryKernel b r s)
      (heatBoundaryMotionDerivative (t-s) (b t-b s) w) t := by
  convert! movingHeatHistoryKernel_hasDerivAt hst hb using 1
  unfold heatBoundaryMotionDerivative
  rw [heatBoundaryKernel_scaling_derivative (sub_pos.mpr hst)]
  ring

theorem linearHeatHistoryKernel_hasDerivAt {t s v : ℝ} (hst : s < t) :
    HasDerivAt (fun r => heatBoundaryKernel (r-s) (v*(r-s)))
      (heatBoundaryMotionDerivative (t-s) (v*(t-s)) v) t := by
  have hd := movingHeatHistoryKernel_hasDerivAt_motion hst ((hasDerivAt_id t).const_mul v)
  have he : (fun r => movingHeatHistoryKernel (fun z => v*z) r s) =
      (fun r => heatBoundaryKernel (r-s) (v*(r-s))) := by
    funext r
    unfold movingHeatHistoryKernel
    congr 1
    ring
  simpa only [id_eq,mul_one,he,← mul_sub] using hd

theorem heatBoundaryMotionDerivative_sub_linear {u x w v : ℝ} (hu : 0 < u) :
    heatBoundaryMotionDerivative u x w-heatBoundaryMotionDerivative u (v*u) v =
      -(heatBoundaryKernel u x-heatBoundaryKernel u (v*u))/u+
      (w-v-(x-v*u)/(2*u))*deriv (heatBoundaryKernel u) x+
      (v/2)*(deriv (heatBoundaryKernel u) x-deriv (heatBoundaryKernel u) (v*u)) := by
  unfold heatBoundaryMotionDerivative
  field_simp
  ring

theorem heatBoundaryMotionDerivative_linear_remainder_bound {u x w v A L : ℝ}
    (hu : 0 < u) (hu1 : u ≤ 1) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hx : ‖x‖ ≤ L*u) (hv : ‖v‖ ≤ L)
    (hrem : ‖x-v*u‖ ≤ A*u*Real.sqrt u) (hw : ‖w-v‖ ≤ A*Real.sqrt u) :
    ‖heatBoundaryMotionDerivative u x w-heatBoundaryMotionDerivative u (v*u) v‖ ≤
      ((8+5*L^2)*A)/(Real.sqrt (2*Real.pi)*u) := by
  have hs : 0 < Real.sqrt u := Real.sqrt_pos.mpr hu
  have hp : 0 < Real.sqrt (2*Real.pi) := Real.sqrt_pos.mpr (by positivity)
  have hlin : ‖v*u‖ ≤ L*u := by
    rw [norm_mul,Real.norm_of_nonneg hu.le]
    exact mul_le_mul_of_nonneg_right hv hu.le
  have hgrad : ‖deriv (heatBoundaryKernel u) x-deriv (heatBoundaryKernel u) (v*u)‖ ≤
      10*L*A/Real.sqrt (2*Real.pi) := by
    calc
      _ ≤ (10*L/(u*Real.sqrt (2*Real.pi*u)))*‖x-v*u‖ :=
        heatBoundaryKernel_gradient_sub_motion_bound hu hL hx hlin
      _ ≤ (10*L/(u*Real.sqrt (2*Real.pi*u)))*(A*u*Real.sqrt u) :=
        mul_le_mul_of_nonneg_left hrem (by positivity)
      _ = _ := by rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]; field_simp
  have hcoef : ‖w-v-(x-v*u)/(2*u)‖ ≤ (3/2)*A*Real.sqrt u := by
    calc
      _ ≤ ‖w-v‖+‖(x-v*u)/(2*u)‖ := norm_sub_le _ _
      _ = ‖w-v‖+‖x-v*u‖/(2*u) := by
        rw [norm_div,Real.norm_of_nonneg (by positivity : 0 ≤ 2*u)]
      _ ≤ A*Real.sqrt u+(A*u*Real.sqrt u)/(2*u) :=
        add_le_add hw (div_le_div_of_nonneg_right hrem (by positivity))
      _ = _ := by field_simp; ring
  rw [heatBoundaryMotionDerivative_sub_linear hu]
  calc
    _ ≤ ‖-(heatBoundaryKernel u x-heatBoundaryKernel u (v*u))/u‖+
        ‖(w-v-(x-v*u)/(2*u))*deriv (heatBoundaryKernel u) x‖+
        ‖(v/2)*(deriv (heatBoundaryKernel u) x-deriv (heatBoundaryKernel u) (v*u))‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ = ‖heatBoundaryKernel u x-heatBoundaryKernel u (v*u)‖/u+
        ‖w-v-(x-v*u)/(2*u)‖*‖deriv (heatBoundaryKernel u) x‖+
        (‖v‖/2)*‖deriv (heatBoundaryKernel u) x-deriv (heatBoundaryKernel u) (v*u)‖ := by
      rw [norm_div,norm_neg,Real.norm_of_nonneg hu.le,norm_mul,norm_mul,norm_div]
      norm_num only [Real.norm_of_nonneg (by norm_num : (0 : ℝ) ≤ 2)]
    _ ≤ (3*A/Real.sqrt (2*Real.pi))/u+
        ((3/2)*A*Real.sqrt u)*(3/(u*Real.sqrt (2*Real.pi*u)))+
        (L/2)*(10*L*A/Real.sqrt (2*Real.pi)) := by
      apply add_le_add
      · exact add_le_add (div_le_div_of_nonneg_right (heatBoundaryKernel_linear_remainder_bound hu hrem) hu.le)
          (mul_le_mul hcoef (heatBoundaryKernel_deriv_bound hu x) (norm_nonneg _) (by positivity))
      · exact mul_le_mul (div_le_div_of_nonneg_right hv (by norm_num)) hgrad
          (norm_nonneg _) (by positivity)
    _ ≤ _ := by
      rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
      field_simp
      nlinarith [mul_nonneg (mul_nonneg hA (sq_nonneg L)) (sub_nonneg.mpr hu1)]

end AmericanConvexity.Stopping
