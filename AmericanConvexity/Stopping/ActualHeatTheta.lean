import AmericanConvexity.Stopping.ActualTheta
import AmericanConvexity.Stopping.HeatPricingTransform

/-! # Actual theta in fixed-space heat coordinates

Heat time is twice normalized pricing time. The inverse exponential gauge
removes both drift and discount, without differentiating the free boundary.
The resulting actual function is continuous across exercise, zero there, and
smoothly solves the diffusivity-1/2 heat equation in continuation.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def heatFromPrice (u : ℝ × ℝ → ℝ) (k h : ℝ) (z : ℝ × ℝ) : ℝ :=
  Real.exp ((k-h-1)/2*z.1+(k+(k-h-1)^2/4)*z.2/2)*u (z.1,z.2/2)

theorem priceFromHeat_heatFromPrice (u : ℝ × ℝ → ℝ) (k h : ℝ) :
    priceFromHeat (heatFromPrice u k h) k h 0 0 = u := by
  funext z
  simp only [priceFromHeat,heatFromPrice,pricingGauge,sub_zero,
    mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)]
  rw [← mul_assoc,← Real.exp_add]
  ring_nf
  simp

theorem heatFromPrice_contDiffAt {u : ℝ × ℝ → ℝ} {k h x s : ℝ}
    (hu : ContDiffAt ℝ ∞ u (x,s/2)) :
    ContDiffAt ℝ ∞ (heatFromPrice u k h) (x,s) := by
  exact (show ContDiffAt ℝ ∞ (fun z : ℝ × ℝ =>
    Real.exp ((k-h-1)/2*z.1+(k+(k-h-1)^2/4)*z.2/2)) (x,s) by fun_prop).mul
      (hu.comp (x,s) (show ContDiffAt ℝ ∞ (fun z : ℝ × ℝ => (z.1,z.2/2))
        (x,s) by fun_prop))

theorem heatFromPrice_equation {u : ℝ × ℝ → ℝ} {k h x s : ℝ}
    (hu : ContDiffAt ℝ ∞ u (x,s/2))
    (he : pricingOperator k h u (x,s/2) = 0) :
    deriv (fun v => heatFromPrice u k h (x,v)) s =
      (1/2)*deriv (deriv (fun y => heatFromPrice u k h (y,s))) x := by
  have hc : ContDiffAt ℝ 2 (heatFromPrice u k h) (x-0,2*(s/2-0)) := by
    have hc' : ContDiffAt ℝ 2 (heatFromPrice u k h) (x,s) :=
      (heatFromPrice_contDiffAt hu).of_le (WithTop.coe_le_coe.mpr le_top)
    simpa only [sub_zero,mul_div_cancel₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using
      hc'
  have hp := priceFromHeat_pricingOperator (k := k) (h := h) (L := 0) (a := 0)
    (x := x) (t := s/2) hc
  rw [priceFromHeat_heatFromPrice,he] at hp
  have hg : pricingGauge k h 0 0 x (s/2) ≠ 0 := Real.exp_ne_zero _
  have hz := (mul_eq_zero.mp hp.symm).resolve_left hg
  simp only [sub_zero,mul_div_cancel₀ _ (by norm_num : (2 : ℝ) ≠ 0)] at hz
  linarith

noncomputable def canonicalHeatTheta (k h : ℝ) (z : ℝ × ℝ) : ℝ :=
  heatFromPrice (fun y => canonicalTheta k h y.1 y.2) k h z

theorem canonicalHeatTheta_continuousAt {k h x s : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    ContinuousAt (canonicalHeatTheta k h) (x,s) := by
  have hc : ContinuousAt (fun y : ℝ × ℝ => canonicalTheta k h y.1 y.2) (x,s/2) :=
    canonicalTheta_continuousAt hk hh hhk (by positivity)
  have hd : ContinuousAt (fun z : ℝ × ℝ => canonicalTheta k h z.1 (z.2/2)) (x,s) :=
    hc.comp (x := (x,s)) (f := fun z : ℝ × ℝ => (z.1,z.2/2)) (by fun_prop)
  unfold canonicalHeatTheta heatFromPrice
  exact (show ContinuousAt (fun z : ℝ × ℝ =>
    Real.exp ((k-h-1)/2*z.1+(k+(k-h-1)^2/4)*z.2/2)) (x,s) by fun_prop).mul
      hd

theorem canonicalHeatTheta_nonneg {k h : ℝ} (hk : 0 ≤ k) (z : ℝ × ℝ) :
    0 ≤ canonicalHeatTheta k h z :=
  mul_nonneg (Real.exp_pos _).le (canonicalTheta_nonneg hk _ _)

theorem canonicalHeatTheta_exercise_zero {k h x s : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : x ≤ canonicalLogBoundary k h (s/2)) :
    canonicalHeatTheta k h (x,s) = 0 := by
  unfold canonicalHeatTheta heatFromPrice
  dsimp only
  rw [canonicalTheta_exercise_zero hk hh hhk (by positivity : 0 < s/2) hx,mul_zero]

theorem canonicalHeatTheta_contDiffAt {k h x s : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : canonicalLogBoundary k h (s/2) < x) :
    ContDiffAt ℝ ∞ (canonicalHeatTheta k h) (x,s) := by
  unfold canonicalHeatTheta
  apply heatFromPrice_contDiffAt
  apply canonicalTheta_contDiffAt hk hh hhk
  rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
  exact ⟨by positivity,hx⟩

theorem canonicalHeatTheta_equation {k h x s : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s)
    (hx : canonicalLogBoundary k h (s/2) < x) :
    deriv (fun v => canonicalHeatTheta k h (x,v)) s =
      (1/2)*deriv (deriv (fun y => canonicalHeatTheta k h (y,s))) x := by
  have hz : (x,s/2) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨by positivity,hx⟩
  apply heatFromPrice_equation (canonicalTheta_contDiffAt hk hh hhk hz)
  have he := canonicalTheta_equation hk hh hhk hz
  unfold pricingOperator
  dsimp only
  linarith

theorem zeroDividend_canonicalHeatTheta_equation {k x s : ℝ} (hk : 0 < k)
    (hs : 0 < s) (hx : canonicalLogBoundary k 0 (s/2) < x) :
    deriv (fun v => canonicalHeatTheta k 0 (x,v)) s =
      (1/2)*deriv (deriv (fun y => canonicalHeatTheta k 0 (y,s))) x :=
  canonicalHeatTheta_equation hk le_rfl hk.le hs hx

theorem liuRange_canonicalHeatTheta_equation {k h x s : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (hs : 0 < s)
    (hx : canonicalLogBoundary k h (s/2) < x) :
    deriv (fun v => canonicalHeatTheta k h (x,v)) s =
      (1/2)*deriv (deriv (fun y => canonicalHeatTheta k h (y,s))) x :=
  canonicalHeatTheta_equation (by linarith) hh (by linarith) hs hx

end AmericanConvexity.Stopping
