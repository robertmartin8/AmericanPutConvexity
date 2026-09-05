import AmericanConvexity.Stopping.ActualHeatFluxHolder
import AmericanConvexity.Stopping.LocalHalfHolder

/-! # One-half Holder pricing flux and actual boundary velocity

The inverse pricing gauge is C1 along the actual boundary. The forcing
denominator in the Stefan identity is positive and C1. Consequently both
operations preserve the proved square-root modulus of the actual heat flux.
No second derivative of the boundary is assumed or claimed here.
-/

namespace AmericanConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalHeatThetaRightFlux_continuousAt {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    ContinuousAt (canonicalHeatThetaRightFlux k h) s := by
  obtain ⟨F,hF,htrace⟩ := exists_canonicalHeatTheta_continuous_right_flux hk hh hhk (half_pos hs)
  rw [show 2*(s/2) = s by ring] at htrace
  apply hF.continuousAt.congr_of_eventuallyEq
  filter_upwards [htrace] with u hu
  exact hu.derivWithin (uniqueDiffWithinAt_Ici _)

theorem canonicalThetaRightFlux_eq_gauged_heat {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    canonicalThetaRightFlux k h t =
      inverseThetaHeatGauge k h (canonicalLogBoundary k h t) t*canonicalHeatThetaRightFlux k h (2*t) := by
  have hd := canonicalHeatTheta_hasDerivWithinAt_right_flux hk hh hhk (by positivity : 0 < 2*t)
  rw [show 2*t/2 = t by ring] at hd
  exact (canonicalTheta_hasDerivWithinAt_of_heat_flux hk hh hhk ht hd).derivWithin
    (uniqueDiffWithinAt_Ici _)

theorem inverseThetaHeatGauge_boundary_contDiffAt {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    ContDiffAt ℝ 1 (fun s => inverseThetaHeatGauge k h (canonicalLogBoundary k h s) s) t := by
  have hb := (canonicalLogBoundary_contDiffOn_one hk hh hhk).contDiffAt (Ioi_mem_nhds ht)
  unfold inverseThetaHeatGauge
  exact ((contDiffAt_const.mul hb).add
    (contDiffAt_const.mul contDiffAt_id)).neg.exp

theorem canonicalThetaRightFlux_holder {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    LocalHalfHolderAt (canonicalThetaRightFlux k h) t := by
  have hH : LocalHalfHolderAt (canonicalHeatThetaRightFlux k h) (2*t) :=
    canonicalHeatThetaRightFlux_holder hk hh hhk ht
  have htime := hH.positive_rescale (by norm_num : (0 : ℝ) < 2)
  have hc : ContinuousAt (fun s => canonicalHeatThetaRightFlux k h (2*s)) t :=
    (canonicalHeatThetaRightFlux_continuousAt hk hh hhk (by positivity : 0 < 2*t)).comp
      (x := t) (f := fun s : ℝ => 2*s) (by fun_prop)
  apply (htime.mul_contDiffAt hc (inverseThetaHeatGauge_boundary_contDiffAt hk hh hhk ht)).congr
  filter_upwards [Ioi_mem_nhds ht] with s hs
  exact canonicalThetaRightFlux_eq_gauged_heat hk hh hhk hs

theorem canonicalLogBoundary_deriv_holder {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    LocalHalfHolderAt (deriv (canonicalLogBoundary k h)) t := by
  have hb := (canonicalLogBoundary_contDiffOn_one hk hh hhk).contDiffAt (Ioi_mem_nhds ht)
  have hg : ContDiffAt ℝ 1 (fun s => (-1 : ℝ)/(k-h*Real.exp (canonicalLogBoundary k h s))) t :=
    contDiffAt_const.div (contDiffAt_const.sub (contDiffAt_const.mul hb.exp))
      (canonicalBoundary_forcing_pos hk hh hhk ht).ne'
  apply ((canonicalThetaRightFlux_holder hk hh hhk ht).mul_contDiffAt
    (canonicalThetaRightFlux_continuousAt hk hh hhk ht) hg).congr
  filter_upwards [Ioi_mem_nhds ht] with s hs
  rw [canonicalLogBoundary_deriv_eq_velocity hk hh hhk hs]
  ring

theorem canonicalHeatGraph_deriv_holder {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    LocalHalfHolderAt (deriv (fun u => canonicalLogBoundary k h (u/2))) s := by
  have hb : LocalHalfHolderAt (deriv (canonicalLogBoundary k h)) ((1/2)*s) :=
    canonicalLogBoundary_deriv_holder hk hh hhk (by positivity)
  have htime := hb.positive_rescale (by norm_num : (0 : ℝ) < 1/2)
  have hc : ContinuousAt (fun u => deriv (canonicalLogBoundary k h) ((1/2)*u)) s :=
    (canonicalLogBoundary_deriv_continuousAt hk hh hhk (by positivity : 0 < (1/2)*s)).comp
      (x := s) (f := fun u : ℝ => (1/2)*u) (by fun_prop)
  apply (htime.mul_contDiffAt hc (contDiffAt_const (c := (1/2 : ℝ)))).congr
  filter_upwards [Ioi_mem_nhds hs] with u hu
  rw [(canonicalHeatGraph_hasDerivAt hk hh hhk hu).deriv]
  rw [show (1/2 : ℝ)*u = u/2 by ring]
  ring

theorem zeroDividend_canonicalThetaRightFlux_holder {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) : LocalHalfHolderAt (canonicalThetaRightFlux k 0) t :=
  canonicalThetaRightFlux_holder hk le_rfl hk.le ht

theorem liuRange_canonicalThetaRightFlux_holder {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) : LocalHalfHolderAt (canonicalThetaRightFlux k h) t :=
  canonicalThetaRightFlux_holder (by linarith) hh (by linarith) ht

theorem zeroDividend_canonicalLogBoundary_deriv_holder {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) : LocalHalfHolderAt (deriv (canonicalLogBoundary k 0)) t :=
  canonicalLogBoundary_deriv_holder hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_deriv_holder {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    LocalHalfHolderAt (deriv (canonicalLogBoundary k h)) t :=
  canonicalLogBoundary_deriv_holder (by linarith) hh (by linarith) ht

end AmericanConvexity.Stopping
