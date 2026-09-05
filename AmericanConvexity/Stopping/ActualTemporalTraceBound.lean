import AmericanConvexity.Stopping.ActualIncrementComparison
import AmericanConvexity.Stopping.ActualContactIncrement
import AmericanConvexity.Stopping.ActualTemporalLipschitz

/-! # Uniform linear bounds for the actual time derivative near contact

A stationary exponential barrier controls time increments on the earlier
continuation region. The contact data is quadratic in the increment, while
strict boundary decrease supplies a positive gap at the initial time.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalPrice_temporal_lipschitz_on_rectangle {k h a U X R : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) (hXR : X ≤ R) :
    ∃ M : ℝ, 0 < M ∧ ∀ x ∈ Icc X R, ∀ s ∈ Icc a U, ∀ v ∈ Icc a U,
      |canonicalPrice k h x v-canonicalPrice k h x s| ≤ M*|v-s| := by
  have hcont : Continuous (fun x => actualTemporalDerivativeBound k h x a U) := by
    unfold actualTemporalDerivativeBound dilationWeight
    fun_prop
  obtain ⟨y,_,hymax⟩ := isCompact_Icc.exists_isMaxOn ⟨X,le_rfl,hXR⟩ hcont.continuousOn
  let M := max (actualTemporalDerivativeBound k h y a U) 0+1
  refine ⟨M,by dsimp [M]; positivity,?_⟩
  intro x hx s hs v hv
  apply (canonicalPrice_temporal_lipschitz_on_interval hk hh hhk ha hs hv).trans
  apply mul_le_mul_of_nonneg_right _ (abs_nonneg _)
  exact (hymax hx).trans (by dsimp [M]; linarith [le_max_left (actualTemporalDerivativeBound k h y a U) 0])

