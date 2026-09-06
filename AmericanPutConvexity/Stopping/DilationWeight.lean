import AmericanPutConvexity.Stopping.StationaryPutCap

/-! # An exponential weight for parabolic dilation comparisons

The weight dominates the price's spatial growth and its initial dilation
error, and its derivative is nonpositive below strike.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def dilationWeight (x : ℝ) : ℝ := Real.exp (3*x)+Real.exp (-3*x)

theorem dilationWeight_pos (x : ℝ) : 0 < dilationWeight x := by
  unfold dilationWeight
  positivity

theorem dilation_exp_le_weight {ρ x : ℝ} (hρ : 0 ≤ ρ) (hρ2 : ρ ≤ 2) :
    Real.exp (ρ*x) ≤ dilationWeight x := by
  rcases le_total 0 x with hx | hx
  · have he : Real.exp (ρ*x) ≤ Real.exp (3*x) := Real.exp_le_exp.mpr (by nlinarith)
    exact he.trans (le_add_of_nonneg_right (Real.exp_pos _).le)
  · have he : Real.exp (ρ*x) ≤ Real.exp (-3*x) := Real.exp_le_exp.mpr (by nlinarith)
    exact he.trans (le_add_of_nonneg_left (Real.exp_pos _).le)

theorem dilation_exp_sub_le_weight {ρ x : ℝ} (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) :
    Real.exp (ρ*x)-Real.exp x ≤ (ρ-1)*dilationWeight x := by
  have hδ : 0 ≤ ρ-1 := sub_nonneg.mpr hρ
  rcases le_total 0 x with hx | hx
  · have ht := Real.add_one_le_exp (x-ρ*x)
    have hp := mul_le_mul_of_nonneg_left ht (Real.exp_pos (ρ*x)).le
    have heq : Real.exp (ρ*x)*Real.exp (x-ρ*x) = Real.exp x := by
      rw [← Real.exp_add]
      congr 1
      ring
    rw [heq] at hp
    have hbound : x*Real.exp (ρ*x) ≤ Real.exp (3*x) := calc
      x*Real.exp (ρ*x) ≤ Real.exp x*Real.exp (ρ*x) :=
        mul_le_mul_of_nonneg_right (by linarith [Real.add_one_le_exp x]) (Real.exp_pos _).le
      _ = Real.exp (x+ρ*x) := (Real.exp_add _ _).symm
      _ ≤ Real.exp (3*x) := Real.exp_le_exp.mpr (by nlinarith)
    have hmul := mul_le_mul_of_nonneg_left hbound hδ
    have hn := mul_nonneg hδ (Real.exp_pos (-3*x)).le
    unfold dilationWeight
    nlinarith
  · have he : Real.exp (ρ*x) ≤ Real.exp x := Real.exp_le_exp.mpr (by nlinarith)
    exact (sub_nonpos.mpr he).trans (mul_nonneg hδ (dilationWeight_pos x).le)

theorem dilation_exp_source_le_weight {ρ x : ℝ} (hρ : 1 ≤ ρ) (hρ2 : ρ ≤ 2) :
    ρ^2*Real.exp (ρ*x)-Real.exp x ≤ 4*(ρ-1)*dilationWeight x := by
  have hδ : 0 ≤ ρ-1 := sub_nonneg.mpr hρ
  have hs : 0 ≤ ρ^2-1 := by nlinarith
  have hsq : ρ^2-1 ≤ 3*(ρ-1) := by nlinarith
  have hm := mul_le_mul_of_nonneg_right hsq (dilationWeight_pos x).le
  have he := mul_le_mul_of_nonneg_left (dilation_exp_le_weight (by linarith) hρ2 (x := x)) hs
  have hd := dilation_exp_sub_le_weight hρ hρ2 (x := x)
  nlinarith

theorem dilationWeight_hasDerivAt (x : ℝ) :
    HasDerivAt dilationWeight (3*(Real.exp (3*x)-Real.exp (-3*x))) x := by
  convert! ((((hasDerivAt_id x).const_mul 3).exp).add
    (((hasDerivAt_id x).const_mul (-3)).exp)) using 1
  simp only [id_eq]
  ring

