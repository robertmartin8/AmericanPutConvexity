import AmericanConvexity.Stopping.ActualTemporalLipschitz
import AmericanConvexity.Stopping.ActualBoundaryIncrement

/-! # Local half-power continuity of the actual exercise boundary

The price's positive-time Lipschitz bound and uniform quadratic separation
upgrade the earlier quarter-power boundary modulus to a square-root modulus.
This remains a continuity result, not boundary differentiability or smoothness.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology

theorem half_bound_of_square_bound {A H D z : ℝ} (hA : 0 < A) (hH : 0 ≤ H)
    (hD : 0 ≤ D) (hz : 0 ≤ z) (hbound : A/4*D^2 ≤ H*z) :
    D ≤ Real.sqrt (4*H/A)*Real.sqrt z := by
  have hsq : D^2 ≤ (4*H/A)*z := by
    rw [div_mul_eq_mul_div,le_div_iff₀ hA]
    nlinarith
  apply (sq_le_sq₀ hD (mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _))).mp
  rw [mul_pow,Real.sq_sqrt (show 0 ≤ 4*H/A by positivity),Real.sq_sqrt hz]
  exact hsq

theorem canonicalLogBoundary_squared_increment_linear_bound {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η H : ℝ, 0 < η ∧ 0 < H ∧ ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      0 < s ∧ 0 < u ∧
      (k-h*Real.exp (canonicalLogBoundary k h t))/4 *
          (canonicalLogBoundary k h s-canonicalLogBoundary k h u)^2 ≤ H*(u-s) := by
  obtain ⟨η₀,hη₀,hbound⟩ := canonicalLogBoundary_increment_bounds hk hh hhk ht
  let F : ℝ → ℝ := fun x => actualTemporalDerivativeBound k h x (t/2) (2*t)
  have hF : Continuous F := by
    unfold F actualTemporalDerivativeBound dilationWeight
    fun_prop
  let H := F (canonicalLogBoundary k h t)+1
  have hH : 0 < H := by
    have hn := actualTemporalDerivativeBound_nonneg (k := k)
      (x := canonicalLogBoundary k h t) (T := 2*t) hh (half_pos ht)
    dsimp only [H,F]
    linarith
  have hc : ContinuousAt (fun s => F (canonicalLogBoundary k h s)) t :=
    hF.continuousAt.comp (canonicalLogBoundary_continuousAt hk hh hhk ht.le)
  have he : ∀ᶠ s in 𝓝 t, F (canonicalLogBoundary k h s) < H :=
    hc.eventually (Iio_mem_nhds (show F (canonicalLogBoundary k h t) < H by dsimp [H]; linarith))
  obtain ⟨δ,hδ,hδball⟩ := Metric.mem_nhds_iff.mp he
  let η := min η₀ (min δ (t/2))
  have hη : 0 < η := lt_min hη₀ (lt_min hδ (half_pos ht))
  have hη₀le : η ≤ η₀ := min_le_left _ _
  have hηδ : η ≤ δ := (min_le_right _ _).trans (min_le_left _ _)
  have hηt : η ≤ t/2 := (min_le_right _ _).trans (min_le_right _ _)
  have hwindow (s : ℝ) (hs : dist s t < η) : s ∈ Icc (t/2) (2*t) := by
    have hb := abs_lt.mp (show |s-t| < t/2 from hs.trans_le hηt)
    constructor <;> linarith [hb.1,hb.2]
  refine ⟨η,H,hη,hH,?_⟩
  intro s u hs hu hsu
  obtain ⟨hs0,hu0,_,hb⟩ := hbound s u (hs.trans_le hη₀le) (hu.trans_le hη₀le) hsu
  have hFs := hδball (show s ∈ Metric.ball t δ from hs.trans_le hηδ)
  change F (canonicalLogBoundary k h s) < H at hFs
  have hp := canonicalPrice_temporal_lipschitz_on_interval (x := canonicalLogBoundary k h s)
    hk hh hhk (half_pos ht) (hwindow s hs) (hwindow u hu)
  rw [abs_of_nonneg (sub_nonneg.mpr (canonicalPrice_monotone_time hk.le _ hsu)),
    abs_of_nonneg (sub_nonneg.mpr hsu)] at hp
  refine ⟨hs0,hu0,hb.trans (hp.trans ?_)⟩
  exact mul_le_mul_of_nonneg_right hFs.le (sub_nonneg.mpr hsu)

theorem canonicalLogBoundary_local_half_bound {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤
        C*Real.sqrt (dist s u) := by
  obtain ⟨η,H,hη,hH,hbound⟩ := canonicalLogBoundary_squared_increment_linear_bound hk hh hhk ht
  let A := k-h*Real.exp (canonicalLogBoundary k h t)
  have hA : 0 < A := canonicalBoundary_forcing_pos hk hh hhk ht
  let C := Real.sqrt (4*H/A)
  have hC : 0 < C := Real.sqrt_pos.mpr (by positivity)
  have hordered : ∀ s u : ℝ, dist s t < η → dist u t < η → s ≤ u →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤ C*Real.sqrt (dist s u) := by
    intro s u hs hu hsu
    obtain ⟨hs0,hu0,hb⟩ := hbound s u hs hu hsu
    have hm := canonicalLogBoundary_antitoneOn hk hh hhk hs0.le hu0.le hsu
    have he := half_bound_of_square_bound hA hH.le (sub_nonneg.mpr hm) (sub_nonneg.mpr hsu) hb
    simpa only [Real.dist_eq,abs_of_nonneg (sub_nonneg.mpr hm),
      abs_of_nonpos (sub_nonpos.mpr hsu),neg_sub] using he
  refine ⟨η,C,hη,hC,?_⟩
  intro s u hs hu
  rcases le_total s u with hsu | hus
  · exact hordered s u hs hu hsu
  · simpa only [dist_comm] using hordered u s hu hs hus

theorem zeroDividend_canonicalLogBoundary_local_half_bound {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k 0 s) (canonicalLogBoundary k 0 u) ≤ C*Real.sqrt (dist s u) :=
  canonicalLogBoundary_local_half_bound hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_local_half_bound {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ η C : ℝ, 0 < η ∧ 0 < C ∧ ∀ s u : ℝ, dist s t < η → dist u t < η →
      dist (canonicalLogBoundary k h s) (canonicalLogBoundary k h u) ≤ C*Real.sqrt (dist s u) :=
  canonicalLogBoundary_local_half_bound (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
