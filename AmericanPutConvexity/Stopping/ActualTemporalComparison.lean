import AmericanPutConvexity.Stopping.ActualTimeIncrement

/-! # Propagating short-maturity increment bounds to later maturities

This is a comparison theorem for the actual stopping price. It does not assume
a classical solution, free-boundary smoothness, or a dynamic-programming axiom.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalTimeIncrement_le_on_rectangle {k h δ L R T C : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hδ : 0 ≤ δ) (hC : 0 ≤ C)
    (hbottom : ∀ x ∈ Icc L R, canonicalTimeIncrement k h δ x 0 ≤ C)
    (hleft : ∀ t ∈ Icc 0 T, canonicalTimeIncrement k h δ L t ≤ C)
    (hright : ∀ t ∈ Icc 0 T, canonicalTimeIncrement k h δ R t ≤ C) :
    ∀ z ∈ Icc L R ×ˢ Icc 0 T, canonicalTimeIncrement k h δ z.1 z.2 ≤ C := by
  intro z hz
  by_contra! hpos
  let W : ℝ × ℝ → ℝ := fun w => canonicalTimeIncrement k h δ w.1 w.2
  obtain ⟨w,hw,hmax⟩ := (isCompact_Icc.prod isCompact_Icc).exists_isMaxOn ⟨z,hz⟩
    (canonicalTimeIncrement_continuous (h := h) hk.le δ).continuousOn
  have hWC : C < W w := hpos.trans_le (hmax hz)
  have hwL : L < w.1 := by
    by_contra! hn
    have he : w.1 = L := le_antisymm hn hw.1.1
    have hb := hleft w.2 hw.2
    change C < canonicalTimeIncrement k h δ w.1 w.2 at hWC
    rw [he] at hWC
    linarith
  have hwR : w.1 < R := by
    by_contra! hn
    have he : w.1 = R := le_antisymm hw.1.2 hn
    have hb := hright w.2 hw.2
    change C < canonicalTimeIncrement k h δ w.1 w.2 at hWC
    rw [he] at hWC
    linarith
  have hwt : 0 < w.2 := by
    by_contra! hn
    have he : w.2 = 0 := le_antisymm hn hw.2.1
    have hb := hbottom w.1 hw.1
    change C < canonicalTimeIncrement k h δ w.1 w.2 at hWC
    rw [he] at hWC
    linarith
  have hspace : IsLocalMax (fun x => canonicalTimeIncrement k h δ x w.2) w.1 := by
    filter_upwards [Ioo_mem_nhds hwL hwR] with x hx
    exact hmax (show (x,w.2) ∈ Icc L R ×ˢ Icc 0 T from ⟨⟨hx.1.le,hx.2.le⟩,hw.2⟩)
  have htime : ∀ᶠ t in 𝓝[<] w.2,
      canonicalTimeIncrement k h δ w.1 t ≤ canonicalTimeIncrement k h δ w.1 w.2 := by
    filter_upwards [nhdsWithin_le_nhds (Ioi_mem_nhds hwt),self_mem_nhdsWithin] with t ht htw
    exact hmax (show (w.1,t) ∈ Icc L R ×ˢ Icc 0 T from
      ⟨hw.1,ht.le,(show t < w.2 from htw).le.trans hw.2.2⟩)
  exact canonicalTimeIncrement_no_positive_max hk hh hhk hδ hwt hspace htime (hC.trans_lt hWC)

/-- Any uniform bound for the expiry increment is also a uniform bound for
the same maturity increment at every later time. -/
theorem canonicalTimeIncrement_le_of_initial_bound {k h δ C : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hδ : 0 ≤ δ) (hC : 0 ≤ C)
    (hinit : ∀ x, canonicalPrice k h x δ-putPayoff x ≤ C)
    (x : ℝ) {T : ℝ} (hT : 0 ≤ T) : canonicalTimeIncrement k h δ x T ≤ C := by
  apply le_of_forall_pos_le_add
  intro ε hε
  obtain ⟨R₀,hR₀⟩ := eventually_atTop.mp (canonicalPrice_decay_uniform (h := h) hk.le (T+δ) hε)
  let L := min x (Real.log ε)
  let R := max x R₀
  have hLε : Real.exp L ≤ ε :=
    (Real.exp_le_exp.mpr (min_le_right _ _)).trans_eq (Real.exp_log hε)
  apply canonicalTimeIncrement_le_on_rectangle hk hh hhk hδ (by linarith : 0 ≤ C+ε)
    (L := L) (R := R) (T := T) ?_ ?_ ?_ (x,T) ⟨⟨min_le_left _ _,le_max_left _ _⟩,hT,le_rfl⟩
  · intro y _
    have hi := hinit y
    simpa only [canonicalTimeIncrement,zero_add,canonicalPrice_initial hk.le] using
      hi.trans (le_add_of_nonneg_right hε.le)
  · intro t _
    have hu := (canonicalPrice_bounds (h := h) hk.le L (t+δ)).2
    have hl := (le_max_left (1-Real.exp L) 0).trans (canonicalPrice_bounds (h := h) hk.le L t).1
    unfold canonicalTimeIncrement
    linarith
  · intro t ht
    have hu := (hR₀ R (le_max_right _ _) (t+δ) (by linarith [ht.2])).2
    have hl := (putPayoff_nonneg R).trans (canonicalPrice_bounds (h := h) hk.le R t).1
    unfold canonicalTimeIncrement
    linarith

end AmericanPutConvexity.Stopping
