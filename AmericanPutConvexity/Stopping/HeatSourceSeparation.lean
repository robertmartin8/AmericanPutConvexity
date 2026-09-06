import AmericanPutConvexity.Stopping.HeatLocalizationSource

/-! # A locally constant cutoff produces no source near contact

No regularity of the localized function is needed: every coefficient of the
source is a derivative of the cutoff, and vanishes on its constant germ.
-/

namespace AmericanPutConvexity.Stopping

open Set Filter
open scoped Topology

theorem heatPartial_eventuallyEq_zero_of_constant
    {χ : ℝ × ℝ → ℝ} {z : ℝ × ℝ} {c : ℝ}
    (he : χ =ᶠ[𝓝 z] fun _ => c) (e : ℝ × ℝ) :
    heatPartial χ e =ᶠ[𝓝 z] 0 := by
  filter_upwards [he.fderiv (𝕜 := ℝ)] with w hw
  simp [heatPartial,hw]

theorem heatLocalizationSource_notMem_tsupport_of_constant
    {χ : ℝ × ℝ → ℝ} {z : ℝ × ℝ} {c : ℝ}
    (he : χ =ᶠ[𝓝 z] fun _ => c) (W : ℝ × ℝ → ℝ) :
    z ∉ tsupport (heatLocalizationSource χ W) := by
  have hx := heatPartial_eventuallyEq_zero_of_constant he (1,0)
  have ht := heatPartial_eventuallyEq_zero_of_constant he (0,1)
  have hxx := heatPartial_eventuallyEq_zero_of_constant hx (1,0)
  apply notMem_tsupport_iff_eventuallyEq.mpr
  filter_upwards [hx,ht,hxx] with w hwx hwt hwxx
  simp only [Pi.zero_apply] at hwx hwt hwxx ⊢
  simp [heatLocalizationSource,hwx,hwt,hwxx]

end AmericanPutConvexity.Stopping
