import AmericanConvexity.Stopping.HeatLocalizationSource

/-! # Constructed compact causal sources for actual theta

A tensor-product cutoff is one near any chosen positive-time contact. Its
spatial transitions avoid the moving graph throughout its time support.
The source is consequently bounded and continuous without a boundary flux
assumption. The heat potential representing this source is a separate step.
-/

namespace AmericanConvexity.Stopping

open Set Filter Metric Boundary
open scoped Topology ContDiff

theorem exists_graph_heat_cutoff_after {b : ℝ → ℝ} {a s : ℝ}
    (hb : ContinuousAt b s) (has : a < s) :
    ∃ χ : ℝ × ℝ → ℝ, ContDiff ℝ ∞ χ ∧
      HasCompactSupport χ ∧ χ =ᶠ[𝓝 (b s,s)] 1 ∧
      (∀ z ∈ tsupport χ, a < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)), z.1 ≠ b z.2) := by
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp
    (hb.preimage_mem_nhds (ball_mem_nhds (b s) (by norm_num : (0 : ℝ) < 1)))
  let δ := min (ε/2) ((s-a)/2)
  have hδ : 0 < δ := lt_min (by positivity) (by linarith)
  have hδε : δ < ε := (min_le_left _ _).trans_lt (by linarith)
  have hδs : δ ≤ (s-a)/2 := min_le_right _ _
  let ψ : ContDiffBump (b s) := {
    rIn := 1
    rOut := 2
    rIn_pos := by norm_num
    rIn_lt_rOut := by norm_num }
  let η : ContDiffBump s := {
    rIn := δ/2
    rOut := δ
    rIn_pos := by positivity
    rIn_lt_rOut := by linarith }
  let χ : ℝ × ℝ → ℝ := fun z => ψ z.1*η z.2
  have hc : ContDiff ℝ ∞ χ :=
    (ψ.contDiff.comp contDiff_fst).mul (η.contDiff.comp contDiff_snd)
  have hprod : tsupport χ ⊆ tsupport ψ ×ˢ tsupport η := by
    apply closure_minimal _ ((isClosed_tsupport _).prod (isClosed_tsupport _))
    intro z hz
    refine ⟨subset_closure ?_,subset_closure ?_⟩
    · intro hx
      exact hz (by simp [χ,hx])
    · intro ht
      exact hz (by simp [χ,ht])
  have htime (z : ℝ × ℝ) (hz : z ∈ tsupport χ) : dist z.2 s ≤ δ := by
    have ht := (hprod hz).2
    simpa only [η.tsupport_eq,mem_closedBall] using ht
  have hdx (z : ℝ × ℝ) : heatPartial χ (1,0) z = deriv ψ z.1*η z.2 := by
    rw [← (heatPartial_time (hc.contDiffAt.differentiableAt (by simp))).deriv]
    exact (((ψ.contDiff : ContDiff ℝ ∞ ψ).differentiable (by simp)).differentiableAt.hasDerivAt.mul_const
      (η z.2)).deriv
  have hflat (z : ℝ × ℝ) (hz : z.1 ∈ ball (b s) 1) :
      z ∉ tsupport (heatPartial χ (1,0)) := by
    apply notMem_tsupport_iff_eventuallyEq.mpr
    filter_upwards [continuousAt_fst.preimage_mem_nhds (isOpen_ball.mem_nhds hz)] with y hy
    rw [hdx]
    have he : deriv ψ y.1 = 0 := by
      have he := (ψ.eventuallyEq_one_of_mem_ball hy).deriv_eq
      simpa only [Pi.one_def,deriv_const] using he
    simp [he]
  refine ⟨χ,hc,
    (ψ.hasCompactSupport.prod η.hasCompactSupport).of_isClosed_subset (isClosed_tsupport _) hprod,
    ?_,?_,?_⟩
  · filter_upwards [continuousAt_fst.preimage_mem_nhds ψ.eventuallyEq_one,
      continuousAt_snd.preimage_mem_nhds η.eventuallyEq_one] with z hx ht
    simp only [χ,Pi.one_apply] at *
    rw [hx,ht,mul_one]
  · intro z hz
    have ht := htime z hz
    rw [Real.dist_eq,abs_le] at ht
    linarith
  · intro z hz he
    have ht := htime z (heatPartial_tsupport_subset χ (1,0) hz)
    have hbz : b z.2 ∈ ball (b s) 1 := hball (ht.trans_lt hδε)
    exact hflat z (he ▸ hbz) hz

