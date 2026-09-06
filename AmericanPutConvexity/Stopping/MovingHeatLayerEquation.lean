import AmericanPutConvexity.Stopping.CausalHeatKernel
import Mathlib.Analysis.Calculus.ContDiff.Deriv

/-! # The heat-layer PDE for a merely continuous moving graph

Source time is the integration variable. All differentiation is in the
evaluation point, so neither the graph nor the density is differentiated.
Compact continuous densities give a classical heat solution off the graph.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff

theorem movingHeat_offOrigin {b : ℝ → ℝ} {x t : ℝ} (hx : x ≠ b t) (u : ℝ) :
    t-u ≠ 0 ∨ x-b u ≠ 0 := by
  by_cases htu : t = u
  · right
    intro he
    apply hx
    rw [htu]
    exact sub_eq_zero.mp he
  · exact Or.inl (sub_ne_zero.mpr htu)

noncomputable def movingPlaneIntegral (F : ℝ × ℝ → ℝ) (b f : ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ u, F (z.2-u,z.1-b u)*f u

theorem movingPlaneKernel_continuousAt {F : ℝ × ℝ → ℝ} {b : ℝ → ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z) (hb : Continuous b)
    {x t u : ℝ} (hx : x ≠ b t) :
    ContinuousAt (fun p : (ℝ × ℝ) × ℝ => F (p.1.2-p.2,p.1.1-b p.2)) ((x,t),u) := by
  exact (hF _ (movingHeat_offOrigin hx u)).continuousAt.comp
    (x := ((x,t),u)) (f := fun p : (ℝ × ℝ) × ℝ => (p.1.2-p.2,p.1.1-b p.2)) (by fun_prop)

theorem compact_movingPlaneIntegral_continuousOn {F : ℝ × ℝ → ℝ} {b f : ℝ → ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z) (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) :
    ContinuousOn (movingPlaneIntegral F b f) {z | z.1 ≠ b z.2} := by
  apply continuousOn_integral_of_compact_support hc
  · intro p hp
    exact ((movingPlaneKernel_continuousAt hF hb hp.1).mul
      (hf.continuousAt.comp continuousAt_snd)).continuousWithinAt
  · intro z u _ hu
    rw [image_eq_zero_of_notMem_tsupport hu,mul_zero]

theorem compact_movingPlaneIntegral_hasDeriv_space {F : ℝ × ℝ → ℝ} {b f : ℝ → ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z) (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) {x t : ℝ} (hx : x ≠ b t) :
    HasDerivAt (fun y => movingPlaneIntegral F b f (y,t))
      (movingPlaneIntegral (heatPartial F (0,1)) b f (x,t)) x := by
  have hD : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F (0,1)) z :=
    fun z hz => heatPartial_smoothAt (hF z hz) (0,1)
  apply compact_kernelIntegral_hasDeriv hf hc (U := {y | y ≠ b t})
    (F := fun y u => F (t-u,y-b u))
    (F' := fun y u => heatPartial F (0,1) (t-u,y-b u)) isOpen_ne
  · intro p hp
    exact ((movingPlaneKernel_continuousAt hF hb hp.1).comp
      (x := p) (f := fun p : ℝ × ℝ => ((p.1,t),p.2)) (by fun_prop)).continuousWithinAt
  · intro p hp
    exact ((movingPlaneKernel_continuousAt hD hb hp.1).comp
      (x := p) (f := fun p : ℝ × ℝ => ((p.1,t),p.2)) (by fun_prop)).continuousWithinAt
  · intro y hy u
    simpa only [mul_one,id_eq,Function.comp_apply] using! (heatPartial_space
      ((hF _ (movingHeat_offOrigin hy u)).differentiableAt (by simp))).comp y
        ((hasDerivAt_id y).sub_const (b u))
  · exact hx

theorem compact_movingPlaneIntegral_hasDeriv_time {F : ℝ × ℝ → ℝ} {b f : ℝ → ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z) (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) {x t : ℝ} (hx : x ≠ b t) :
    HasDerivAt (fun s => movingPlaneIntegral F b f (x,s))
      (movingPlaneIntegral (heatPartial F (1,0)) b f (x,t)) t := by
  have hD : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F (1,0)) z :=
    fun z hz => heatPartial_smoothAt (hF z hz) (1,0)
  apply compact_kernelIntegral_hasDeriv hf hc (U := {s | x ≠ b s})
    (F := fun s u => F (s-u,x-b u))
    (F' := fun s u => heatPartial F (1,0) (s-u,x-b u)) (isOpen_ne_fun continuous_const hb)
  · intro p hp
    exact ((movingPlaneKernel_continuousAt hF hb hp.1).comp
      (x := p) (f := fun p : ℝ × ℝ => ((x,p.1),p.2)) (by fun_prop)).continuousWithinAt
  · intro p hp
    exact ((movingPlaneKernel_continuousAt hD hb hp.1).comp
      (x := p) (f := fun p : ℝ × ℝ => ((x,p.1),p.2)) (by fun_prop)).continuousWithinAt
  · intro s hs u
    simpa only [mul_one,id_eq,Function.comp_apply] using! (heatPartial_time
      ((hF _ (movingHeat_offOrigin hs u)).differentiableAt (by simp))).comp s
        ((hasDerivAt_id s).sub_const u)
  · exact hx

theorem compact_movingPlaneIntegral_contDiffOn_space {F : ℝ × ℝ → ℝ} {b f : ℝ → ℝ}
    (hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ F z) (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) (t : ℝ) (n : ℕ) :
    ContDiffOn ℝ n (fun x => movingPlaneIntegral F b f (x,t)) {x | x ≠ b t} := by
  induction n generalizing F with
  | zero =>
    apply contDiffOn_zero.mpr
    exact (compact_movingPlaneIntegral_continuousOn hF hb hf hc).comp
      (continuous_id.prodMk continuous_const).continuousOn (fun _ hx => hx)
  | succ n ih =>
    rw [show ((n+1 : ℕ) : ℕ∞ω) = (n : ℕ∞ω)+1 by norm_cast,
      contDiffOn_succ_iff_deriv_of_isOpen isOpen_ne]
    refine ⟨fun x hx => (compact_movingPlaneIntegral_hasDeriv_space hF hb hf hc hx).differentiableAt.differentiableWithinAt,
      by simp,?_⟩
    have hD : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F (0,1)) z :=
      fun z hz => heatPartial_smoothAt (hF z hz) (0,1)
    apply (ih hD).congr
    intro x hx
    exact (compact_movingPlaneIntegral_hasDeriv_space hF hb hf hc hx).deriv

