import AmericanConvexity.Finance
import AmericanConvexity.Boundary.Coordinates
import AmericanConvexity.Boundary.Limits
import AmericanConvexity.Boundary.InitialProfileCheck
import AmericanConvexity.Boundary.Profiles

/-!
# Axiom checks for selected upstream and local results

These guards fail if a change introduces additional axioms, including `sorryAx`,
into these results. They do not audit all of MathFin or prove the still-outstanding
American-put boundary-convexity theorem.
-/

/-- info: 'MathFin.americanPrice_ge_intrinsic' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms MathFin.americanPrice_ge_intrinsic

/-- info: 'MathFin.binomialPrice_le_americanPrice' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms MathFin.binomialPrice_le_americanPrice

/-- info: 'MathFin.americanPrice_le_of_supermartingale_dominating' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in
#print axioms MathFin.americanPrice_le_of_supermartingale_dominating

/-- info: 'AmericanConvexity.Boundary.deriv2_stockBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.deriv2_stockBoundary

/-- info: 'AmericanConvexity.Boundary.deriv2_stockBoundary_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.deriv2_stockBoundary_pos

/-- info: 'AmericanConvexity.Boundary.stockBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stockBoundary_convexOn

/-- info: 'AmericanConvexity.Boundary.convexOn_of_pointwise_limit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.convexOn_of_pointwise_limit

/-- info: 'AmericanConvexity.Boundary.flatInitialProfile_conditions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.flatInitialProfile_conditions

/-- info: 'AmericanConvexity.Boundary.initial_speed_eq_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.initial_speed_eq_zero

/-- info: 'AmericanConvexity.Boundary.NormalizedPutSolution.contact_in_stock_units' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.NormalizedPutSolution.contact_in_stock_units

/-- info: 'AmericanConvexity.Boundary.NormalizedPutSolution.boundary_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.NormalizedPutSolution.boundary_unique

/-- info: 'AmericanConvexity.Boundary.NormalizedPutSolution.stock_curvature_of_log_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.NormalizedPutSolution.stock_curvature_of_log_curvature

/-- info: 'AmericanConvexity.Boundary.appendixProfile_initialData' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.appendixProfile_initialData

/-- info: 'AmericanConvexity.Boundary.appendixProfile_slope_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.appendixProfile_slope_pos

/-- info: 'AmericanConvexity.Boundary.flatInitialProfile_initialData' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.flatInitialProfile_initialData
