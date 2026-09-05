import AmericanConvexity.Stopping.ActualPremiumGradientDifferential
import AmericanConvexity.Boundary.LipschitzImplicitBoundary
import Mathlib.Analysis.Calculus.ContDiff.Deriv

/-! # The actual boundary derivative and Stefan velocity identity

Convexity makes continuation a convex epigraph. The premium gradient's
full differential extends to its closure away from expiry. Applying the
Lipschitz zero-graph lemma proves, rather than assumes, differentiability
of the actual boundary and identifies its velocity with the theta flux.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

def canonicalContinuationAfter (k h a : ℝ) : Set (ℝ × ℝ) :=
  canonicalContinuationRegion k h ∩ {z | a < z.2}

theorem canonicalContinuationRegion_convex {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    Convex ℝ (canonicalContinuationRegion k h) := by
  rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
  exact (canonicalLogBoundary_convexOn hk hh hhk).convex_strict_epigraph.linear_preimage
    (LinearEquiv.prodComm ℝ ℝ ℝ).toLinearMap

theorem canonicalContinuationAfter_convex {k h a : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    Convex ℝ (canonicalContinuationAfter k h a) :=
  (canonicalContinuationRegion_convex hk hh hhk).inter
    ((convex_Ioi a).linear_preimage (LinearMap.snd ℝ ℝ ℝ))

theorem canonicalContinuationAfter_isOpen {k h a : ℝ} (hk : 0 ≤ k) :
    IsOpen (canonicalContinuationAfter k h a) :=
  (canonicalContinuationRegion_isOpen hk).inter (isOpen_lt continuous_const continuous_snd)

theorem canonicalContinuationAfter_closure_time {k h a : ℝ} {z : ℝ × ℝ}
    (hz : z ∈ closure (canonicalContinuationAfter k h a)) : a ≤ z.2 := by
  have hsub : canonicalContinuationAfter k h a ⊆ {y : ℝ × ℝ | a ≤ y.2} := by
    intro y hy
    change a ≤ y.2
    exact hy.2.le
  exact closure_minimal hsub (isClosed_le continuous_const continuous_snd) hz

theorem canonicalBoundary_mem_closure_continuationAfter {k h a s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) (has : a < s) :
    (canonicalLogBoundary k h s,s) ∈ closure (canonicalContinuationAfter k h a) := by
  have hm : Tendsto (fun ε : ℝ => (canonicalLogBoundary k h s+ε,s)) (𝓝[>] 0)
      (𝓝 (canonicalLogBoundary k h s,s)) := by
    simpa only [add_zero] using
      (show ContinuousAt (fun ε : ℝ => (canonicalLogBoundary k h s+ε,s)) 0 by fun_prop).tendsto.mono_left
        (nhdsWithin_le_nhds (s := Ioi 0))
  apply mem_closure_of_tendsto hm
  filter_upwards [self_mem_nhdsWithin] with ε hε
  refine ⟨?_,has⟩
  rw [canonicalContinuationRegion_eq_logBoundary hk hh hhk]
  exact ⟨hs,lt_add_of_pos_right _ hε⟩

theorem canonicalPremiumGradient_hasFDerivWithinAt_contact {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasFDerivWithinAt (canonicalPremiumGradient k h)
      ((k-h*Real.exp (canonicalLogBoundary k h t)) • ContinuousLinearMap.fst ℝ ℝ ℝ+
        canonicalThetaRightFlux k h t • ContinuousLinearMap.snd ℝ ℝ ℝ)
      (closure (canonicalContinuationAfter k h (t/2))) (canonicalLogBoundary k h t,t) := by
  apply hasFDerivWithinAt_closure_of_tendsto_fderiv
    (fun z hz => ((canonicalPremiumGradient_contDiffAt hk hh hhk hz.1).differentiableAt (by simp)).differentiableWithinAt)
    (canonicalContinuationAfter_convex hk hh hhk) (canonicalContinuationAfter_isOpen hk.le)
  · intro z hz
    have hzt : 0 < z.2 := (half_pos ht).trans_le (canonicalContinuationAfter_closure_time hz)
    exact (canonicalIntrinsicPremium_gradient_continuousAt hk hh hhk hzt).continuousWithinAt
  · exact (canonicalPremiumGradient_fderiv_tendsto_contact hk hh hhk ht).mono_left
      (nhdsWithin_mono _ inter_subset_left)

theorem canonicalLogBoundary_hasDerivAt_velocity {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    HasDerivAt (canonicalLogBoundary k h)
      (-canonicalThetaRightFlux k h t/(k-h*Real.exp (canonicalLogBoundary k h t))) t := by
  obtain ⟨C,hC,hLip⟩ := canonicalLogBoundary_local_pointwise_lipschitz hk hh hhk ht
  apply hasDerivAt_of_lipschitz_zero_graph (canonicalBoundary_forcing_pos hk hh hhk ht).ne' hC
    (canonicalLogBoundary_continuousAt hk hh hhk ht.le) hLip
    (S := closure (canonicalContinuationAfter k h (t/2)))
    (U := canonicalPremiumGradient k h)
  · filter_upwards [Ioi_mem_nhds (half_lt_self ht)] with s hs
    exact canonicalBoundary_mem_closure_continuationAfter hk hh hhk ((half_pos ht).trans hs) hs
  · filter_upwards [Ioi_mem_nhds ht] with s hs
    exact canonicalIntrinsicPremium_boundary_deriv_zero hk hh hhk hs
  · exact canonicalPremiumGradient_hasFDerivWithinAt_contact hk hh hhk ht

theorem canonicalLogBoundary_deriv_eq_velocity {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (canonicalLogBoundary k h) t =
      -canonicalThetaRightFlux k h t/(k-h*Real.exp (canonicalLogBoundary k h t)) :=
  (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk ht).deriv

theorem canonicalThetaRightFlux_eq_stefan {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    canonicalThetaRightFlux k h t =
      -(k-h*Real.exp (canonicalLogBoundary k h t))*deriv (canonicalLogBoundary k h) t := by
  rw [canonicalLogBoundary_deriv_eq_velocity hk hh hhk ht]
  field_simp [(canonicalBoundary_forcing_pos hk hh hhk ht).ne']

theorem canonicalLogBoundary_deriv_neg {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    deriv (canonicalLogBoundary k h) t < 0 := by
  rw [canonicalLogBoundary_deriv_eq_velocity hk hh hhk ht]
  exact div_neg_of_neg_of_pos (neg_neg_of_pos (canonicalThetaRightFlux_pos hk hh hhk ht))
    (canonicalBoundary_forcing_pos hk hh hhk ht)

theorem canonicalLogBoundary_deriv_continuousAt {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContinuousAt (deriv (canonicalLogBoundary k h)) t := by
  have hc : ContinuousAt (fun s => -canonicalThetaRightFlux k h s/
      (k-h*Real.exp (canonicalLogBoundary k h s))) t := by
    apply (canonicalThetaRightFlux_continuousAt hk hh hhk ht).neg.div
    · apply continuousAt_const.sub
      apply continuousAt_const.mul
      exact Real.continuous_exp.continuousAt.comp
        (canonicalLogBoundary_continuousAt hk hh hhk ht.le)
    · exact (canonicalBoundary_forcing_pos hk hh hhk ht).ne'
  apply hc.congr_of_eventuallyEq
  filter_upwards [Ioi_mem_nhds ht] with s hs
  exact canonicalLogBoundary_deriv_eq_velocity hk hh hhk hs

theorem canonicalLogBoundary_contDiffOn_one {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    ContDiffOn ℝ 1 (canonicalLogBoundary k h) (Ioi 0) := by
  rw [contDiffOn_one_iff_derivWithin isOpen_Ioi.uniqueDiffOn]
  refine ⟨fun t ht => (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk ht).differentiableAt.differentiableWithinAt,?_⟩
  apply (show ContinuousOn (deriv (canonicalLogBoundary k h)) (Ioi 0) from
    fun t ht => (canonicalLogBoundary_deriv_continuousAt hk hh hhk ht).continuousWithinAt).congr
  intro t ht
  exact derivWithin_of_isOpen isOpen_Ioi ht

theorem canonicalLogBoundary_oneSidedDerivs_eq {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    derivWithin (canonicalLogBoundary k h) (Iio t) t =
      derivWithin (canonicalLogBoundary k h) (Ioi t) t := by
  have hd := (canonicalLogBoundary_hasDerivAt_velocity hk hh hhk ht).differentiableAt
  rw [hd.derivWithin (uniqueDiffWithinAt_Iio t),hd.derivWithin (uniqueDiffWithinAt_Ioi t)]

theorem zeroDividend_canonicalLogBoundary_hasDerivAt_velocity {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    HasDerivAt (canonicalLogBoundary k 0) (-canonicalThetaRightFlux k 0 t/k) t := by
  simpa only [zero_mul,sub_zero] using canonicalLogBoundary_hasDerivAt_velocity hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_hasDerivAt_velocity {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    HasDerivAt (canonicalLogBoundary k h)
      (-canonicalThetaRightFlux k h t/(k-h*Real.exp (canonicalLogBoundary k h t))) t :=
  canonicalLogBoundary_hasDerivAt_velocity (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
