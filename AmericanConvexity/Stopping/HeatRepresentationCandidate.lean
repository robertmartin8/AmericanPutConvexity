import AmericanConvexity.Stopping.LocalSourceEquation
import AmericanConvexity.Stopping.MovingHeatLayerBridge

/-! # The source-potential and boundary-layer candidate

For diffusivity 1/2 the candidate is F - V/2. Its PDE is the source PDE,
and its density equation imposes zero exterior flux and interior flux f.
These are properties of a constructed function, not yet its identification
with a prescribed free-boundary solution.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff

noncomputable def heatRepresentationCandidate (Q : ℝ × ℝ → ℝ)
    (b f : ℝ → ℝ) (D : ℝ) (z : ℝ × ℝ) : ℝ :=
  heatSourcePotential Q D z-(1/2)*causalMovingHeatLayer b f z

theorem heatRepresentationCandidate_continuousOn {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D Cq Cf : ℝ} (hD : 0 < D)
    (hQ : Continuous Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq) (hb : Continuous b)
    (hf : Continuous f) (hCf : ∀ t, ‖f t‖ ≤ Cf) (hfa : ∀ t, t ≤ a → f t = 0) :
    ContinuousOn (heatRepresentationCandidate Q b f D) {z | z.2 ≤ a+D} :=
  (heatSourcePotential_continuous hQ hCq).continuousOn.sub
    (continuousOn_const.mul (causalMovingHeatLayer_continuousOn_window hD hb hf hCf hfa))

theorem heatRepresentationCandidate_bound {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D Cq Cf : ℝ} (hD : 0 < D)
    (hCq : ∀ z, ‖Q z‖ ≤ Cq) (hCf : ∀ t, ‖f t‖ ≤ Cf)
    (hfa : ∀ t, t ≤ a → f t = 0) (z : ℝ × ℝ) (ht : z.2 ≤ a+D) :
    ‖heatRepresentationCandidate Q b f D z‖ ≤
      volume.real (Ioo 0 D)*(heatSourceAverageConstant*Cq)+
        (1/2)*((2*Cf/Real.sqrt (2*Real.pi))*Real.sqrt D) := by
  unfold heatRepresentationCandidate
  apply (norm_sub_le _ _).trans
  rw [norm_mul,Real.norm_of_nonneg (by norm_num : (0 : ℝ) ≤ 1/2)]
  exact add_le_add (heatSourcePotential_bound hCq z)
    (mul_le_mul_of_nonneg_left (causalMovingHeatLayer_bound_window hD hCf hfa ht z.1) (by norm_num))

theorem heatRepresentationCandidate_causal {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D : ℝ}
    (hQa : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0) (hfa : ∀ t, t ≤ a → f t = 0)
    (z : ℝ × ℝ) (ht : z.2 ≤ a) : heatRepresentationCandidate Q b f D z = 0 := by
  rw [heatRepresentationCandidate,heatSourcePotential_causal hQa z ht,
    causalMovingHeatLayer_zero_initial hfa ht,mul_zero,sub_zero]

theorem heat_deriv2_sub_at {F G : ℝ → ℝ} {x : ℝ}
    (hF : ContDiffAt ℝ 2 F x) (hG : ContDiffAt ℝ 2 G x) :
    deriv (deriv (fun y => F y-G y)) x = deriv (deriv F) x-deriv (deriv G) x := by
  simpa only [iteratedDeriv_succ,iteratedDeriv_zero,Pi.sub_apply] using! iteratedDeriv_sub (n := 2) hF hG

theorem heat_deriv2_const_mul_at {F : ℝ → ℝ} {x : ℝ}
    (hF : ContDiffAt ℝ 2 F x) (c : ℝ) :
    deriv (deriv (fun y => c*F y)) x = c*deriv (deriv F) x := by
  simpa only [iteratedDeriv_succ,iteratedDeriv_zero] using! iteratedDeriv_const_mul (n := 2) c hF

