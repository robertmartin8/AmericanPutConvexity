import AmericanPutConvexity.Stopping.ActualHistoryTimeBounds
import AmericanPutConvexity.Stopping.HeatHistorySourceTime

/-! # Older sources have Lipschitz observation-time dependence

The positive gap from the last old source controls the kernel derivative.
All source integrals and the split at a later local start are genuinely
integrable for the actual graph and bounded continuous density.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory

theorem canonicalHeatHistory_source_integrable {k h a t r C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hat : a < t) (htr : t ≤ r)
    (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) :
    IntegrableOn (fun s => movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) r s*f s)
      (Ioo a t) := by
  obtain ⟨L,hL,_,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := r) hk hh hhk ha
  let b := fun s => canonicalLogBoundary k h (max a s/2)
  have hb : Continuous b := canonicalHeatGraph_clamp_continuous hk hh hhk ha
  have he (s : ℝ) (hs : a ≤ s) : b s = canonicalLogBoundary k h (s/2) := by
    dsimp [b]
    rw [max_eq_right hs]
  have hr : a ≤ r := hat.le.trans htr
  have hi := movingHeatHistoryKernel_source_integrable hat htr hL hb hf
    (fun s hs => by
      rw [he r hr,he s hs.1.le]
      exact hm s ⟨hs.1.le,hs.2.le.trans htr⟩ r ⟨hr,le_rfl⟩ (hs.2.le.trans htr)) hCf
  apply hi.congr_fun _ measurableSet_Ioo
  intro s hs
  dsimp [movingHeatHistoryKernel]
  rw [he r hr,he s hs.1.le]

theorem canonicalHeatHistory_split {k h a₀ a t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀)
    (ha : a₀ < a) (hat : a < t) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) :
    heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t-a₀) f t =
      (∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t s*f s)+
      heatHistory (fun s => canonicalLogBoundary k h (s/2)) (t-a) f t := by
  rw [← heatHistoryFrom_eq_elapsed _ _ (ha.le.trans hat.le),← heatHistoryFrom_eq_elapsed _ _ hat.le]
  unfold heatHistoryFrom
  exact setIntegral_Ioo_split ha.le hat.le
    (canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha hat.le hf hCf)
    (canonicalHeatHistory_source_integrable hk hh hhk (ha₀.trans ha) hat le_rfl hf hCf)

theorem exists_canonicalOlderHistory_time_bound {k h a₀ T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ a t₁ t₂ e, a₀ < a → 0 < e → a+e ≤ t₁ → t₁ ≤ t₂ → t₂ ≤ T →
      ∀ (f : ℝ → ℝ) (C : ℝ), Continuous f → 0 ≤ C → (∀ s, ‖f s‖ ≤ C) →
      ‖(∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₂ s*f s)-
        (∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₁ s*f s)‖ ≤
        (8*L*C*(a-a₀)/(e*Real.sqrt (2*Real.pi*e)))*(t₂-t₁) := by
  obtain ⟨L,hL,_,hbound⟩ := exists_canonicalHeatHistory_time_bounds (T := T) hk hh hhk ha₀
  refine ⟨L,hL,?_⟩
  intro a t₁ t₂ e ha he hgap htt htT f C hf hC hCf
  have hat₁ : a < t₁ := by linarith
  have hat₂ : a < t₂ := hat₁.trans_le htt
  have hi₁ := canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha hat₁.le hf hCf
  have hi₂ := canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha hat₂.le hf hCf
  rw [← integral_sub hi₂ hi₁]
  have hpt (s : ℝ) (hs : s ∈ Ioo a₀ a) :
      ‖movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₂ s*f s-
        movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) t₁ s*f s‖ ≤
        (8*L*C/(e*Real.sqrt (2*Real.pi*e)))*(t₂-t₁) := by
    have hst : s < t₁ := hs.2.trans hat₁
    have hkbound := hbound s ⟨hs.1.le,(hs.2.trans hat₂).le.trans htT⟩
      t₁ ⟨(ha.trans hat₁).le,htt.trans htT⟩ t₂ ⟨(ha.trans hat₂).le,htT⟩ hst htt
    have hegap : e ≤ t₁-s := by linarith [hs.2]
    have hd : e*Real.sqrt (2*Real.pi*e) ≤ (t₁-s)*Real.sqrt (2*Real.pi*(t₁-s)) :=
      mul_le_mul hegap (Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hegap (by positivity)))
        (Real.sqrt_nonneg _) (by linarith)
    rw [← sub_mul,norm_mul]
    calc
      _ ≤ ((8*L/((t₁-s)*Real.sqrt (2*Real.pi*(t₁-s))))*(t₂-t₁))*C :=
        mul_le_mul hkbound (hCf s) (norm_nonneg _) (by positivity)
      _ ≤ ((8*L/(e*Real.sqrt (2*Real.pi*e)))*(t₂-t₁))*C :=
        mul_le_mul_of_nonneg_right (mul_le_mul_of_nonneg_right
          (div_le_div_of_nonneg_left (by positivity) (by positivity) hd) (sub_nonneg.mpr htt)) hC
      _ = _ := by ring
  have hbnd := norm_setIntegral_le_of_norm_le_const
    (measure_Ioo_lt_top : volume (Ioo a₀ a) < ⊤) hpt
  rw [Real.volume_real_Ioo_of_le ha.le] at hbnd
  convert! hbnd using 1
  ring

end AmericanPutConvexity.Stopping
