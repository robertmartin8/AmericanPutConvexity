import AmericanPutConvexity.Stopping.HeatRepresentationIdentification
import AmericanPutConvexity.Stopping.ActualHeatForcing
import Mathlib.Topology.Algebra.MetricSpace.Lipschitz

/-! # Representation and normal derivative for localized actual theta

All regularity, support, boundary, and PDE premises of the representation
theorem are discharged for actual theta. The remaining input is the density
equation already constructed by ActualHeatForcing.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory Boundary
open scoped Topology ContDiff BoundedContinuousFunction

theorem canonicalHeatGraph_clamp_window_bound {k h a T : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a) :
    ∃ L : ℝ, 0 ≤ L ∧ ∀ t, a ≤ t → t ≤ T → ∀ u, 0 < u →
      ‖canonicalLogBoundary k h (max a t/2)-canonicalLogBoundary k h (max a (t-u)/2)‖ ≤ L*u := by
  have hloc := (canonicalLogBoundary_locallyLipschitzOn hk hh hhk).mono
    (show Icc (a/2) (T/2) ⊆ Ioi 0 from fun _ hx => (half_pos ha).trans_le hx.1)
  obtain ⟨L,hLip⟩ := hloc.exists_lipschitzOnWith_of_compact isCompact_Icc
  refine ⟨L,L.coe_nonneg,?_⟩
  intro t hat ht u hu
  have hmax : max a t = t := max_eq_right hat
  have hlow : a ≤ max a (t-u) := le_max_left _ _
  have hhigh : max a (t-u) ≤ t := max_le hat (by linarith)
  have hdiff : t-max a (t-u) ≤ u := by have := le_max_right a (t-u); linarith
  have he := hLip.dist_le_mul (t/2)
    (show t/2 ∈ Icc (a/2) (T/2) from ⟨by linarith,by linarith⟩)
    (max a (t-u)/2) (show max a (t-u)/2 ∈ Icc (a/2) (T/2) from ⟨by linarith,by linarith⟩)
  rw [dist_eq_norm,Real.dist_eq,abs_of_nonneg (by linarith : 0 ≤ t/2-max a (t-u)/2)] at he
  rw [hmax]
  exact he.trans (mul_le_mul_of_nonneg_left (by linarith : t/2-max a (t-u)/2 ≤ u) L.coe_nonneg)

