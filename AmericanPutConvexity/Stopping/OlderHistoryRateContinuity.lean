import AmericanPutConvexity.Stopping.HistoryRateIntegrability
import AmericanPutConvexity.Stopping.CompactIntervalIntegralContinuity

/-! # Continuous older-source rate on the actual graph -/

namespace AmericanPutConvexity.Stopping

open Set Filter MeasureTheory
open scoped Topology

theorem canonicalOlderHistoryRate_continuousAt {k h a₀ a t : ℝ} {f : ℝ → ℝ}
    (hk : 0 < k) (hh : 0 ≤ h) (hhk : h ≤ k) (ha₀ : 0 < a₀) (ha : a₀ < a) (hat : a < t)
    (hf : Continuous f) :
    ContinuousAt (fun r => ∫ s in Ioo a₀ a, heatBoundaryMotionDerivative (r-s)
      (canonicalLogBoundary k h (r/2)-canonicalLogBoundary k h (s/2))
      (deriv (fun u => canonicalLogBoundary k h (u/2)) r)*f s) t := by
  apply integral_Ioo_continuousAt_of_joint_continuous (U := Ioi a) isOpen_Ioi hat
  intro r hr s hs
  have hrpos : 0 < r := (ha₀.trans ha).trans hr
  have hspos : 0 < s := ha₀.trans_le hs.1
  have hbr := (canonicalHeatGraph_hasDerivAt hk hh hhk hrpos).continuousAt.comp
    (x := (r,s)) (f := fun z : ℝ × ℝ => z.1) continuousAt_fst
  have hbs := (canonicalHeatGraph_hasDerivAt hk hh hhk hspos).continuousAt.comp
    (x := (r,s)) (f := fun z : ℝ × ℝ => z.2) continuousAt_snd
  have hbv := (canonicalHeatGraph_deriv_continuousAt hk hh hhk hrpos).comp
    (x := (r,s)) (f := fun z : ℝ × ℝ => z.1) continuousAt_fst
  exact (heatBoundaryMotionDerivative_continuousAt_varying
    (continuousAt_fst.sub continuousAt_snd) (hbr.sub hbs) hbv
    (sub_pos.mpr (hs.2.trans_lt hr))).mul (hf.continuousAt.comp continuousAt_snd)

end AmericanPutConvexity.Stopping