theorem heatRepresentationCandidate_regular {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D : ℝ} (hD : 0 < D)
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hQa : ∀ z : ℝ × ℝ, z.2 ≤ a → Q z = 0)
    (hb : Continuous b) (hf : Continuous f) (hfa : ∀ t, t ≤ a → f t = 0)
    (hsmooth : ∀ z : ℝ × ℝ, a < z.2 → z.1 ≠ b z.2 → ContDiffAt ℝ ∞ Q z)
    {x t : ℝ} (hta : a < t) (htD : t < a+D) (hx : x ≠ b t) :
    ContDiffAt ℝ 2 (fun y => heatRepresentationCandidate Q b f D (y,t)) x ∧
    DifferentiableAt ℝ (fun s => heatRepresentationCandidate Q b f D (x,s)) t ∧
    deriv (fun s => heatRepresentationCandidate Q b f D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatRepresentationCandidate Q b f D (y,t))) x+Q (x,t) := by
  have hU : IsOpen {z : ℝ × ℝ | a < z.2 ∧ z.1 ≠ b z.2} :=
    (isOpen_lt continuous_const continuous_snd).inter
      (isOpen_ne_fun continuous_fst (hb.comp continuous_snd))
  obtain ⟨hFx,hFt,hFe⟩ := local_heatSourcePotential_regular hQ hc hD hQa hU
    (fun _ hz => hsmooth _ hz.1 hz.2) ⟨hta,hx⟩ htD
  have hVx := causalMovingHeatLayer_contDiffAt_space_of_causal hb hf hfa hx
  have hVt := causalMovingHeatLayer_differentiableAt_time_of_causal hb hf hfa hx
  refine ⟨hFx.sub (contDiffAt_const.mul hVx),hFt.sub (hVt.const_mul (1/2)),?_⟩
  unfold heatRepresentationCandidate
  rw [deriv_fun_sub hFt (hVt.const_mul (1/2)),deriv_const_mul (1/2) hVt,
    heat_deriv2_sub_at hFx (contDiffAt_const.mul hVx),heat_deriv2_const_mul_at hVx,
    hFe,causalMovingHeatLayer_equation_of_causal hb hf hfa hx]
  ring

theorem heatRepresentationCandidate_shifted_traces {Q : ℝ × ℝ → ℝ}
    {b f : ℝ → ℝ} {a D Cq Cf L t : ℝ} (hD : 0 < D) (hL : 0 ≤ L)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (hCq : ∀ z, ‖Q z‖ ≤ Cq)
    (hb : Continuous b) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ Cf)
    (hfa : ∀ s, s ≤ a → f s = 0) (ht : t ≤ a+D)
    (hmove : ∀ u ∈ Ioo 0 D, ‖b t-b (t-u)‖ ≤ L*u)
    (heq : f t = 2*heatSourcePotentialSpatial Q D (b t,t)+heatHistory b D f t) :
    HasDerivWithinAt (fun x => heatRepresentationCandidate Q b f D (b t+x,t)) 0 (Iic 0) 0 ∧
    HasDerivWithinAt (fun x => heatRepresentationCandidate Q b f D (b t+x,t)) (f t) (Ici 0) 0 := by
  obtain ⟨hl,hr⟩ := causalMovingHeatLayer_normal_traces hD hL hb hf hCf hfa ht hmove
  have hF : HasDerivAt (fun x => heatSourcePotential Q D (b t+x,t))
      (heatSourcePotentialSpatial Q D (b t,t)) 0 := by
    simpa only [add_zero,mul_one,id_eq,Function.comp_apply] using!
      (heatSourcePotential_hasDerivAt hD hQ hc hCq (b t+0) t).comp 0
        ((hasDerivAt_id 0).const_add (b t))
  constructor
  · convert! hF.hasDerivWithinAt.sub (hl.const_mul (1/2)) using 1
    linarith
  · convert! hF.hasDerivWithinAt.sub (hr.const_mul (1/2)) using 1
    linarith

end AmericanConvexity.Stopping
