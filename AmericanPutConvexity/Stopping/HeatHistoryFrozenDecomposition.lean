import AmericanPutConvexity.Stopping.HeatHistoryReference
import AmericanPutConvexity.Stopping.HeatHistoryRemainderTime

/-! # Exact source-time decomposition with a common frozen reference

Integrability of the straight-line reference and original histories justifies
every subtraction and interval split. The same reference slope and density
value must be used at both observation times.
-/

namespace AmericanPutConvexity.Stopping

open Set MeasureTheory

theorem linearHeatHistory_source_integrable {a t r : ℝ}
    (hat : a < t) (htr : t ≤ r) (v c : ℝ) :
    IntegrableOn (fun s => heatBoundaryKernel (r-s) (v*(r-s))*c) (Ioo a t) := by
  rw [integrableOn_Ioo_reflect_iff _ hat.le r]
  simp only [sub_sub_cancel]
  exact (linearHeatHistory_integrable (by linarith : 0 < r-a) v c).mono_set
    (fun _ hu => ⟨by linarith [hu.1],hu.2⟩)

theorem frozenHeatHistoryRemainder_source_integrable {b f : ℝ → ℝ} {a t r : ℝ}
    (hat : a < t) (htr : t ≤ r) (v c : ℝ)
    (hi : IntegrableOn (fun s => movingHeatHistoryKernel b r s*f s) (Ioo a t)) :
    IntegrableOn (fun s => frozenHeatHistoryRemainder b f v c r s) (Ioo a t) :=
  hi.sub (linearHeatHistory_source_integrable hat htr v c)

theorem heatHistoryFrom_sub_reference {b f : ℝ → ℝ} {a t v c : ℝ}
    (hat : a < t)
    (hi : IntegrableOn (fun s => movingHeatHistoryKernel b t s*f s) (Ioo a t)) :
    (∫ s in Ioo a t, frozenHeatHistoryRemainder b f v c t s) =
      heatHistoryFrom b f a t-linearHeatHistoryIntegral v c (t-a) := by
  unfold frozenHeatHistoryRemainder
  rw [integral_sub hi (linearHeatHistory_source_integrable hat le_rfl v c)]
  congr 1
  rw [setIntegral_Ioo_reflect _ hat.le t,sub_self]
  simp only [sub_sub_cancel,linearHeatHistoryIntegral]

theorem heatHistoryFrom_frozen_decomposition {b f : ℝ → ℝ} {a t₁ t₂ v c : ℝ}
    (hat : a < t₁) (htt : t₁ < t₂)
    (hi₁ : IntegrableOn (fun s => movingHeatHistoryKernel b t₁ s*f s) (Ioo a t₁))
    (hi₂ : IntegrableOn (fun s => movingHeatHistoryKernel b t₂ s*f s) (Ioo a t₂)) :
    heatHistoryFrom b f a t₂-heatHistoryFrom b f a t₁ =
      (∫ s in Ioo a t₁, frozenHeatHistoryRemainder b f v c t₂ s-
        frozenHeatHistoryRemainder b f v c t₁ s)+
      (∫ s in Ioo t₁ t₂, frozenHeatHistoryRemainder b f v c t₂ s)+
      (linearHeatHistoryIntegral v c (t₂-a)-linearHeatHistoryIntegral v c (t₁-a)) := by
  have hR₁ := frozenHeatHistoryRemainder_source_integrable hat le_rfl v c hi₁
  have hR₂ := frozenHeatHistoryRemainder_source_integrable (hat.trans htt) le_rfl v c hi₂
  have hOld : IntegrableOn (fun s => frozenHeatHistoryRemainder b f v c t₂ s) (Ioo a t₁) :=
    hR₂.mono_set (fun _ hs => ⟨hs.1,hs.2.trans htt⟩)
  have hNew : IntegrableOn (fun s => frozenHeatHistoryRemainder b f v c t₂ s) (Ioo t₁ t₂) :=
    hR₂.mono_set (fun _ hs => ⟨hat.trans hs.1,hs.2⟩)
  have he₁ := heatHistoryFrom_sub_reference (v := v) (c := c) hat hi₁
  have he₂ := heatHistoryFrom_sub_reference (v := v) (c := c) (hat.trans htt) hi₂
  rw [integral_sub hOld hR₁]
  rw [setIntegral_Ioo_split hat.le htt.le hOld hNew] at he₂
  linarith

end AmericanPutConvexity.Stopping
