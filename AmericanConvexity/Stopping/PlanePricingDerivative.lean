import AmericanConvexity.Stopping.HeatBoundaryEquation
import Mathlib.Analysis.Calculus.FDeriv.Symmetric

/-! # Differentiating a constant-coefficient pricing equation

Directional derivatives commute for the smooth plane functions used here.
The argument includes the third-order interchange needed to differentiate
the spatial Laplacian. Coordinates in the pricing equation are (space,time).
-/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology ContDiff

theorem heatPartial_comm {F : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hF : ContDiffAt ℝ 2 F z) (v w : ℝ × ℝ) :
    heatPartial (heatPartial F v) w z = heatPartial (heatPartial F w) v z := by
  have hd : DifferentiableAt ℝ (fderiv ℝ F) z :=
    (hF.fderiv_right (m := 1) (by norm_num)).differentiableAt (by norm_num)
  have he (a b : ℝ × ℝ) : heatPartial (heatPartial F a) b z =
      fderiv ℝ (fderiv ℝ F) z b a := by
    unfold heatPartial
    rw [fderiv_clm_apply hd (differentiableAt_const a)]
    simp
  rw [he v w,he w v]
  exact (hF.isSymmSndFDerivAt (by norm_num)).eq w v

theorem heatPartial_comm_third {F : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hF : ContDiffAt ℝ ∞ F z) (v w : ℝ × ℝ) :
    heatPartial (heatPartial (heatPartial F v) v) w z =
      heatPartial (heatPartial (heatPartial F w) v) v z := by
  have h2 : ContDiffAt ℝ 2 F z := hF.of_le (WithTop.coe_le_coe.mpr le_top)
  have he : heatPartial (heatPartial F v) w =ᶠ[𝓝 z] heatPartial (heatPartial F w) v := by
    filter_upwards [h2.eventually (by norm_num)] with y hy
    exact heatPartial_comm hy v w
  rw [heatPartial_comm ((heatPartial_smoothAt hF v).of_le (WithTop.coe_le_coe.mpr le_top)) v w]
  exact congrArg (fun L : (ℝ × ℝ) →L[ℝ] ℝ => L v) he.fderiv_eq

theorem heatPartial_pricing_combination {F G H : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) (α k : ℝ) (v : ℝ × ℝ) :
    heatPartial (fun y => F y+α*G y-k*H y) v z =
      heatPartial F v z+α*heatPartial G v z-k*heatPartial H v z := by
  have hd := ((hF.hasFDerivAt.add (hG.hasFDerivAt.const_mul α)).sub
    (hH.hasFDerivAt.const_mul k)).fderiv
  have he := congrArg (fun L : (ℝ × ℝ) →L[ℝ] ℝ => L v) hd
  have hfun : ((F+fun y => α*G y)-fun y => k*H y) = (fun y => F y+α*G y-k*H y) := rfl
  rw [hfun] at he
  simpa only [sub_apply,add_apply,smul_apply,smul_eq_mul,heatPartial] using he

theorem heatPartial_spatial_second {F : ℝ × ℝ → ℝ} {x t : ℝ}
    (hF : ContDiffAt ℝ ∞ F (x,t)) :
    deriv (deriv (fun y => F (y,t))) x = heatPartial (heatPartial F (1,0)) (1,0) (x,t) := by
  have h1 : ContDiffAt ℝ 1 F (x,t) := hF.of_le (WithTop.coe_le_coe.mpr le_top)
  have hnear : ∀ᶠ y in 𝓝 x, ContDiffAt ℝ 1 F (y,t) :=
    (show ContinuousAt (fun y : ℝ => (y,t)) x by fun_prop).eventually
      (h1.eventually (by norm_num))
  have he : deriv (fun y => F (y,t)) =ᶠ[𝓝 x]
      (fun y => heatPartial F (1,0) (y,t)) := by
    filter_upwards [hnear] with y hy
    exact (heatPartial_time (hy.differentiableAt (by norm_num))).deriv
  rw [he.deriv_eq]
  exact (heatPartial_time ((heatPartial_smoothAt hF (1,0)).differentiableAt (by simp))).deriv

theorem heatPartial_pricing_equation_derivative {F : ℝ × ℝ → ℝ} {z : ℝ × ℝ} {α k : ℝ}
    (hF : ContDiffAt ℝ ∞ F z)
    (heq : heatPartial F (0,1) =ᶠ[𝓝 z]
      (fun y => heatPartial (heatPartial F (1,0)) (1,0) y+α*heatPartial F (1,0) y-k*F y)) :
    heatPartial (heatPartial F (0,1)) (0,1) z =
      heatPartial (heatPartial (heatPartial F (0,1)) (1,0)) (1,0) z +
        α*heatPartial (heatPartial F (0,1)) (1,0) z-k*heatPartial F (0,1) z := by
  have hdx := heatPartial_smoothAt hF (1,0)
  have hdxx := heatPartial_smoothAt hdx (1,0)
  have he := congrArg (fun L : (ℝ × ℝ) →L[ℝ] ℝ => L (0,1)) heq.fderiv_eq
  change heatPartial (heatPartial F (0,1)) (0,1) z =
    heatPartial (fun y => heatPartial (heatPartial F (1,0)) (1,0) y+
      α*heatPartial F (1,0) y-k*F y) (0,1) z at he
  rw [heatPartial_pricing_combination (hdxx.differentiableAt (by simp))
    (hdx.differentiableAt (by simp)) (hF.differentiableAt (by simp)),
    heatPartial_comm_third hF (1,0) (0,1),
    heatPartial_comm (hF.of_le (WithTop.coe_le_coe.mpr le_top)) (1,0) (0,1)] at he
  exact he

end AmericanConvexity.Stopping
