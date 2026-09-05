import AmericanConvexity.Stopping.ActualOlderHistory
import AmericanConvexity.Stopping.FrozenDerivativeIntegrability
import Mathlib.Analysis.Calculus.ParametricIntegral

/-! # Ordinary time derivative of the older-source actual history

A positive gap separates every old source from every nearby observation.
The actual C1 graph and the kernel derivative bound therefore supply a
uniform integrable majorant on a two-sided observation neighborhood.
-/

namespace AmericanConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalOlderHistory_hasDerivAt {k h a₀ a t C : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀)
    (ha : a₀ < a) (hat : a < t) (hf : Continuous f) (hCf : ∀ s, ‖f s‖ ≤ C) :
    HasDerivAt
      (fun r => ∫ s in Ioo a₀ a, movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) r s*f s)
      (∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (t-s)
        (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2))
        (deriv (fun u => canonicalLogBoundary k h (u/2)) t)*f s) t := by
  let e := (t-a)/2
  have he : 0 < e := half_pos (sub_pos.mpr hat)
  have hC : 0 ≤ C := (norm_nonneg (f t)).trans (hCf t)
  obtain ⟨L,hL,hv,hm⟩ := exists_canonicalHeatGraph_C1_window_bound (T := t+e) hk hh hhk ha₀
  let U := Ioo (t-e) (t+e)
  have hU : U ∈ 𝓝 t := Ioo_mem_nhds (by linarith) (by linarith)
  have hgap (r : ℝ) (hr : r ∈ U) : a+e < r := by
    have h := hr.1
    dsimp [e] at *
    linarith
  have hra (r : ℝ) (hr : r ∈ U) : a < r := by linarith [hgap r hr]
  have hrI (r : ℝ) (hr : r ∈ U) : r ∈ Icc a₀ (t+e) :=
    ⟨(ha.trans (hra r hr)).le,hr.2.le⟩
  have hd (r : ℝ) (hr : r ∈ U) :
      HasDerivAt (fun u => canonicalLogBoundary k h (u/2))
        (deriv (fun u => canonicalLogBoundary k h (u/2)) r) r :=
    (canonicalHeatGraph_hasDerivAt hk hh hhk (ha₀.trans (ha.trans (hra r hr)))).differentiableAt.hasDerivAt
  have htc : ContinuousOn (fun s => heatBoundaryMotionDerivative (t-s)
      (canonicalLogBoundary k h (t/2)-canonicalLogBoundary k h (s/2))
      (deriv (fun u => canonicalLogBoundary k h (u/2)) t)*f s) (Ioo a₀ a) := by
    intro s hs
    have hbc := (canonicalHeatGraph_hasDerivAt hk hh hhk (ha₀.trans hs.1)).continuousAt
    exact ((heatBoundaryMotionDerivative_continuousAt
      (show ContinuousAt (fun z : ℝ => t-z) s by fun_prop)
      ((continuousAt_const (y := canonicalLogBoundary k h (t/2))).sub hbc)
      (sub_pos.mpr (hs.2.trans hat))).mul hf.continuousAt).continuousWithinAt
  apply (hasDerivAt_integral_of_dominated_loc_of_deriv_le
    (μ := volume.restrict (Ioo a₀ a))
    (F := fun r s => movingHeatHistoryKernel (fun u => canonicalLogBoundary k h (u/2)) r s*f s)
    (F' := fun r s => heatBoundaryMotionDerivative (r-s)
      (canonicalLogBoundary k h (r/2)-canonicalLogBoundary k h (s/2))
      (deriv (fun u => canonicalLogBoundary k h (u/2)) r)*f s)
    (bound := fun _ => 8*L*C/(e*Real.sqrt (2*Real.pi*e))) hU
    (by
      filter_upwards [hU] with r hr
      exact (canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha (hra r hr).le hf hCf).aestronglyMeasurable)
    (canonicalHeatHistory_source_integrable hk hh hhk ha₀ ha hat.le hf hCf)
    (htc.aestronglyMeasurable measurableSet_Ioo) ?_
    (integrableOn_const (hs := measure_Ioo_lt_top.ne)) ?_).2
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    intro r hr
    have hst := hs.2.trans (hra r hr)
    have hsI : s ∈ Icc a₀ (t+e) := ⟨hs.1.le,(hs.2.trans hat).le.trans (by linarith)⟩
    have hkbound := movingHeatHistoryKernel_deriv_bound hst hL (hd r hr)
      (hv r (hrI r hr)) (hm s hsI r (hrI r hr) hst.le)
    rw [(movingHeatHistoryKernel_hasDerivAt_motion hst (hd r hr)).deriv] at hkbound
    have hgap' : e ≤ r-s := by linarith [hgap r hr,hs.2]
    have hden : e*Real.sqrt (2*Real.pi*e) ≤ (r-s)*Real.sqrt (2*Real.pi*(r-s)) :=
      mul_le_mul hgap' (Real.sqrt_le_sqrt (mul_le_mul_of_nonneg_left hgap' (by positivity)))
        (Real.sqrt_nonneg _) (by linarith)
    rw [norm_mul]
    calc
      _ ≤ (8*L/((r-s)*Real.sqrt (2*Real.pi*(r-s))))*C :=
        mul_le_mul hkbound (hCf s) (norm_nonneg _) (by positivity)
      _ ≤ (8*L/(e*Real.sqrt (2*Real.pi*e)))*C :=
        mul_le_mul_of_nonneg_right (div_le_div_of_nonneg_left (by positivity) (by positivity) hden) hC
      _ = _ := by ring
  · filter_upwards [ae_restrict_mem measurableSet_Ioo] with s hs
    intro r hr
    exact (movingHeatHistoryKernel_hasDerivAt_motion (hs.2.trans (hra r hr)) (hd r hr)).mul_const (f s)

end AmericanConvexity.Stopping
