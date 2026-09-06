import AmericanPutConvexity.Stopping.MovingHeatJump
import Mathlib.Analysis.Calculus.ParametricIntegral
import Mathlib.Analysis.Calculus.FDeriv.Extend

/-! # Spatial differentiation and normal flux of a heat layer potential

The displacement d(s) describes the moving graph in elapsed heat time.
All integrals include arbitrarily small positive elapsed times. Integrable
Gaussian bounds justify differentiation; the normal-kernel jump then gives
both the interior derivative trace and the genuine right-sided derivative
of the potential at contact. No derivative of d is assumed.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology

theorem heatKernel_inverse_sqrt_bound {s : ℝ} (hs : 0 < s) (x : ℝ) :
    ‖heatKernel s x‖ ≤ (Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt s)⁻¹ := by
  have he : Real.exp (-(x^2)/(2*s)) ≤ 1 := Real.exp_le_one_iff.mpr
    (div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (sq_nonneg x)) (by positivity))
  rw [Real.norm_of_nonneg (heatKernel_nonneg hs x)]
  unfold heatKernel
  calc
    _ ≤ (Real.sqrt (2*Real.pi*s))⁻¹*1 :=
      mul_le_mul_of_nonneg_left he (by positivity)
    _ = _ := by rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi),mul_inv_rev]; ring

theorem heatBoundaryKernel_away_bound {s a x : ℝ} (hs : 0 < s) (ha : 0 < a)
    (hx : a ≤ x) :
    ‖heatBoundaryKernel s x‖ ≤ (2/(a*Real.sqrt (2*Real.pi)))*(Real.sqrt s)⁻¹ := by
  have hx0 : 0 < x := ha.trans_le hx
  have he := (Real.mul_exp_neg_le_exp_neg_one (x^2/(2*s))).trans
    (Real.exp_le_one_iff.mpr (by norm_num : (-1 : ℝ) ≤ 0))
  have hex : (x/s)*Real.exp (-(x^2)/(2*s)) ≤ 2/x := by
    have hm := mul_le_mul_of_nonneg_left he (by positivity : 0 ≤ 2/x)
    convert! hm using 1 <;> field_simp
  have hax : 2/x ≤ 2/a := div_le_div_of_nonneg_left (by norm_num) ha hx
  rw [Real.norm_of_nonneg (heatBoundaryKernel_pos hs hx0).le]
  unfold heatBoundaryKernel heatKernel
  calc
    _ = ((x/s)*Real.exp (-(x^2)/(2*s)))*(Real.sqrt (2*Real.pi*s))⁻¹ := by ring
    _ ≤ (2/a)*(Real.sqrt (2*Real.pi*s))⁻¹ :=
      mul_le_mul_of_nonneg_right (hex.trans hax) (by positivity)
    _ = _ := by rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi),mul_inv_rev]; ring

theorem movingHeatBoundaryKernel_away_bound {s a x d L : ℝ}
    (hs : 0 < s) (ha : 0 < a) (hx : a ≤ x) (hd : ‖d‖ ≤ L*s) :
    ‖heatBoundaryKernel s (x+d)‖ ≤
      ((2/a+3*L)/Real.sqrt (2*Real.pi))*(Real.sqrt s)⁻¹ := by
  calc
    _ ≤ ‖heatBoundaryKernel s (x+d)-heatBoundaryKernel s x‖+‖heatBoundaryKernel s x‖ :=
      norm_le_norm_sub_add _ _
    _ ≤ ((3*L/Real.sqrt (2*Real.pi))/Real.sqrt s) +
        (2/(a*Real.sqrt (2*Real.pi)))*(Real.sqrt s)⁻¹ :=
      add_le_add (heatBoundaryKernel_lipschitz_motion_bound hs hd x)
        (heatBoundaryKernel_away_bound hs ha hx)
    _ = _ := by ring

noncomputable def movingHeatLayer (d g : ℝ → ℝ) (T x : ℝ) : ℝ :=
  ∫ s in Ioo 0 T, heatKernel s (x+d s)*g s

noncomputable def movingHeatLayerFlux (d g : ℝ → ℝ) (T : ℝ) : ℝ :=
  -(g 0 + ∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s)

