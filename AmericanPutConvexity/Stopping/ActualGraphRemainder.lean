import AmericanPutConvexity.Stopping.ActualVelocityHolder
import AmericanPutConvexity.Stopping.HalfHolderRemainder
import AmericanPutConvexity.Stopping.HeatHistoryLinearization

/-! # Actual C1,1/2 heat graph and uniform first-order remainder

On a positive time interval around every contact, the actual heat graph's
velocity has a square-root modulus and its error from any anchored line has
order (t-s)^(3/2). These are inputs for improving the history estimate beyond
the initial one-half Holder exponent, not an assertion of C2 regularity.
-/

namespace AmericanPutConvexity.Stopping

open Set

theorem exists_canonicalHeatGraph_halfHolder_window {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (A l u : ℝ), 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ →
        ‖deriv (fun s => canonicalLogBoundary k h (s/2)) s₂-
          deriv (fun s => canonicalLogBoundary k h (s/2)) s₁‖ ≤ A*Real.sqrt (s₂-s₁)) ∧
      ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ ≤ s₂ → ∀ r ∈ Icc s₁ s₂,
        ‖canonicalLogBoundary k h (s₂/2)-canonicalLogBoundary k h (s₁/2)-
          deriv (fun s => canonicalLogBoundary k h (s/2)) r*(s₂-s₁)‖ ≤
            A*(s₂-s₁)*Real.sqrt (s₂-s₁) :=
  (canonicalHeatGraph_deriv_holder hk hh hhk ht).exists_positive_deriv_window ht
    (fun _ hs => (canonicalHeatGraph_hasDerivAt hk hh hhk hs).differentiableAt)

theorem zeroDividend_exists_canonicalHeatGraph_halfHolder_window {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ (A l u : ℝ), 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ →
        ‖deriv (fun s => canonicalLogBoundary k 0 (s/2)) s₂-
          deriv (fun s => canonicalLogBoundary k 0 (s/2)) s₁‖ ≤ A*Real.sqrt (s₂-s₁)) ∧
      ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ ≤ s₂ → ∀ r ∈ Icc s₁ s₂,
        ‖canonicalLogBoundary k 0 (s₂/2)-canonicalLogBoundary k 0 (s₁/2)-
          deriv (fun s => canonicalLogBoundary k 0 (s/2)) r*(s₂-s₁)‖ ≤
            A*(s₂-s₁)*Real.sqrt (s₂-s₁) :=
  exists_canonicalHeatGraph_halfHolder_window hk le_rfl hk.le ht

theorem liuRange_exists_canonicalHeatGraph_halfHolder_window {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ (A l u : ℝ), 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ →
        ‖deriv (fun s => canonicalLogBoundary k h (s/2)) s₂-
          deriv (fun s => canonicalLogBoundary k h (s/2)) s₁‖ ≤ A*Real.sqrt (s₂-s₁)) ∧
      ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ ≤ s₂ → ∀ r ∈ Icc s₁ s₂,
        ‖canonicalLogBoundary k h (s₂/2)-canonicalLogBoundary k h (s₁/2)-
          deriv (fun s => canonicalLogBoundary k h (s/2)) r*(s₂-s₁)‖ ≤
            A*(s₂-s₁)*Real.sqrt (s₂-s₁) :=
  exists_canonicalHeatGraph_halfHolder_window (by linarith) hh (by linarith) ht

theorem exists_canonicalHeatGraph_linear_kernel_bound {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (A l u : ℝ), 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      ∀ s₁ ∈ Ioo l u, ∀ s₂ ∈ Ioo l u, s₁ < s₂ → ∀ r ∈ Icc s₁ s₂,
        ‖movingHeatHistoryKernel (fun s => canonicalLogBoundary k h (s/2)) s₂ s₁-
          heatBoundaryKernel (s₂-s₁)
            (deriv (fun s => canonicalLogBoundary k h (s/2)) r*(s₂-s₁))‖ ≤
              3*A/Real.sqrt (2*Real.pi) := by
  obtain ⟨A,l,u,hA,hl,htU,_,hrem⟩ := exists_canonicalHeatGraph_halfHolder_window hk hh hhk ht
  refine ⟨A,l,u,hA,hl,htU,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst r hr
  exact heatBoundaryKernel_linear_remainder_bound (sub_pos.mpr hst)
    (hrem s₁ hs₁ s₂ hs₂ hst.le r hr)

end AmericanPutConvexity.Stopping
