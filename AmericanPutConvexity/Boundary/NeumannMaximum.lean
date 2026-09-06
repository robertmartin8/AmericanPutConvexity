import AmericanPutConvexity.Boundary.ParabolicMaximum

/-! # A strict maximum principle with a one-sided Neumann boundary

The moving left endpoint is only continuous. A strictly positive derivative
into the spatial domain excludes a maximum on that endpoint. The derivative
is genuinely one-sided; no derivative of a zero extension or of the boundary
curve is used.
-/

namespace AmericanPutConvexity.Boundary

open Set Filter
open scoped Topology

theorem right_deriv_nonpos_at_max {f : ℝ → ℝ} {x v : ℝ}
    (hd : HasDerivWithinAt f v (Ici x) x)
    (hm : ∀ᶠ y in 𝓝[>] x, f y ≤ f x) : v ≤ 0 := by
  have hl := (hasDerivWithinAt_iff_tendsto_slope' (by simp : x ∉ Ioi x)).mp
    (hd.mono Ioi_subset_Ici_self)
  apply le_of_tendsto hl
  filter_upwards [hm,self_mem_nhdsWithin] with y hy hyx
  simpa only [slope,vsub_eq_sub,smul_eq_mul,div_eq_inv_mul] using
    div_nonpos_of_nonpos_of_nonneg (sub_nonpos.mpr hy) (sub_nonneg.mpr hyx.le)

theorem strict_neumann_parabolic_maximum {u D : ℝ → ℝ → ℝ} {b : ℝ → ℝ}
    {R a T κ : ℝ} (hκ : 0 ≤ κ)
    (hQ : IsCompact (movingStrip b R a T))
    (hb : ContinuousOn b (Icc a T))
    (hu : ContinuousOn (fun z : ℝ × ℝ => u z.1 z.2) (movingStrip b R a T))
    (htd : ∀ x t, a < t → t ≤ T → b t < x → x < R → DifferentiableAt ℝ (u x) t)
    (hpde : ∀ x t, a < t → t ≤ T → b t < x → x < R →
      deriv (u x) t < κ*deriv (deriv (fun y => u y t)) x + D x t*deriv (fun y => u y t) x)
    (hinitial : ∀ x, b a ≤ x → x ≤ R → u x a ≤ 0)
    (hleft : ∀ t, a < t → t ≤ T → ∃ v : ℝ, 0 < v ∧
      HasDerivWithinAt (fun x => u x t) v (Ici (b t)) (b t))
    (hright : ∀ t, a ≤ t → t ≤ T → u R t ≤ 0) :
    ∀ z ∈ movingStrip b R a T, u z.1 z.2 ≤ 0 := by
  intro z hz
  by_contra hn
  have hzpos : 0 < u z.1 z.2 := lt_of_not_ge hn
  obtain ⟨w,hw,hmax⟩ := hQ.exists_isMaxOn ⟨z,hz⟩ hu
  have hwpos : 0 < u w.1 w.2 := hzpos.trans_le (hmax hz)
  obtain ⟨hwa,hwT,hwb,hwR⟩ := hw
  have hat : a < w.2 := lt_of_le_of_ne hwa (by
    intro he
    have hh := hinitial w.1 (by simpa [← he] using hwb) hwR
    have : u w.1 w.2 ≤ 0 := by simpa [he] using hh
    linarith)
  have hxR : w.1 < R := lt_of_le_of_ne hwR (by
    intro he
    have hh := hright w.2 hwa hwT
    rw [← he] at hh
    linarith)
  have hbx : b w.2 < w.1 := lt_of_le_of_ne hwb (by
    intro he
    obtain ⟨v,hv,hd⟩ := hleft w.2 hat hwT
    have hm : ∀ᶠ y in 𝓝[>] (b w.2), u y w.2 ≤ u (b w.2) w.2 := by
      filter_upwards [self_mem_nhdsWithin,nhdsWithin_le_nhds
        (Iio_mem_nhds (show b w.2 < R by linarith))] with y hy hyR
      have hh := hmax (show (y,w.2) ∈ movingStrip b R a T from ⟨hwa,hwT,hy.le,hyR.le⟩)
      change u y w.2 ≤ u w.1 w.2 at hh
      simpa only [he] using hh
    have hn := right_deriv_nonpos_at_max hd hm
    linarith)
  have hspace : ∀ᶠ y in 𝓝 w.1, (y,w.2) ∈ movingStrip b R a T := by
    filter_upwards [Ioo_mem_nhds hbx hxR] with y hy
    exact ⟨hwa,hwT,hy.1.le,hy.2.le⟩
  have hmspace : IsLocalMax (fun y => u y w.2) w.1 := by
    filter_upwards [hspace] with y hy
    exact hmax hy
  have hcspace : ContinuousAt (fun y => u y w.2) w.1 :=
    Tendsto.comp (hu w ⟨hwa,hwT,hwb,hwR⟩) (tendsto_nhdsWithin_iff.mpr
      ⟨continuousAt_id.prodMk continuousAt_const,hspace⟩)
  have hbcont := hb w.2 ⟨hwa,hwT⟩
  have htime : ∀ᶠ s in 𝓝[<] w.2, (w.1,s) ∈ movingStrip b R a T := by
    have hi : ∀ᶠ s in 𝓝[<] w.2, s ∈ Icc a T := by
      filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds hat),self_mem_nhdsWithin] with s hs hs'
      exact ⟨hs.le,(show s < w.2 from hs').le.trans hwT⟩
    have hbsmall : ∀ᶠ s in 𝓝[<] w.2, b s < w.1 :=
      (hbcont.mono_left (le_inf nhdsWithin_le_nhds (le_principal_iff.mpr hi))).eventually
        (Iio_mem_nhds hbx)
    filter_upwards [hi,hbsmall] with s hs hbs
    exact ⟨hs.1,hs.2,hbs.le,hwR⟩
  have hmt : ∀ᶠ s in 𝓝[<] w.2, u w.1 s ≤ u w.1 w.2 := by
    filter_upwards [htime] with s hs
    exact hmax hs
  have hdt := deriv_nonneg_at_left_max (htd w.1 w.2 hat hwT hbx hxR) hmt
  have hdxx := second_deriv_nonpos_at_local_max hmspace hcspace
  have hineq := hpde w.1 w.2 hat hwT hbx hxR
  rw [hmspace.deriv_eq_zero,mul_zero,add_zero] at hineq
  have hsign := mul_nonpos_of_nonneg_of_nonpos hκ hdxx
  linarith

end AmericanPutConvexity.Boundary
