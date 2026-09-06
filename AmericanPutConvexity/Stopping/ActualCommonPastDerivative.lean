import AmericanPutConvexity.Stopping.ActualFrozenDerivative
import AmericanPutConvexity.Stopping.ActualOlderHistory
import AmericanPutConvexity.Stopping.HeatHistoryFrozenDecomposition
import AmericanPutConvexity.Stopping.FrozenCommonPastDerivative

/-! # The actual graph supplies right differentiation of common-past history

For a continuous bounded density with the proved local three-quarter
modulus, all hypotheses of dominated right differentiation are supplied on
a short positive-time window. The source endpoint and both reference values
are fixed throughout this derivative.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalCommonPast_hasDerivWithinAt_right {k h t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ T : ℝ, 0 < T ∧ T ≤ 1/4 ∧ T < t ∧
      HasDerivWithinAt
        (fun r => ∫ u in Ioo 0 T, frozenHeatHistoryRemainder
          (fun s => canonicalLogBoundary k h (s/2)) f
          (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) r (t-u))
        (∫ u in Ioo 0 T, deriv (fun r => frozenHeatHistoryRemainder
          (fun s => canonicalLogBoundary k h (s/2)) f
          (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) r (t-u)) t) (Ici t) t := by
  obtain ⟨A,l,u,hA,hl,htU,hmodB,hrem⟩ := exists_canonicalHeatGraph_threeQuarter_window hk hh hhk ht
  obtain ⟨L,hL,hv,hmove⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  obtain ⟨D,V,hD,hV,hmodF⟩ := hm
  obtain ⟨T,hT,hT1,hsub⟩ := exists_short_closed_window (inter_mem hV (Ioo_mem_nhds htU.1 htU.2))
  have hTt : T < t := by
    have he := (hsub (show t-T ∈ Icc (t-T) (t+T) by constructor <;> linarith)).2.1
    linarith
  have hU : Icc (t-T) (t+T) ⊆ Ioo l u := fun _ hz => (hsub hz).2
  have hs (z : ℝ) (hz : z ∈ Ioo 0 T) : t-z ∈ Icc (t-T) (t+T) :=
    ⟨by linarith [hz.2],by linarith [hz.1]⟩
  have hobs (r : ℝ) (hr : r ∈ Icc t (t+T)) : r ∈ Icc (t-T) (t+T) :=
    ⟨by linarith [hr.1],hr.2⟩
  have hI (r : ℝ) (hr : r ∈ Icc (t-T) (t+T)) : r ∈ Icc l u :=
    ⟨(hU hr).1.le,(hU hr).2.le⟩
  refine ⟨T,hT,hT1,hTt,?_⟩
  apply frozenCommonPast_hasDerivWithinAt_right hT hT (by linarith) hA hL hD
    (fun r hr => (canonicalHeatGraph_hasDerivAt hk hh hhk (ht.trans_le hr.1)).differentiableAt)
    (hv t ⟨htU.1.le,htU.2.le⟩)
  · intro z hz r hr
    exact hmove (t-z) (hI _ (hs z hz)) r (hI _ (hobs r hr)) (by linarith [hz.1,hr.1])
  · intro z hz r hr
    exact hrem (t-z) (hU (hs z hz)) r (hU (hobs r hr)) (by linarith [hz.1,hr.1])
      t ⟨by linarith [hz.1],hr.1⟩
  · intro z hz r hr
    have hsmall : Icc (t-z) r ⊆ Ioo l u :=
      fun x hx => ⟨(hU (hs z hz)).1.trans_le hx.1,hx.2.trans_lt (hU (hobs r hr)).2⟩
    exact threeQuarter_pair_bound_on_subinterval hA hmodB hsmall
      ⟨by linarith [hz.1,hr.1],le_rfl⟩ ⟨by linarith [hz.1],hr.1⟩
  · intro z _
    exact hCf (t-z)
  · intro z hz
    rw [norm_sub_rev]
    have he := hmodF (t-z) (hsub (hs z hz)).1 t
      (hsub (show t ∈ Icc (t-T) (t+T) by constructor <;> linarith)).1 (by linarith [hz.1])
    simpa only [sub_sub_cancel] using he
  · intro r hr
    have hi := canonicalHeatHistory_source_integrable hk hh hhk
      (by linarith : 0 < t-T) (by linarith : t-T < t) hr.1 hf hCf
    have hR := frozenHeatHistoryRemainder_source_integrable (by linarith : t-T < t) hr.1
      (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) hi
    have he := (integrableOn_Ioo_reflect_iff _ (by linarith : t-T ≤ t) t).mp hR
    simpa only [sub_self,sub_sub_cancel] using he

end AmericanPutConvexity.Stopping
