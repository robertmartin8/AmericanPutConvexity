import AmericanPutConvexity.Stopping.HeatSourcePotential
import AmericanPutConvexity.Stopping.ActualHeatSource
import AmericanPutConvexity.Stopping.ActualHeatDensity

/-! # Constructed forcing for the actual boundary integral equation

The forcing is twice the spatial derivative of the actual localized source
potential. Clamping the graph before the causal start gives a continuous
global representative; causality makes its value independent of that clamp.
This constructs the density for the actual source, but does not yet identify
the resulting layer potential with actual theta.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology BoundedContinuousFunction ContDiff

noncomputable def heatSourceForcingBCF {Q : ℝ × ℝ → ℝ} {b : ℝ → ℝ} {C D : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) (hb : Continuous b) : ℝ →ᵇ ℝ :=
  BoundedContinuousFunction.ofNormedAddCommGroup
    (fun s => 2*heatSourcePotentialSpatial Q D (b s,s))
    (continuous_const.mul ((heatSourcePotentialSpatial_continuous hD hQ hC).comp
      (hb.prodMk continuous_id)))
    (4*heatSourceGradientConstant*C*Real.sqrt D) (fun s => by
      rw [norm_mul,Real.norm_of_nonneg (by norm_num : (0 : ℝ) ≤ 2)]
      have hbnd := mul_le_mul_of_nonneg_left (heatSourcePotentialSpatial_bound hD hC (b s,s))
        (by norm_num : (0 : ℝ) ≤ 2)
      convert! hbnd using 1; ring)

noncomputable def heatSourceForcingCausal {Q : ℝ × ℝ → ℝ} {b : ℝ → ℝ} {C D a : ℝ}
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C) (hb : Continuous b)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) : CausalBoundaryData a :=
  ⟨heatSourceForcingBCF hD hQ hC hb,fun s hs => by
    change 2*heatSourcePotentialSpatial Q D (b s,s) = 0
    rw [heatSourcePotentialSpatial_causal hcausal _ hs,mul_zero]⟩