theorem movingHeatLayer_integrand_continuousOn {d g : ℝ → ℝ} {T : ℝ}
    (hd : ContinuousOn d (Ioo 0 T)) (hg : Continuous g) (x : ℝ) :
    ContinuousOn (fun s => heatKernel s (x+d s)*g s) (Ioo 0 T) := by
  intro s hs
  exact ((heatKernel_smoothAt (x := x+d s) hs.1).continuousAt.comp_continuousWithinAt
    (f := fun u : ℝ => (u,x+d u))
    (continuousWithinAt_id.prodMk (continuousWithinAt_const.add (hd s hs)))).mul
    hg.continuousAt.continuousWithinAt

theorem movingHeatLayer_integrable {d g : ℝ → ℝ} {T C : ℝ}
    (hT : 0 < T) (hd : ContinuousOn d (Ioo 0 T)) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (x : ℝ) :
    IntegrableOn (fun s => heatKernel s (x+d s)*g s) (Ioo 0 T) := by
  apply ((integrableOn_inverse_sqrt hT).const_mul ((Real.sqrt (2*Real.pi))⁻¹*C)).mono'
    ((movingHeatLayer_integrand_continuousOn hd hg x).aestronglyMeasurable measurableSet_Ioo)
  filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
  rw [norm_mul]
  calc
    _ ≤ ((Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt s)⁻¹)*C :=
      mul_le_mul (heatKernel_inverse_sqrt_bound hs.1 _) (hC s) (norm_nonneg _) (by positivity)
    _ = _ := by ring

/-- The layer itself is continuous across contact, unlike its normal derivative. -/
theorem movingHeatLayer_continuous {d g : ℝ → ℝ} {T C : ℝ}
    (hT : 0 < T) (hd : ContinuousOn d (Ioo 0 T)) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) : Continuous (movingHeatLayer d g T) := by
  apply continuous_of_dominated
    (bound := fun s => ((Real.sqrt (2*Real.pi))⁻¹*C)*(Real.sqrt s)⁻¹)
  · intro x
    exact (movingHeatLayer_integrable hT hd hg hC x).aestronglyMeasurable
  · intro x
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    rw [norm_mul]
    calc
      _ ≤ ((Real.sqrt (2*Real.pi))⁻¹*(Real.sqrt s)⁻¹)*C :=
        mul_le_mul (heatKernel_inverse_sqrt_bound hs.1 _) (hC s) (norm_nonneg _) (by positivity)
      _ = _ := by ring
  · exact (integrableOn_inverse_sqrt hT).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    exact ((continuous_iff_continuousAt.mpr fun y =>
      (heatKernel_hasDeriv_space hs.1 y).continuousAt).comp
        (continuous_id.add continuous_const)).mul continuous_const

theorem movingHeatLayer_hasDerivAt {d g : ℝ → ℝ} {T L C x : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hx : 0 < x) :
    HasDerivAt (movingHeatLayer d g T)
      (∫ s in Ioo 0 T, -(heatBoundaryKernel s (x+d s)*g s)) x := by
  have hmeas (u : ℝ) : AEStronglyMeasurable
      (fun s => -(heatBoundaryKernel s (u+d s)*g s)) (volume.restrict (Ioo 0 T)) := by
    apply ContinuousOn.aestronglyMeasurable _ measurableSet_Ioo
    intro s hs
    exact (((heatBoundaryKernel_smoothAt (x := u+d s) hs.1).continuousAt.comp_continuousWithinAt
      (f := fun v : ℝ => (v,u+d v))
      (continuousWithinAt_id.prodMk (continuousWithinAt_const.add (hd s hs)))).mul
        hg.continuousAt.continuousWithinAt).neg
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (F := fun u s => heatKernel s (u+d s)*g s)
    (F' := fun u s => -(heatBoundaryKernel s (u+d s)*g s))
    (bound := fun s => ((2/(x/2)+3*L)/Real.sqrt (2*Real.pi)*C)*(Real.sqrt s)⁻¹)
    (Ioi_mem_nhds (half_lt_self hx))
    (Eventually.of_forall fun u => (movingHeatLayer_integrable hT hd hg hC u).aestronglyMeasurable)
    (movingHeatLayer_integrable hT hd hg hC x) (hmeas x) ?_
    ((integrableOn_inverse_sqrt hT).const_mul _) ?_).2
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    intro u hu
    rw [norm_neg,norm_mul]
    calc
      _ ≤ (((2/(x/2)+3*L)/Real.sqrt (2*Real.pi))*(Real.sqrt s)⁻¹)*C :=
        mul_le_mul (movingHeatBoundaryKernel_away_bound hs.1 (half_pos hx) hu.le (hmove s hs))
          (hC s) (norm_nonneg _) (by positivity)
      _ = _ := by ring
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    intro u _
    convert! (((heatKernel_hasDeriv_space hs.1 (u+d s)).comp u
      ((hasDerivAt_id u).add_const (d s))).mul_const (g s)) using 1
    dsimp [heatBoundaryKernel]
    ring

