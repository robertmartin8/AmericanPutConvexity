import AmericanPutConvexity.Stopping.ActualTimeDerivativeContinuity

/-! # Exact continuation-side spatial-curvature trace at actual contact

The pricing PDE and the proved joint traces of the time derivative, premium,
and spatial gradient identify the premium's second spatial derivative limit.
This is a trace within continuation, not a second derivative across exercise.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalIntrinsicPremium_deriv2_tendsto_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1)
      (𝓝[canonicalContinuationRegion k h] (canonicalLogBoundary k h t,t))
      (𝓝 (k-h*Real.exp (canonicalLogBoundary k h t))) := by
  let F : ℝ × ℝ → ℝ := fun z => deriv (canonicalPrice k h z.1) z.2 +
    k-h*Real.exp z.1-(k-h-1)*deriv (fun y => canonicalIntrinsicPremium k h y z.2) z.1 +
      k*canonicalIntrinsicPremium k h z.1 z.2
  have hg := canonicalIntrinsicPremium_gradient_continuousAt
    (x := canonicalLogBoundary k h t) hk hh hhk ht
  have hp := (canonicalIntrinsicPremium_continuous (h := h) hk.le).continuousAt
    (x := (canonicalLogBoundary k h t,t))
  have he : ContinuousAt (fun z : ℝ × ℝ => Real.exp z.1) (canonicalLogBoundary k h t,t) := by fun_prop
  have hF : ContinuousAt F (canonicalLogBoundary k h t,t) :=
    (((canonicalPrice_time_deriv_continuousAt_contact hk hh hhk ht).add continuousAt_const).sub
      (continuousAt_const.mul he)).sub (continuousAt_const.mul hg) |>.add (continuousAt_const.mul hp)
  have hval : F (canonicalLogBoundary k h t,t) = k-h*Real.exp (canonicalLogBoundary k h t) := by
    dsimp only [F]
    rw [canonicalPrice_time_deriv_contact hk hh hhk ht,
      canonicalIntrinsicPremium_boundary_zero hk hh hhk ht,
      canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht]
    ring
  have hlim := hF.tendsto.mono_left (nhdsWithin_le_nhds (s := canonicalContinuationRegion k h))
  rw [hval] at hlim
  apply hlim.congr'
  filter_upwards [self_mem_nhdsWithin] with z hz
  have hpde := canonicalIntrinsicPremium_equation hk.le hz
  have hdt : deriv (canonicalIntrinsicPremium k h z.1) z.2 = deriv (canonicalPrice k h z.1) z.2 :=
    deriv_sub_const (1-Real.exp z.1)
  rw [hdt] at hpde
  dsimp only [F]
  linarith

theorem zeroDividend_canonicalIntrinsicPremium_deriv2_tendsto_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (deriv (fun y => canonicalIntrinsicPremium k 0 y z.2)) z.1)
      (𝓝[canonicalContinuationRegion k 0] (canonicalLogBoundary k 0 t,t)) (𝓝 k) := by
  simpa only [zero_mul,sub_zero] using
    canonicalIntrinsicPremium_deriv2_tendsto_contact hk le_rfl hk.le ht

theorem liuRange_canonicalIntrinsicPremium_deriv2_tendsto_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    Tendsto (fun z : ℝ × ℝ => deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1)
      (𝓝[canonicalContinuationRegion k h] (canonicalLogBoundary k h t,t))
      (𝓝 (k-h*Real.exp (canonicalLogBoundary k h t))) :=
  canonicalIntrinsicPremium_deriv2_tendsto_contact (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
