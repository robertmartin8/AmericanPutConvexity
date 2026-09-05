import AmericanConvexity.Stopping.LocalHalfHolder
import AmericanConvexity.Stopping.HeatHistoryThreeQuarter

/-! # Local three-quarter moduli and uniform history constants -/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology NNReal

def LocalThreeQuarterHolderAt (f : ℝ → ℝ) (t : ℝ) : Prop :=
  ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 t ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
    ‖f s₂-f s₁‖ ≤ A*(s₂-s₁)^(3/4 : ℝ)

theorem LocalThreeQuarterHolderAt.congr {f g : ℝ → ℝ} {t : ℝ}
    (hf : LocalThreeQuarterHolderAt f t) (he : g =ᶠ[𝓝 t] f) : LocalThreeQuarterHolderAt g t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  refine ⟨A,U ∩ {s | g s = f s},hA,inter_mem hU he,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  rw [hs₂.2,hs₁.2]
  exact hbound s₁ hs₁.1 s₂ hs₂.1 hst

theorem LocalThreeQuarterHolderAt.add_contDiffAt {f g : ℝ → ℝ} {t : ℝ}
    (hf : LocalThreeQuarterHolderAt f t) (hg : ContDiffAt ℝ 1 g t) :
    LocalThreeQuarterHolderAt (fun s => g s+f s) t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  obtain ⟨M,V,hV,hLip⟩ := hg.exists_lipschitzOnWith
  refine ⟨(M : ℝ)+A,U ∩ V ∩ Ioo (t-1/2) (t+1/2),by positivity,
    inter_mem (inter_mem hU hV) (Ioo_mem_nhds (by linarith) (by linarith)),?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have hp : s₂-s₁ ≤ (s₂-s₁)^(3/4 : ℝ) := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_ge (sub_pos.mpr hst)
      (by linarith [hs₁.2.1,hs₂.2.2] : s₂-s₁ ≤ 1) (by norm_num : (3/4 : ℝ) ≤ 1)
  have hgBound : ‖g s₂-g s₁‖ ≤ (M : ℝ)*(s₂-s₁) := by
    simpa only [dist_eq_norm,Real.norm_of_nonneg (sub_nonneg.mpr hst.le)] using
      hLip.dist_le_mul s₂ hs₂.1.2 s₁ hs₁.1.2
  calc
    _ = ‖(g s₂-g s₁)+(f s₂-f s₁)‖ := by congr 1; ring
    _ ≤ ‖g s₂-g s₁‖+‖f s₂-f s₁‖ := norm_add_le _ _
    _ ≤ (M : ℝ)*(s₂-s₁)^(3/4 : ℝ)+A*(s₂-s₁)^(3/4 : ℝ) :=
      add_le_add (hgBound.trans (mul_le_mul_of_nonneg_left hp M.coe_nonneg))
        (hbound s₁ hs₁.1.1 s₂ hs₂.1.1 hst)
    _ = _ := by ring

theorem exists_short_closed_window {U : Set ℝ} {t : ℝ} (hU : U ∈ 𝓝 t) :
    ∃ ε : ℝ, 0 < ε ∧ ε ≤ 1/4 ∧ Icc (t-ε) (t+ε) ⊆ U := by
  obtain ⟨d,hd,hsub⟩ := Metric.mem_nhds_iff.mp hU
  let ε := min (d/4) (1/4)
  have hε : 0 < ε := lt_min (by positivity) (by norm_num)
  refine ⟨ε,hε,min_le_right _ _,?_⟩
  intro s hs
  apply hsub
  rw [Metric.mem_ball,Real.dist_eq]
  have hb : |s-t| ≤ ε := abs_le.mpr ⟨by linarith [hs.1],by linarith [hs.2]⟩
  exact hb.trans_lt ((min_le_left _ _).trans_lt (by linarith : d/4 < d))

noncomputable def heatHistoryThreeQuarterUniformConstant (A L C D e : ℝ) : ℝ :=
  4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
      (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))+
    6*(A*C+L*D)/Real.sqrt (2*Real.pi)+3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt e)

theorem heatHistoryThreeQuarterUniformConstant_nonneg {A L C D e : ℝ}
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hC : 0 ≤ C) (hD : 0 ≤ D) :
    0 ≤ heatHistoryThreeQuarterUniformConstant A L C D e := by
  unfold heatHistoryThreeQuarterUniformConstant
  positivity

theorem heatHistoryThreeQuarterConstant_le_uniform {A L C D e x : ℝ}
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (he : 0 < e) (hex : e ≤ x) (hx1 : x ≤ 1) :
    heatHistoryThreeQuarterConstant A L C D x ≤ heatHistoryThreeQuarterUniformConstant A L C D e := by
  have hx : 0 ≤ x := he.le.trans hex
  have hp : x^(1/4 : ℝ) ≤ 1 := Real.rpow_le_one hx hx1 (by norm_num)
  unfold heatHistoryThreeQuarterConstant heatHistoryThreeQuarterUniformConstant
  apply add_le_add
  · apply add_le_add _ le_rfl
    simpa only [mul_one] using mul_le_mul_of_nonneg_left hp
      (show 0 ≤ 4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
        (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi)) by positivity)
  · apply div_le_div_of_nonneg_left (by positivity) (by positivity)
    exact mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt hex) (Real.sqrt_nonneg _)

end AmericanConvexity.Stopping
