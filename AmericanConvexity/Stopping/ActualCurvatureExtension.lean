import AmericanConvexity.Stopping.ActualPriceC1
import AmericanConvexity.Stopping.ActualSpatialSecondTrace
import Mathlib.Analysis.Calculus.FDeriv.Extend

/-! # Continuous extension of continuation-side premium curvature

The PDE expression extends the spatial curvature continuously to contact.
It is not the actual second derivative on the exercise side. The gradient
has this extension as its genuine one-sided derivative at contact.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def canonicalPremiumCurvatureExtension (k h : ℝ) (z : ℝ × ℝ) : ℝ :=
  deriv (canonicalPrice k h z.1) z.2 + k-h*Real.exp z.1 -
    (k-h-1)*deriv (fun y => canonicalIntrinsicPremium k h y z.2) z.1 +
      k*canonicalIntrinsicPremium k h z.1 z.2

theorem canonicalPremiumCurvatureExtension_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (canonicalPremiumCurvatureExtension k h) (x,t) := by
  have hp := (canonicalIntrinsicPremium_continuous (h := h) hk.le).continuousAt (x := (x,t))
  have hg := canonicalIntrinsicPremium_gradient_continuousAt (x := x) hk hh hhk ht
  have he : ContinuousAt (fun z : ℝ × ℝ => Real.exp z.1) (x,t) := by fun_prop
  exact (((canonicalPrice_time_deriv_continuousAt hk hh hhk ht).add continuousAt_const).sub
    (continuousAt_const.mul he)).sub (continuousAt_const.mul hg) |>.add (continuousAt_const.mul hp)

theorem canonicalPremiumCurvatureExtension_eq_deriv2 {k h : ℝ} (hk : 0 ≤ k)
    {z : ℝ × ℝ} (hz : z ∈ canonicalContinuationRegion k h) :
    canonicalPremiumCurvatureExtension k h z =
      deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1 := by
  have hpde := canonicalIntrinsicPremium_equation hk hz
  have hdt : deriv (canonicalIntrinsicPremium k h z.1) z.2 = deriv (canonicalPrice k h z.1) z.2 :=
    deriv_sub_const (1-Real.exp z.1)
  rw [hdt] at hpde
  unfold canonicalPremiumCurvatureExtension
  linarith

theorem canonicalPremiumCurvatureExtension_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    canonicalPremiumCurvatureExtension k h (canonicalLogBoundary k h t,t) =
      k-h*Real.exp (canonicalLogBoundary k h t) := by
  unfold canonicalPremiumCurvatureExtension
  rw [canonicalPrice_time_deriv_contact hk hh hhk ht,
    canonicalIntrinsicPremium_boundary_zero hk hh hhk ht,
    canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht]
  ring

theorem canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivWithinAt (deriv (fun x => canonicalIntrinsicPremium k h x t))
      (k-h*Real.exp (canonicalLogBoundary k h t))
      (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) := by
  have hg := canonicalIntrinsicPremium_gradient_continuousAt
    (x := canonicalLogBoundary k h t) hk hh hhk ht
  have hgs : ContinuousAt (deriv (fun x => canonicalIntrinsicPremium k h x t))
      (canonicalLogBoundary k h t) :=
    hg.comp (f := fun x : ℝ => (x,t)) (by fun_prop)
  have hmap : Tendsto (fun x : ℝ => (x,t)) (𝓝[>] (canonicalLogBoundary k h t))
      (𝓝[canonicalContinuationRegion k h] (canonicalLogBoundary k h t,t)) := by
    apply tendsto_nhdsWithin_iff.mpr
    refine ⟨(show ContinuousAt (fun x : ℝ => (x,t)) (canonicalLogBoundary k h t) by
      fun_prop).tendsto.mono_left nhdsWithin_le_nhds,?_⟩
    filter_upwards [self_mem_nhdsWithin] with x hx
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨ht,hx⟩
  have hlim := (canonicalIntrinsicPremium_deriv2_tendsto_contact hk hh hhk ht).comp hmap
  apply hasDerivWithinAt_Ici_of_tendsto_deriv
    (s := Ioi (canonicalLogBoundary k h t)) ?_ hgs.continuousWithinAt self_mem_nhdsWithin hlim
  intro x hx
  have hz : (x,t) ∈ canonicalContinuationRegion k h := by
    rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
    exact ⟨ht,hx⟩
  have hd : ContDiffAt ℝ 1 (deriv (fun y => canonicalIntrinsicPremium k h y t)) x :=
    (canonicalIntrinsicPremium_contDiffAt hk.le hz).derivWithin (by norm_num)
  exact (hd.differentiableAt (by norm_num)).differentiableWithinAt

theorem canonicalIntrinsicPremium_gradient_right_slope_tendsto {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun x => deriv (fun y => canonicalIntrinsicPremium k h y t) x /
      (x-canonicalLogBoundary k h t)) (𝓝[>] (canonicalLogBoundary k h t))
      (𝓝 (k-h*Real.exp (canonicalLogBoundary k h t))) := by
  have hd := (canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact hk hh hhk ht).mono
    Ioi_subset_Ici_self
  have hl := (hasDerivWithinAt_iff_tendsto_slope'
    (by simp : canonicalLogBoundary k h t ∉ Ioi (canonicalLogBoundary k h t))).mp hd
  have he : slope (deriv (fun x => canonicalIntrinsicPremium k h x t))
      (canonicalLogBoundary k h t) = fun x =>
        deriv (fun y => canonicalIntrinsicPremium k h y t) x/(x-canonicalLogBoundary k h t) := by
    funext x
    simp only [slope,canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht,
      sub_zero,vsub_eq_sub,smul_eq_mul,div_eq_inv_mul]
  rw [he] at hl
  exact hl

theorem zeroDividend_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    HasDerivWithinAt (deriv (fun x => canonicalIntrinsicPremium k 0 x t)) k
      (Ici (canonicalLogBoundary k 0 t)) (canonicalLogBoundary k 0 t) := by
  simpa only [zero_mul,sub_zero] using
    canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact hk le_rfl hk.le ht

theorem liuRange_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    HasDerivWithinAt (deriv (fun x => canonicalIntrinsicPremium k h x t))
      (k-h*Real.exp (canonicalLogBoundary k h t))
      (Ici (canonicalLogBoundary k h t)) (canonicalLogBoundary k h t) :=
  canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