theorem dilationWeight_deriv (x : ℝ) :
    deriv dilationWeight x = 3*(Real.exp (3*x)-Real.exp (-3*x)) :=
  (dilationWeight_hasDerivAt x).deriv

theorem dilationWeight_deriv_nonpos {x : ℝ} (hx : x < 0) : deriv dilationWeight x ≤ 0 := by
  rw [dilationWeight_deriv]
  have he := Real.exp_le_exp.mpr (show 3*x ≤ -3*x by linarith)
  linarith

theorem dilationWeight_deriv_abs_le (x : ℝ) : |deriv dilationWeight x| ≤ 3*dilationWeight x := by
  rw [dilationWeight_deriv]
  apply abs_le.mpr
  have hp := (Real.exp_pos (3*x)).le
  have hn := (Real.exp_pos (-3*x)).le
  unfold dilationWeight
  constructor <;> linarith

theorem dilationWeight_deriv2 (x : ℝ) : deriv (deriv dilationWeight) x = 9*dilationWeight x := by
  have he : deriv dilationWeight = fun y => 3*(Real.exp (3*y)-Real.exp (-3*y)) :=
    funext dilationWeight_deriv
  rw [he]
  have hd := (((((hasDerivAt_id x).const_mul 3).exp).sub
    (((hasDerivAt_id x).const_mul (-3)).exp)).const_mul 3)
  dsimp only [Pi.sub_apply,id_eq] at hd
  rw [hd.deriv]
  unfold dilationWeight
  ring

noncomputable def dilationBarrier (α D x t : ℝ) : ℝ :=
  D*Real.exp ((10+3*|α|)*t)*dilationWeight x

theorem dilation_exp_le_weight_far_left {ρ D x : ℝ} (hρ : 1 ≤ ρ) (hD : 0 < D)
    (hx0 : x ≤ 0) (hxD : x ≤ Real.log D) : Real.exp (ρ*x) ≤ D*dilationWeight x := by
  have he : ρ*x ≤ Real.log D+(-3*x) := by nlinarith
  have hb : Real.exp (ρ*x) ≤ D*Real.exp (-3*x) := by
    simpa only [Real.exp_add,Real.exp_log hD] using Real.exp_le_exp.mpr he
  unfold dilationWeight
  nlinarith [mul_pos hD (Real.exp_pos (3*x))]

theorem dilation_exp_le_weight_far_right {ρ D x : ℝ} (hρ2 : ρ ≤ 2) (hD : 0 < D)
    (hx0 : 0 ≤ x) (hxD : -Real.log D ≤ x) : Real.exp (ρ*x) ≤ D*dilationWeight x := by
  have he : ρ*x ≤ Real.log D+3*x := by nlinarith
  have hb : Real.exp (ρ*x) ≤ D*Real.exp (3*x) := by
    simpa only [Real.exp_add,Real.exp_log hD] using Real.exp_le_exp.mpr he
  unfold dilationWeight
  nlinarith [mul_pos hD (Real.exp_pos (-3*x))]

theorem dilationBarrier_contDiff (α D : ℝ) :
    ContDiff ℝ 2 (fun z : ℝ × ℝ => dilationBarrier α D z.1 z.2) := by
  unfold dilationBarrier dilationWeight
  fun_prop

theorem dilationBarrier_nonneg {α D x t : ℝ} (hD : 0 ≤ D) :
    0 ≤ dilationBarrier α D x t := by
  unfold dilationBarrier
  exact mul_nonneg (mul_nonneg hD (Real.exp_pos _).le) (dilationWeight_pos x).le

theorem dilationBarrier_le_of_nonneg_time {α D x t : ℝ} (hD : 0 ≤ D) (ht : 0 ≤ t) :
    D*dilationWeight x ≤ dilationBarrier α D x t := by
  have he : 1 ≤ Real.exp ((10+3*|α|)*t) := Real.one_le_exp_iff.mpr (by positivity)
  have hm := mul_le_mul_of_nonneg_left he hD
  simpa only [dilationBarrier,mul_one] using mul_le_mul_of_nonneg_right hm (dilationWeight_pos x).le