theorem movingHeatLayer_deriv_tendsto {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hsupport : ∀ s, T ≤ s → g s = 0) :
    Tendsto (deriv (movingHeatLayer d g T)) (𝓝[>] (0 : ℝ))
      (𝓝 (-(g 0 + ∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s))) := by
  apply (movingHeatBoundaryKernel_jump hT hL hd hmove hg hC hsupport).neg.congr'
  filter_upwards [self_mem_nhdsWithin] with x hx
  rw [(movingHeatLayer_hasDerivAt hT hL hd hmove hg hC hx).deriv,integral_neg]

/-- The one-sided derivative exists, with the same value as the interior flux trace. -/
theorem movingHeatLayer_hasDerivWithinAt_contact {d g : ℝ → ℝ} {T L C : ℝ}
    (hT : 0 < T) (hL : 0 ≤ L) (hd : ContinuousOn d (Ioo 0 T))
    (hmove : ∀ s ∈ Ioo 0 T, ‖d s‖ ≤ L*s) (hg : Continuous g)
    (hC : ∀ s, ‖g s‖ ≤ C) (hsupport : ∀ s, T ≤ s → g s = 0) :
    HasDerivWithinAt (movingHeatLayer d g T)
      (-(g 0 + ∫ s in Ioo 0 T, heatBoundaryKernel s (d s)*g s)) (Ici 0) 0 := by
  apply hasDerivWithinAt_Ici_of_tendsto_deriv (s := Ioi (0 : ℝ))
    (fun x hx => (movingHeatLayer_hasDerivAt hT hL hd hmove hg hC hx).differentiableAt.differentiableWithinAt)
    (movingHeatLayer_continuous hT hd hg hC).continuousAt.continuousWithinAt self_mem_nhdsWithin
    (movingHeatLayer_deriv_tendsto hT hL hd hmove hg hC hsupport)

/-- Uniform Lipschitz motion makes the flux continuous in a parameter whenever
the displacements and densities depend continuously on it. A derivative of
the moving graph is still not required. -/
theorem movingHeatLayerFlux_continuous {ι : Type*} [TopologicalSpace ι] [FirstCountableTopology ι]
    {d g : ι → ℝ → ℝ} {T L C : ℝ} (hT : 0 < T) (hL : 0 ≤ L)
    (hd : ∀ p, ContinuousOn (d p) (Ioo 0 T))
    (hmove : ∀ p s, s ∈ Ioo 0 T → ‖d p s‖ ≤ L*s)
    (hg : ∀ p, Continuous (g p)) (hC : ∀ p s, ‖g p s‖ ≤ C)
    (hdp : ∀ s ∈ Ioo 0 T, Continuous (fun p => d p s))
    (hgp : ∀ s, Continuous (fun p => g p s)) :
    Continuous (fun p => movingHeatLayerFlux (d p) (g p) T) := by
  apply ((hgp 0).add ?_).neg
  apply continuous_of_dominated
    (bound := fun s => (3*L/Real.sqrt (2*Real.pi)*C)*(Real.sqrt s)⁻¹)
  · intro p
    have he : movingHeatRemainder (d p) (g p) 0 =
        (fun s => heatBoundaryKernel s (d p s)*g p s) := by
      funext s
      simp only [movingHeatRemainder,zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero]
    rw [← he]
    exact (movingHeatRemainder_integrable hT hL (hd p) (hmove p) (hg p) (hC p) 0).aestronglyMeasurable
  · intro p
    filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    simpa only [movingHeatRemainder,zero_add,heatBoundaryKernel,zero_div,zero_mul,sub_zero]
      using movingHeatRemainder_bound hL hs.1 (hmove p s hs) (hC p s) 0
  · exact (integrableOn_inverse_sqrt hT).const_mul _
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    exact ((continuous_iff_continuousAt.mpr fun y =>
      (heatBoundaryKernel_hasDeriv_space hs.1 y).continuousAt).comp (hdp s hs)).mul (hgp s)

end AmericanPutConvexity.Stopping
