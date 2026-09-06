import AmericanPutConvexity.Boundary.ParabolicMaximum

/-! # Compact ordered equal-time triples in a moving strip -/

namespace AmericanPutConvexity.Boundary

open Set

abbrev SpaceTimeTriple := (ℝ × ℝ) × (ℝ × ℝ) × (ℝ × ℝ)

def sameTimeTriple (x y z t : ℝ) : SpaceTimeTriple := ((x,t),(y,t),(z,t))

def orderedTriples (Q : Set (ℝ × ℝ)) : Set SpaceTimeTriple :=
  (Q ×ˢ Q ×ˢ Q) ∩ {w | w.1.2 = w.2.1.2 ∧ w.1.2 = w.2.2.2 ∧
    w.1.1 ≤ w.2.1.1 ∧ w.2.1.1 ≤ w.2.2.1}

theorem orderedTriples_isCompact {Q : Set (ℝ × ℝ)} (hQ : IsCompact Q) :
    IsCompact (orderedTriples Q) := by
  have h1 : IsClosed {w : SpaceTimeTriple | w.1.2 = w.2.1.2} :=
    isClosed_eq (by fun_prop) (by fun_prop)
  have h2 : IsClosed {w : SpaceTimeTriple | w.1.2 = w.2.2.2} :=
    isClosed_eq (by fun_prop) (by fun_prop)
  have h3 : IsClosed {w : SpaceTimeTriple | w.1.1 ≤ w.2.1.1} :=
    isClosed_le (by fun_prop) (by fun_prop)
  have h4 : IsClosed {w : SpaceTimeTriple | w.2.1.1 ≤ w.2.2.1} :=
    isClosed_le (by fun_prop) (by fun_prop)
  exact (hQ.prod (hQ.prod hQ)).inter_right (h1.inter (h2.inter (h3.inter h4)))

theorem sameTimeTriple_mem {b : ℝ → ℝ} {R a T x y z t : ℝ}
    (ha : a ≤ t) (hT : t ≤ T) (hb : b t ≤ x) (hxy : x ≤ y) (hyz : y ≤ z) (hR : z ≤ R) :
    sameTimeTriple x y z t ∈ orderedTriples (movingStrip b R a T) := by
  refine ⟨⟨?_,?_,?_⟩,rfl,rfl,hxy,hyz⟩
  · exact ⟨ha,hT,hb,(hxy.trans hyz).trans hR⟩
  · exact ⟨ha,hT,hb.trans hxy,hyz.trans hR⟩
  · exact ⟨ha,hT,(hb.trans hxy).trans hyz,hR⟩

end AmericanPutConvexity.Boundary
