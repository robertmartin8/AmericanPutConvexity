import AmericanPutConvexity.Stopping.ActualHistoryThreeQuarter
import AmericanPutConvexity.Stopping.ActualOlderHistory
import AmericanPutConvexity.Stopping.LocalThreeQuarterHolder

/-! # Three-quarter regularity of the actual history from its original start

Only local square-root regularity of the density is needed. Older sources
are Lipschitz in observation time, and the complete recent history has a
uniform three-quarter bound on a neighborhood separated from its new start.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalHeatHistory_local_threeQuarter {k h a₀ t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (hat : a₀ < t)
    (hf : Continuous f) (hC : 0 ≤ C) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hhalf : LocalHalfHolderAt f t) :
    LocalThreeQuarterHolderAt
      (fun r => heatHistory (fun s => canonicalLogBoundary k h (s/2)) (r-a₀) f r) t := by
  obtain ⟨A,L,l,u,hA,hL,_,htU,hcontrol⟩ :=
    exists_canonicalHeatHistory_threeQuarter_control hk hh hhk (ha₀.trans hat)
  obtain ⟨D,V,hD,hV,hmod⟩ := hhalf
  have hS : V ∩ Ioo l u ∩ Ioi a₀ ∈ 𝓝 t :=
    inter_mem (inter_mem hV (Ioo_mem_nhds htU.1 htU.2)) (Ioi_mem_nhds hat)
  obtain ⟨ε,hε,hε1,hsub⟩ := exists_short_closed_window hS
  let a := t-ε
  let T := t+ε
  let e := ε/2
  have he : 0 < e := half_pos hε
  have haT : a ≤ T := by dsimp [a,T]; linarith
  have ha : a₀ < a := (hsub (left_mem_Icc.mpr haT)).2
  have hlocal : Icc a T ⊆ Ioo l u := fun _ hs => (hsub hs).1.2
  have hspan : T-a ≤ 1 := by dsimp [T,a]; linarith
  have hfmod : ∀ s ∈ Icc a T, ∀ r ∈ Icc a T, s ≤ r → ‖f r-f s‖ ≤ D*Real.sqrt (r-s) := by
    intro s hs r hr hsr
    rcases eq_or_lt_of_le hsr with heq | hlt
    · simp [heq]
    · exact hmod s (hsub hs).1.1 r (hsub hr).1.1 hlt
  obtain ⟨J,hJ,hOld⟩ := exists_canonicalOlderHistory_time_bound (T := T) hk hh hhk ha₀
  let K := heatHistoryThreeQuarterUniformConstant A L C D e
  let O := 8*J*C*(a-a₀)/(e*Real.sqrt (2*Real.pi*e))
  have hK : 0 ≤ K := heatHistoryThreeQuarterUniformConstant_nonneg hA hL hC hD
  have hO : 0 ≤ O := by dsimp [O]; positivity
  let W := Ioo (t-ε/2) (t+ε/2)
  have hW : W ∈ 𝓝 t := Ioo_mem_nhds (by linarith) (by linarith)
  refine ⟨O+K,W,add_nonneg hO hK,hW,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have hs₁' : t-ε/2 < s₁ ∧ s₁ < t+ε/2 := hs₁
  have hs₂' : t-ε/2 < s₂ ∧ s₂ < t+ε/2 := hs₂
  have has₁ : a < s₁ := by dsimp [a]; linarith [hs₁'.1]
  have has₂ : a < s₂ := has₁.trans hst
  have hs₂T : s₂ ≤ T := by dsimp [T]; linarith [hs₂'.2]
  have hgap : a+e ≤ s₁ := by dsimp [a,e]; linarith [hs₁'.1]
  have hx1 : s₁-a ≤ 1 := by dsimp [a]; linarith [hs₁'.2]
  have hlocalBound := hcontrol a T hlocal hspan f C D hC hD hf hCf hfmod s₁ s₂ has₁ hst hs₂T
  have hlocalBound' :
      ‖heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₂-a) f s₂-
        heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₁-a) f s₁‖ ≤ K*(s₂-s₁)^(3/4 : ℝ) :=
    hlocalBound.trans (mul_le_mul_of_nonneg_right
      (heatHistoryThreeQuarterConstant_le_uniform hA hL hC hD he (by linarith) hx1)
      (Real.rpow_nonneg (sub_nonneg.mpr hst.le) _))
  have hp : s₂-s₁ ≤ (s₂-s₁)^(3/4 : ℝ) := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_ge (sub_pos.mpr hst)
      (by linarith [hs₁'.1,hs₂'.2] : s₂-s₁ ≤ 1) (by norm_num : (3/4 : ℝ) ≤ 1)
  have hold := (hOld a s₁ s₂ e ha he hgap hst.le hs₂T f C hf hC hCf).trans
    (mul_le_mul_of_nonneg_left hp hO)
  dsimp only
  rw [canonicalHeatHistory_split hk hh hhk ha₀ ha has₂ hf hCf,
    canonicalHeatHistory_split hk hh hhk ha₀ ha has₁ hf hCf]
  calc
    _ = ‖((∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) s₂ s*f s)-
          (∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) s₁ s*f s))+
        (heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₂-a) f s₂-
          heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₁-a) f s₁)‖ := by congr 1; ring
    _ ≤ ‖(∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) s₂ s*f s)-
          (∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) s₁ s*f s)‖+
        ‖heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₂-a) f s₂-
          heatHistory (fun s => canonicalLogBoundary k h (s/2)) (s₁-a) f s₁‖ := norm_add_le _ _
    _ ≤ O*(s₂-s₁)^(3/4 : ℝ)+K*(s₂-s₁)^(3/4 : ℝ) := add_le_add hold hlocalBound'
    _ = _ := by ring

end AmericanPutConvexity.Stopping
