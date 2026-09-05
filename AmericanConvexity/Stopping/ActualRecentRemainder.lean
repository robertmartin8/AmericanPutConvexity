import AmericanConvexity.Stopping.ActualFrozenDerivative
import AmericanConvexity.Stopping.ThreeQuarterRecent

/-! # Actual new-source remainder vanishes in the time difference quotient -/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

noncomputable def recentFrozenHistory (b f : ℝ → ℝ) (t δ : ℝ) : ℝ :=
  ∫ u in Ioo 0 δ, frozenHeatHistoryRemainder b f (deriv b t) (f t) (t+δ) (t+δ-u)

theorem canonicalRecentFrozenHistory_bound {k h t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : ContinuousOn f (Ioi 0)) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ T M : ℝ, 0 < T ∧ 0 ≤ M ∧ ∀ δ : ℝ, 0 < δ → δ ≤ T →
      IntegrableOn (fun u => frozenHeatHistoryRemainder
        (fun s => canonicalLogBoundary k h (s/2)) f
        (deriv (fun s => canonicalLogBoundary k h (s/2)) t) (f t) (t+δ) (t+δ-u)) (Ioo 0 δ) ∧
      ‖recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2)) f t δ‖ ≤ M*δ^(5/4 : ℝ) := by
  obtain ⟨A,l,u,hA,hl,htU,hmodB,_⟩ := exists_canonicalHeatGraph_threeQuarter_window hk hh hhk ht
  obtain ⟨L,hL,hv,_⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  obtain ⟨D,V,hD,hV,hmodF⟩ := hm
  let C := ‖f t‖+1
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hfc := (hf t ht).continuousAt (Ioi_mem_nhds ht)
  have hfb : ∀ᶠ s in 𝓝 t, ‖f s‖ ≤ C := by
    filter_upwards [hfc.norm.preimage_mem_nhds (Iio_mem_nhds (lt_add_one ‖f t‖))] with s hs
    exact hs.le
  obtain ⟨T,hT,_,hsub⟩ := exists_short_closed_window
    (inter_mem (inter_mem hV (Ioo_mem_nhds htU.1 htU.2)) hfb)
  let M := 6*(A*C+L*D)/Real.sqrt (2*Real.pi)
  refine ⟨T,M,hT,by dsimp [M]; positivity,?_⟩
  intro δ hδ hδT
  have hwin : Icc t (t+δ) ⊆ Icc (t-T) (t+T) :=
    fun z hz => ⟨by linarith [hz.1],by linarith [hz.2]⟩
  have hU : Icc t (t+δ) ⊆ Ioo l u := fun z hz => (hsub (hwin hz)).1.2
  have hsrc (z : ℝ) (hz : z ∈ Ioo ((t+δ)-δ) (t+δ)) : z ∈ Icc t (t+δ) :=
    ⟨by linarith [hz.1],hz.2.le⟩
  have hs (z : ℝ) (hz : z ∈ Ioo 0 δ) : t+δ-z ∈ Icc t (t+δ) :=
    ⟨by linarith [hz.2],by linarith [hz.1]⟩
  apply frozenHeatHistoryRemainder_recent_threeQuarter hδ hA hL
    (fun z hz => (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU (hsrc z hz)).1)).continuousAt.continuousWithinAt)
    (hf.mono (fun z hz => hl.trans (hU (hsrc z hz)).1))
    (hv t ⟨htU.1.le,htU.2.le⟩)
  · intro z hz
    have hst : t+δ-z ≤ t+δ := by linarith [hz.1]
    have hsmall : Icc (t+δ-z) (t+δ) ⊆ Icc t (t+δ) :=
      fun r hr => ⟨(hs z hz).1.trans hr.1,hr.2⟩
    have he := firstOrder_remainder_of_deriv_deviation hst
      (fun r hr => (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU (hsmall hr)).1)).differentiableAt)
      (fun r hr => threeQuarter_pair_bound_on_subinterval hA hmodB hU (hsmall hr)
        (left_mem_Icc.mpr (by linarith : t ≤ t+δ)))
    simpa only [sub_sub_cancel,add_sub_cancel_left] using he
  · intro z hz
    exact (hsub (hwin (hs z hz))).2
  · intro z hz
    have he := hmodF t (hsub (hwin (left_mem_Icc.mpr (by linarith)))).1.1
      (t+δ-z) (hsub (hwin (hs z hz))).1.1 (by linarith [hz.2])
    exact he.trans (mul_le_mul_of_nonneg_left
      (Real.rpow_le_rpow (by linarith [hz.2] : 0 ≤ t+δ-z-t)
        (by linarith [hz.1]) (by norm_num : (0 : ℝ) ≤ 3/4)) hD)

theorem canonicalRecentFrozenHistory_quotient_tendsto {k h t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : ContinuousOn f (Ioi 0)) (hm : LocalThreeQuarterHolderAt f t) :
    Tendsto (fun δ => recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2)) f t δ/δ)
      (𝓝[>] (0 : ℝ)) (𝓝 0) := by
  obtain ⟨T,M,hT,_,hb⟩ := canonicalRecentFrozenHistory_bound hk hh hhk ht hf hm
  apply quotient_tendsto_zero_of_fiveQuarter_bound (M := M)
  filter_upwards [self_mem_nhdsWithin,
    (nhdsWithin_le_nhds (Iio_mem_nhds hT) : ∀ᶠ δ in 𝓝[>] (0 : ℝ), δ < T)] with δ hδ hδT
  exact (hb δ hδ hδT.le).2

theorem canonicalHeatFlux_recentFrozenHistory_quotient_tendsto {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    Tendsto (fun δ => recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2))
      (canonicalHeatThetaRightFlux k h) t δ/δ) (𝓝[>] (0 : ℝ)) (𝓝 0) := by
  have hm := canonicalHeatThetaRightFlux_threeQuarter hk hh hhk (half_pos ht)
  rw [show 2*(t/2) = t by ring] at hm
  exact canonicalRecentFrozenHistory_quotient_tendsto hk hh hhk ht
    (fun s hs => (canonicalHeatThetaRightFlux_continuousAt hk hh hhk hs).continuousWithinAt) hm

theorem zeroDividend_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    Tendsto (fun δ => recentFrozenHistory (fun s => canonicalLogBoundary k 0 (s/2))
      (canonicalHeatThetaRightFlux k 0) t δ/δ) (𝓝[>] (0 : ℝ)) (𝓝 0) :=
  canonicalHeatFlux_recentFrozenHistory_quotient_tendsto hk le_rfl hk.le ht

theorem liuRange_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    Tendsto (fun δ => recentFrozenHistory (fun s => canonicalLogBoundary k h (s/2))
      (canonicalHeatThetaRightFlux k h) t δ/δ) (𝓝[>] (0 : ℝ)) (𝓝 0) :=
  canonicalHeatFlux_recentFrozenHistory_quotient_tendsto (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
