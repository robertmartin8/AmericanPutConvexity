import AmericanPutConvexity.Stopping.ActualContactDifferentiability
import AmericanPutConvexity.Stopping.HeatDensityEquation

/-! # A continuous boundary-integral density for the actual local graph

The actual boundary has a globally Lipschitz extension agreeing with it
near every positive maturity. Solving the boundary integral equation for
that extension gives the equation for the actual graph on a smaller window.
The density is constructed for every bounded continuous causal forcing.
Identification of the forcing/representation for actual theta is separate.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology BoundedContinuousFunction

theorem canonicalLogBoundary_local_lipschitz_extension {k h a : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ η : ℝ, 0 < η ∧ ∃ (L : NNReal) (e : ℝ → ℝ),
      LipschitzWith L e ∧ EqOn (canonicalLogBoundary k h) e (Metric.ball a η) := by
  obtain ⟨L,S,hS,hLip⟩ := canonicalLogBoundary_locallyLipschitzOn hk hh hhk ha
  rw [nhdsWithin_eq_nhds.mpr (Ioi_mem_nhds ha)] at hS
  obtain ⟨η,hη,hball⟩ := Metric.mem_nhds_iff.mp hS
  obtain ⟨e,he,heq⟩ := hLip.extend_real
  exact ⟨η,hη,L,e,he,fun _ hx => heq (hball hx)⟩

/-- Heat time is twice normalized pricing time. The window and density are
constructed, and the final equation contains the actual boundary, not its
auxiliary extension. No smoothness or flux hypothesis is imposed on it. -/
theorem exists_canonicalLogBoundary_heat_density {k h a : ℝ} (hk : 0 < k)
    (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ D : ℝ, 0 < D ∧ D < a ∧ ∀ g : CausalBoundaryData (2*a-D/2),
      ∃ f : CausalBoundaryData (2*a-D/2), ∀ t ∈ Icc (2*a-D/2) (2*a+D/2),
        f.1 t = g.1 t + ∫ s in Ioo 0 (t-(2*a-D/2)),
          heatBoundaryKernel s (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h ((t-s)/2))*f.1 (t-s) := by
  obtain ⟨η,hη,L,e,he,heq⟩ := canonicalLogBoundary_local_lipschitz_extension hk hh hhk ha
  obtain ⟨D₀,hD₀,hsmall₀⟩ := exists_small_heatHistory_window (L : ℝ)
  let D := min D₀ (min η (a/2))
  have hD : 0 < D := lt_min hD₀ (lt_min hη (half_pos ha))
  have hDη : D ≤ η := (min_le_right _ _).trans (min_le_left _ _)
  have hDa : D < a := ((min_le_right _ _).trans (min_le_right _ _)).trans_lt (half_lt_self ha)
  have hsmall : heatHistoryNormBound L D < 1 :=
    ((heatHistoryNormBound_mono L.coe_nonneg) (min_le_left _ _)).trans_lt hsmall₀
  let b := fun t : ℝ => e (t/2)
  have hb : Continuous b := he.continuous.comp (continuous_id.div_const 2)
  have hmove : ∀ t s : ℝ, 0 < s → ‖b t-b (t-s)‖ ≤ (L : ℝ)*s := by
    intro t s hs
    have hh := he.dist_le_mul (t/2) ((t-s)/2)
    have hdist : dist (t/2) ((t-s)/2) = s/2 := by
      rw [Real.dist_eq,show t/2-(t-s)/2 = s/2 by ring,abs_of_pos (half_pos hs)]
    rw [hdist,dist_eq_norm] at hh
    exact hh.trans (mul_le_mul_of_nonneg_left (by linarith [hs] : s/2 ≤ s) L.coe_nonneg)
  have hagree (u : ℝ) (hu : u ∈ Icc (a-D/4) (a+D/4)) :
      canonicalLogBoundary k h u = e u := by
    apply heq
    change dist u a < η
    rw [Real.dist_eq,abs_lt]
    constructor <;> linarith [hu.1,hu.2]
  refine ⟨D,hD,hDa,?_⟩
  intro g
  obtain ⟨f,hf,_⟩ := exists_unique_causal_heat_density hD L.coe_nonneg hb hmove hsmall g
  refine ⟨f,?_⟩
  intro t ht
  rw [hf t,heatHistory_eq_causal_past f.2 (by linarith [ht.2] : t ≤ (2*a-D/2)+D)]
  congr 1
  apply setIntegral_congr_fun measurableSet_Ioo
  intro s hs
  dsimp only
  change heatBoundaryKernel s (e (t/2)-e ((t-s)/2))*f.1 (t-s) = _
  rw [hagree (t/2) ⟨by linarith [ht.1],by linarith [ht.2]⟩,
    hagree ((t-s)/2) ⟨by linarith [hs.2],by linarith [ht.2,hs.1]⟩]

theorem zeroDividend_exists_canonicalLogBoundary_heat_density {k a : ℝ}
    (hk : 0 < k) (ha : 0 < a) :
    ∃ D : ℝ, 0 < D ∧ D < a ∧ ∀ g : CausalBoundaryData (2*a-D/2),
      ∃ f : CausalBoundaryData (2*a-D/2), ∀ t ∈ Icc (2*a-D/2) (2*a+D/2),
        f.1 t = g.1 t + ∫ s in Ioo 0 (t-(2*a-D/2)),
          heatBoundaryKernel s (canonicalLogBoundary k 0 (t/2)-canonicalLogBoundary k 0 ((t-s)/2))*f.1 (t-s) :=
  exists_canonicalLogBoundary_heat_density hk le_rfl hk.le ha

theorem liuRange_exists_canonicalLogBoundary_heat_density {k h a : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ha : 0 < a) :
    ∃ D : ℝ, 0 < D ∧ D < a ∧ ∀ g : CausalBoundaryData (2*a-D/2),
      ∃ f : CausalBoundaryData (2*a-D/2), ∀ t ∈ Icc (2*a-D/2) (2*a+D/2),
        f.1 t = g.1 t + ∫ s in Ioo 0 (t-(2*a-D/2)),
          heatBoundaryKernel s (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h ((t-s)/2))*f.1 (t-s) :=
  exists_canonicalLogBoundary_heat_density (by linarith) hh (by linarith) ha

end AmericanPutConvexity.Stopping
