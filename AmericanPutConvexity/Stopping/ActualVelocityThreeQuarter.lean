import AmericanPutConvexity.Stopping.ActualHeatFluxThreeQuarter
import AmericanPutConvexity.Stopping.ActualVelocityHolder
import AmericanPutConvexity.Stopping.ThreeQuarterOperations

/-! # Three-quarter Holder pricing flux and actual boundary velocity

The improved modulus passes through the C1 pricing gauge and the positive
Stefan denominator. These are statements about the actual stopping boundary;
no second derivative is assumed or asserted.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter Boundary
open scoped Topology ContDiff

theorem canonicalThetaRightFlux_threeQuarter {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    LocalThreeQuarterHolderAt (canonicalThetaRightFlux k h) t := by
  have hH := canonicalHeatThetaRightFlux_threeQuarter hk hh hhk ht
  have htime := hH.positive_rescale (by norm_num : (0 : ℝ) < 2)
  have hc : ContinuousAt (fun s => canonicalHeatThetaRightFlux k h (2*s)) t :=
    (canonicalHeatThetaRightFlux_continuousAt hk hh hhk (by positivity : 0 < 2*t)).comp
      (x := t) (f := fun s : ℝ => 2*s) (by fun_prop)
  apply (htime.mul_contDiffAt hc (inverseThetaHeatGauge_boundary_contDiffAt hk hh hhk ht)).congr
  filter_upwards [Ioi_mem_nhds ht] with s hs
  exact canonicalThetaRightFlux_eq_gauged_heat hk hh hhk hs

theorem canonicalLogBoundary_deriv_threeQuarter {k h t : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ht : 0 < t) :
    LocalThreeQuarterHolderAt (deriv (canonicalLogBoundary k h)) t := by
  have hb := (canonicalLogBoundary_contDiffOn_one hk hh hhk).contDiffAt (Ioi_mem_nhds ht)
  have hg : ContDiffAt ℝ 1 (fun s => (-1 : ℝ)/(k-h*Real.exp (canonicalLogBoundary k h s))) t :=
    contDiffAt_const.div (contDiffAt_const.sub (contDiffAt_const.mul hb.exp))
      (canonicalBoundary_forcing_pos hk hh hhk ht).ne'
  apply ((canonicalThetaRightFlux_threeQuarter hk hh hhk ht).mul_contDiffAt
    (canonicalThetaRightFlux_continuousAt hk hh hhk ht) hg).congr
  filter_upwards [Ioi_mem_nhds ht] with s hs
  rw [canonicalLogBoundary_deriv_eq_velocity hk hh hhk hs]
  ring

theorem canonicalHeatGraph_deriv_threeQuarter {k h s : ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (hs : 0 < s) :
    LocalThreeQuarterHolderAt (deriv (fun u => canonicalLogBoundary k h (u/2))) s := by
  have hb : LocalThreeQuarterHolderAt (deriv (canonicalLogBoundary k h)) ((1/2)*s) :=
    canonicalLogBoundary_deriv_threeQuarter hk hh hhk (by positivity)
  have htime := hb.positive_rescale (by norm_num : (0 : ℝ) < 1/2)
  have hc : ContinuousAt (fun u => deriv (canonicalLogBoundary k h) ((1/2)*u)) s :=
    (canonicalLogBoundary_deriv_continuousAt hk hh hhk (by positivity : 0 < (1/2)*s)).comp
      (x := s) (f := fun u : ℝ => (1/2)*u) (by fun_prop)
  apply (htime.mul_contDiffAt hc (contDiffAt_const (c := (1/2 : ℝ)))).congr
  filter_upwards [Ioi_mem_nhds hs] with u hu
  rw [(canonicalHeatGraph_hasDerivAt hk hh hhk hu).deriv]
  rw [show (1/2 : ℝ)*u = u/2 by ring]
  ring

theorem zeroDividend_canonicalThetaRightFlux_threeQuarter {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) : LocalThreeQuarterHolderAt (canonicalThetaRightFlux k 0) t :=
  canonicalThetaRightFlux_threeQuarter hk le_rfl hk.le ht

theorem liuRange_canonicalThetaRightFlux_threeQuarter {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    LocalThreeQuarterHolderAt (canonicalThetaRightFlux k h) t :=
  canonicalThetaRightFlux_threeQuarter (by linarith) hh (by linarith) ht

theorem zeroDividend_canonicalLogBoundary_deriv_threeQuarter {k t : ℝ}
    (hk : 0 < k) (ht : 0 < t) :
    LocalThreeQuarterHolderAt (deriv (canonicalLogBoundary k 0)) t :=
  canonicalLogBoundary_deriv_threeQuarter hk le_rfl hk.le ht

theorem liuRange_canonicalLogBoundary_deriv_threeQuarter {k h t : ℝ}
    (hh : 0 ≤ h) (hliu : h+1 ≤ k) (ht : 0 < t) :
    LocalThreeQuarterHolderAt (deriv (canonicalLogBoundary k h)) t :=
  canonicalLogBoundary_deriv_threeQuarter (by linarith) hh (by linarith) ht

end AmericanPutConvexity.Stopping
