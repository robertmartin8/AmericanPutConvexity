import AmericanConvexity.Stopping.HeatLocalizationSource
import AmericanConvexity.Stopping.SourceHeatEquation
import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension

/-! # Local smooth decomposition of the actual heat source

A smooth cutoff supported inside an open smoothness region gives a globally
smooth compact source agreeing with the original source near the chosen point.
The remaining compact continuous source vanishes on a neighborhood of that
point. No smoothness across the exercise graph is assumed.
-/

namespace AmericanConvexity.Stopping

open Set Filter Metric Boundary
open scoped Topology ContDiff

theorem heatLocalizationSource_contDiffAt {χ W : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hc : ContDiffAt ℝ ∞ χ z) (hW : ContDiffAt ℝ ∞ W z) :
    ContDiffAt ℝ ∞ (heatLocalizationSource χ W) z :=
  (((heatPartial_smoothAt hc (0,1)).sub (contDiffAt_const.mul
    (heatPartial_smoothAt (heatPartial_smoothAt hc (1,0)) (1,0)))).mul hW).sub
      ((heatPartial_smoothAt hc (1,0)).mul (heatPartial_smoothAt hW (1,0)))

theorem exists_compact_smooth_source_germ {Q : ℝ × ℝ → ℝ} {U : Set (ℝ × ℝ)}
    (hU : IsOpen U) (hQ : ∀ z ∈ U, ContDiffAt ℝ ∞ Q z) {z : ℝ × ℝ} (hz : z ∈ U) :
    ∃ R : ℝ × ℝ → ℝ, ContDiff ℝ ∞ R ∧ HasCompactSupport R ∧
      R =ᶠ[𝓝 z] Q ∧ tsupport R ⊆ tsupport Q ∧ (∀ w, Q w = 0 → R w = 0) := by
  obtain ⟨ε,hε,hball⟩ := Metric.mem_nhds_iff.mp (hU.mem_nhds hz)
  let ψ : ContDiffBump z := {
    rIn := ε/4
    rOut := ε/2
    rIn_pos := by positivity
    rIn_lt_rOut := by linarith }
  have hs : tsupport ψ ⊆ U := by
    intro y hy
    apply hball
    rw [ψ.tsupport_eq,mem_closedBall] at hy
    exact mem_ball.mpr (hy.trans_lt (by dsimp [ψ]; linarith))
  let R : ℝ × ℝ → ℝ := fun y => ψ y*Q y
  have hR : ContDiff ℝ ∞ R := by
    apply contDiff_iff_contDiffAt.mpr
    intro y
    by_cases hy : y ∈ tsupport ψ
    · exact ψ.contDiff.contDiffAt.mul (hQ y (hs hy))
    · apply (contDiffAt_const (c := (0 : ℝ))).congr_of_eventuallyEq
      filter_upwards [notMem_tsupport_iff_eventuallyEq.mp hy] with w hw
      simp [R,hw]
  refine ⟨R,hR,ψ.hasCompactSupport.mul_right,?_,?_,?_⟩
  · filter_upwards [ψ.eventuallyEq_one] with y hy
    simp only [R,Pi.one_apply] at *
    rw [hy,one_mul]
  · exact tsupport_mul_subset_right (f := (ψ : ℝ × ℝ → ℝ)) (g := Q)
  · intro w hw
    simp [R,hw]

theorem compact_smooth_source_remainder {Q R : ℝ × ℝ → ℝ} {z : ℝ × ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hR : ContDiff ℝ ∞ R) (hRc : HasCompactSupport R) (he : R =ᶠ[𝓝 z] Q) :
    Continuous (Q-R) ∧ HasCompactSupport (Q-R) ∧ z ∉ tsupport (Q-R) := by
  refine ⟨hQ.sub hR.continuous,hc.sub hRc,notMem_tsupport_iff_eventuallyEq.mpr ?_⟩
  filter_upwards [he] with w hw
  simp [hw]

theorem source_germ_causal {Q R : ℝ × ℝ → ℝ} {a : ℝ}
    (hcausal : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (hs : ∀ w, Q w = 0 → R w = 0)
    (z : ℝ × ℝ) (hz : z.2 ≤ a) : R z = 0 := hs z (hcausal z hz)

theorem canonicalHeat_off_contact_isOpen {k h : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) :
    IsOpen {z : ℝ × ℝ | 0 < z.2 ∧ z.1 ≠ canonicalLogBoundary k h (z.2/2)} := by
  apply isOpen_iff_mem_nhds.mpr
  intro z hz
  have hb : ContinuousAt (fun w : ℝ × ℝ => canonicalLogBoundary k h (w.2/2)) z :=
    (canonicalLogBoundary_continuousAt hk hh hhk (div_nonneg hz.1.le (by norm_num))).comp
      (x := z) (f := fun w : ℝ × ℝ => w.2/2) (by fun_prop)
  filter_upwards [continuousAt_snd.preimage_mem_nhds (Ioi_mem_nhds hz.1),
    (continuousAt_fst.prodMk hb).preimage_mem_nhds (isOpen_ne_fun continuous_fst continuous_snd |>.mem_nhds hz.2)] with w hwt hwx
  exact ⟨hwt,hwx⟩

theorem actualHeatLocalizationSource_contDiffAt_off_contact {k h : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : ContDiff ℝ ∞ χ)
    {z : ℝ × ℝ} (ht : 0 < z.2) (hx : z.1 ≠ canonicalLogBoundary k h (z.2/2)) :
    ContDiffAt ℝ ∞ (heatLocalizationSource χ (canonicalHeatTheta k h)) z :=
  heatLocalizationSource_contDiffAt hc.contDiffAt
    (canonicalHeatTheta_contDiffAt_off_contact hk hh hhk ht hx)

theorem exists_actualHeatSource_smooth_germ {k h : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hc : ContDiff ℝ ∞ χ)
    {z : ℝ × ℝ} (ht : 0 < z.2) (hx : z.1 ≠ canonicalLogBoundary k h (z.2/2)) :
    ∃ R : ℝ × ℝ → ℝ, ContDiff ℝ ∞ R ∧ HasCompactSupport R ∧
      R =ᶠ[𝓝 z] heatLocalizationSource χ (canonicalHeatTheta k h) ∧
      tsupport R ⊆ tsupport (heatLocalizationSource χ (canonicalHeatTheta k h)) ∧
      (∀ w, heatLocalizationSource χ (canonicalHeatTheta k h) w = 0 → R w = 0) :=
  exists_compact_smooth_source_germ (canonicalHeat_off_contact_isOpen hk hh hhk)
    (fun _ hw => actualHeatLocalizationSource_contDiffAt_off_contact hk hh hhk hc hw.1 hw.2)
    ⟨ht,hx⟩

end AmericanConvexity.Stopping
