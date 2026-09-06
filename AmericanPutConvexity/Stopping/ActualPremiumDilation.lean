import AmericanPutConvexity.Stopping.ActualTemporalModulus
import Mathlib.Analysis.Calculus.IteratedDeriv.FaaDiBruno

/-! # Parabolic dilation of the actual intrinsic premium

The premium is zero in exercise and has strictly positive spatial derivative
in continuation. This lets a spatial maximum test exclude exercise points
without differentiating the free boundary. The dilation uses `(ρ*x, ρ^2*t)`.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalIntrinsicPremium_le_exp {k h : ℝ} (hk : 0 ≤ k) (x t : ℝ) :
    canonicalIntrinsicPremium k h x t ≤ Real.exp x := by
  have hp := (canonicalPrice_bounds (h := h) hk x t).2
  unfold canonicalIntrinsicPremium
  linarith

theorem canonicalIntrinsicPremium_deriv_bounds {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    0 ≤ deriv (fun y => canonicalIntrinsicPremium k h y t) x ∧
      deriv (fun y => canonicalIntrinsicPremium k h y t) x ≤ Real.exp x := by
  refine ⟨(canonicalIntrinsicPremium_monotone_spatial hk hh hhk ht).deriv_nonneg, ?_⟩
  rw [canonicalIntrinsicPremium_spatial_deriv hk hh hhk ht]
  have hp := (canonicalPrice_antitone_spatial (h := h) hk.le t).deriv_nonpos (x := x)
  linarith

theorem canonicalIntrinsicPremium_eq_zero_in_exercise {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hx : x ≤ canonicalLogBoundary k h t) : canonicalIntrinsicPremium k h x t = 0 := by
  simp only [canonicalIntrinsicPremium, canonicalPrice_exercise_value hk hh hhk ht hx, sub_self]

theorem canonicalIntrinsicPremium_deriv_zero_in_exercise {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hx : x ≤ canonicalLogBoundary k h t) :
    deriv (fun y => canonicalIntrinsicPremium k h y t) x = 0 := by
  rw [canonicalIntrinsicPremium_spatial_deriv hk hh hhk ht,
    (canonicalPrice_hasDerivAt_exercise hk hh hhk ht hx).deriv]
  ring

theorem canonicalIntrinsicPremium_deriv_pos_in_continuation {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hx : canonicalLogBoundary k h t < x) :
    0 < deriv (fun y => canonicalIntrinsicPremium k h y t) x := by
  rw [canonicalIntrinsicPremium_spatial_deriv hk hh hhk ht]
  linarith [canonicalPrice_spatial_deriv_gt_exercise hk hh hhk ht hx]

theorem canonicalIntrinsicPremium_joint_contDiffAt {k h x t : ℝ} (hk : 0 ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    ContDiffAt ℝ 2 (fun z : ℝ × ℝ => canonicalIntrinsicPremium k h z.1 z.2) (x,t) :=
  ((canonicalPrice_contDiffAt hk hz).of_le (WithTop.coe_le_coe.mpr le_top)).sub (by fun_prop)

theorem canonicalIntrinsicPremium_equation {k h x t : ℝ} (hk : 0 ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (canonicalIntrinsicPremium k h x) t =
      deriv (deriv (fun y => canonicalIntrinsicPremium k h y t)) x +
        (k-h-1)*deriv (fun y => canonicalIntrinsicPremium k h y t) x -
        k*canonicalIntrinsicPremium k h x t - k + h*Real.exp x := by
  have hp : ContDiffAt ℝ 2 (fun y => canonicalPrice k h y t) x :=
    ((canonicalPrice_contDiffAt hk hz).of_le (WithTop.coe_le_coe.mpr le_top)).comp
      (f := fun y : ℝ => (y,t)) x (by fun_prop)
  have hg : ContDiffAt ℝ 2 (fun y : ℝ => 1-Real.exp y) x := by fun_prop
  have hsecond : deriv (deriv (fun y => canonicalIntrinsicPremium k h y t)) x =
      deriv (deriv (fun y => canonicalPrice k h y t)) x + Real.exp x := by
    simpa only [canonicalIntrinsicPremium,iteratedDeriv_succ,iteratedDeriv_zero,
      deriv_const_sub',Real.deriv_exp,deriv.fun_neg',sub_neg_eq_add] using
      iteratedDeriv_fun_sub (n := 2) hp hg
  have hfirst : deriv (fun y => canonicalIntrinsicPremium k h y t) x =
      deriv (fun y => canonicalPrice k h y t) x + Real.exp x := by
    unfold canonicalIntrinsicPremium
    rw [deriv_fun_sub (hp.differentiableAt (by norm_num)) (hg.differentiableAt (by norm_num))]
    simp only [deriv_const_sub',Real.deriv_exp,sub_neg_eq_add]
  rw [hsecond,hfirst]
  unfold canonicalIntrinsicPremium
  rw [deriv_sub_const,canonicalPrice_continuation_pde hk hz]
  ring

noncomputable def canonicalPremiumDilation (k h ρ x t : ℝ) : ℝ :=
  canonicalIntrinsicPremium k h (ρ*x) (ρ^2*t)-canonicalIntrinsicPremium k h x t

theorem canonicalPremiumDilation_continuous {k h : ℝ} (hk : 0 ≤ k) (ρ : ℝ) :
    Continuous (fun z : ℝ × ℝ => canonicalPremiumDilation k h ρ z.1 z.2) :=
  ((canonicalIntrinsicPremium_continuous hk).comp
    (show Continuous (fun z : ℝ × ℝ => (ρ*z.1,ρ^2*z.2)) by fun_prop)).sub
      (canonicalIntrinsicPremium_continuous hk)

theorem canonicalPremiumDilation_spatial_deriv {k h ρ x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 0 < ρ) (ht : 0 < t) :
    deriv (fun y => canonicalPremiumDilation k h ρ y t) x =
      ρ*deriv (fun y => canonicalIntrinsicPremium k h y (ρ^2*t)) (ρ*x)-
        deriv (fun y => canonicalIntrinsicPremium k h y t) x := by
  have hd (y s : ℝ) (hs : 0 < s) : DifferentiableAt ℝ
      (fun z => canonicalIntrinsicPremium k h z s) y :=
    (canonicalPrice_differentiableAt_spatial hk hh hhk hs y).sub
      ((Real.hasDerivAt_exp y).const_sub 1).differentiableAt
  have hscaled := (hd (ρ*x) (ρ^2*t) (by positivity)).hasDerivAt.comp x
    ((hasDerivAt_id x).const_mul ρ)
  dsimp only [Function.comp_def,id_eq] at hscaled
  unfold canonicalPremiumDilation
  rw [deriv_fun_sub hscaled.differentiableAt (hd x t ht),hscaled.deriv]
  ring

/-- If a nonnegative correction has nonpositive spatial derivative below
strike, a positive maximum of dilation minus correction is in continuation
at both of its price evaluation points. -/
theorem canonicalPremiumDilation_positive_max_continuation {k h ρ x t : ℝ}
    {E : ℝ → ℝ} (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hρ : 0 < ρ) (ht : 0 < t) (hE : 0 ≤ E x) (hdE : DifferentiableAt ℝ E x)
    (hslope : x < 0 → deriv E x ≤ 0)
    (hm : IsLocalMax (fun y => canonicalPremiumDilation k h ρ y t-E y) x)
    (hpos : 0 < canonicalPremiumDilation k h ρ x t-E x) :
    canonicalLogBoundary k h t < x ∧ canonicalLogBoundary k h (ρ^2*t) < ρ*x := by
  have htρ : 0 < ρ^2*t := by positivity
  have hscaled : canonicalLogBoundary k h (ρ^2*t) < ρ*x := by
    by_contra! he
    have hz := canonicalIntrinsicPremium_eq_zero_in_exercise hk hh hhk htρ he
    have hn := canonicalIntrinsicPremium_nonneg (h := h) hk.le x t
    unfold canonicalPremiumDilation at hpos
    rw [hz] at hpos
    linarith
  refine ⟨?_,hscaled⟩
  by_contra! he
  have hx : x < 0 := he.trans_lt (canonicalLogBoundary_neg hk hh hhk ht)
  have hd (s : ℝ) (hs : 0 < s) (y : ℝ) : DifferentiableAt ℝ
      (fun z => canonicalIntrinsicPremium k h z s) y :=
    (canonicalPrice_differentiableAt_spatial hk hh hhk hs y).sub
      ((Real.hasDerivAt_exp y).const_sub 1).differentiableAt
  have hW : DifferentiableAt ℝ (fun y => canonicalPremiumDilation k h ρ y t) x :=
    ((hd (ρ^2*t) htρ (ρ*x)).comp x (differentiableAt_id.const_mul ρ)).sub (hd t ht x)
  have hzero := hm.deriv_eq_zero
  rw [deriv_fun_sub hW hdE,canonicalPremiumDilation_spatial_deriv hk hh hhk hρ ht,
    canonicalIntrinsicPremium_deriv_zero_in_exercise hk hh hhk ht he] at hzero
  have hp := mul_pos hρ (canonicalIntrinsicPremium_deriv_pos_in_continuation hk hh hhk htρ hscaled)
  linarith [hslope hx]

theorem canonicalPremiumDilation_contDiffAt {k h ρ x t : ℝ} (hk : 0 ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h)
    (hzρ : (ρ*x,ρ^2*t) ∈ canonicalContinuationRegion k h) :
    ContDiffAt ℝ 2 (fun z : ℝ × ℝ => canonicalPremiumDilation k h ρ z.1 z.2) (x,t) :=
  ((canonicalIntrinsicPremium_joint_contDiffAt hk hzρ).comp
    (f := fun z : ℝ × ℝ => (ρ*z.1,ρ^2*z.2)) (x,t) (by fun_prop)).sub
      (canonicalIntrinsicPremium_joint_contDiffAt hk hz)

/-- Exact dilation source. The two terms with a minus sign and a factor `k`
are nonpositive for `ρ ≥ 1`; the remaining source is first order in `ρ-1`. -/
theorem canonicalPremiumDilation_equation {k h ρ x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hρ : 0 < ρ) (ht : 0 < t)
    (hz : (x,t) ∈ canonicalContinuationRegion k h)
    (hzρ : (ρ*x,ρ^2*t) ∈ canonicalContinuationRegion k h) :
    pricingOperator k h (fun z => canonicalPremiumDilation k h ρ z.1 z.2) (x,t) =
      (k-h-1)*ρ*(ρ-1)*deriv (fun y => canonicalIntrinsicPremium k h y (ρ^2*t)) (ρ*x) -
        k*(ρ^2-1)*canonicalIntrinsicPremium k h (ρ*x) (ρ^2*t) +
        k*(1-ρ^2) + h*(ρ^2*Real.exp (ρ*x)-Real.exp x) := by
  have hc := canonicalIntrinsicPremium_joint_contDiffAt hk.le hz
  have hcρ := canonicalIntrinsicPremium_joint_contDiffAt hk.le hzρ
  have hs : ContDiffAt ℝ 2 (fun y => canonicalIntrinsicPremium k h y t) x :=
    hc.comp (f := fun y : ℝ => (y,t)) x (by fun_prop)
  have hsρ : ContDiffAt ℝ 2 (fun y => canonicalIntrinsicPremium k h y (ρ^2*t)) (ρ*x) :=
    hcρ.comp (f := fun y : ℝ => (y,ρ^2*t)) (ρ*x) (by fun_prop)
  have hsc : ContDiffAt ℝ 2 (fun y => canonicalIntrinsicPremium k h (ρ*y) (ρ^2*t)) x :=
    hsρ.comp (f := fun y : ℝ => ρ*y) x (by fun_prop)
  have hsecondScaled : deriv (deriv (fun y => canonicalIntrinsicPremium k h (ρ*y) (ρ^2*t))) x =
      ρ^2*deriv (deriv (fun y => canonicalIntrinsicPremium k h y (ρ^2*t))) (ρ*x) := by
    have he := iteratedDeriv_comp_two hsρ
      (show ContDiffAt ℝ 2 (fun y : ℝ => ρ*y) x by fun_prop)
    have hlin : deriv (HMul.hMul ρ : ℝ → ℝ) = fun _ => ρ := by
      funext y
      exact (by simpa only [id_eq,mul_one] using ((hasDerivAt_id y).const_mul ρ).deriv)
    simpa only [Function.comp_def,iteratedDeriv_succ,iteratedDeriv_zero,
      hlin,deriv_const',zero_mul,add_zero,mul_comm] using he
  have hsecond : deriv (deriv (fun y => canonicalPremiumDilation k h ρ y t)) x =
      ρ^2*deriv (deriv (fun y => canonicalIntrinsicPremium k h y (ρ^2*t))) (ρ*x)-
        deriv (deriv (fun y => canonicalIntrinsicPremium k h y t)) x := by
    simpa only [canonicalPremiumDilation,iteratedDeriv_succ,iteratedDeriv_zero,hsecondScaled] using
      iteratedDeriv_fun_sub (n := 2) hsc hs
  have hd : DifferentiableAt ℝ (canonicalIntrinsicPremium k h x) t :=
    (hc.comp (f := fun s : ℝ => (x,s)) t (by fun_prop)).differentiableAt (by norm_num)
  have hdρ : DifferentiableAt ℝ (canonicalIntrinsicPremium k h (ρ*x)) (ρ^2*t) :=
    (hcρ.comp (f := fun s : ℝ => (ρ*x,s)) (ρ^2*t) (by fun_prop)).differentiableAt (by norm_num)
  have hdsc := hdρ.hasDerivAt.comp t ((hasDerivAt_id t).const_mul (ρ^2))
  dsimp only [Function.comp_def,id_eq] at hdsc
  have htime : deriv (canonicalPremiumDilation k h ρ x) t =
      ρ^2*deriv (canonicalIntrinsicPremium k h (ρ*x)) (ρ^2*t)-
        deriv (canonicalIntrinsicPremium k h x) t := by
    unfold canonicalPremiumDilation
    rw [deriv_fun_sub hdsc.differentiableAt hd,hdsc.deriv]
    ring
  unfold pricingOperator
  dsimp only
  rw [htime,hsecond,canonicalPremiumDilation_spatial_deriv hk hh hhk hρ ht,
    canonicalIntrinsicPremium_equation hk.le hzρ,canonicalIntrinsicPremium_equation hk.le hz]
  unfold canonicalPremiumDilation
  ring

end AmericanPutConvexity.Stopping
