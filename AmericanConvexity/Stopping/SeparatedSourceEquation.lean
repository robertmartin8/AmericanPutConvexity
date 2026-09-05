import AmericanConvexity.Stopping.SupportedKernelIntegral
import AmericanConvexity.Stopping.CausalHeatKernel

/-! # The source-time heat integral off the source's support

For a compact continuous source the original source-time integral is smooth
and solves the homogeneous heat equation away from the source's support.
This is the separated remainder in the local source decomposition.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology ContDiff

noncomputable def sourcePlaneIntegral (F Q : ℝ × ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  ∫ w : ℝ × ℝ, F (z.2-w.2,z.1-w.1)*Q w

theorem sourceKernel_offOrigin {Q : ℝ × ℝ → ℝ} {z w : ℝ × ℝ}
    (hz : z ∉ tsupport Q) (hw : w ∈ tsupport Q) : z.2-w.2 ≠ 0 ∨ z.1-w.1 ≠ 0 := by
  by_contra he
  push Not at he
  have hzw : z = w := Prod.ext (sub_eq_zero.mp he.2) (sub_eq_zero.mp he.1)
  exact hz (hzw ▸ hw)

theorem sourcePlaneKernel_continuousAt {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    {z w : ℝ × ℝ} (hz : z ∉ tsupport Q) (hw : w ∈ tsupport Q) :
    ContinuousAt (fun v : (ℝ × ℝ) × (ℝ × ℝ) => F (v.1.2-v.2.2,v.1.1-v.2.1)) (z,w) :=
  (hF _ (sourceKernel_offOrigin hz hw)).continuousAt.comp
    (x := (z,w)) (f := fun v : (ℝ × ℝ) × (ℝ × ℝ) => (v.1.2-v.2.2,v.1.1-v.2.1)) (by fun_prop)

theorem sourcePlaneIntegral_continuousOn {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) :
    ContinuousOn (sourcePlaneIntegral F Q) (tsupport Q)ᶜ := by
  apply continuousOn_integral_of_compact_support hc
  · exact supported_kernelProduct_continuousOn (F := fun (z w : ℝ × ℝ) => F (z.2-w.2,z.1-w.1)) hQ
      (fun _ hz _ hw => sourcePlaneKernel_continuousAt hF hz hw)
  · intro z w _ hw
    rw [image_eq_zero_of_notMem_tsupport hw,mul_zero]

theorem sourcePlaneIntegral_integrable {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    {z : ℝ × ℝ} (hz : z ∉ tsupport Q) :
    Integrable (fun w : ℝ × ℝ => F (z.2-w.2,z.1-w.1)*Q w) := by
  have hcont : Continuous (fun w : ℝ × ℝ => F (z.2-w.2,z.1-w.1)*Q w) :=
    (supported_kernelProduct_continuousOn (F := fun (z w : ℝ × ℝ) => F (z.2-w.2,z.1-w.1))
      (U := (tsupport Q)ᶜ) hQ
      (fun _ hp _ hw => sourcePlaneKernel_continuousAt hF hp hw)).comp_continuous
      (continuous_const.prodMk continuous_id) (fun _ => ⟨hz,mem_univ _⟩)
  exact hcont.integrable_of_hasCompactSupport hc.mul_left

theorem sourcePlaneIntegral_hasDeriv_space {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) {x t : ℝ}
    (hz : (x,t) ∉ tsupport Q) :
    HasDerivAt (fun y => sourcePlaneIntegral F Q (y,t))
      (sourcePlaneIntegral (heatPartial F (0,1)) Q (x,t)) x := by
  have hD : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F (0,1)) v :=
    fun v hv => heatPartial_smoothAt (hF v hv) (0,1)
  apply supported_planeIntegral_hasDeriv hQ hc
    (U := {y | (y,t) ∉ tsupport Q})
    ((isClosed_tsupport Q).isOpen_compl.preimage (continuous_id.prodMk continuous_const))
    (F := fun y w => F (t-w.2,y-w.1)) (F' := fun y w => heatPartial F (0,1) (t-w.2,y-w.1))
  · intro y hy w hw
    exact (sourcePlaneKernel_continuousAt hF hy hw).comp
      (x := (y,w)) (f := fun v : ℝ × (ℝ × ℝ) => ((v.1,t),v.2)) (by fun_prop)
  · intro y hy w hw
    exact (sourcePlaneKernel_continuousAt hD hy hw).comp
      (x := (y,w)) (f := fun v : ℝ × (ℝ × ℝ) => ((v.1,t),v.2)) (by fun_prop)
  · intro y hy w hw
    simpa only [mul_one,id_eq,Function.comp_apply] using! (heatPartial_space
      ((hF _ (sourceKernel_offOrigin hy hw)).differentiableAt (by simp))).comp y
        ((hasDerivAt_id y).sub_const w.1)
  · exact hz

theorem sourcePlaneIntegral_hasDeriv_time {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) {x t : ℝ}
    (hz : (x,t) ∉ tsupport Q) :
    HasDerivAt (fun s => sourcePlaneIntegral F Q (x,s))
      (sourcePlaneIntegral (heatPartial F (1,0)) Q (x,t)) t := by
  have hD : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial F (1,0)) v :=
    fun v hv => heatPartial_smoothAt (hF v hv) (1,0)
  apply supported_planeIntegral_hasDeriv hQ hc
    (U := {s | (x,s) ∉ tsupport Q})
    ((isClosed_tsupport Q).isOpen_compl.preimage (continuous_const.prodMk continuous_id))
    (F := fun s w => F (s-w.2,x-w.1)) (F' := fun s w => heatPartial F (1,0) (s-w.2,x-w.1))
  · intro s hs w hw
    exact (sourcePlaneKernel_continuousAt hF hs hw).comp
      (x := (s,w)) (f := fun v : ℝ × (ℝ × ℝ) => ((x,v.1),v.2)) (by fun_prop)
  · intro s hs w hw
    exact (sourcePlaneKernel_continuousAt hD hs hw).comp
      (x := (s,w)) (f := fun v : ℝ × (ℝ × ℝ) => ((x,v.1),v.2)) (by fun_prop)
  · intro s hs w hw
    simpa only [mul_one,id_eq,Function.comp_apply] using! (heatPartial_time
      ((hF _ (sourceKernel_offOrigin hs hw)).differentiableAt (by simp))).comp s
        ((hasDerivAt_id s).sub_const w.2)
  · exact hz

theorem sourcePlaneIntegral_contDiffOn_space {F Q : ℝ × ℝ → ℝ}
    (hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ F v)
    (hQ : Continuous Q) (hc : HasCompactSupport Q) (t : ℝ) (n : ℕ) :
    ContDiffOn ℝ n (fun x => sourcePlaneIntegral F Q (x,t)) {x | (x,t) ∉ tsupport Q} := by
  induction n generalizing F with
  | zero =>
    exact contDiffOn_zero.mpr ((sourcePlaneIntegral_continuousOn hF hQ hc).comp
      (continuous_id.prodMk continuous_const).continuousOn (fun _ hx => hx))
  | succ n ih =>
    have hU : IsOpen {x : ℝ | (x,t) ∉ tsupport Q} :=
      (isClosed_tsupport Q).isOpen_compl.preimage (continuous_id.prodMk continuous_const)
    rw [show ((n+1 : ℕ) : ℕ∞ω) = (n : ℕ∞ω)+1 by norm_cast,
      contDiffOn_succ_iff_deriv_of_isOpen hU]
    refine ⟨fun x hx => (sourcePlaneIntegral_hasDeriv_space hF hQ hc hx).differentiableAt.differentiableWithinAt,
      by simp,?_⟩
    apply (ih (fun v hv => heatPartial_smoothAt (hF v hv) (0,1))).congr
    intro x hx
    exact (sourcePlaneIntegral_hasDeriv_space hF hQ hc hx).deriv

noncomputable def causalHeatSourceIntegral (Q : ℝ × ℝ → ℝ) : ℝ × ℝ → ℝ :=
  sourcePlaneIntegral causalHeatKernelPlane Q

theorem causalHeatSourceIntegral_equation {Q : ℝ × ℝ → ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q) {x t : ℝ}
    (hz : (x,t) ∉ tsupport Q) :
    deriv (fun s => causalHeatSourceIntegral Q (x,s)) t =
      (1/2)*deriv (deriv (fun y => causalHeatSourceIntegral Q (y,t))) x := by
  have hF : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ causalHeatKernelPlane v :=
    fun _ hv => causalHeatKernelPlane_smoothAt hv
  have hD : ∀ v, v.1 ≠ 0 ∨ v.2 ≠ 0 → ContDiffAt ℝ ∞ (heatPartial causalHeatKernelPlane (0,1)) v :=
    fun v hv => heatPartial_smoothAt (hF v hv) (0,1)
  have he : deriv (fun y => causalHeatSourceIntegral Q (y,t)) =ᶠ[𝓝 x]
      (fun y => sourcePlaneIntegral (heatPartial causalHeatKernelPlane (0,1)) Q (y,t)) := by
    filter_upwards [((isClosed_tsupport Q).isOpen_compl.preimage
      (continuous_id.prodMk continuous_const)).mem_nhds hz] with y hy
    exact (sourcePlaneIntegral_hasDeriv_space hF hQ hc hy).deriv
  rw [he.deriv_eq]
  change deriv (fun s => sourcePlaneIntegral causalHeatKernelPlane Q (x,s)) t = _
  rw [(sourcePlaneIntegral_hasDeriv_time hF hQ hc hz).deriv,
    (sourcePlaneIntegral_hasDeriv_space hD hQ hc hz).deriv]
  unfold sourcePlaneIntegral
  rw [← integral_const_mul]
  apply integral_congr_ae
  apply Eventually.of_forall
  intro w
  dsimp only
  by_cases hw : w ∈ tsupport Q
  · rw [causalHeatKernelPlane_equation (sourceKernel_offOrigin hz hw)]
    ring
  · rw [image_eq_zero_of_notMem_tsupport hw]
    ring

end AmericanConvexity.Stopping
