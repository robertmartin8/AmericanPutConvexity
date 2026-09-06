import Mathlib.Analysis.Convex.Function
import Mathlib.Topology.Algebra.Order.LiminfLimsup
import Mathlib.Topology.Algebra.MulAction
import Mathlib.Topology.Instances.Real.Lemmas

/-!
# The weak-convexity limit step in CCJZ (2008), Section 3

Pointwise convergence suffices to pass the defining non-strict convexity inequality
to the limit. Proving convergence of the Stefan boundaries is a separate PDE task.
Strict convexity / strictly positive second derivative does NOT follow by this step.
-/

namespace AmericanPutConvexity.Boundary

open Filter
open scoped Topology

/-- A pointwise limit of convex real functions on a fixed convex domain is convex.
The nontrivial-filter assumption prevents a vacuous convergence hypothesis.
-/
theorem convexOn_of_pointwise_limit {ι : Type*} {l : Filter ι} [l.NeBot]
    {D : Set ℝ} {f : ι → ℝ → ℝ} {g : ℝ → ℝ}
    (hD : Convex ℝ D) (hf : ∀ i, ConvexOn ℝ D (f i))
    (hlim : ∀ x ∈ D, Tendsto (fun i => f i x) l (nhds (g x))) :
    ConvexOn ℝ D g := by
  refine ⟨hD, ?_⟩
  intro x hx y hy a b ha hb hab
  exact le_of_tendsto_of_tendsto
    (hlim _ (hD hx hy ha hb hab))
    (((hlim x hx).const_smul a).add ((hlim y hy).const_smul b))
    (Filter.Eventually.of_forall fun i => (hf i).2 hx hy ha hb hab)

end AmericanPutConvexity.Boundary