theorem dilationBarrier_hasDeriv_x (α D x t : ℝ) :
    HasDerivAt (fun y => dilationBarrier α D y t)
      (D*Real.exp ((10+3*|α|)*t)*deriv dilationWeight x) x := by
  rw [dilationWeight_deriv]
  exact (dilationWeight_hasDerivAt x).const_mul _

theorem dilationBarrier_deriv_x_nonpos {α D x t : ℝ} (hD : 0 ≤ D) (hx : x < 0) :
    deriv (fun y => dilationBarrier α D y t) x ≤ 0 := by
  rw [(dilationBarrier_hasDeriv_x α D x t).deriv]
  exact mul_nonpos_of_nonneg_of_nonpos (mul_nonneg hD (Real.exp_pos _).le)
    (dilationWeight_deriv_nonpos hx)

theorem dilationBarrier_pricingOperator (k h D x t : ℝ) :
    pricingOperator k h (fun z => dilationBarrier (k-h-1) D z.1 z.2) (x,t) =
      D*Real.exp ((10+3*|k-h-1|)*t)*
        ((1+3*|k-h-1|+k)*dilationWeight x-(k-h-1)*deriv dilationWeight x) := by
  let α := k-h-1
  have hdxx : deriv (deriv (fun y => dilationBarrier α D y t)) x =
      D*Real.exp ((10+3*|α|)*t)*(9*dilationWeight x) := by
    have he : deriv (fun y => dilationBarrier α D y t) =
        fun y => D*Real.exp ((10+3*|α|)*t)*deriv dilationWeight y :=
      funext fun y => (dilationBarrier_hasDeriv_x α D y t).deriv
    rw [he,deriv_const_mul_field,dilationWeight_deriv2]
  have hdt := (((((hasDerivAt_id t).const_mul (10+3*|α|)).exp).const_mul D).mul_const
    (dilationWeight x))
  dsimp only [id_eq] at hdt
  change HasDerivAt (dilationBarrier α D x) _ t at hdt
  change deriv (dilationBarrier α D x) t -
    deriv (deriv (fun y => dilationBarrier α D y t)) x -
    α*deriv (fun y => dilationBarrier α D y t) x+k*dilationBarrier α D x t = _
  rw [hdt.deriv,hdxx,(dilationBarrier_hasDeriv_x α D x t).deriv]
  change _ = D*Real.exp ((10+3*|α|)*t)*((1+3*|α|+k)*dilationWeight x-α*deriv dilationWeight x)
  unfold dilationBarrier
  ring

theorem dilationBarrier_supersolution {k h D x t : ℝ} (hk : 0 ≤ k)
    (hD : 0 ≤ D) (ht : 0 ≤ t) :
    D*dilationWeight x ≤
      pricingOperator k h (fun z => dilationBarrier (k-h-1) D z.1 z.2) (x,t) := by
  have ha : (k-h-1)*deriv dilationWeight x ≤ 3*|k-h-1| * dilationWeight x := calc
    (k-h-1)*deriv dilationWeight x ≤ |(k-h-1)*deriv dilationWeight x| := le_abs_self _
    _ = |k-h-1| * |deriv dilationWeight x| := abs_mul _ _
    _ ≤ |k-h-1| * (3*dilationWeight x) :=
      mul_le_mul_of_nonneg_left (dilationWeight_deriv_abs_le x) (abs_nonneg _)
    _ = _ := by ring
  have hl : dilationWeight x ≤
      (1+3*|k-h-1|+k)*dilationWeight x-(k-h-1)*deriv dilationWeight x := by
    nlinarith [mul_nonneg hk (dilationWeight_pos x).le]
  have hm := mul_le_mul_of_nonneg_left hl (mul_nonneg hD (Real.exp_pos ((10+3*|k-h-1|)*t)).le)
  rw [dilationBarrier_pricingOperator]
  exact (dilationBarrier_le_of_nonneg_time hD ht).trans hm

end AmericanPutConvexity.Stopping
