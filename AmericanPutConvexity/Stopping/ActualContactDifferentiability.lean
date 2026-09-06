import AmericanPutConvexity.Stopping.ActualStockConvexity
import AmericanPutConvexity.Stopping.ActualBoundaryNondegeneracy
import AmericanPutConvexity.Boundary.LipschitzContactDifferentiability

/-! # Actual-price first differentiability at space-time contact

The intrinsic premium has zero full derivative at the exercise boundary.
In particular, the time derivative of the actual price exists there and is
zero. This uses proved local Lipschitz boundary motion, not boundary derivatives.
Continuity of the time derivative and higher boundary regularity remain separate.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalLogBoundary_local_pointwise_lipschitz {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ C : ℝ, 0 ≤ C ∧ ∀ᶠ s in 𝓝 t,
      ‖canonicalLogBoundary k h s-canonicalLogBoundary k h t‖ ≤ C*‖s-t‖ := by
  obtain ⟨C,S,hS,hLip⟩ := canonicalLogBoundary_locallyLipschitzOn hk hh hhk ht
  rw [nhdsWithin_eq_nhds.mpr (Ioi_mem_nhds ht)] at hS
  refine ⟨C,C.coe_nonneg,?_⟩
  filter_upwards [hS] with s hs
  simpa only [dist_eq_norm] using hLip.dist_le_mul s hs t (mem_of_mem_nhds hS)

theorem canonicalIntrinsicPremium_hasFDerivAt_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasFDerivAt (fun z : ℝ × ℝ => canonicalIntrinsicPremium k h z.1 z.2)
      (0 : (ℝ × ℝ) →L[ℝ] ℝ) (canonicalLogBoundary k h t,t) := by
  obtain ⟨C,hC,hLip⟩ := canonicalLogBoundary_local_pointwise_lipschitz hk hh hhk ht
  apply hasFDerivAt_zero_of_flat_lipschitz_contact hC
    (canonicalLogBoundary_continuousAt hk hh hhk ht.le) hLip
  · filter_upwards [Ioi_mem_nhds ht] with s hs
    exact canonicalIntrinsicPremium_boundary_zero hk hh hhk hs
  · filter_upwards [Ioi_mem_nhds ht] with s hs
    intro x
    exact (canonicalPrice_differentiableAt_spatial hk hh hhk hs x).sub
      ((Real.hasDerivAt_exp x).const_sub 1).differentiableAt
  · exact canonicalIntrinsicPremium_gradient_continuousAt hk hh hhk ht
  · exact canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk ht

theorem canonicalIntrinsicPremium_hasDerivAt_time_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivAt (canonicalIntrinsicPremium k h (canonicalLogBoundary k h t)) 0 t := by
  have hd := (canonicalIntrinsicPremium_hasFDerivAt_contact hk hh hhk ht).comp_hasDerivAt t
    ((hasDerivAt_const t (canonicalLogBoundary k h t)).prodMk (hasDerivAt_id t))
  simpa only [Function.comp_def,id_eq,zero_apply] using hd

theorem canonicalPrice_hasDerivAt_time_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivAt (canonicalPrice k h (canonicalLogBoundary k h t)) 0 t := by
  have hd := (canonicalIntrinsicPremium_hasDerivAt_time_contact hk hh hhk ht).add_const
    (1-Real.exp (canonicalLogBoundary k h t))
  convert! hd using 1
  funext s
  dsimp [canonicalIntrinsicPremium]
  ring

theorem canonicalPrice_time_deriv_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (canonicalPrice k h (canonicalLogBoundary k h t)) t = 0 :=
  (canonicalPrice_hasDerivAt_time_contact hk hh hhk ht).deriv

theorem canonicalPrice_hasFDerivAt_contact {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasFDerivAt (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2)
      (-(Real.exp (canonicalLogBoundary k h t) • ContinuousLinearMap.fst ℝ ℝ ℝ))
      (canonicalLogBoundary k h t,t) := by
  have hpay := ((hasFDerivAt_fst (𝕜 := ℝ) (p := (canonicalLogBoundary k h t,t))).exp).const_sub 1
  have hd := (canonicalIntrinsicPremium_hasFDerivAt_contact hk hh hhk ht).add hpay
  have hfun : ((fun z : ℝ × ℝ => canonicalIntrinsicPremium k h z.1 z.2) +
      (fun z : ℝ × ℝ => 1-Real.exp z.1)) = (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) := by
    funext z
    dsimp only [Pi.add_apply]
    dsimp [canonicalIntrinsicPremium]
    ring
  rw [hfun,zero_add] at hd
  exact hd

theorem canonicalPrice_joint_differentiableAt {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    DifferentiableAt ℝ (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) (x,t) := by
  rcases lt_trichotomy x (canonicalLogBoundary k h t) with hx | hx | hx
  · have hb : ContinuousAt (fun z : ℝ × ℝ => canonicalLogBoundary k h z.2) (x,t) := by
      have hb0 := canonicalLogBoundary_continuousAt hk hh hhk ht.le
      exact hb0.comp (x := (x,t)) (f := fun z : ℝ × ℝ => z.2) continuousAt_snd
    have hi : ∀ᶠ z : ℝ × ℝ in 𝓝 (x,t), z.1 < canonicalLogBoundary k h z.2 :=
      continuousAt_fst.eventually_lt hb hx
    have heq : (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2) =ᶠ[𝓝 (x,t)]
        (fun z => 1-Real.exp z.1) := by
      filter_upwards [hi,continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds ht)] with z hz hzt
      exact canonicalPrice_exercise_value hk hh hhk hzt hz.le
    exact ((hasFDerivAt_fst (𝕜 := ℝ) (p := (x,t))).exp.const_sub 1).differentiableAt.congr_of_eventuallyEq heq
  · rw [hx]
    exact (canonicalPrice_hasFDerivAt_contact hk hh hhk ht).differentiableAt
  · have hz : (x,t) ∈ canonicalContinuationRegion k h := by
      rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
      exact ⟨ht,hx⟩
    exact (canonicalPrice_contDiffAt hk.le hz).differentiableAt (by simp)

theorem canonicalPrice_differentiableAt_time {k h x t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    DifferentiableAt ℝ (canonicalPrice k h x) t :=
  (canonicalPrice_joint_differentiableAt hk hh hhk ht).comp t
    (show DifferentiableAt ℝ (fun s : ℝ => (x,s)) t by fun_prop)

theorem zeroDividend_canonicalPrice_hasFDerivAt_contact {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    HasFDerivAt (fun z : ℝ × ℝ => canonicalPrice k 0 z.1 z.2)
      (-(Real.exp (canonicalLogBoundary k 0 t) • ContinuousLinearMap.fst ℝ ℝ ℝ))
      (canonicalLogBoundary k 0 t,t) :=
  canonicalPrice_hasFDerivAt_contact hk le_rfl hk.le ht

theorem liuRange_canonicalPrice_hasFDerivAt_contact {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    HasFDerivAt (fun z : ℝ × ℝ => canonicalPrice k h z.1 z.2)
      (-(Real.exp (canonicalLogBoundary k h t) • ContinuousLinearMap.fst ℝ ℝ ℝ))
      (canonicalLogBoundary k h t,t) :=
  canonicalPrice_hasFDerivAt_contact (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
