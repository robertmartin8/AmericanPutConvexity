import AmericanPutConvexity.Stopping.HeatHistoryFrozenDecomposition
import AmericanPutConvexity.Stopping.HeatRemainderOverlap
import AmericanPutConvexity.Stopping.HeatRemainderRecent

/-! # Three-quarter estimate for the complete local history

The common-past frozen remainder, new-source remainder, and reference upper
limit are all included. Hypotheses distinguish the common-past Taylor bound
from the new-source bound, whose reference precedes the new sources.
-/

namespace AmericanPutConvexity.Stopping

open Set MeasureTheory

noncomputable def heatHistoryThreeQuarterConstant (A L C D T : ℝ) : ℝ :=
  4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
      (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*T^(1/4 : ℝ)+
    6*(A*C+L*D)/Real.sqrt (2*Real.pi)+3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt T)

theorem heatHistoryFrom_frozen_threeQuarter {b f : ℝ → ℝ} {a t₁ t₂ v c A L C D : ℝ}
    (hat : a < t₁) (htt : t₁ < t₂) (hspan : t₂-a ≤ 1)
    (hA : 0 ≤ A) (hL : 0 ≤ L) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hb : Continuous b) (hf : Continuous f) (hv : ‖v‖ ≤ L) (hc : ‖c‖ ≤ C)
    (hi₁ : IntegrableOn (fun s => movingHeatHistoryKernel b t₁ s*f s) (Ioo a t₁))
    (hi₂ : IntegrableOn (fun s => movingHeatHistoryKernel b t₂ s*f s) (Ioo a t₂))
    (hd : ∀ r ∈ Icc t₁ t₂, DifferentiableAt ℝ b r)
    (hx : ∀ s ∈ Ioo a t₁, ∀ r ∈ Icc t₁ t₂, ‖b r-b s‖ ≤ L*(r-s))
    (hrem : ∀ s ∈ Ioo a t₁, ∀ r ∈ Icc t₁ t₂,
      ‖b r-b s-v*(r-s)‖ ≤ A*(r-s)*Real.sqrt (r-s))
    (hw : ∀ s ∈ Ioo a t₁, ∀ r ∈ Icc t₁ t₂, ‖deriv b r-v‖ ≤ A*Real.sqrt (r-s))
    (hfs : ∀ s ∈ Ioo a t₂, ‖f s‖ ≤ C)
    (hmod : ∀ s ∈ Ioo a t₁, ‖f s-c‖ ≤ D*Real.sqrt (t₁-s))
    (hremNew : ∀ s ∈ Ioo t₁ t₂, ‖b t₂-b s-v*(t₂-s)‖ ≤ A*Real.sqrt (t₂-t₁)*(t₂-s))
    (hmodNew : ∀ s ∈ Ioo t₁ t₂, ‖f s-c‖ ≤ D*Real.sqrt (t₂-t₁)) :
    ‖heatHistoryFrom b f a t₂-heatHistoryFrom b f a t₁‖ ≤
      (4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
          (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*(t₁-a)^(1/4 : ℝ)+
        6*(A*C+L*D)/Real.sqrt (2*Real.pi)+
        3*L*C/(Real.sqrt (2*Real.pi)*Real.sqrt (t₁-a)))*(t₂-t₁)^(3/4 : ℝ) := by
  have hδ : 0 < t₂-t₁ := sub_pos.mpr htt
  have hT : 0 < t₁-a := sub_pos.mpr hat
  have hsrc (u : ℝ) (hu : u ∈ Ioo 0 (t₁-a)) : t₁-u ∈ Ioo a t₁ :=
    ⟨by linarith [hu.2],by linarith [hu.1]⟩
  have hF : AEStronglyMeasurable
      (fun u => frozenHeatHistoryRemainder b f v c t₂ (t₁-u)-
        frozenHeatHistoryRemainder b f v c t₁ (t₁-u)) (volume.restrict (Ioo 0 (t₁-a))) :=
    ((frozenHeatHistoryRemainder_source_continuousOn htt.le hb.continuousOn hf.continuousOn).sub
      (frozenHeatHistoryRemainder_source_continuousOn le_rfl hb.continuousOn hf.continuousOn)).aestronglyMeasurable
      measurableSet_Ioo
  obtain ⟨_,hOld⟩ := frozenHeatHistoryRemainder_overlap_threeQuarter htt hT (by linarith)
    hA hL hC hD hd hv (fun u hu => hx _ (hsrc u hu)) (fun u hu => hrem _ (hsrc u hu))
    (fun u hu => hw _ (hsrc u hu))
    (fun u hu => hfs _ ⟨(hsrc u hu).1,(hsrc u hu).2.trans htt⟩)
    (fun u hu => by simpa only [sub_sub_cancel] using hmod _ (hsrc u hu)) hF
  have hnew (u : ℝ) (hu : u ∈ Ioo 0 (t₂-t₁)) : t₂-u ∈ Ioo t₁ t₂ :=
    ⟨by linarith [hu.2],by linarith [hu.1]⟩
  obtain ⟨_,hNew⟩ := frozenHeatHistoryRemainder_recent_bound (t := t₂) hδ hA hL hb hf hv
    (fun u hu => by simpa only [sub_sub_cancel] using hremNew _ (hnew u hu))
    (fun u hu => hfs _ ⟨hat.trans (hnew u hu).1,(hnew u hu).2⟩)
    (fun u hu => hmodNew _ (hnew u hu))
  have hRef := linearHeatHistory_time_sub_bound hT (by linarith : t₁-a ≤ t₂-a) hL hC hv hc
  rw [show t₂-a-(t₁-a) = t₂-t₁ by ring] at hRef
  have hpower : t₂-t₁ ≤ (t₂-t₁)^(3/4 : ℝ) := by
    simpa only [Real.rpow_one] using Real.rpow_le_rpow_of_exponent_ge hδ
      (by linarith : t₂-t₁ ≤ 1) (by norm_num : (3/4 : ℝ) ≤ 1)
  have hOld' : ‖∫ s in Ioo a t₁, frozenHeatHistoryRemainder b f v c t₂ s-
      frozenHeatHistoryRemainder b f v c t₁ s‖ ≤
      (4*max (6*(A*C+L*D)/Real.sqrt (2*Real.pi))
        (((8+5*L^2)*A*C+8*L*D)/Real.sqrt (2*Real.pi))*(t₁-a)^(1/4 : ℝ))*(t₂-t₁)^(3/4 : ℝ) := by
    rw [setIntegral_Ioo_reflect _ hat.le t₁,sub_self]
    exact hOld
  have hNew' : ‖∫ s in Ioo t₁ t₂, frozenHeatHistoryRemainder b f v c t₂ s‖ ≤
      (6*(A*C+L*D)/Real.sqrt (2*Real.pi))*(t₂-t₁)^(3/4 : ℝ) := by
    rw [setIntegral_Ioo_reflect _ htt.le t₂,sub_self]
    exact hNew.trans (mul_le_mul_of_nonneg_left hpower (by positivity))
  rw [heatHistoryFrom_frozen_decomposition hat htt hi₁ hi₂]
  calc
    _ ≤ ‖∫ s in Ioo a t₁, frozenHeatHistoryRemainder b f v c t₂ s-
        frozenHeatHistoryRemainder b f v c t₁ s‖+
        ‖∫ s in Ioo t₁ t₂, frozenHeatHistoryRemainder b f v c t₂ s‖+
        ‖linearHeatHistoryIntegral v c (t₂-a)-linearHeatHistoryIntegral v c (t₁-a)‖ :=
      (norm_add_le _ _).trans (add_le_add (norm_add_le _ _) le_rfl)
    _ ≤ _ := by
      have he := add_le_add (add_le_add hOld' hNew')
        (hRef.trans (mul_le_mul_of_nonneg_left hpower (by positivity)))
      convert! he using 1
      ring

end AmericanPutConvexity.Stopping
