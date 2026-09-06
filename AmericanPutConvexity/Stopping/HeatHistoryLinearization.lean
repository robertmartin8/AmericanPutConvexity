import AmericanPutConvexity.Stopping.HeatHistoryTimeKernel

/-! # Bounded remainder after freezing the history kernel to a line

A C1,1/2 graph differs from its tangent by order u^(3/2). The spatial
kernel derivative has order u^(-3/2), so their product is bounded. A
one-half Holder density adds another bounded remainder. This identifies
the singular leading term without differentiating the density or velocity.
-/

namespace AmericanPutConvexity.Stopping

theorem heatBoundaryKernel_linear_remainder_bound {u x v A : ℝ}
    (hu : 0 < u) (hrem : ‖x-v*u‖ ≤ A*u*Real.sqrt u) :
    ‖heatBoundaryKernel u x-heatBoundaryKernel u (v*u)‖ ≤ 3*A/Real.sqrt (2*Real.pi) := by
  calc
    _ ≤ (3/(u*Real.sqrt (2*Real.pi*u)))*‖x-v*u‖ := heatBoundaryKernel_sub_bound hu _ _
    _ ≤ (3/(u*Real.sqrt (2*Real.pi*u)))*(A*u*Real.sqrt u) :=
      mul_le_mul_of_nonneg_left hrem (by positivity)
    _ = _ := by
      rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
      have hs : Real.sqrt u ≠ 0 := (Real.sqrt_pos.mpr hu).ne'
      field_simp

theorem heatHistory_integrand_linear_remainder_bound {u x v A L C D fs ft : ℝ}
    (hu : 0 < u) (hA : 0 ≤ A) (hL : 0 ≤ L)
    (hrem : ‖x-v*u‖ ≤ A*u*Real.sqrt u) (hv : ‖v‖ ≤ L)
    (hfs : ‖fs‖ ≤ C) (hmod : ‖fs-ft‖ ≤ D*Real.sqrt u) :
    ‖heatBoundaryKernel u x*fs-heatBoundaryKernel u (v*u)*ft‖ ≤
      3*(A*C+L*D)/Real.sqrt (2*Real.pi) := by
  have hlinear : ‖v*u‖ ≤ L*u := by
    rw [norm_mul,Real.norm_of_nonneg hu.le]
    exact mul_le_mul_of_nonneg_right hv hu.le
  have hK := heatBoundaryKernel_motion_bound hu hlinear
  have hR := heatBoundaryKernel_linear_remainder_bound hu hrem
  calc
    _ = ‖(heatBoundaryKernel u x-heatBoundaryKernel u (v*u))*fs+
        heatBoundaryKernel u (v*u)*(fs-ft)‖ := by congr 1; ring
    _ ≤ ‖(heatBoundaryKernel u x-heatBoundaryKernel u (v*u))*fs‖+
        ‖heatBoundaryKernel u (v*u)*(fs-ft)‖ := norm_add_le _ _
    _ = ‖heatBoundaryKernel u x-heatBoundaryKernel u (v*u)‖*‖fs‖+
        ‖heatBoundaryKernel u (v*u)‖*‖fs-ft‖ := by rw [norm_mul,norm_mul]
    _ ≤ (3*A/Real.sqrt (2*Real.pi))*C+
        (3*L/Real.sqrt (2*Real.pi*u))*(D*Real.sqrt u) :=
      add_le_add (mul_le_mul hR hfs (norm_nonneg _) (by positivity))
        (mul_le_mul hK hmod (norm_nonneg _) (by positivity))
    _ = _ := by
      rw [Real.sqrt_mul (by positivity : 0 ≤ 2*Real.pi)]
      have hs : Real.sqrt u ≠ 0 := (Real.sqrt_pos.mpr hu).ne'
      field_simp

end AmericanPutConvexity.Stopping
