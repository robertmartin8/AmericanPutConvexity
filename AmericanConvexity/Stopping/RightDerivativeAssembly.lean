import AmericanConvexity.Stopping.RightIntegralDerivative

/-! # Right-derivative assembly with a vanishing increment remainder -/

namespace AmericanConvexity.Stopping

open Set Filter
open scoped Topology

theorem hasDerivWithinAt_Ici_of_increment_remainder
    {F H J R : ℝ → ℝ} {t dH dJ : ℝ}
    (hH : HasDerivWithinAt H dH (Ici t) t) (hJ : HasDerivWithinAt J dJ (Ici t) t)
    (hR : Tendsto (fun r => R r/(r-t)) (𝓝[>] t) (𝓝 0))
    (he : ∀ᶠ r in 𝓝[>] t, F r-F t = (H r-H t)+(J r-J t)+R r) :
    HasDerivWithinAt F (dH+dJ) (Ici t) t := by
  have hh := (hasDerivWithinAt_iff_tendsto_slope' (by simp : t ∉ Ioi t)).mp (hH.add hJ).Ioi_of_Ici
  have hl := hh.add hR
  simp only [add_zero] at hl
  apply HasDerivWithinAt.Ici_of_Ioi
  apply (hasDerivWithinAt_iff_tendsto_slope' (by simp : t ∉ Ioi t)).mpr
  apply hl.congr'
  filter_upwards [he] with r hr
  simp only [slope_def_field,Pi.add_apply]
  rw [hr]
  ring

theorem tendsto_sub_nhdsGT (t : ℝ) :
    Tendsto (fun r : ℝ => r-t) (𝓝[>] t) (𝓝[>] (0 : ℝ)) := by
  have hc : Continuous (fun r : ℝ => r-t) := by fun_prop
  have hn : Tendsto (fun r : ℝ => r-t) (𝓝[>] t) (𝓝 (0 : ℝ)) := by
    simpa only [sub_self] using (hc.tendsto t).mono_left
      (nhdsWithin_le_nhds : 𝓝[>] t ≤ 𝓝 t)
  apply tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within _ hn
  filter_upwards [self_mem_nhdsWithin] with r hr
  change 0 < r-t
  exact sub_pos.mpr (show t < r from hr)

end AmericanConvexity.Stopping