theorem canonicalHeatGraph_clamp_continuous {k h a : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    Continuous (fun s : ℝ => canonicalLogBoundary k h (max a s/2)) := by
  apply continuous_iff_continuousAt.mpr
  intro s
  have hp : 0 < max a s/2 := by linarith [le_max_left a s]
  exact (canonicalLogBoundary_continuousAt hk hh hhk hp.le).comp
    (x := s) (f := fun s : ℝ => max a s/2) (by fun_prop)

noncomputable def canonicalHeatSourceForcing {k h a C D : ℝ} {Q : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) : CausalBoundaryData a :=
  heatSourceForcingCausal hD hQ hC (canonicalHeatGraph_clamp_continuous hk hh hhk ha) hcausal

theorem canonicalHeatSourceForcing_apply {k h a C D : ℝ} {Q : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (hD : 0 < D) (hQ : Continuous Q) (hC : ∀ z, ‖Q z‖ ≤ C)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (s : ℝ) :
    (canonicalHeatSourceForcing hk hh hhk ha hD hQ hC hcausal).1 s =
      2*heatSourcePotentialSpatial Q D (canonicalLogBoundary k h (s/2),s) := by
  change 2*heatSourcePotentialSpatial Q D (canonicalLogBoundary k h (max a s/2),s) = _
  by_cases hs : s ≤ a
  · rw [heatSourcePotentialSpatial_causal hcausal _ hs,
      heatSourcePotentialSpatial_causal hcausal _ hs]
  · rw [max_eq_right (le_of_not_ge hs)]

theorem canonicalHeatSourceForcing_hasDerivAt {k h a C D : ℝ} {Q : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (hD : 0 < D) (hQ : Continuous Q) (hc : HasCompactSupport Q) (hC : ∀ z, ‖Q z‖ ≤ C)
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (s : ℝ) :
    HasDerivAt (fun x => heatSourcePotential Q D (x,s))
      ((canonicalHeatSourceForcing hk hh hhk ha hD hQ hC hcausal).1 s/2)
      (canonicalLogBoundary k h (s/2)) := by
  rw [canonicalHeatSourceForcing_apply]
  convert! heatSourcePotential_hasDerivAt hD hQ hc hC (canonicalLogBoundary k h (s/2)) s using 1
  ring

/-- The density now has the actual source potential's forcing, not an
arbitrary assumed forcing. No normal derivative of actual theta is assumed. -/
theorem exists_actualHeatSource_density {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ D : ℝ, 0 < D ∧ D < t ∧ ∃ χ : ℝ × ℝ → ℝ,
      ContDiff ℝ ∞ χ ∧ HasCompactSupport χ ∧
      χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1 ∧
      (∀ z ∈ tsupport χ, 2*t-D/2 < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)),
        z.1 ≠ canonicalLogBoundary k h (z.2/2)) ∧
      ∃ f : CausalBoundaryData (2*t-D/2), ∀ s ∈ Icc (2*t-D/2) (2*t+D/2),
        f.1 s = 2*heatSourcePotentialSpatial
          (heatLocalizationSource χ (canonicalHeatTheta k h)) D (canonicalLogBoundary k h (s/2),s) +
          ∫ u in Ioo 0 (s-(2*t-D/2)),
            heatBoundaryKernel u (canonicalLogBoundary k h (s/2)-canonicalLogBoundary k h ((s-u)/2))*f.1 (s-u) := by
  obtain ⟨D,hD,hDt,hsolve⟩ := exists_canonicalLogBoundary_heat_density hk hh hhk ht
  have ha : 0 < 2*t-D/2 := by linarith
  obtain ⟨χ,hc,hcomp,he,hs,htrans,hQ,hQc,⟨C,hC⟩,hcausal⟩ :=
    exists_actualHeatTheta_source_after hk hh hhk ht ha.le (by linarith : 2*t-D/2 < 2*t)
  let g := canonicalHeatSourceForcing hk hh hhk ha hD hQ hC hcausal
  obtain ⟨f,hf⟩ := hsolve g
  refine ⟨D,hD,hDt,χ,hc,hcomp,he,hs,htrans,f,?_⟩
  intro s hst
  rw [hf s hst]
  congr 1
  exact canonicalHeatSourceForcing_apply hk hh hhk ha hD hQ hC hcausal s

theorem zeroDividend_exists_actualHeatSource_density {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    ∃ D : ℝ, 0 < D ∧ D < t ∧ ∃ χ : ℝ × ℝ → ℝ,
      ContDiff ℝ ∞ χ ∧ HasCompactSupport χ ∧
      χ =ᶠ[𝓝 (canonicalLogBoundary k 0 t,2*t)] 1 ∧
      (∀ z ∈ tsupport χ, 2*t-D/2 < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)),
        z.1 ≠ canonicalLogBoundary k 0 (z.2/2)) ∧
      ∃ f : CausalBoundaryData (2*t-D/2), ∀ s ∈ Icc (2*t-D/2) (2*t+D/2),
        f.1 s = 2*heatSourcePotentialSpatial
          (heatLocalizationSource χ (canonicalHeatTheta k 0)) D (canonicalLogBoundary k 0 (s/2),s) +
          ∫ u in Ioo 0 (s-(2*t-D/2)),
            heatBoundaryKernel u (canonicalLogBoundary k 0 (s/2)-canonicalLogBoundary k 0 ((s-u)/2))*f.1 (s-u) :=
  exists_actualHeatSource_density hk le_rfl hk.le ht

theorem liuRange_exists_actualHeatSource_density {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    ∃ D : ℝ, 0 < D ∧ D < t ∧ ∃ χ : ℝ × ℝ → ℝ,
      ContDiff ℝ ∞ χ ∧ HasCompactSupport χ ∧
      χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1 ∧
      (∀ z ∈ tsupport χ, 2*t-D/2 < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)),
        z.1 ≠ canonicalLogBoundary k h (z.2/2)) ∧
      ∃ f : CausalBoundaryData (2*t-D/2), ∀ s ∈ Icc (2*t-D/2) (2*t+D/2),
        f.1 s = 2*heatSourcePotentialSpatial
          (heatLocalizationSource χ (canonicalHeatTheta k h)) D (canonicalLogBoundary k h (s/2),s) +
          ∫ u in Ioo 0 (s-(2*t-D/2)),
            heatBoundaryKernel u (canonicalLogBoundary k h (s/2)-canonicalLogBoundary k h ((s-u)/2))*f.1 (s-u) :=
  exists_actualHeatSource_density (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
