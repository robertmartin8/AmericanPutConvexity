import AmericanConvexity.Stopping.ActualHistoryTimeBounds
import AmericanConvexity.Stopping.HeatHistoryHolder

/-! # Actual-graph history is one-half Holder in observation time

The actual heat graph supplies the C1 window bounds. Clamping it before
the positive causal start gives a globally continuous representative,
without changing any source-time integral on the window. The density is
only assumed continuous and bounded; its derivative is not used.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology

theorem exists_canonicalHeatHistory_holder_bound {k h a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t₁ t₂, a < t₁ → t₁ < t₂ → t₂ ≤ T →
      ∀ (f : ℝ → ℝ) (C : ℝ), Continuous f → 0 ≤ C → (∀ s, ‖f s‖ ≤ C) →
      ‖heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t₂-a) f t₂-
        heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t₁-a) f t₁‖ ≤
        (34*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
  obtain ⟨L,hL,hv,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := T) hk hh hhk ha
  let b := fun s => canonicalLogBoundary k h (max a s/2)
  have hb : Continuous b := canonicalHeatGraph_clamp_continuous hk hh hhk ha
  have hbeq (s : ℝ) (hs : a ≤ s) : b s = canonicalLogBoundary k h (s/2) := by
    dsimp [b]
    rw [max_eq_right hs]
  have he (s : ℝ) (hs : a < s) : b =ᶠ[𝓝 s] (fun u => canonicalLogBoundary k h (u/2)) := by
    filter_upwards [Ioi_mem_nhds hs] with u hu
    exact hbeq u hu.le
  have hhistory (f : ℝ → ℝ) (s : ℝ) (has : a ≤ s) :
      heatHistoryFrom b f a s = heatHistory (fun u => canonicalLogBoundary k h (u/2)) (s-a) f s := by
    rw [← heatHistoryFrom_eq_elapsed _ _ has]
    unfold heatHistoryFrom
    apply setIntegral_congr_fun measurableSet_Ioo
    intro u hu
    dsimp [movingHeatHistoryKernel]
    rw [hbeq s has,hbeq u hu.1.le]
  refine ⟨L,hL,?_⟩
  intro t₁ t₂ hat htt htT f C hf hC hCf
  have hsub : Icc t₁ t₂ ⊆ Icc a T := fun _ ht => ⟨hat.le.trans ht.1,ht.2.trans htT⟩
  have hd (s : ℝ) (hst : s ∈ Icc t₁ t₂) : DifferentiableAt ℝ b s :=
    ((canonicalHeatGraph_hasDerivAt hk hh hhk (ha.trans_le (hsub hst).1)).congr_of_eventuallyEq
      (he s (hat.trans_le hst.1))).differentiableAt
  have hv' (s : ℝ) (hst : s ∈ Icc t₁ t₂) : ‖deriv b s‖ ≤ L := by
    rw [(he s (hat.trans_le hst.1)).deriv_eq]
    exact hv s (hsub hst)
  have hm' : ∀ s ∈ Icc a t₂, ∀ t ∈ Icc s t₂, ‖b t-b s‖ ≤ L*(t-s) := by
    intro s hs t ht
    rw [hbeq s hs.1,hbeq t (hs.1.trans ht.1)]
    exact hm s ⟨hs.1,hs.2.trans htT⟩ t ⟨hs.1.trans ht.1,ht.2.trans htT⟩ ht.1
  have hbound := heatHistoryFrom_time_sub_bound hat htt hL hC hb hf hCf hd hv' hm'
  rw [hhistory f t₂ (hat.le.trans htt.le),hhistory f t₁ hat.le] at hbound
  exact hbound

theorem zeroDividend_exists_canonicalHeatHistory_holder_bound {k a T : ℝ}
    (hk : 0 < k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t₁ t₂, a < t₁ → t₁ < t₂ → t₂ ≤ T →
      ∀ (f : ℝ → ℝ) (C : ℝ), Continuous f → 0 ≤ C → (∀ s, ‖f s‖ ≤ C) →
      ‖heatHistory (fun s => canonicalLogBoundary k 0 (s/2)) (t₂-a) f t₂-
        heatHistory (fun s => canonicalLogBoundary k 0 (s/2)) (t₁-a) f t₁‖ ≤
        (34*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) :=
  exists_canonicalHeatHistory_holder_bound hk le_rfl hk.le ha

theorem liuRange_exists_canonicalHeatHistory_holder_bound {k h a T : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t₁ t₂, a < t₁ → t₁ < t₂ → t₂ ≤ T →
      ∀ (f : ℝ → ℝ) (C : ℝ), Continuous f → 0 ≤ C → (∀ s, ‖f s‖ ≤ C) →
      ‖heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t₂-a) f t₂-
        heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t₁-a) f t₁‖ ≤
        (34*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) :=
  exists_canonicalHeatHistory_holder_bound (by linarith) hh (by linarith) ha

end AmericanConvexity.Stopping
