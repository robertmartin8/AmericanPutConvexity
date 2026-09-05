import AmericanConvexity.Stopping.ActualSpatialRegularity

/-! # Nondegeneracy near the actual exercise boundary

Joint gradient continuity and the interior PDE give a strictly positive lower
bound for the second spatial derivative of the intrinsic premium near every
positive-time boundary point, on the continuation side. No derivative of the
boundary is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalIntrinsicPremium_spatial_deriv {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (fun y => canonicalIntrinsicPremium k h y t) x =
      deriv (fun y => canonicalPrice k h y t) x + Real.exp x := by
  unfold canonicalIntrinsicPremium
  rw [deriv_fun_sub (canonicalPrice_differentiableAt_spatial hk hh hhk ht x)
    ((Real.hasDerivAt_exp x).const_sub 1).differentiableAt]
  simp only [deriv_const_sub',Real.deriv_exp,sub_neg_eq_add]

theorem canonicalIntrinsicPremium_gradient_continuousAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (fun z : ℝ × ℝ => deriv (fun y => canonicalIntrinsicPremium k h y z.2) z.1)
      (x,t) := by
  have he : ContinuousAt (fun z : ℝ × ℝ => Real.exp z.1) (x,t) := by fun_prop
  apply ((canonicalPrice_gradient_continuousAt hk hh hhk ht).add he).congr_of_eventuallyEq
  filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hz
  exact canonicalIntrinsicPremium_spatial_deriv hk hh hhk hz

theorem canonicalIntrinsicPremium_boundary_zero {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    canonicalIntrinsicPremium k h (canonicalLogBoundary k h t) t = 0 := by
  simp only [canonicalIntrinsicPremium,canonicalPrice_value_matching hk hh hhk ht,sub_self]

theorem canonicalIntrinsicPremium_boundary_deriv_zero {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (fun y => canonicalIntrinsicPremium k h y t) (canonicalLogBoundary k h t) = 0 := by
  rw [canonicalIntrinsicPremium_spatial_deriv hk hh hhk ht,
    (canonicalPrice_hasDerivAt_boundary hk hh hhk ht).deriv,neg_add_cancel]

theorem canonicalBoundary_forcing_pos {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    0 < k-h*Real.exp (canonicalLogBoundary k h t) := by
  apply sub_pos.mpr
  calc
    h*Real.exp (canonicalLogBoundary k h t) ≤ k*Real.exp (canonicalLogBoundary k h t) :=
      mul_le_mul_of_nonneg_right hhk (Real.exp_pos _).le
    _ < k := mul_lt_of_lt_one_right hk (Real.exp_lt_one_iff.mpr (canonicalLogBoundary_neg hk hh hhk ht))

/-- A locally uniform positive lower bound, valid at all nearby continuation
points while both space and maturity vary. This is not a second-derivative
trace assertion, and does not assert boundary smoothness. -/
theorem canonicalIntrinsicPremium_deriv2_lower_near_boundary {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∀ᶠ z : ℝ × ℝ in 𝓝 (canonicalLogBoundary k h t,t),
      z ∈ canonicalContinuationRegion k h →
      (k-h*Real.exp (canonicalLogBoundary k h t))/2 ≤
        deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1 := by
  let b := canonicalLogBoundary k h t
  let F : ℝ × ℝ → ℝ := fun z => k-h*Real.exp z.1 -
    (k-h-1)*deriv (fun y => canonicalIntrinsicPremium k h y z.2) z.1 +
      k*canonicalIntrinsicPremium k h z.1 z.2
  have hg := canonicalIntrinsicPremium_gradient_continuousAt (x := b) hk hh hhk ht
  have hp := (canonicalIntrinsicPremium_continuous (h := h) hk.le).continuousAt (x := (b,t))
  have he : ContinuousAt (fun z : ℝ × ℝ => Real.exp z.1) (b,t) := by fun_prop
  have hF : ContinuousAt F (b,t) :=
    (continuousAt_const.sub (continuousAt_const.mul he)).sub (continuousAt_const.mul hg) |>.add
      (continuousAt_const.mul hp)
  have hval : F (b,t) = k-h*Real.exp b := by
    dsimp only [F]
    rw [canonicalIntrinsicPremium_boundary_zero hk hh hhk ht,
      canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht]
    ring
  have hpos := canonicalBoundary_forcing_pos hk hh hhk ht
  have hhalf : (k-h*Real.exp b)/2 < F (b,t) := by rw [hval]; linarith
  filter_upwards [hF.preimage_mem_nhds (Ioi_mem_nhds hhalf)] with z hz
  intro hcont
  have hforce := canonicalIntrinsicPremium_forcing hk.le hcont
  change (k-h*Real.exp b)/2 < F z at hz
  dsimp only [F] at hz
  linarith

theorem zeroDividend_canonicalIntrinsicPremium_deriv2_lower_near_boundary {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∀ᶠ z : ℝ × ℝ in 𝓝 (canonicalLogBoundary k 0 t,t),
      z ∈ canonicalContinuationRegion k 0 →
      k/2 ≤ deriv (deriv (fun y => canonicalIntrinsicPremium k 0 y z.2)) z.1 := by
  simpa only [zero_mul,sub_zero] using
    canonicalIntrinsicPremium_deriv2_lower_near_boundary hk le_rfl hk.le ht

theorem liuRange_canonicalIntrinsicPremium_deriv2_lower_near_boundary {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∀ᶠ z : ℝ × ℝ in 𝓝 (canonicalLogBoundary k h t,t),
      z ∈ canonicalContinuationRegion k h →
      (k-h*Real.exp (canonicalLogBoundary k h t))/2 ≤
        deriv (deriv (fun y => canonicalIntrinsicPremium k h y z.2)) z.1 :=
  canonicalIntrinsicPremium_deriv2_lower_near_boundary (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
