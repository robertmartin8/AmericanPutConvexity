import AmericanConvexity.Stopping.ExpiryUpperCap
import AmericanConvexity.Stopping.ActualTemporalModulus

/-! # Explicit expiry and temporal bounds for the actual stopping price

Comparison with the constructed square-root cap gives a quantitative bound
at strike. The actual temporal comparison transfers it to all spots and all
nonnegative maturities. No classical-solution premise is used.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem canonicalPrice_le_expiryUpperCap {k h t : ℝ} (hk : 0 < k) (ht : 0 ≤ t) (x : ℝ) :
    canonicalPrice k h x t ≤ expiryUpperCap (k-h-1) x t := by
  apply le_of_forall_pos_le_add
  intro ε hε
  obtain ⟨R₀,hR₀⟩ := eventually_atTop.mp (canonicalPrice_decay_uniform (h := h) hk.le t hε)
  let L := min x (-1)
  let R := max x R₀
  have hbound := canonicalPrice_le_of_upper_supports (h := h) hk
    (U := fun z => expiryUpperCap (k-h-1) z.1 z.2+ε) (L := L) (R := R) (T := t)
    ((expiryUpperCap_continuous (k-h-1)).add continuous_const).continuousOn
    (fun z hz => (expiryUpperCap_bounds (k-h-1) z.1 hz.2.1).2.2.trans
      (le_add_of_nonneg_right hε.le))
    (fun z hz => ?_) (fun y _ => ?_) (fun s hs => ?_) (fun s hs => ?_)
  · exact hbound (x,t) ⟨⟨min_le_left _ _,le_max_left _ _⟩,ht,le_rfl⟩
  · refine ⟨fun w => expiryUpperCap (k-h-1) w.1 w.2+ε,
      (expiryUpperCap_contDiffAt (k-h-1) z.1 hz.2.1).add contDiffAt_const,rfl,
      Eventually.of_forall (fun _ => le_rfl),?_⟩
    rw [pricingOperator_add_constant]
    exact add_nonneg (expiryUpperCap_supersolution hk.le hz.2.1) (mul_nonneg hk.le hε.le)
  · rw [canonicalPrice_initial hk.le]
    exact (expiryUpperCap_bounds (k-h-1) y le_rfl).2.2.trans (le_add_of_nonneg_right hε.le)
  · have hb := (expiryUpperCap_bounds (k-h-1) L hs.1).2.1
    have hL : L ≤ -1 := min_le_right _ _
    have hp := (canonicalPrice_bounds (h := h) hk.le L s).2
    dsimp only
    linarith
  · have hp := (hR₀ R (le_max_right _ _) s hs.2).2
    have hb := (expiryUpperCap_bounds (k-h-1) R hs.1).1
    dsimp only
    linarith

theorem canonicalPrice_atStrike_sqrt_bound {k h t : ℝ} (hk : 0 < k) (ht : 0 ≤ t) :
    canonicalPrice k h 0 t ≤ Real.sqrt t+|k-h-1| * t := by
  simpa only [expiryUpperCap_atStrike] using canonicalPrice_le_expiryUpperCap (h := h) hk ht 0

theorem canonicalPrice_temporal_sqrt_bound {k h s t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤
      Real.sqrt |t-s|+|k-h-1| * |t-s| :=
  (canonicalPrice_temporal_modulus hk hh hhk hs ht x).trans
    (canonicalPrice_atStrike_sqrt_bound hk (abs_nonneg _))

theorem zeroDividend_canonicalPrice_temporal_sqrt_bound {k s t : ℝ} (hk : 0 < k)
    (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k 0 x t-canonicalPrice k 0 x s| ≤ Real.sqrt |t-s|+|k-1| * |t-s| := by
  simpa only [sub_zero] using canonicalPrice_temporal_sqrt_bound hk le_rfl hk.le hs ht x

theorem liuRange_canonicalPrice_temporal_sqrt_bound {k h s t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (hs : 0 ≤ s) (ht : 0 ≤ t) (x : ℝ) :
    |canonicalPrice k h x t-canonicalPrice k h x s| ≤ Real.sqrt |t-s|+|k-h-1| * |t-s| :=
  canonicalPrice_temporal_sqrt_bound (by linarith) hh (by linarith) hs ht x

end AmericanConvexity.Stopping
