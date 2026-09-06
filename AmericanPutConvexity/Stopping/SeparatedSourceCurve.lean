import AmericanPutConvexity.Stopping.SeparatedSourceEquation
import Mathlib.Analysis.Calculus.ContDiff.Deriv

/-! # C1 source-potential integrals along a C1 curve away from the source

Only the kernel is differentiated. The compact source is continuous, not
assumed smooth. A scalar curve parameter suffices for the boundary forcing,
so no boundary derivative beyond the already-proved C1 regularity is used.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff

noncomputable def sourcePlaneCurveDerivative (F Q : ℝ × ℝ → ℝ)
    (b v : ℝ → ℝ) (t : ℝ) : ℝ :=
  sourcePlaneIntegral (heatPartial F (1,0)) Q (b t,t)+
    v t*sourcePlaneIntegral (heatPartial F (0,1)) Q (b t,t)

theorem sourcePlaneIntegral_curve_hasDerivAt {F Q : ℝ × ℝ → ℝ}
    {b v : ℝ → ℝ} {U : Set ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hU : IsOpen U)
    (hb : ∀ t ∈ U, HasDerivAt b (v t) t) (hv : ContinuousOn v U)
    (hsep : ∀ t ∈ U, (b t,t) ∉ tsupport Q) {t : ℝ} (ht : t ∈ U) :
    HasDerivAt (fun s => sourcePlaneIntegral F Q (b s,s))
      (sourcePlaneCurveDerivative F Q b v t) t := by
  let D := fun (s : ℝ) (w : ℝ × ℝ) => heatPartial F (1,0) (s-w.2,b s-w.1)+
    v s*heatPartial F (0,1) (s-w.2,b s-w.1)
  have hpart (e : ℝ × ℝ) : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F e) z :=
    fun z hz => heatPartial_smoothAt (hF z hz) e
  have hcurve (s : ℝ) (hs : s ∈ U) (w : ℝ × ℝ) :
      ContinuousAt (fun p : ℝ × (ℝ × ℝ) => ((b p.1,p.1),p.2)) (s,w) :=
    (((hb s hs).continuousAt.comp continuousAt_fst).prodMk continuousAt_fst).prodMk continuousAt_snd
  have hd : HasDerivAt (fun s => ∫ w, F (s-w.2,b s-w.1)*Q w) (∫ w, D t w*Q w) t := by
    apply supported_planeIntegral_hasDeriv hQ hc hU
    · intro s hs w hw
      exact (sourcePlaneKernel_continuousAt hF (hsep s hs) hw).comp
        (x := (s,w)) (f := fun p : ℝ × (ℝ × ℝ) => ((b p.1,p.1),p.2)) (hcurve s hs w)
    · intro s hs w hw
      have ht' := (sourcePlaneKernel_continuousAt (hpart (1,0)) (hsep s hs) hw).comp
        (x := (s,w)) (f := fun p : ℝ × (ℝ × ℝ) => ((b p.1,p.1),p.2)) (hcurve s hs w)
      have hx' := (sourcePlaneKernel_continuousAt (hpart (0,1)) (hsep s hs) hw).comp
        (x := (s,w)) (f := fun p : ℝ × (ℝ × ℝ) => ((b p.1,p.1),p.2)) (hcurve s hs w)
      exact ht'.add (((hv s hs).continuousAt (hU.mem_nhds hs)).comp continuousAt_fst |>.mul hx')
    · intro s hs w hw
      have hfd := (hF (s-w.2,b s-w.1)
        (sourceKernel_offOrigin (hsep s hs) hw)).differentiableAt (by simp)
      have hh := hfd.hasFDerivAt.comp_hasDerivAt s
        (((hasDerivAt_id s).sub_const w.2).prodMk ((hb s hs).sub_const w.1))
      have he : fderiv ℝ F (s-w.2,b s-w.1) (1,v s) = D s w := by
        rw [show ((1,v s) : ℝ × ℝ) = (1,0)+v s • ((0,1) : ℝ × ℝ) by ext <;> simp,
          map_add,map_smul]
        rfl
      simpa only [Function.comp_def,he] using! hh
    · exact ht
  have hi₁ := sourcePlaneIntegral_integrable (hpart (1,0)) hQ hc (hsep t ht)
  have hi₂ := sourcePlaneIntegral_integrable (hpart (0,1)) hQ hc (hsep t ht)
  have he : (∫ w, D t w*Q w) = sourcePlaneCurveDerivative F Q b v t := by
    dsimp [D,sourcePlaneCurveDerivative,sourcePlaneIntegral]
    simp only [add_mul,mul_assoc]
    rw [integral_add hi₁ (hi₂.const_mul (v t)),integral_const_mul]
  rw [he] at hd
  exact hd

theorem sourcePlaneCurveDerivative_continuousOn {F Q : ℝ × ℝ → ℝ}
    {b v : ℝ → ℝ} {U : Set ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z)
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hb : ContinuousOn b U) (hv : ContinuousOn v U)
    (hsep : ∀ t ∈ U, (b t,t) ∉ tsupport Q) :
    ContinuousOn (sourcePlaneCurveDerivative F Q b v) U := by
  have hpart (e : ℝ × ℝ) := sourcePlaneIntegral_continuousOn
    (fun z hz => heatPartial_smoothAt (hF z hz) e) hQ hc
  exact ((hpart (1,0)).comp (hb.prodMk continuousOn_id) hsep).add
    (hv.mul ((hpart (0,1)).comp (hb.prodMk continuousOn_id) hsep))

theorem sourcePlaneIntegral_curve_contDiffOn_one {F Q : ℝ × ℝ → ℝ}
    {b v : ℝ → ℝ} {U : Set ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hU : IsOpen U)
    (hb : ∀ t ∈ U, HasDerivAt b (v t) t) (hv : ContinuousOn v U)
    (hsep : ∀ t ∈ U, (b t,t) ∉ tsupport Q) :
    ContDiffOn ℝ 1 (fun t => sourcePlaneIntegral F Q (b t,t)) U := by
  have hd (t : ℝ) (ht : t ∈ U) :=
    sourcePlaneIntegral_curve_hasDerivAt hF hQ hc hU hb hv hsep ht
  rw [contDiffOn_one_iff_derivWithin hU.uniqueDiffOn]
  refine ⟨fun t ht => (hd t ht).differentiableAt.differentiableWithinAt,?_⟩
  apply (sourcePlaneCurveDerivative_continuousOn hF hQ hc
    (fun t ht => (hb t ht).continuousAt.continuousWithinAt) hv hsep).congr
  intro t ht
  exact (hd t ht).hasDerivWithinAt.derivWithin (hU.uniqueDiffOn t ht)

end AmericanPutConvexity.Stopping
