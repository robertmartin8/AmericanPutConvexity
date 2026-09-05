import AmericanConvexity.Stopping.HeatDensityEquation

/-! # Both normal traces and the density equation's flux matching

Reflection supplies the exterior-side derivative of a single heat layer.
For U=F-V/2, the density equation makes U's exterior derivative zero and
its interior derivative equal to the constructed density. The diffusivity
is 1/2, so the factor 1/2 in this potential is essential.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology BoundedContinuousFunction

theorem movingHeatLayer_reflect (d g : ℝ → ℝ) (T x : ℝ) :
    movingHeatLayer (fun s => -d s) g T (-x) = movingHeatLayer d g T x := by
  apply setIntegral_congr_fun measurableSet_Ioo
  intro s _
  dsimp only
  rw [show -x + -d s = -(x+d s) by ring]
  simp only [heatKernel,neg_sq]

theorem movingHeatLayer_hasDerivWithinAt_contact_left {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hsupport : ∀ s, T ≤ s → g s = 0) :
    HasDerivWithinAt (movingHeatLayer d g T)
      (g 0-∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s) (Iic 0) 0 := by
  have hr := movingHeatLayer_hasDerivWithinAt_contact hT hL hd.neg
    (fun s hs => by simpa only [Pi.neg_apply,norm_neg] using hmove s hs) hg hC hsupport
  have hneg : HasDerivWithinAt (fun x : ℝ => -x) (-1) (Iic 0) 0 :=
    (hasDerivAt_neg (0 : ℝ)).hasDerivWithinAt
  have hc := hr.comp_of_eq 0 hneg (show MapsTo (fun x : ℝ => -x) (Iic 0) (Ici 0) from
    by intro x hx; change x ≤ 0 at hx; change 0 ≤ -x; linarith) (by simp)
  have hfun : (movingHeatLayer (fun s => -d s) g T ∘ fun x => -x) = movingHeatLayer d g T :=
    funext (movingHeatLayer_reflect d g T)
  have hint : (∫ s in Ioo 0 T, heatBoundaryKernel s (-d s)*g s) =
      -(∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s) := by
    rw [← integral_neg]
    apply setIntegral_congr_fun measurableSet_Ioo
    intro s _
    dsimp only
    rw [heatBoundaryKernel_odd]
    ring
  change HasDerivWithinAt (movingHeatLayer (fun s => -d s) g T ∘ fun x => -x)
    (-(g 0+∫ s in Ioo 0 T, heatBoundaryKernel s (-d s)*g s)*(-1)) (Iic 0) 0 at hc
  rw [hfun,hint] at hc
  convert! hc using 1
  ring

/-- The integral equation is exactly the condition that kills exterior flux.
The forcing is twice the free term's spatial derivative, in heat coordinates. -/
theorem heatDensity_flux_matching {b F : ℝ → ℝ} {a D L t : ℝ}
    (hD : 0 < D) (hL : 0 ≤ L) (hb : Continuous b)
    (hmove : ∀ t s, 0 < s → ‖b t-b (t-s)‖ ≤ L*s)
    (f g : CausalBoundaryData a)
    (hf : f.1 t = g.1 t+heatHistory b D f.1 t) (ht : t ≤ a+D)
    (hF : HasDerivAt F (g.1 t/2) 0) :
    let d := fun s => b t-b (t-s)
    let U := fun x => F x-(1/2)*movingHeatLayer d (fun s => f.1 (t-s)) D x
    HasDerivWithinAt U 0 (Iic 0) 0 ∧ HasDerivWithinAt U (f.1 t) (Ici 0) 0 := by
  have hd : ContinuousOn (fun s => b t-b (t-s)) (Ioo 0 D) :=
    (continuous_const.sub (hb.comp (continuous_const.sub continuous_id))).continuousOn
  have hg : Continuous (fun s => f.1 (t-s)) := f.1.continuous.comp (continuous_const.sub continuous_id)
  have hs : ∀ s, D ≤ s → f.1 (t-s) = 0 := fun s hs => f.2 (t-s) (by linarith)
  have hl := movingHeatLayer_hasDerivWithinAt_contact_left hD hL hd
    (fun s hs => hmove t s hs.1) hg (fun s => f.1.norm_coe_le_norm (t-s)) hs
  have hr := movingHeatLayer_hasDerivWithinAt_contact hD hL hd
    (fun s hs => hmove t s hs.1) hg (fun s => f.1.norm_coe_le_norm (t-s)) hs
  simp only [sub_zero] at hl hr
  change f.1 t = g.1 t+∫ s in Ioo 0 D, heatBoundaryKernel s (b t-b (t-s))*f.1 (t-s) at hf
  constructor
  · convert! hF.hasDerivWithinAt.sub (hl.const_mul (1/2)) using 1
    linarith
  · convert! hF.hasDerivWithinAt.sub (hr.const_mul (1/2)) using 1
    linarith

end AmericanConvexity.Stopping