theorem canonicalPrice_time_deriv_linear_near_boundary {k h t : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ η N : ℝ, 0 < η ∧ 0 < N ∧ ∀ u : ℝ, dist u t < η → 0 < u ∧
      ∀ x ∈ Icc (canonicalLogBoundary k h u) 0,
        0 ≤ deriv (canonicalPrice k h x) u ∧
        deriv (canonicalPrice k h x) u ≤ N*(x-canonicalLogBoundary k h u) := by
  obtain ⟨ε,A,hε,hA,hcontact⟩ := canonicalPrice_contact_increment_quadratic hk hh hhk ht
  let r := min ε (t/2)
  have hr : 0 < r := lt_min hε (half_pos ht)
  have hrε : r ≤ ε := min_le_left _ _
  have hrt : r ≤ t/2 := min_le_right _ _
  let a := t-r/2
  let l := t-r/4
  let v := t+r/4
  have ha : 0 < a := by dsimp [a]; linarith
  have hl : 0 < l := by dsimp [l]; linarith
  have hv : 0 < v := by dsimp [v]; linarith
  have hal : a < l := by dsimp [a,l]; linarith
  let g := canonicalLogBoundary k h a-canonicalLogBoundary k h l
  have hg : 0 < g := sub_pos.mpr (canonicalLogBoundary_strictAntiOn hk hh hhk ha hl hal)
  let ρ := |k-h-1|+1
  have hρ : 0 < ρ := by dsimp [ρ]; positivity
  have hαρ : k-h-1 ≤ ρ := by dsimp [ρ]; linarith [le_abs_self (k-h-1)]
  obtain ⟨M,hM,hbound⟩ := canonicalPrice_temporal_lipschitz_on_rectangle
    (U := t+r) hk hh hhk ha (canonicalLogBoundary_neg hk hh hhk hv).le
  let C := M/stationaryBoundaryBarrier ρ 0 g
  have hC : 0 < C := div_pos hM (stationaryBoundaryBarrier_pos hρ hg)
  refine ⟨r/8,C*ρ,by positivity,mul_pos hC hρ,?_⟩
  intro u hu
  have huabs : |u-t| < r/8 := by simpa only [Real.dist_eq] using hu
  have hulo : t-r/8 < u := by linarith [(abs_lt.mp huabs).1]
  have huhi : u < t+r/8 := by linarith [(abs_lt.mp huabs).2]
  have hu0 : 0 < u := by linarith
  have hau : a ≤ u := by dsimp [a]; linarith
  have hlu : l ≤ u := by dsimp [l]; linarith
  have huv : u ≤ v := by dsimp [v]; linarith
  refine ⟨hu0,?_⟩
  intro x hx
  refine ⟨canonicalPrice_time_deriv_nonneg hk.le x u,?_⟩
  have hinc (δ : ℝ) (hδ : 0 < δ) (hδr : δ < r/4) :
      canonicalTimeIncrement k h δ x u ≤
        A*δ^2+δ*C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x := by
    refine canonicalTimeIncrement_le_exponential hk hh hhk hδ.le ha hau hρ hαρ hg hA.le hM.le
      (R := 0) (β := canonicalLogBoundary k h u) ?_ ?_ ?_ ?_ ?_ (x,u) ?_
    · intro s hs
      exact (canonicalLogBoundary_neg hk hh hhk (ha.trans_le hs.1)).le
    · intro s hs
      exact canonicalLogBoundary_antitoneOn hk hh hhk (ha.trans_le hs.1).le hu0.le hs.2
    · have he := canonicalLogBoundary_antitoneOn hk hh hhk hl.le hu0.le hlu
      dsimp only [g]
      linarith
    · intro z hz
      have hsz : z.2 ∈ Icc a (t+r) := ⟨hz.1,by linarith [hz.2.1]⟩
      have hszδ : z.2+δ ∈ Icc a (t+r) := ⟨by linarith [hz.1],by linarith [hz.2.1]⟩
      have hxz : z.1 ∈ Icc (canonicalLogBoundary k h v) 0 := by
        refine ⟨?_,hz.2.2.2⟩
        exact (canonicalLogBoundary_antitoneOn hk hh hhk (ha.trans_le hz.1).le hv.le
          (hz.2.1.trans huv)).trans hz.2.2.1
      have he := hbound z.1 hxz z.2 hsz (z.2+δ) hszδ
      have hd : |z.2+δ-z.2| = δ := by simp [abs_of_pos hδ]
      rw [hd] at he
      exact (le_abs_self _).trans he
    · intro s hs
      have hsa : |s-t| < ε := by
        apply abs_lt.mpr
        dsimp [a] at hs
        constructor <;> linarith [hs.1,hs.2]
      have hsd : |s+δ-t| < ε := by
        apply abs_lt.mpr
        dsimp [a] at hs
        constructor <;> linarith [hs.1,hs.2]
      have he := (hcontact s (s+δ) (by simpa only [Real.dist_eq] using hsa)
        (by simpa only [Real.dist_eq] using hsd) (by linarith)).2.2.2
      simpa only [canonicalTimeIncrement,add_sub_cancel_left] using he
    · exact ⟨hau,le_rfl,hx.1,hx.2⟩
  have hquot : ∀ᶠ δ : ℝ in 𝓝[>] 0,
      (canonicalPrice k h x (u+δ)-canonicalPrice k h x u)/δ ≤
        A*δ+C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x := by
    filter_upwards [self_mem_nhdsWithin,
      nhdsWithin_le_nhds (Iio_mem_nhds (by positivity : 0 < r/4))] with δ hδ hδr
    apply (div_le_iff₀ (show 0 < δ from hδ)).mpr
    have he := hinc δ hδ hδr
    change canonicalPrice k h x (u+δ)-canonicalPrice k h x u ≤ _ at he
    nlinarith only [he]
  have hlim : Tendsto (fun δ : ℝ => (canonicalPrice k h x (u+δ)-canonicalPrice k h x u)/δ)
      (𝓝[>] 0) (𝓝 (deriv (canonicalPrice k h x) u)) := by
    simpa only [smul_eq_mul,div_eq_inv_mul] using
      (canonicalPrice_differentiableAt_time hk hh hhk hu0).hasDerivAt.tendsto_slope_zero_right
  have hlimR : Tendsto (fun δ : ℝ => A*δ+C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x)
      (𝓝[>] 0) (𝓝 (C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x)) := by
    have he : ContinuousAt (fun δ : ℝ => A*δ+C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x) 0 := by fun_prop
    simpa only [mul_zero,zero_add] using he.tendsto.mono_left nhdsWithin_le_nhds
  calc
    deriv (canonicalPrice k h x) u ≤ C*stationaryBoundaryBarrier ρ (canonicalLogBoundary k h u) x :=
      le_of_tendsto_of_tendsto hlim hlimR hquot
    _ ≤ C*(ρ*(x-canonicalLogBoundary k h u)) :=
      mul_le_mul_of_nonneg_left (stationaryBoundaryBarrier_le_linear ρ _ x) hC.le
    _ = C*ρ*(x-canonicalLogBoundary k h u) := by ring

end AmericanConvexity.Stopping
