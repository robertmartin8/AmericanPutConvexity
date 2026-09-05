import AmericanConvexity.Stopping.ActualPriceC1
import AmericanConvexity.Stopping.PlanePricingDerivative

/-! # The actual time derivative as a parabolic Dirichlet solution

Theta is defined from the actual stopping price. It is jointly continuous at
positive times, vanishes in exercise, is nonnegative, and solves the same
pricing equation smoothly in continuation. No boundary velocity is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def canonicalTheta (k h x t : ℝ) : ℝ := deriv (canonicalPrice k h x) t

theorem canonicalTheta_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => canonicalTheta k h z.1 z.2) (x,t) :=
  canonicalPrice_time_deriv_continuousAt hk hh hhk ht

theorem canonicalTheta_nonneg {k h : ℝ} (hk : 0 ≤ k) (x t : ℝ) :
    0 ≤ canonicalTheta k h x t := canonicalPrice_time_deriv_nonneg hk x t

theorem canonicalTheta_exercise_zero {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) (hx : x ≤ canonicalLogBoundary k h t) :
    canonicalTheta k h x t = 0 := canonicalPrice_time_deriv_exercise hk hh hhk ht hx

theorem canonicalTheta_contDiffAt {k h : ℝ} {z : ℝ × ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : z ∈ canonicalContinuationRegion k h) :
    ContDiffAt ℝ ∞ (fun y : ℝ × ℝ => canonicalTheta k h y.1 y.2) z := by
  have ht : 0 < z.2 := ((canonicalContinuationRegion_eq_logBoundary hk hh hhk) ▸ hz).1
  apply (heatPartial_smoothAt (canonicalPrice_contDiffAt hk.le hz) (0,1)).congr_of_eventuallyEq
  filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with y hyt
  exact canonicalPrice_time_deriv_eq_partial hk hh hhk hyt

theorem canonicalPrice_partial_equation {k h : ℝ} {z : ℝ × ℝ} (hk : 0 ≤ k)
    (hz : z ∈ canonicalContinuationRegion k h) :
    heatPartial (fun y : ℝ × ℝ => canonicalPrice k h y.1 y.2) (0,1) z =
      heatPartial (heatPartial (fun y : ℝ × ℝ => canonicalPrice k h y.1 y.2) (1,0)) (1,0) z +
        (k-h-1)*heatPartial (fun y : ℝ × ℝ => canonicalPrice k h y.1 y.2) (1,0) z -
          k*canonicalPrice k h z.1 z.2 := by
  have hc := canonicalPrice_contDiffAt hk hz
  have hd := hc.differentiableAt (by simp)
  have he := canonicalPrice_continuation_pde hk hz
  rw [(heatPartial_space hd).deriv,(heatPartial_time hd).deriv,heatPartial_spatial_second hc] at he
  exact he

theorem canonicalTheta_equation {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (canonicalTheta k h x) t =
      deriv (deriv (fun y => canonicalTheta k h y t)) x +
        (k-h-1)*deriv (fun y => canonicalTheta k h y t) x-k*canonicalTheta k h x t := by
  let F : ℝ × ℝ → ℝ := fun z => canonicalPrice k h z.1 z.2
  let Q := heatPartial F (0,1)
  have hc : ContDiffAt ℝ ∞ F (x,t) := canonicalPrice_contDiffAt hk.le hz
  have hQ : ContDiffAt ℝ ∞ Q (x,t) := heatPartial_smoothAt hc (0,1)
  have ht : 0 < t := ((canonicalContinuationRegion_eq_logBoundary hk hh hhk) ▸ hz).1
  have heq : heatPartial F (0,1) =ᶠ[𝓝 (x,t)]
      (fun y => heatPartial (heatPartial F (1,0)) (1,0) y+
        (k-h-1)*heatPartial F (1,0) y-k*F y) := by
    filter_upwards [(canonicalContinuationRegion_isOpen hk.le).mem_nhds hz] with y hy
    exact canonicalPrice_partial_equation hk.le hy
  have hpde := heatPartial_pricing_equation_derivative hc heq
  have hex : (fun y => canonicalTheta k h y t) = fun y => Q (y,t) := by
    funext y
    exact canonicalPrice_time_deriv_eq_partial hk hh hhk ht
  have het : canonicalTheta k h x =ᶠ[𝓝 t] (fun s => Q (x,s)) := by
    filter_upwards [Ioi_mem_nhds ht] with s hs
    exact canonicalPrice_time_deriv_eq_partial hk hh hhk hs
  rw [het.deriv_eq,hex,heatPartial_spatial_second hQ,(heatPartial_space
    (hQ.differentiableAt (by simp))).deriv,(heatPartial_time (hQ.differentiableAt (by simp))).deriv]
  have hval : canonicalTheta k h x t = Q (x,t) := canonicalPrice_time_deriv_eq_partial hk hh hhk ht
  rw [hval]
  exact hpde

theorem canonicalPrice_mixed_derivs_eq {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (fun s => deriv (fun y => canonicalPrice k h y s) x) t =
      deriv (fun y => canonicalTheta k h y t) x := by
  let F : ℝ × ℝ → ℝ := fun z => canonicalPrice k h z.1 z.2
  have hc : ContDiffAt ℝ ∞ F (x,t) := canonicalPrice_contDiffAt hk.le hz
  have ht : 0 < t := hz.1
  have hsp : (fun s => deriv (fun y => canonicalPrice k h y s) x) =ᶠ[𝓝 t]
      (fun s => heatPartial F (1,0) (x,s)) := by
    filter_upwards [Ioi_mem_nhds ht] with s hs
    exact (heatPartial_time (canonicalPrice_joint_differentiableAt hk hh hhk hs)).deriv
  have htm : (fun y => canonicalTheta k h y t) = fun y => heatPartial F (0,1) (y,t) := by
    funext y
    exact canonicalPrice_time_deriv_eq_partial hk hh hhk ht
  rw [hsp.deriv_eq,htm,(heatPartial_space
    ((heatPartial_smoothAt hc (1,0)).differentiableAt (by simp))).deriv,
    (heatPartial_time ((heatPartial_smoothAt hc (0,1)).differentiableAt (by simp))).deriv]
  exact heatPartial_comm (hc.of_le (WithTop.coe_le_coe.mpr le_top)) (1,0) (0,1)

theorem zeroDividend_canonicalTheta_equation {k x t : ℝ} (hk : 0 < k)
    (hz : (x,t) ∈ canonicalContinuationRegion k 0) :
    deriv (canonicalTheta k 0 x) t =
      deriv (deriv (fun y => canonicalTheta k 0 y t)) x +
        (k-1)*deriv (fun y => canonicalTheta k 0 y t) x-k*canonicalTheta k 0 x t := by
  simpa only [sub_zero] using canonicalTheta_equation hk le_rfl hk.le hz

theorem liuRange_canonicalTheta_equation {k h x t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (canonicalTheta k h x) t =
      deriv (deriv (fun y => canonicalTheta k h y t)) x +
        (k-h-1)*deriv (fun y => canonicalTheta k h y t) x-k*canonicalTheta k h x t :=
  canonicalTheta_equation (by linarith) hh (by linarith) hz

end AmericanConvexity.Stopping
