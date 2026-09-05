import AmericanConvexity.Stopping.LocalHeatSource
import AmericanConvexity.Stopping.SeparatedSourceBridge

/-! # The heat potential equation for locally smooth sources

The source need only be smooth on an open neighborhood of the evaluation
point. Smooth localization handles the nearby source, and the source-time
kernel proof handles the remainder. This applies on both sides of the actual
exercise graph without assuming any smoothness across that graph.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory Boundary
open MathFin.FeynmanKacHeatEquation
open scoped Topology ContDiff

theorem heatSourceAverage_add {Q R : ℝ × ℝ → ℝ}
    (hQ : Continuous Q) (hcQ : HasCompactSupport Q)
    (hR : Continuous R) (hcR : HasCompactSupport R) (u : ℝ) (z : ℝ × ℝ) :
    heatSourceAverage (Q+R) u z = heatSourceAverage Q u z+heatSourceAverage R u z := by
  obtain ⟨C,hC⟩ := hcQ.exists_bound_of_continuous hQ
  obtain ⟨B,hB⟩ := hcR.exists_bound_of_continuous hR
  unfold heatSourceAverage heatSourceMoment
  simp only [Pi.add_apply,mul_add]
  exact integral_add (heatSourceMoment_integrable (integrable_heatKernel (by norm_num)) hQ hC u z)
    (heatSourceMoment_integrable (integrable_heatKernel (by norm_num)) hR hB u z)

theorem heatSourcePotential_add {Q R : ℝ × ℝ → ℝ}
    (hQ : Continuous Q) (hcQ : HasCompactSupport Q)
    (hR : Continuous R) (hcR : HasCompactSupport R) (D : ℝ) (z : ℝ × ℝ) :
    heatSourcePotential (Q+R) D z = heatSourcePotential Q D z+heatSourcePotential R D z := by
  obtain ⟨C,hC⟩ := hcQ.exists_bound_of_continuous hQ
  obtain ⟨B,hB⟩ := hcR.exists_bound_of_continuous hR
  unfold heatSourcePotential
  simp_rw [heatSourceAverage_add hQ hcQ hR hcR]
  exact integral_add (heatSourceAverage_integrable_time hQ hC z)
    (heatSourceAverage_integrable_time hR hB z)

theorem source_deriv2_add_at {f g : ℝ → ℝ} {x : ℝ}
    (hf : ContDiffAt ℝ 2 f x) (hg : ContDiffAt ℝ 2 g x) :
    deriv (deriv (fun y => f y+g y)) x = deriv (deriv f) x+deriv (deriv g) x := by
  simpa only [iteratedDeriv_succ,iteratedDeriv_zero,Pi.add_apply] using! iteratedDeriv_add (n := 2) hf hg

theorem local_heatSourcePotential_regular {Q : ℝ × ℝ → ℝ} {a D : ℝ} {U : Set (ℝ × ℝ)}
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hD : 0 < D)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    (hU : IsOpen U) (hsmooth : ∀ w ∈ U, ContDiffAt ℝ ∞ Q w)
    {x t : ℝ} (hz : (x,t) ∈ U) (ht : t < a+D) :
    ContDiffAt ℝ 2 (fun y => heatSourcePotential Q D (y,t)) x ∧
    DifferentiableAt ℝ (fun s => heatSourcePotential Q D (x,s)) t ∧
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x+Q (x,t) := by
  obtain ⟨R,hR,hRc,heq,_,hzero⟩ := exists_compact_smooth_source_germ hU hsmooth hz
  obtain ⟨hS,hSc,hSz⟩ := compact_smooth_source_remainder hQ hc hR hRc heq
  have hRa : ∀ w : ℝ × ℝ, w.2 ≤ a → R w = 0 := source_germ_causal hcausal hzero
  have hSa : ∀ w : ℝ × ℝ, w.2 ≤ a → (Q-R) w = 0 := by
    intro w hw
    simp [hcausal w hw,hRa w hw]
  have he : heatSourcePotential Q D =
      (fun w => heatSourcePotential R D w+heatSourcePotential (Q-R) D w) := by
    funext w
    rw [← heatSourcePotential_add hR.continuous hRc hS hSc]
    congr 1
    ext v
    simp
  have hRx : ContDiffAt ℝ 2 (fun y => heatSourcePotential R D (y,t)) x :=
    (smooth_heatSourcePotential_contDiff_space hR hRc D t 2).contDiffAt
  have hSx := separated_heatSourcePotential_contDiffAt_space hS hSc hSa hSz ht 2
  have hRt := (smooth_heatSourcePotential_hasDeriv_time hR hRc D x t).differentiableAt
  have hSt := separated_heatSourcePotential_differentiableAt_time hS hSc hSa hSz ht
  rw [he]
  refine ⟨hRx.add hSx,hRt.add hSt,?_⟩
  dsimp only
  rw [deriv_fun_add hRt hSt,source_deriv2_add_at hRx hSx,
    smooth_heatSourcePotential_equation hR hRc hD hRa x t ht.le,
    separated_heatSourcePotential_equation hS hSc hSa hSz ht,heq.self_of_nhds]
  ring

theorem actualHeatSourcePotential_regular {k h a D : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 ≤ a) (hD : 0 < D)
    (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2))
    {x t : ℝ} (ht : 0 < t) (htD : t < a+D)
    (hx : x ≠ canonicalLogBoundary k h (t/2)) :
    let Q := heatLocalizationSource χ (canonicalHeatTheta k h)
    ContDiffAt ℝ 2 (fun y => heatSourcePotential Q D (y,t)) x ∧
    DifferentiableAt ℝ (fun s => heatSourcePotential Q D (x,s)) t ∧
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x+Q (x,t) :=
  local_heatSourcePotential_regular
    (actualHeatLocalizationSource_continuous hk hh hhk ha hc hs htrans)
    (heatLocalizationSource_hasCompactSupport hcomp _) hD
    (heatLocalizationSource_causal hs _)
    (canonicalHeat_off_contact_isOpen hk hh hhk)
    (fun _ hz => actualHeatLocalizationSource_contDiffAt_off_contact hk hh hhk hc hz.1 hz.2)
    ⟨ht,hx⟩ htD

theorem zeroDividend_actualHeatSourcePotential_equation {k a D : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (ha : 0 ≤ a) (hD : 0 < D)
    (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k 0 (z.2/2))
    {x t : ℝ} (ht : 0 < t) (htD : t < a+D)
    (hx : x ≠ canonicalLogBoundary k 0 (t/2)) :
    let Q := heatLocalizationSource χ (canonicalHeatTheta k 0)
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x+Q (x,t) :=
  (actualHeatSourcePotential_regular hk le_rfl hk.le ha hD hc hcomp hs htrans ht htD hx).2.2

theorem liuRange_actualHeatSourcePotential_equation {k h a D : ℝ} {χ : ℝ × ℝ → ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ha : 0 ≤ a) (hD : 0 < D)
    (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2))
    {x t : ℝ} (ht : 0 < t) (htD : t < a+D)
    (hx : x ≠ canonicalLogBoundary k h (t/2)) :
    let Q := heatLocalizationSource χ (canonicalHeatTheta k h)
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x+Q (x,t) := by
  exact (actualHeatSourcePotential_regular (by linarith) hh (by linarith)
    ha hD hc hcomp hs htrans ht htD hx).2.2

end AmericanConvexity.Stopping