theorem exists_graph_heat_cutoff {b : ℝ → ℝ} {s : ℝ}
    (hb : ContinuousAt b s) (hs : 0 < s) :
    ∃ (a : ℝ) (χ : ℝ × ℝ → ℝ), 0 < a ∧ a < s ∧ ContDiff ℝ ∞ χ ∧
      HasCompactSupport χ ∧ χ =ᶠ[𝓝 (b s,s)] 1 ∧
      (∀ z ∈ tsupport χ, a < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)), z.1 ≠ b z.2) := by
  obtain ⟨χ,hχ⟩ := exists_graph_heat_cutoff_after hb (by linarith : s/2 < s)
  exact ⟨s/2,χ,by positivity,by linarith,hχ⟩

theorem exists_actualHeatTheta_source_after {k h t a : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t)
    (ha : 0 ≤ a) (hat : a < 2*t) :
    ∃ χ : ℝ × ℝ → ℝ, ContDiff ℝ ∞ χ ∧ HasCompactSupport χ ∧
      χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1 ∧
      (∀ z ∈ tsupport χ, a < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)),
        z.1 ≠ canonicalLogBoundary k h (z.2/2)) ∧
      Continuous (heatLocalizationSource χ (canonicalHeatTheta k h)) ∧
      HasCompactSupport (heatLocalizationSource χ (canonicalHeatTheta k h)) ∧
      (∃ C : ℝ, ∀ z, ‖heatLocalizationSource χ (canonicalHeatTheta k h) z‖ ≤ C) ∧
      (∀ z : ℝ × ℝ, z.2 ≤ a → heatLocalizationSource χ (canonicalHeatTheta k h) z = 0) := by
  have hb : ContinuousAt (fun s : ℝ => canonicalLogBoundary k h (s/2)) (2*t) := by
    have hb0 := canonicalLogBoundary_continuousAt hk hh hhk ht.le
    have he : 2*t/2 = t := by ring
    exact (he ▸ hb0).comp (x := 2*t) (f := fun s : ℝ => s/2) (by fun_prop)
  obtain ⟨χ,hc,hcomp,he,hs,htrans⟩ := exists_graph_heat_cutoff_after hb hat
  refine ⟨χ,hc,hcomp,?_,hs,htrans,
    actualHeatLocalizationSource_continuous hk hh hhk ha hc hs htrans,
    heatLocalizationSource_hasCompactSupport hcomp _,
    actualHeatLocalizationSource_bounded hk hh hhk ha hc hcomp hs htrans,
    heatLocalizationSource_causal hs _⟩
  simpa only [mul_div_cancel_left₀ _ (by norm_num : (2 : ℝ) ≠ 0)] using he

/-- The actual source, with its cutoff, is constructed around each contact.
The returned support and transition conditions remain available to identify
the localized PDE solution with a heat-layer representation. -/
theorem exists_actualHeatTheta_source {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ∃ (a : ℝ) (χ : ℝ × ℝ → ℝ), 0 < a ∧ a < 2*t ∧ ContDiff ℝ ∞ χ ∧
      HasCompactSupport χ ∧ χ =ᶠ[𝓝 (canonicalLogBoundary k h t,2*t)] 1 ∧
      (∀ z ∈ tsupport χ, a < z.2) ∧
      (∀ z ∈ tsupport (heatPartial χ (1,0)),
        z.1 ≠ canonicalLogBoundary k h (z.2/2)) ∧
      Continuous (heatLocalizationSource χ (canonicalHeatTheta k h)) ∧
      HasCompactSupport (heatLocalizationSource χ (canonicalHeatTheta k h)) ∧
      (∃ C : ℝ, ∀ z, ‖heatLocalizationSource χ (canonicalHeatTheta k h) z‖ ≤ C) ∧
      (∀ z : ℝ × ℝ, z.2 ≤ a → heatLocalizationSource χ (canonicalHeatTheta k h) z = 0) := by
  obtain ⟨χ,hc,hcomp,he,hs,htrans,hcont,hsc,hbound,hcausal⟩ :=
    exists_actualHeatTheta_source_after hk hh hhk ht ht.le (by linarith : t < 2*t)
  exact ⟨t,χ,ht,by linarith,hc,hcomp,he,hs,htrans,hcont,hsc,hbound,hcausal⟩

end AmericanConvexity.Stopping
