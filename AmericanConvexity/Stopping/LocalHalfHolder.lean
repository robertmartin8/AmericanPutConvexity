import Mathlib.Analysis.Calculus.ContDiff.RCLike
import Mathlib.Analysis.Real.Sqrt

/-! # Local square-root moduli and C1 multipliers

These elementary transfer rules preserve a one-half Holder bound under
positive time rescaling, local equality, and multiplication by a C1 factor.
-/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology NNReal

def LocalHalfHolderAt (f : ℝ → ℝ) (t : ℝ) : Prop :=
  ∃ (A : ℝ) (U : Set ℝ), 0 ≤ A ∧ U ∈ 𝓝 t ∧ ∀ s₁ ∈ U, ∀ s₂ ∈ U, s₁ < s₂ →
    ‖f s₂-f s₁‖ ≤ A*Real.sqrt (s₂-s₁)

theorem LocalHalfHolderAt.congr {f g : ℝ → ℝ} {t : ℝ}
    (hf : LocalHalfHolderAt f t) (he : g =ᶠ[𝓝 t] f) : LocalHalfHolderAt g t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  refine ⟨A,U ∩ {s | g s = f s},hA,inter_mem hU he,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  rw [hs₂.2,hs₁.2]
  exact hbound s₁ hs₁.1 s₂ hs₂.1 hst

theorem LocalHalfHolderAt.positive_rescale {f : ℝ → ℝ} {a t : ℝ}
    (hf : LocalHalfHolderAt f (a*t)) (ha : 0 < a) :
    LocalHalfHolderAt (fun s => f (a*s)) t := by
  obtain ⟨A,U,hA,hU,hbound⟩ := hf
  refine ⟨A*Real.sqrt a,(fun s => a*s) ⁻¹' U,by positivity,
    (show ContinuousAt (fun s : ℝ => a*s) t by fun_prop).preimage_mem_nhds hU,?_⟩
  intro s₁ hs₁ s₂ hs₂ hst
  have he := hbound (a*s₁) hs₁ (a*s₂) hs₂ (mul_lt_mul_of_pos_left hst ha)
  rw [← mul_sub,Real.sqrt_mul ha.le] at he
  simpa only [mul_assoc] using he

theorem LocalHalfHolderAt.mul_contDiffAt {f g : ℝ → ℝ} {t : ℝ}
    (hf : LocalHalfHolderAt f t) (hfc : ContinuousAt f t) (hg : ContDiffAt ℝ 1 g t) :
    LocalHalfHolderAt (fun s => g s*f s) t := by
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
  have hsmall : s₂-s₁ ≤ 1 := by linarith [hs₁.2.1,hs₂.2.2]
  have hdelta : s₂-s₁ ≤ Real.sqrt (s₂-s₁) := Real.le_sqrt_self_iff.mpr hsmall
  have hfBound := hbound s₁ hs₁.1.1.1.1 s₂ hs₂.1.1.1.1 hst
  have hgBound : ‖g s₂-g s₁‖ ≤ (M : ℝ)*Real.sqrt (s₂-s₁) := by
    have he : ‖g s₂-g s₁‖ ≤ (M : ℝ)*(s₂-s₁) := by
      simpa only [dist_eq_norm,Real.norm_of_nonneg (sub_nonneg.mpr hst.le)] using
        hLip.dist_le_mul s₂ hs₂.1.1.1.2 s₁ hs₁.1.1.1.2
    exact he.trans (mul_le_mul_of_nonneg_left hdelta M.coe_nonneg)
  calc
    _ = ‖g s₂*(f s₂-f s₁)+(g s₂-g s₁)*f s₁‖ := by congr 1; ring
    _ ≤ ‖g s₂*(f s₂-f s₁)‖+‖(g s₂-g s₁)*f s₁‖ := norm_add_le _ _
    _ = ‖g s₂‖*‖f s₂-f s₁‖+‖g s₂-g s₁‖*‖f s₁‖ := by rw [norm_mul,norm_mul]
    _ ≤ B*(A*Real.sqrt (s₂-s₁))+((M : ℝ)*Real.sqrt (s₂-s₁))*C :=
      add_le_add (mul_le_mul hs₂.1.2 hfBound (norm_nonneg _) hB)
        (mul_le_mul hgBound hs₁.1.1.2 (norm_nonneg _) (by positivity))
    _ = _ := by ring

end AmericanConvexity.Stopping