noncomputable def causalMovingHeatLayer (b f : ℝ → ℝ) : ℝ × ℝ → ℝ :=
  movingPlaneIntegral causalHeatKernelPlane b f

theorem causalMovingHeatLayer_equation {b f : ℝ → ℝ} (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) {x t : ℝ} (hx : x ≠ b t) :
    deriv (fun s => causalMovingHeatLayer b f (x,s)) t =
      (1/2)*deriv (deriv (fun y => causalMovingHeatLayer b f (y,t))) x := by
  have hF : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞ causalHeatKernelPlane z :=
    fun _ hz => causalHeatKernelPlane_smoothAt hz
  have hD : ∀ z, z.1 ≠ 0 ∨ z.2 ≠ 0 → ContDiffAt ℝ ∞
      (heatPartial causalHeatKernelPlane (0,1)) z :=
    fun z hz => heatPartial_smoothAt (hF z hz) (0,1)
  have he : deriv (fun y => causalMovingHeatLayer b f (y,t)) =ᶠ[𝓝 x]
      (fun y => movingPlaneIntegral (heatPartial causalHeatKernelPlane (0,1)) b f (y,t)) := by
    filter_upwards [isOpen_ne.mem_nhds hx] with y hy
    exact (compact_movingPlaneIntegral_hasDeriv_space hF hb hf hc hy).deriv
  simp only [causalMovingHeatLayer] at he ⊢
  rw [(compact_movingPlaneIntegral_hasDeriv_time hF hb hf hc hx).deriv,he.deriv_eq,
    (compact_movingPlaneIntegral_hasDeriv_space hD hb hf hc hx).deriv]
  unfold movingPlaneIntegral
  rw [← integral_const_mul]
  apply integral_congr_ae
  apply Eventually.of_forall
  intro u
  dsimp only
  rw [causalHeatKernelPlane_equation (movingHeat_offOrigin hx u)]
  ring

theorem causalMovingHeatLayer_contDiffAt_space {b f : ℝ → ℝ} (hb : Continuous b)
    (hf : Continuous f) (hc : HasCompactSupport f) {x t : ℝ} (hx : x ≠ b t) :
    ContDiffAt ℝ 2 (fun y => causalMovingHeatLayer b f (y,t)) x :=
  (compact_movingPlaneIntegral_contDiffOn_space (fun _ hz => causalHeatKernelPlane_smoothAt hz)
    hb hf hc t 2).contDiffAt (isOpen_ne.mem_nhds hx)

end AmericanPutConvexity.Stopping
