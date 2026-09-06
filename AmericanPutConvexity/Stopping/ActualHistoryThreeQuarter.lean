import AmericanPutConvexity.Stopping.HalfHolderHistory
import AmericanPutConvexity.Stopping.ActualGraphRemainder

/-! # Complete local-history three-quarter estimate on the actual graph

The graph supplies its own velocity modulus and uniform motion bound. Any
smaller source window and bounded continuous density with a square-root
modulus on that window satisfy the complete history estimate. Clamping the
graph strictly before the window makes it globally continuous without
changing the integrals or any derivatives used in the proof.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

def LocalHistoryThreeQuarterControl (b : ℝ → ℝ) (A L l u : ℝ) : Prop :=
  ∀ a T, Icc a T ⊆ Ioo l u → T-a ≤ 1 → ∀ (f : ℝ → ℝ) (C D : ℝ),
    0 ≤ C → 0 ≤ D → Continuous f → (∀ s, ‖f s‖ ≤ C) →
    (∀ s ∈ Icc a T, ∀ t ∈ Icc a T, s ≤ t → ‖f t-f s‖ ≤ D*Real.sqrt (t-s)) →
    ∀ t₁ t₂, a < t₁ → t₁ < t₂ → t₂ ≤ T →
      ‖heatHistory b (t₂-a) f t₂-heatHistory b (t₁-a) f t₁‖ ≤
        heatHistoryThreeQuarterConstant A L C D (t₁-a)*(t₂-t₁)^(3/4 : ℝ)

theorem exists_canonicalHeatHistory_threeQuarter_control {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      LocalHistoryThreeQuarterControl (fun s => canonicalLogBoundary k h (s/2)) A L l u := by
  obtain ⟨A,l,u,hA,hl,htU,hmod,_⟩ := exists_canonicalHeatGraph_halfHolder_window hk hh hhk ht
  obtain ⟨L,hL,hvel,_⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  let b := fun s => canonicalLogBoundary k h (max (l/2) s/2)
  have hb : Continuous b := canonicalHeatGraph_clamp_continuous hk hh hhk (half_pos hl)
  have hbe (r : ℝ) (hr : r ∈ Ioo l u) : b =ᶠ[𝓝 r] (fun s => canonicalLogBoundary k h (s/2)) := by
    filter_upwards [Ioi_mem_nhds (show l/2 < r by linarith [hr.1])] with s hs
    dsimp [b]
    rw [max_eq_right hs.le]
  have hderiv (r : ℝ) (hr : r ∈ Ioo l u) :
      deriv b r = deriv (fun s => canonicalLogBoundary k h (s/2)) r := (hbe r hr).deriv_eq
  have hval (r : ℝ) (hr : l ≤ r) : b r = canonicalLogBoundary k h (r/2) := by
    dsimp [b]
    rw [max_eq_right (by linarith : l/2 ≤ r)]
  refine ⟨A,L,l,u,hA,hL,hl,htU,?_⟩
  intro a T hsub hspan f C D hC hD hf hCf hfmod t₁ t₂ hat htt htT
  have haT : a ≤ T := (hat.trans htt).le.trans htT
  have haU : a ∈ Ioo l u := hsub (left_mem_Icc.mpr haT)
  have hs₁ : t₁ ∈ Icc a T := ⟨hat.le,htt.le.trans htT⟩
  have hs₂ : t₂ ∈ Icc a T := ⟨(hat.trans htt).le,htT⟩
  have hs : Icc a t₂ ⊆ Ioo l u := fun _ hr => hsub ⟨hr.1,hr.2.trans htT⟩
  have hd (r : ℝ) (hr : r ∈ Icc a t₂) : DifferentiableAt ℝ b r :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hs hr).1)).differentiableAt.congr_of_eventuallyEq
      (hbe r (hs hr))
  have hv (r : ℝ) (hr : r ∈ Icc a t₂) : ‖deriv b r‖ ≤ L := by
    rw [hderiv r (hs hr)]
    exact hvel r ⟨(hs hr).1.le,(hs hr).2.le⟩
  have hm : ∀ r ∈ Icc a t₂, ∀ s ∈ Icc a t₂, r ≤ s →
      ‖deriv b s-deriv b r‖ ≤ A*Real.sqrt (s-r) := by
    intro r hr s hst hrs
    rw [hderiv s (hs hst),hderiv r (hs hr)]
    rcases eq_or_lt_of_le hrs with heq | hlt
    · simp [heq]
    · exact hmod r (hs hr) s (hs hst) hlt
  have he := heatHistoryFrom_threeQuarter_of_halfHolder hat htt (by linarith) hA hL hC hD hb hf hCf
    hd hv hm (fun r hr s hst hrs => hfmod r ⟨hr.1,hr.2.trans htT⟩ s ⟨hst.1,hst.2.trans htT⟩ hrs)
  have hhistory (r : ℝ) (hr : r ∈ Icc a T) :
      heatHistoryFrom b f a r = heatHistory (fun s => canonicalLogBoundary k h (s/2)) (r-a) f r := by
    rw [← heatHistoryFrom_eq_elapsed _ _ hr.1]
    unfold heatHistoryFrom
    apply setIntegral_congr_fun measurableSet_Ioo
    intro s hsr
    dsimp [movingHeatHistoryKernel]
    rw [hval r (haU.1.le.trans hr.1),hval s (haU.1.le.trans hsr.1.le)]
  rw [hhistory t₂ hs₂,hhistory t₁ hs₁] at he
  exact he

theorem zeroDividend_exists_canonicalHeatHistory_threeQuarter_control {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      LocalHistoryThreeQuarterControl (fun s => canonicalLogBoundary k 0 (s/2)) A L l u :=
  exists_canonicalHeatHistory_threeQuarter_control hk le_rfl hk.le ht

theorem liuRange_exists_canonicalHeatHistory_threeQuarter_control {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ (A L l u : ℝ), 0 ≤ A ∧ 0 ≤ L ∧ 0 < l ∧ t ∈ Ioo l u ∧
      LocalHistoryThreeQuarterControl (fun s => canonicalLogBoundary k h (s/2)) A L l u :=
  exists_canonicalHeatHistory_threeQuarter_control (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
