import AmericanConvexity.Stopping.UpperSupportComparison

/-! # An explicit square-root upper cap at expiry

The smoothed wedge `(sqrt(x^2+4*t)-x)/2`, with a drift correction, dominates
the put payoff and is a pricing supersolution. At strike it is exactly
`sqrt(t)+abs(alpha)*t`. No European pricing formula is used.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def expiryUpperCap (α x t : ℝ) : ℝ :=
  (Real.sqrt (x^2+4*t)-x)/2+|α| * t

theorem expiryUpperCap_continuous (α : ℝ) :
    Continuous (fun z : ℝ × ℝ => expiryUpperCap α z.1 z.2) := by
  unfold expiryUpperCap
  fun_prop

theorem expiryUpperCap_contDiffAt (α x : ℝ) {t : ℝ} (ht : 0 < t) :
    ContDiffAt ℝ 2 (fun z : ℝ × ℝ => expiryUpperCap α z.1 z.2) (x,t) := by
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  unfold expiryUpperCap
  fun_prop (disch := exact hr.ne')

theorem expiryUpperCap_bounds (α x : ℝ) {t : ℝ} (ht : 0 ≤ t) :
    0 ≤ expiryUpperCap α x t ∧ -x ≤ expiryUpperCap α x t ∧ putPayoff x ≤ expiryUpperCap α x t := by
  have hs : |x| ≤ Real.sqrt (x^2+4*t) := by
    rw [← Real.sqrt_sq_eq_abs]
    exact Real.sqrt_le_sqrt (by linarith)
  have hcorr : 0 ≤ |α| * t := mul_nonneg (abs_nonneg _) ht
  have hzero : 0 ≤ expiryUpperCap α x t := by
    unfold expiryUpperCap
    linarith [le_abs_self x]
  have hneg : -x ≤ expiryUpperCap α x t := by
    unfold expiryUpperCap
    linarith [neg_le_abs x]
  refine ⟨hzero,hneg,?_⟩
  apply max_le _ hzero
  exact (show 1-Real.exp x ≤ -x by linarith [Real.add_one_le_exp x]).trans hneg

theorem expiryUpperCap_radius_hasDeriv_x (x : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (fun y => Real.sqrt (y^2+4*t)) (x/Real.sqrt (x^2+4*t)) x := by
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  have hs : 0 < Real.sqrt (x^2+4*t) := Real.sqrt_pos.mpr hr
  convert! (Real.hasDerivAt_sqrt hr.ne').comp x ((hasDerivAt_pow 2 x).add_const (4*t)) using 1
  field_simp
  ring

theorem expiryUpperCap_hasDeriv_x (α x : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (fun y => expiryUpperCap α y t)
      ((x/Real.sqrt (x^2+4*t)-1)/2) x :=
  (((expiryUpperCap_radius_hasDeriv_x x ht).sub (hasDerivAt_id x)).div_const 2).add_const (|α| * t)

theorem expiryUpperCap_deriv2_x (α x : ℝ) {t : ℝ} (ht : 0 < t) :
    deriv (deriv (fun y => expiryUpperCap α y t)) x = 2*t/Real.sqrt (x^2+4*t)^3 := by
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  have hs : 0 < Real.sqrt (x^2+4*t) := Real.sqrt_pos.mpr hr
  rw [show deriv (fun y => expiryUpperCap α y t) =
    fun y => (y/Real.sqrt (y^2+4*t)-1)/2 from funext (fun y => (expiryUpperCap_hasDeriv_x α y ht).deriv)]
  have hd := (((hasDerivAt_id x).div (expiryUpperCap_radius_hasDeriv_x x ht) hs.ne').sub_const 1).div_const 2
  dsimp only [Pi.div_def,id_eq] at hd
  rw [hd.deriv]
  have he := Real.sq_sqrt hr.le
  field_simp
  nlinarith

theorem expiryUpperCap_hasDeriv_t (α x : ℝ) {t : ℝ} (ht : 0 < t) :
    HasDerivAt (expiryUpperCap α x) (1/Real.sqrt (x^2+4*t)+|α|) t := by
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  have hs : 0 < Real.sqrt (x^2+4*t) := Real.sqrt_pos.mpr hr
  have hd := (Real.hasDerivAt_sqrt hr.ne').comp t
    (((hasDerivAt_id t).const_mul 4).const_add (x^2))
  convert! ((hd.sub_const x).div_const 2).add ((hasDerivAt_id t).const_mul |α|) using 1
  field_simp
  ring

theorem expiryUpperCap_slope_bounds (α x : ℝ) {t : ℝ} (ht : 0 < t) :
    |deriv (fun y => expiryUpperCap α y t) x| ≤ 1 := by
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  have hs : 0 < Real.sqrt (x^2+4*t) := Real.sqrt_pos.mpr hr
  have hx : |x| ≤ Real.sqrt (x^2+4*t) := by
    rw [← Real.sqrt_sq_eq_abs]
    exact Real.sqrt_le_sqrt (by linarith)
  rw [(expiryUpperCap_hasDeriv_x α x ht).deriv]
  apply abs_le.mpr
  have hu : x/Real.sqrt (x^2+4*t) ≤ 1 := (div_le_one hs).mpr ((le_abs_self x).trans hx)
  have hl : -1 ≤ x/Real.sqrt (x^2+4*t) := (le_div_iff₀ hs).mpr (by linarith [neg_le_abs x])
  constructor <;> linarith

theorem expiryUpperCap_supersolution {k h x t : ℝ} (hk : 0 ≤ k) (ht : 0 < t) :
    0 ≤ pricingOperator k h (fun z => expiryUpperCap (k-h-1) z.1 z.2) (x,t) := by
  let α := k-h-1
  have hr : 0 < x^2+4*t := by nlinarith [sq_nonneg x]
  have hs : 0 < Real.sqrt (x^2+4*t) := Real.sqrt_pos.mpr hr
  have he := Real.sq_sqrt hr.le
  have hheat : 2*t/Real.sqrt (x^2+4*t)^3 ≤ 1/Real.sqrt (x^2+4*t) := by
    apply (div_le_div_iff₀ (pow_pos hs 3) hs).mpr
    nlinarith [mul_nonneg hs.le (show 0 ≤ x^2+2*t by nlinarith [sq_nonneg x])]
  have hsl := expiryUpperCap_slope_bounds α x ht
  have hdrift : α*deriv (fun y => expiryUpperCap α y t) x ≤ |α| := by
    calc
      _ ≤ |α*deriv (fun y => expiryUpperCap α y t) x| := le_abs_self _
      _ = |α| * |deriv (fun y => expiryUpperCap α y t) x| := abs_mul _ _
      _ ≤ |α| * 1 := mul_le_mul_of_nonneg_left hsl (abs_nonneg _)
      _ = |α| := mul_one _
  have hkill := mul_nonneg hk (expiryUpperCap_bounds α x ht.le).1
  change 0 ≤ deriv (expiryUpperCap α x) t -
    deriv (deriv (fun y => expiryUpperCap α y t)) x -
      α*deriv (fun y => expiryUpperCap α y t) x + k*expiryUpperCap α x t
  rw [(expiryUpperCap_hasDeriv_t α x ht).deriv,expiryUpperCap_deriv2_x α x ht]
  linarith

theorem expiryUpperCap_atStrike (α t : ℝ) :
    expiryUpperCap α 0 t = Real.sqrt t+|α| * t := by
  have he : Real.sqrt (4*t) = 2*Real.sqrt t := by
    rw [Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 4)]
    norm_num
  simp only [expiryUpperCap,zero_pow (by decide : 2 ≠ 0),zero_add,sub_zero,he]
  ring

end AmericanConvexity.Stopping
