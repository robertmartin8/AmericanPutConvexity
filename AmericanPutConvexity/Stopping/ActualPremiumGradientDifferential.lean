import AmericanPutConvexity.Stopping.ActualThetaGradientTrace
import AmericanPutConvexity.Stopping.ActualCurvatureExtension

/-! # The full continuation-side differential of the premium gradient

Its spatial coefficient is premium curvature. Its time coefficient is the
spatial derivative of theta, by commutation in the smooth continuation
region. Both have proved joint limits at contact.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

noncomputable def canonicalPremiumGradient (k h : ℝ) (z : ℝ × ℝ) : ℝ :=
  deriv (fun x => canonicalIntrinsicPremium k h x z.2) z.1

theorem canonicalPremiumGradient_contDiffAt {k h : ℝ} {z : ℝ × ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hz : z ∈ canonicalContinuationRegion k h) :
    ContDiffAt ℝ ∞ (canonicalPremiumGradient k h) z := by
  let P := fun y : ℝ × ℝ => canonicalPrice k h y.1 y.2
  have hc := (heatPartial_smoothAt (canonicalPrice_contDiffAt hk.le hz) (1,0)).add
    (show ContDiffAt ℝ ∞ (fun y : ℝ × ℝ => Real.exp y.1) z by fun_prop)
  apply hc.congr_of_eventuallyEq
  filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds hz.1)] with y hyt
  rw [canonicalPremiumGradient,canonicalIntrinsicPremium_spatial_deriv hk hh hhk hyt]
  rw [(heatPartial_time (canonicalPrice_joint_differentiableAt hk hh hhk hyt)).deriv]

theorem canonicalPremiumGradient_time_deriv {k h x t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hz : (x,t) ∈ canonicalContinuationRegion k h) :
    deriv (fun s => canonicalPremiumGradient k h (x,s)) t =
      deriv (fun y => canonicalTheta k h y t) x := by
  have he : (fun s => canonicalPremiumGradient k h (x,s)) =ᶠ[𝓝 t]
      (fun s => deriv (fun y => canonicalPrice k h y s) x+Real.exp x) := by
    filter_upwards [Ioi_mem_nhds hz.1] with s hs
    exact canonicalIntrinsicPremium_spatial_deriv hk hh hhk hs
  rw [he.deriv_eq,deriv_add_const]
  exact canonicalPrice_mixed_derivs_eq hk hh hhk hz

theorem plane_fderiv_eq_partials {F : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hd : DifferentiableAt ℝ F z) :
    fderiv ℝ F z =
      deriv (fun x => F (x,z.2)) z.1 • ContinuousLinearMap.fst ℝ ℝ ℝ+
      deriv (fun t => F (z.1,t)) z.2 • ContinuousLinearMap.snd ℝ ℝ ℝ := by
  rw [(heatPartial_time hd).deriv,(heatPartial_space hd).deriv]
  apply ContinuousLinearMap.ext
  intro v
  have hv : v = v.1 • ((1,0) : ℝ × ℝ)+v.2 • ((0,1) : ℝ × ℝ) := by ext <;> simp
  conv_lhs => rw [hv]
  rw [map_add,map_smul,map_smul]
  change v.1 * (fderiv ℝ F z) (1,0)+v.2 * (fderiv ℝ F z) (0,1) =
    (fderiv ℝ F z) (1,0)*v.1+(fderiv ℝ F z) (0,1)*v.2
  ring

theorem canonicalPremiumGradient_fderiv {k h : ℝ} {z : ℝ × ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k)
    (hz : z ∈ canonicalContinuationRegion k h) :
    fderiv ℝ (canonicalPremiumGradient k h) z =
      canonicalPremiumCurvatureExtension k h z • ContinuousLinearMap.fst ℝ ℝ ℝ+
      deriv (fun x => canonicalTheta k h x z.2) z.1 • ContinuousLinearMap.snd ℝ ℝ ℝ := by
  rw [plane_fderiv_eq_partials ((canonicalPremiumGradient_contDiffAt hk hh hhk hz).differentiableAt (by simp)),
    canonicalPremiumGradient_time_deriv hk hh hhk hz,canonicalPremiumCurvatureExtension_eq_deriv2 hk.le hz]
  rfl

theorem canonicalPremiumGradient_fderiv_tendsto_contact {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fderiv ℝ (canonicalPremiumGradient k h))
      (𝓝[canonicalContinuationRegion k h] (canonicalLogBoundary k h t,t))
      (𝓝 ((k-h*Real.exp (canonicalLogBoundary k h t)) • ContinuousLinearMap.fst ℝ ℝ ℝ+
        canonicalThetaRightFlux k h t • ContinuousLinearMap.snd ℝ ℝ ℝ)) := by
  have hc := (canonicalPremiumCurvatureExtension_continuousAt (x := canonicalLogBoundary k h t)
    hk hh hhk ht).tendsto.mono_left (nhdsWithin_le_nhds (s := canonicalContinuationRegion k h))
  rw [canonicalPremiumCurvatureExtension_contact hk hh hhk ht] at hc
  have hg := (canonicalTheta_gradient_tendsto_contact hk hh hhk ht).mono_left
    (nhdsWithin_mono _ (show canonicalContinuationRegion k h ⊆
      {z : ℝ × ℝ | canonicalLogBoundary k h z.2 < z.1} by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact fun _ hz => hz.2))
  apply ((hc.smul tendsto_const_nhds).add (hg.smul tendsto_const_nhds)).congr'
  filter_upwards [self_mem_nhdsWithin] with z hz
  exact (canonicalPremiumGradient_fderiv hk hh hhk hz).symm

end AmericanPutConvexity.Stopping
