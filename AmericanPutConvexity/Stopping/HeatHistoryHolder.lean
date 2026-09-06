import AmericanPutConvexity.Stopping.HeatHistorySourceTime

/-! # Square-root time regularity of the full boundary history

The common-past term contributes 28 and the recent-source term contributes
6 to the uniform constant. Integrability is proved before splitting the
source-time interval or subtracting the two old integrals.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem heatHistoryFrom_time_sub_bound {b f : ℝ → ℝ} {a t₁ t₂ L C : ℝ}
    (hat : a < t₁) (htt : t₁ < t₂) (hL : 0 ≤ L) (hC : 0 ≤ C)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C)
    (hd : ∀ t ∈ Icc t₁ t₂, DifferentiableAt ℝ b t)
    (hv : ∀ t ∈ Icc t₁ t₂, ‖deriv b t‖ ≤ L)
    (hm : ∀ s ∈ Icc a t₂, ∀ t ∈ Icc s t₂, ‖b t-b s‖ ≤ L*(t-s)) :
    ‖heatHistoryFrom b f a t₂-heatHistoryFrom b f a t₁‖ ≤
      (34*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
  have hi₁ : IntegrableOn (fun s => movingHeatHistoryKernel b t₁ s*f s) (Ioo a t₁) :=
    movingHeatHistoryKernel_source_integrable hat le_rfl hL hb hf
      (fun s hs => hm s ⟨hs.1.le,hs.2.le.trans htt.le⟩ t₁ ⟨hs.2.le,htt.le⟩) hCf
  have hi₂ : IntegrableOn (fun s => movingHeatHistoryKernel b t₂ s*f s) (Ioo a t₁) :=
    movingHeatHistoryKernel_source_integrable hat htt.le hL hb hf
      (fun s hs => hm s ⟨hs.1.le,hs.2.le.trans htt.le⟩ t₂ ⟨hs.2.le.trans htt.le,le_rfl⟩) hCf
  have hiNew : IntegrableOn (fun s => movingHeatHistoryKernel b t₂ s*f s) (Ioo t₁ t₂) :=
    movingHeatHistoryKernel_source_integrable htt le_rfl hL hb hf
      (fun s hs => hm s ⟨hat.le.trans hs.1.le,hs.2.le⟩ t₂ ⟨hs.2.le,le_rfl⟩) hCf
  let old := ∫ s in Ioo a t₁, (movingHeatHistoryKernel b t₂ s-movingHeatHistoryKernel b t₁ s)*f s
  let recent := ∫ s in Ioo t₁ t₂, movingHeatHistoryKernel b t₂ s*f s
  have heOld : old = (∫ s in Ioo a t₁, movingHeatHistoryKernel b t₂ s*f s)-
      (∫ s in Ioo a t₁, movingHeatHistoryKernel b t₁ s*f s) := by
    dsimp [old]
    simp only [sub_mul]
    exact integral_sub hi₂ hi₁
  have he : heatHistoryFrom b f a t₂-heatHistoryFrom b f a t₁ = old+recent := by
    rw [heOld]
    unfold heatHistoryFrom
    rw [setIntegral_Ioo_split hat.le htt.le hi₂ hiNew]
    dsimp [recent]
    ring
  have hOld : ‖old‖ ≤ (28*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
    dsimp [old]
    rw [setIntegral_Ioo_reflect _ hat.le t₁,sub_self]
    apply movingHeatHistoryKernel_overlap_bound htt hL hC hd hv ?_ hCf
    intro u hu t ht
    apply hm (t₁-u) ⟨by linarith [hu.2],by linarith [hu.1]⟩ t
      ⟨by linarith [hu.1,ht.1],ht.2⟩
  have hRecent : ‖recent‖ ≤ (6*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := by
    dsimp [recent]
    rw [setIntegral_Ioo_reflect _ htt.le t₂,sub_self]
    apply movingHeatHistoryKernel_recent_bound (sub_pos.mpr htt) hL ?_ hCf
    intro u hu
    have he := hm (t₂-u) ⟨by linarith [hu.2],by linarith [hu.1]⟩ t₂
      ⟨by linarith [hu.1],le_rfl⟩
    simpa only [sub_sub_cancel] using he
  rw [he]
  calc
    _ ≤ ‖old‖+‖recent‖ := norm_add_le _ _
    _ ≤ (28*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁)+
        (6*L*C/Real.sqrt (2*Real.pi))*Real.sqrt (t₂-t₁) := add_le_add hOld hRecent
    _ = _ := by ring

end AmericanPutConvexity.Stopping
