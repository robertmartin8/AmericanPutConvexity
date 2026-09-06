import AmericanPutConvexity.Stopping.LocalThreeQuarterHolder

/-! # Three-quarter moduli under time rescaling and C1 multiplication -/

namespace AmericanPutConvexity.Stopping

open Set Filter
open scoped Topology NNReal

theorem LocalThreeQuarterHolderAt.positive_rescale {f : ℝ → ℝ} {a t : ℝ}
    (hf : LocalThreeQuarterHolderAt f (a*t)) (ha : 0 < a) :
    LocalThreeQuarterHolderAt (fun s => f (a*s)) t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  refine ⟨A*a^(3/4 : ℝ),(fun s => a*s) ⁻¹' U,by positivity,
    (show ContinuousAt (fun s : ℝ => a*s) t by fun_prop).preimage_mem_nhds hU,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have he := hbound (a*s₁) hs₁ (a*s₂) hs₂ (mul_lt_mul_of_pos_left hst ha)
  rw [← mul_sub,Real.mul_rpow ha.le (sub_nonneg.mpr hst.le)] at he
  simpa only [mul_assoc] using he

theorem LocalThreeQuarterHolderAt.mul_contDiffAt {f g : ℝ → ℝ} {t : ℝ}
    (hf : LocalThreeQuarterHolderAt f t) (hfc : ContinuousAt f t) (hg : ContDiffAt ℝ 1 g t) :
    LocalThreeQuarterHolderAt (fun s => g s*f s) t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  obtain ⟨M,V,hV,hLip⟩ := hg.exists_lipschitzOnWith
  let C := ‖f t‖+1
  let B := ‖g t‖+1
  have hC : 0 ≤ C := by dsimp [C]; positivity
  have hB : 0 ≤ B := by dsimp [B]; positivity
  have hfb : ∀ᶠ s in 𝓝 t, ‖f s‖ ≤ C := by
    filter_upwards [hfc.norm.preimage_mem_nhds (Iio_mem_nhds (lt_add_one ‖f t‖))] with s hs
    exact hs.le
  have hgb : ∀ᶠ s in 𝓝 t, ‖g s‖ ≤ B := by
    filter_upwards [hg.continuousAt.norm.preimage_mem_nhds (Iio_mem_nhds (lt_add_one ‖g t‖))] with s hs
    exact hs.le
  let W := U ∩ V ∩ {s | ‖f s‖ ≤ C} ∩ {s | ‖g s‖ ≤ B} ∩ Ioo (t-1/2) (t+1/2)
  have hW : W ∈ 𝓝 t := inter_mem (inter_mem (inter_mem (inter_mem hU hV) hfb) hgb)
    (Ioo_mem_nhds (by linarith) (by linarith))
  refine ⟨B*A+(M : ℝ)*C,W,by positivity,hW,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have hdelta : s₂-s₁ ≤ (s₂-s₁)^(3/4 : ℝ) := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_ge (sub_pos.mpr hst)
      (by linarith [hs₁.2.1,hs₂.2.2] : s₂-s₁ ≤ 1) (by norm_num : (3/4 : ℝ) ≤ 1)
  have hfBound := hbound s₁ hs₁.1.1.1.1 s₂ hs₂.1.1.1.1 hst
  have hgBound : ‖g s₂-g s₁‖ ≤ (M : ℝ)*(s₂-s₁)^(3/4 : ℝ) := by
    have he : ‖g s₂-g s₁‖ ≤ (M : ℝ)*(s₂-s₁) := by
      simpa only [dist_eq_norm,Real.norm_of_nonneg (sub_nonneg.mpr hst.le)] using
        hLip.dist_le_mul s₂ hs₂.1.1.1.2 s₁ hs₁.1.1.1.2
    exact he.trans (mul_le_mul_of_nonneg_left hdelta M.coe_nonneg)
  calc
    _ = ‖g s₂*(f s₂-f s₁)+(g s₂-g s₁)*f s₁‖ := by congr 1; ring
    _ ≤ ‖g s₂*(f s₂-f s₁)‖+‖(g s₂-g s₁)*f s₁‖ := norm_add_le _ _
    _ = ‖g s₂‖*‖f s₂-f s₁‖+‖g s₂-g s₁‖*‖f s₁‖ := by rw [norm_mul,norm_mul]
    _ ≤ B*(A*(s₂-s₁)^(3/4 : ℝ))+((M : ℝ)*(s₂-s₁)^(3/4 : ℝ))*C :=
      add_le_add (mul_le_mul hs₂.1.2 hfBound (norm_nonneg _) hB)
        (mul_le_mul hgBound hs₁.1.1.2 (norm_nonneg _) (by positivity))
    _ = _ := by ring

end AmericanPutConvexity.Stopping
