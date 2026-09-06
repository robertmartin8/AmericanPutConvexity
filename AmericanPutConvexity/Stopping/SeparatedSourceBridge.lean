import AmericanPutConvexity.Stopping.SeparatedSourceEquation
import AmericanPutConvexity.Stopping.HeatSourcePotential

/-! # Identifying the separated source-time integral with the heat potential

Fubini is justified by compact support and separation from the evaluation
point. Causality then turns the full source-time integral into the fixed
elapsed-time potential. This joins the separated-source PDE to the potential
used in the actual boundary forcing.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open MathFin.FeynmanKacHeatEquation
open scoped Topology ContDiff

theorem heatKernel_sub_comm (u x y : ℝ) : heatKernel u (x-y) = heatKernel u (y-x) := by
  unfold heatKernel
  rw [show (x-y)^2 = (y-x)^2 by ring]

theorem causalHeatSourceIntegral_eq_potential {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {z : ℝ × ℝ} (hz : z ∉ tsupport Q) (ht : z.2 ≤ a+D) :
    causalHeatSourceIntegral Q z = heatSourcePotential Q D z := by
  have hi := sourcePlaneIntegral_integrable
    (fun _ hv => causalHeatKernelPlane_smoothAt hv) hQ hc hz
  change Integrable (fun w : ℝ × ℝ => causalHeatKernel (z.2-w.2) (z.1-w.1)*Q w) at hi
  unfold causalHeatSourceIntegral sourcePlaneIntegral causalHeatKernelPlane
  dsimp only
  change (∫ w : ℝ × ℝ, causalHeatKernel (z.2-w.2) (z.1-w.1)*Q w ∂volume.prod volume) = _
  rw [integral_prod_symm _ hi]
  have he := integral_sub_left_eq_self
    (fun s => ∫ y, causalHeatKernel (z.2-s) (z.1-y)*Q (y,s)) volume z.2
  simp only [sub_sub_cancel] at he
  rw [← he]
  calc
    _ = ∫ u in Ioo 0 D, ∫ y, causalHeatKernel u (z.1-y)*Q (y,z.2-u) := by
      symm
      apply setIntegral_eq_integral_of_forall_compl_eq_zero
      intro u hu
      apply integral_eq_zero_of_ae
      apply Eventually.of_forall
      intro y
      dsimp only
      by_cases hu0 : 0 < u
      · have hDu : D ≤ u := by
          by_contra hn
          exact hu ⟨hu0,lt_of_not_ge hn⟩
        rw [hcausal (y,z.2-u) (by dsimp; linarith),mul_zero]
        rfl
      · rw [causalHeatKernel_zero (le_of_not_gt hu0),zero_mul]
        rfl
    _ = heatSourcePotential Q D z := by
      apply setIntegral_congr_fun measurableSet_Ioo
      intro u hu
      dsimp only
      rw [heatSourceAverage_eq_convolution hu.1]
      apply integral_congr_ae
      exact Eventually.of_forall (fun y => by dsimp only; rw [causalHeatKernel_eq hu.1,heatKernel_sub_comm])

theorem separated_heatSourcePotential_eventuallyEq {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {x t : ℝ} (hz : (x,t) ∉ tsupport Q) (ht : t < a+D) :
    heatSourcePotential Q D =ᶠ[𝓝 (x,t)] causalHeatSourceIntegral Q := by
  filter_upwards [(isClosed_tsupport Q).isOpen_compl.mem_nhds hz,
    continuousAt_snd.preimage_mem_nhds (Iio_mem_nhds ht)] with z hz hzt
  exact (causalHeatSourceIntegral_eq_potential hQ hc hcausal hz (le_of_lt hzt)).symm

theorem separated_heatSourcePotential_equation {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {x t : ℝ} (hz : (x,t) ∉ tsupport Q) (ht : t < a+D) :
    deriv (fun s => heatSourcePotential Q D (x,s)) t =
      (1/2)*deriv (deriv (fun y => heatSourcePotential Q D (y,t))) x := by
  have he := separated_heatSourcePotential_eventuallyEq hQ hc hcausal hz ht
  have het : (fun s => heatSourcePotential Q D (x,s)) =ᶠ[𝓝 t]
      (fun s => causalHeatSourceIntegral Q (x,s)) :=
    (show ContinuousAt (fun s : ℝ => (x,s)) t by fun_prop).preimage_mem_nhds he
  have hex : (fun y => heatSourcePotential Q D (y,t)) =ᶠ[𝓝 x]
      (fun y => causalHeatSourceIntegral Q (y,t)) :=
    (show ContinuousAt (fun y : ℝ => (y,t)) x by fun_prop).preimage_mem_nhds he
  rw [het.deriv_eq,hex.deriv.deriv_eq]
  exact causalHeatSourceIntegral_equation hQ hc hz

theorem separated_heatSourcePotential_contDiffAt_space {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {x t : ℝ} (hz : (x,t) ∉ tsupport Q) (ht : t < a+D) (n : ℕ) :
    ContDiffAt ℝ n (fun y => heatSourcePotential Q D (y,t)) x := by
  have he : (fun y => heatSourcePotential Q D (y,t)) =ᶠ[𝓝 x]
      (fun y => causalHeatSourceIntegral Q (y,t)) :=
    (show ContinuousAt (fun y : ℝ => (y,t)) x by fun_prop).preimage_mem_nhds
      (separated_heatSourcePotential_eventuallyEq hQ hc hcausal hz ht)
  have hU : IsOpen {y : ℝ | (y,t) ∉ tsupport Q} :=
    (isClosed_tsupport Q).isOpen_compl.preimage (continuous_id.prodMk continuous_const)
  exact ((sourcePlaneIntegral_contDiffOn_space (fun _ hv => causalHeatKernelPlane_smoothAt hv)
    hQ hc t n).contDiffAt (hU.mem_nhds hz)).congr_of_eventuallyEq he

theorem separated_heatSourcePotential_differentiableAt_time {Q : ℝ × ℝ → ℝ} {a D : ℝ}
    (hQ : Continuous Q) (hc : HasCompactSupport Q)
    (hcausal : ∀ w : ℝ × ℝ, w.2 ≤ a → Q w = 0)
    {x t : ℝ} (hz : (x,t) ∉ tsupport Q) (ht : t < a+D) :
    DifferentiableAt ℝ (fun s => heatSourcePotential Q D (x,s)) t := by
  have he : (fun s => heatSourcePotential Q D (x,s)) =ᶠ[𝓝 t]
      (fun s => causalHeatSourceIntegral Q (x,s)) :=
    (show ContinuousAt (fun s : ℝ => (x,s)) t by fun_prop).preimage_mem_nhds
      (separated_heatSourcePotential_eventuallyEq hQ hc hcausal hz ht)
  exact (sourcePlaneIntegral_hasDeriv_time (fun _ hv => causalHeatKernelPlane_smoothAt hv)
    hQ hc hz).differentiableAt.congr_of_eventuallyEq he

end AmericanPutConvexity.Stopping
