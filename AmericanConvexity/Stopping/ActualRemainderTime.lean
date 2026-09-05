import AmericanConvexity.Stopping.ActualGraphRemainder
import AmericanConvexity.Stopping.HeatHistoryRemainderTime

/-! # Actual graph supplies the frozen-remainder time estimate

The reference slope is the actual velocity at the earlier observation time.
The source density and its frozen value need only a square-root difference
bound. All graph differentiability, motion, and Taylor estimates are proved
for the actual boundary, with no C2 hypothesis.
-/

namespace AmericanConvexity.Stopping

open Set

def FrozenHistoryTimeControl (b : ℝ → ℝ) (A L l u : ℝ) : Prop :=
  ∀ s ∈ Ioo l u, ∀ t₁ ∈ Ioo l u, ∀ t₂ ∈ Ioo l u,
    s < t₁ → t₁ ≤ t₂ → t₂-s ≤ 1 → ∀ (f : ℝ → ℝ) (C D : ℝ),
    0 ≤ D → ‖f s‖ ≤ C → ‖f s-f t₁‖ ≤ D*Real.sqrt (t₁-s) →
      ‖frozenHeatHistoryRemainder b f (deriv b t₁) (f t₁) t₂ s-
        frozenHeatHistoryRemainder b f (deriv b t₁) (f t₁) t₁ s‖ ≤
        (((8+5*L^2)*A*C+8*L*D)/(Real.sqrt (2*Real.pi)*(t₁-s)))*(t₂-t₁)

theorem exists_canonicalHeatGraph_remainder_time_control {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      FrozenHistoryTimeControl (fun s => canonicalLogBoundary k h (s/2)) A L l u := by
  obtain ⟨A,l,u,hA,hl,htU,hholder,hrem⟩ := exists_canonicalHeatGraph_halfHolder_window hk hh hhk ht
  obtain ⟨L,hL,hv,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  refine ⟨A,L,l,u,hA,hL,hl,htU,?_⟩
  intro s hs t₁ ht₁ t₂ ht₂ hst htt hu1 f C D hD hfs hmod
  have hI (z : ℝ) (hz : z ∈ Ioo l u) : z ∈ Icc l u := ⟨hz.1.le,hz.2.le⟩
  have hU (r : ℝ) (hr : r ∈ Icc t₁ t₂) : r ∈ Ioo l u :=
    ⟨ht₁.1.trans_le hr.1,hr.2.trans_lt ht₂.2⟩
  apply frozenHeatHistoryRemainder_time_sub_bound hst htt hu1 hA hL hD
    (fun r hr => (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU r hr).1)).differentiableAt)
    (fun r hr => hm s (hI s hs) r (hI r (hU r hr)) (hst.le.trans hr.1))
    (hv t₁ (hI t₁ ht₁))
    (fun r hr => hrem s hs r (hU r hr) (hst.le.trans hr.1) t₁ ⟨hst.le,hr.1⟩) _ hfs hmod
  intro r hr
  rcases eq_or_lt_of_le hr.1 with heq | hlt
  · rw [heq,sub_self,norm_zero]
    positivity
  · exact (hholder t₁ ht₁ r (hU r hr) hlt).trans
      (mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (by linarith)) hA)

theorem zeroDividend_exists_canonicalHeatGraph_remainder_time_control {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      FrozenHistoryTimeControl (fun s => canonicalLogBoundary k 0 (s/2)) A L l u :=
  exists_canonicalHeatGraph_remainder_time_control hk le_rfl hk.le ht

theorem liuRange_exists_canonicalHeatGraph_remainder_time_control {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      FrozenHistoryTimeControl (fun s => canonicalLogBoundary k h (s/2)) A L l u :=
  exists_canonicalHeatGraph_remainder_time_control (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