theorem actualHeatTheta_localized_representation {k h a D T : ℝ} {χ : ℝ × ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha : 0 < a)
    (hD : 0 < D) (hT : T < a+D)
    (hc : ContDiff ℝ ∞ χ) (hcomp : HasCompactSupport χ)
    (hs : ∀ z ∈ tsupport χ, a < z.2)
    (htrans : ∀ z ∈ tsupport (heatPartial χ (1,0)),
      z.1 ≠ canonicalLogBoundary k h (z.2/2))
    (f : CausalBoundaryData a)
    (heq : ∀ s ∈ Icc a T, f.1 s =
      2*heatSourcePotentialSpatial (heatLocalizationSource χ (canonicalHeatTheta k h)) D
        (canonicalLogBoundary k h (s/2),s)+
      ∫ u in Ioo 0 (s-a), heatBoundaryKernel u
        (canonicalLogBoundary k h (s/2)-canonicalLogBoundary k h ((s-u)/2))*f.1 (s-u)) :
    let b := fun s => canonicalLogBoundary k h (max a s/2)
    let Q := heatLocalizationSource χ (canonicalHeatTheta k h)
    (∀ z ∈ movingHalfStrip b a T,
      heatRepresentationCandidate Q b f.1 D z = χ z*canonicalHeatTheta k h z) ∧
    (∀ s, a < s → s ≤ T →
      HasDerivWithinAt (fun x => χ (x,s)*canonicalHeatTheta k h (x,s)) (f.1 s)
        (Ici (canonicalLogBoundary k h (s/2))) (canonicalLogBoundary k h (s/2))) := by
  let b := fun s => canonicalLogBoundary k h (max a s/2)
  let Q := heatLocalizationSource χ (canonicalHeatTheta k h)
  let W := fun z => χ z*canonicalHeatTheta k h z
  have hb : Continuous b := canonicalHeatGraph_clamp_continuous hk hh hhk ha
  have hb_eq (s : ℝ) (has : a ≤ s) : b s = canonicalLogBoundary k h (s/2) := by
    dsimp [b]
    rw [max_eq_right has]
  have hQ : Continuous Q := actualHeatLocalizationSource_continuous hk hh hhk ha.le hc hs htrans
  have hQc : HasCompactSupport Q := heatLocalizationSource_hasCompactSupport hcomp _
  obtain ⟨Cq,hCq⟩ := hQc.exists_bound_of_continuous hQ
  have hQa : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0 := heatLocalizationSource_causal hs _
  have hW : Continuous W := actualHeatTheta_localization_continuous hk hh hhk ha.le hc.continuous hs
  obtain ⟨Cw,hCw⟩ := actualHeatTheta_localization_bounded hk hh hhk ha.le hc.continuous hcomp hs
  obtain ⟨L,hL,hmove⟩ := canonicalHeatGraph_clamp_window_bound (T := T) hk hh hhk ha
  have hqs (z : ℝ × ℝ) (haz : a < z.2) (hx : z.1 ≠ b z.2) : ContDiffAt ℝ ∞ Q z := by
    rw [hb_eq z.2 haz.le] at hx
    exact actualHeatLocalizationSource_contDiffAt_off_contact hk hh hhk hc (ha.trans haz) hx
  have hqz (x s : ℝ) (has : a < s) (_ : s ≤ T) (hx : x < b s) : Q (x,s) = 0 := by
    rw [hb_eq s has.le] at hx
    exact actualHeatLocalizationSource_exercise_zero hk hh hhk (ha.trans has) hx.le htrans
  have hfeq (s : ℝ) (has : a < s) (hst : s ≤ T) :
      f.1 s = 2*heatSourcePotentialSpatial Q D (b s,s)+heatHistory b D f.1 s := by
    rw [heatHistory_eq_causal_past f.2 (hst.trans_lt hT).le,hb_eq s has.le,heq s ⟨has.le,hst⟩]
    congr 1
    apply setIntegral_congr_fun measurableSet_Ioo
    intro u hu
    dsimp only
    rw [hb_eq (s-u) (by linarith [hu.2])]
  have hWs (x s : ℝ) (has : a < s) (hx : b s < x) : ContDiffAt ℝ ∞ W (x,s) := by
    rw [hb_eq s has.le] at hx
    exact hc.contDiffAt.mul (canonicalHeatTheta_contDiffAt hk hh hhk (ha.trans has) hx)
  have hWe (x s : ℝ) (has : a < s) (_ : s ≤ T) (hx : b s < x) :
      deriv (fun v => W (x,v)) s = (1/2)*deriv (deriv (fun y => W (y,s))) x+Q (x,s) := by
    rw [hb_eq s has.le] at hx
    have he := actualHeatLocalizationSource_equation hk hh hhk hc (ha.trans has) hx
    change deriv (fun v => W (x,v)) s-(1/2)*deriv (deriv (fun y => W (y,s))) x = Q (x,s) at he
    linarith
  have hWi (x : ℝ) (_ : b a ≤ x) : W (x,a) = 0 := by
    have hχ : χ (x,a) = 0 := image_eq_zero_of_notMem_tsupport (fun hz => (lt_irrefl a) (hs (x,a) hz))
    simp [W,hχ]
  have hWl (s : ℝ) (has : a ≤ s) (_ : s ≤ T) : W (b s,s) = 0 := by
    dsimp [W]
    rw [canonicalHeatTheta_exercise_zero hk hh hhk (ha.trans_le has) (by rw [hb_eq s has]),mul_zero]
  have hident := heatRepresentationCandidate_identification hD hL hT hQ hQc hQa hb
    f.1.continuous (fun s => f.1.norm_coe_le_norm s) f.2 hqs hqz
    (fun s has hst u hu => hmove s has.le hst u hu.1) hfeq hW.continuousOn
    (fun z _ => hCw z)
    (fun x s has _ hx => ((hWs x s has hx).comp x
      (show ContDiffAt ℝ ∞ (fun y : ℝ => (y,s)) x by fun_prop)).of_le (WithTop.coe_le_coe.mpr le_top))
    (fun x s has _ hx => ((hWs x s has hx).comp s
      (show ContDiffAt ℝ ∞ (fun v : ℝ => (x,v)) s by fun_prop)).differentiableAt (by simp))
    hWe hWi hWl
  refine ⟨hident,?_⟩
  intro s has hst
  have hd := heatRepresentation_transfer_right_trace hD hL hQ hQc hCq hb f.1.continuous
    (fun u => f.1.norm_coe_le_norm u) f.2 has.le hst (hst.trans_lt hT).le
    (fun u hu => hmove s has.le hst u hu.1) (hfeq s has hst) hident
  simpa only [hb_eq s has.le] using hd

end AmericanPutConvexity.Stopping
