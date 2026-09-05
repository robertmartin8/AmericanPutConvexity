import Mathlib.Analysis.Calculus.FDeriv.Extend
import Mathlib.Analysis.Calculus.Deriv.Basic

/-! # Differentiating a Lipschitz zero graph from a one-sided full derivative

The zero graph is not assumed differentiable. A nonzero spatial coefficient
in the relative derivative, together with a local Lipschitz bound for the
graph, determines its derivative. The relative domain may be a closed
continuation region rather than an open neighborhood across the graph.
-/

namespace AmericanConvexity.Boundary

open Set Filter
open scoped Topology

theorem hasDerivAt_of_lipschitz_zero_graph {U : ℝ × ℝ → ℝ} {b : ℝ → ℝ}
    {S : Set (ℝ × ℝ)} {t A B C : ℝ} (hA : A ≠ 0) (hC : 0 ≤ C)
    (hb : ContinuousAt b t)
    (hlip : ∀ᶠ s in 𝓝 t, ‖b s-b t‖ ≤ C*‖s-t‖)
    (hmem : ∀ᶠ s in 𝓝 t, (b s,s) ∈ S)
    (hzero : ∀ᶠ s in 𝓝 t, U (b s,s) = 0)
    (hd : HasFDerivWithinAt U
      (A • ContinuousLinearMap.fst ℝ ℝ ℝ+B • ContinuousLinearMap.snd ℝ ℝ ℝ) S (b t,t)) :
    HasDerivAt b (-B/A) t := by
  have hmap : Tendsto (fun s => (b s,s)) (𝓝 t) (𝓝[S] (b t,t)) :=
    tendsto_nhdsWithin_iff.mpr ⟨(hb.prodMk continuousAt_id).tendsto,hmem⟩
  have hzero0 := hzero.self_of_nhds
  rw [hasFDerivWithinAt_iff_isLittleO] at hd
  rw [hasDerivAt_iff_isLittleO,Asymptotics.isLittleO_iff]
  intro ε hε
  have hAn : 0 < ‖A‖ := norm_pos_iff.mpr hA
  have hden : 0 < C+1 := by linarith
  have hη : 0 < ε*‖A‖/(C+1) := div_pos (mul_pos hε hAn) hden
  have hsmall := hmap.eventually (Asymptotics.isLittleO_iff.mp hd hη)
  filter_upwards [hsmall,hlip,hzero] with s hs hl hz
  have hprod : ‖(b s,s)-(b t,t)‖ ≤ (C+1)*‖s-t‖ := by
    rw [Prod.norm_def]
    apply max_le
    · exact hl.trans (by nlinarith [norm_nonneg (s-t)])
    · dsimp only [Prod.snd_sub]
      nlinarith [norm_nonneg (s-t)]
  have hlin : ‖A*(b s-b t)+B*(s-t)‖ ≤ (ε*‖A‖/(C+1))*‖(b s,s)-(b t,t)‖ := by
    change ‖U (b s,s)-U (b t,t)-(A*(b s-b t)+B*(s-t))‖ ≤
      (ε*‖A‖/(C+1))*‖(b s,s)-(b t,t)‖ at hs
    simpa only [hz,hzero0,sub_self,zero_sub,norm_neg] using hs
  have hbound := hlin.trans (mul_le_mul_of_nonneg_left hprod hη.le)
  rw [← mul_assoc,div_mul_cancel₀ _ hden.ne'] at hbound
  have he : A*(b s-b t-(s-t)*(-B/A)) = A*(b s-b t)+B*(s-t) := by field_simp; ring
  rw [← he,norm_mul] at hbound
  have hfinal : ‖b s-b t-(s-t)*(-B/A)‖ ≤ ε*‖s-t‖ := by nlinarith
  simpa only [smul_eq_mul] using hfinal

end AmericanConvexity.Boundary
