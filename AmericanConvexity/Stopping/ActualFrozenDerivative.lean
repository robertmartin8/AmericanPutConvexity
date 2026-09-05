import AmericanConvexity.Stopping.ActualVelocityThreeQuarter
import AmericanConvexity.Stopping.ThreeQuarterRemainder
import AmericanConvexity.Stopping.FrozenDerivativeIntegrability

/-! # Integrable frozen-history derivatives on the actual heat graph

The reference values are the actual graph velocity and density at the
observation time. Every shorter near-diagonal tail has an integral norm
bounded by a constant times its length to the power 1/4. No second boundary
derivative, or differentiation of the density, is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem exists_canonicalHeatGraph_threeQuarter_window {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ A l u : ℝ, 0 ≤ A ∧ 0 < l ∧ t ∈ Ioo l u ∧
      (∀ x ∈ Ioo l u, ∀ y ∈ Ioo l u, x < y →
        ‖deriv (fun s => canonicalLogBoundary k h (s/2)) y-
          deriv (fun s => canonicalLogBoundary k h (s/2)) x‖ ≤ A*(y-x)^(3/4 : ℝ)) ∧
      ∀ x ∈ Ioo l u, ∀ y ∈ Ioo l u, x ≤ y → ∀ r ∈ Icc x y,
        ‖canonicalLogBoundary k h (y/2)-canonicalLogBoundary k h (x/2)-
          deriv (fun s => canonicalLogBoundary k h (s/2)) r*(y-x)‖ ≤
            A*(y-x)*(y-x)^(3/4 : ℝ) :=
  (canonicalHeatGraph_deriv_threeQuarter hk hh hhk ht).exists_positive_deriv_window ht
    (fun _ hs => (canonicalHeatGraph_hasDerivAt hk hh hhk hs).differentiableAt)

def FrozenDerivativeTailControl (b f : ℝ → ℝ) (t T M : ℝ) : Prop :=
  ∀ δ : ℝ, 0 < δ → δ ≤ T →
    IntegrableOn (fun u => deriv
      (fun r => frozenHeatHistoryRemainder b f (deriv b t) (f t) r (t-u)) t) (Ioo 0 δ) ∧
    ‖∫ u in Ioo 0 δ, deriv
      (fun r => frozenHeatHistoryRemainder b f (deriv b t) (f t) r (t-u)) t‖ ≤ M*δ^(1/4 : ℝ)

theorem canonicalFrozenHistoryDerivative_tail_control {k h t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (hf : ContinuousOn f (Ioi 0)) (hm : LocalThreeQuarterHolderAt f t) :
    ∃ T M : ℝ, 0 < T ∧ T ≤ 1 ∧ T < t ∧ 0 ≤ M ∧
      FrozenDerivativeTailControl (fun s => canonicalLogBoundary k h (s/2)) f t T M := by
  obtain ⟨A,l,u,hA,hl,htU,_,hrem⟩ := exists_canonicalHeatGraph_threeQuarter_window hk hh hhk ht
  obtain ⟨L,hL,hv,hmove⟩ := exists_canonicalHeatGraph_C1_window_bound (T := u) hk hh hhk hl
  obtain ⟨D,V,hD,hV,hmod⟩ := hm
  let C := ‖f t‖+1
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hfc := (hf t ht).continuousAt (Ioi_mem_nhds ht)
  have hfb : ∀ᶠ s in 𝓝 t, ‖f s‖ ≤ C := by
    filter_upwards [hfc.norm.preimage_mem_nhds (Iio_mem_nhds (lt_add_one ‖f t‖))] with s hs
    exact hs.le
  have hS : V ∩ Ioo l u ∩ {s | ‖f s‖ ≤ C} ∈ 𝓝 t :=
    inter_mem (inter_mem hV (Ioo_mem_nhds htU.1 htU.2)) hfb
  obtain ⟨T,hT,hT1,hsub⟩ := exists_short_closed_window hS
  have hTt : T < t := by
    have he := (hsub (show t-T ∈ Icc (t-T) (t+T) by constructor <;> linarith)).1.2.1
    linarith
  let M := 4*(((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))
  refine ⟨T,M,hT,by linarith,hTt,by dsimp [M]; positivity,?_⟩
  intro δ hδ hδT
  have hs (z : ℝ) (hz : z ∈ Ioo (t-δ) t) : z ∈ Icc (t-T) (t+T) :=
    ⟨by linarith [hz.1],by linarith [hz.2]⟩
  have hU (z : ℝ) (hz : z ∈ Ioo (t-δ) t) : z ∈ Ioo l u := (hsub (hs z hz)).1.2
  have hs' (z : ℝ) (hz : z ∈ Ioo 0 δ) : t-z ∈ Ioo (t-δ) t :=
    ⟨by linarith [hz.2],by linarith [hz.1]⟩
  apply frozenHeatHistoryRemainder_deriv_integrable_threeQuarter hδ (by linarith) hA hL
    (canonicalHeatGraph_hasDerivAt hk hh hhk ht).differentiableAt.hasDerivAt
    (fun z hz => (canonicalHeatGraph_hasDerivAt hk hh hhk (hl.trans (hU z hz).1)).continuousAt.continuousWithinAt)
    (hf.mono (fun z hz => hl.trans (hU z hz).1)) (hv t ⟨htU.1.le,htU.2.le⟩)
  · intro z hz
    have he := hmove (t-z) ⟨(hU _ (hs' z hz)).1.le,(hU _ (hs' z hz)).2.le⟩
      t ⟨htU.1.le,htU.2.le⟩ (by linarith [hz.1])
    simpa only [sub_sub_cancel] using he
  · intro z hz
    have he := hrem (t-z) (hU _ (hs' z hz)) t htU (by linarith [hz.1])
      t ⟨by linarith [hz.1],le_rfl⟩
    simpa only [sub_sub_cancel] using he
  · intro z hz
    rw [sub_self,norm_zero]
    exact mul_nonneg hA (Real.rpow_nonneg hz.1.le _)
  · intro z hz
    exact (hsub (hs _ (hs' z hz))).2
  · intro z hz
    rw [norm_sub_rev]
    have he := hmod (t-z) (hsub (hs _ (hs' z hz))).1.1 t
      (hsub (show t ∈ Icc (t-T) (t+T) by constructor <;> linarith)).1.1 (by linarith [hz.1])
    simpa only [sub_sub_cancel] using he

theorem canonicalHeatFlux_frozenHistoryDerivative_tail_control {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ T M : ℝ, 0 < T ∧ T ≤ 1 ∧ T < t ∧ 0 ≤ M ∧
      FrozenDerivativeTailControl (fun s => canonicalLogBoundary k h (s/2))
        (canonicalHeatThetaRightFlux k h) t T M := by
  have hm := canonicalHeatThetaRightFlux_threeQuarter hk hh hhk (half_pos ht)
  rw [show 2*(t/2) = t by ring] at hm
  exact canonicalFrozenHistoryDerivative_tail_control hk hh hhk ht
    (fun s hs => (canonicalHeatThetaRightFlux_continuousAt hk hh hhk hs).continuousWithinAt) hm

theorem zeroDividend_canonicalHeatFlux_frozenHistoryDerivative_tail_control {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ T M : ℝ, 0 < T ∧ T ≤ 1 ∧ T < t ∧ 0 ≤ M ∧
      FrozenDerivativeTailControl (fun s => canonicalLogBoundary k 0 (s/2))
        (canonicalHeatThetaRightFlux k 0) t T M :=
  canonicalHeatFlux_frozenHistoryDerivative_tail_control hk le_rfl hk.le ht

theorem liuRange_canonicalHeatFlux_frozenHistoryDerivative_tail_control {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ T M : ℝ, 0 < T ∧ T ≤ 1 ∧ T < t ∧ 0 ≤ M ∧
      FrozenDerivativeTailControl (fun s => canonicalLogBoundary k h (s/2))
        (canonicalHeatThetaRightFlux k h) t T M :=
  canonicalHeatFlux_frozenHistoryDerivative_tail_control (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
