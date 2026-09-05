import AmericanConvexity.Finance
import AmericanConvexity.Boundary.Coordinates
import AmericanConvexity.Boundary.Limits
import AmericanConvexity.Boundary.InitialProfileCheck
import AmericanConvexity.Boundary.Profiles
import AmericanConvexity.Boundary.ProfileConcentration
import AmericanConvexity.Boundary.ProfileOperator
import AmericanConvexity.Boundary.DividendProblem
import AmericanConvexity.Boundary.Comparison
import AmericanConvexity.Boundary.GaugeTransform
import AmericanConvexity.Boundary.ComparisonTail
import AmericanConvexity.Boundary.ComparisonCoefficients
import AmericanConvexity.Boundary.ComparisonMaximum
import AmericanConvexity.Boundary.ComparisonHopf
import AmericanConvexity.Boundary.ComparisonAssembly
import AmericanConvexity.Boundary.RootStability
import AmericanConvexity.Boundary.ComparisonIntervals
import AmericanConvexity.Boundary.ObstacleComparison
import AmericanConvexity.Boundary.ComparisonConclusion
import AmericanConvexity.Boundary.StockConclusion
import AmericanConvexity.Stopping.ClassicalBridge
import AmericanConvexity.Stopping.ClassicalCandidate
import AmericanConvexity.Stopping.BrownianVerification
import AmericanConvexity.Stopping.LocalPriceIto
import AmericanConvexity.Stopping.BrownianLocalVerification
import AmericanConvexity.Stopping.BrownianInteriorLocalization

/-!
# Axiom checks for selected upstream and local results

These guards fail if a change introduces additional axioms, including `sorryAx`,
into these results. They do not audit all of MathFin or establish identification
of the classical pricing contract with the American optimal-stopping value.
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

/-- info: 'AmericanConvexity.Boundary.appendixProfile_concentration' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.appendixProfile_concentration

/-- info: 'AmericanConvexity.Boundary.appendixProfile_sign_conditions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.appendixProfile_sign_conditions

/-- info: 'AmericanConvexity.Boundary.operator_quotient_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.operator_quotient_deriv_neg

/-- info: 'AmericanConvexity.Boundary.dividendPutSolution_zero_iff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.dividendPutSolution_zero_iff

/-- info: 'AmericanConvexity.Boundary.liu_condition_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.liu_condition_normalization

/-- info: 'AmericanConvexity.Boundary.ode_nonneg_of_factored_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.ode_nonneg_of_factored_forcing

/-- info: 'AmericanConvexity.Boundary.Comparison.straightPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightPrice_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.straightPrice_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightPrice_fit

/-- info: 'AmericanConvexity.Boundary.Comparison.straightPrice_dominates' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightPrice_dominates

/-- info: 'AmericanConvexity.Boundary.Comparison.slope_gap_crosses_up' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.slope_gap_crosses_up

/-- info: 'AmericanConvexity.Boundary.Comparison.positive_root_gap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.positive_root_gap

/-- info: 'AmericanConvexity.Boundary.upward_zero_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.upward_zero_unique

/-- info: 'AmericanConvexity.Boundary.Comparison.initialDifference_level_subset_pair' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.initialDifference_level_subset_pair

/-- info: 'AmericanConvexity.Boundary.Comparison.initialDifference_simple_level' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.initialDifference_simple_level

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDifference_initial_superlevel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDifference_initial_superlevel

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_initial_superlevel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_initial_superlevel

/-- info: 'AmericanConvexity.Boundary.Comparison.gauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.gauge_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDifference_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDifference_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDifference_shifted_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDifference_shifted_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDifference_negative_near_corner' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDifference_negative_near_corner

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDifference_boundary_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDifference_boundary_neg

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_tail_estimate' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_tail_estimate

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_uniform_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_uniform_tail

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_right_negative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_right_negative

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_uniform_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_uniform_tail

/-- info: 'AmericanConvexity.Boundary.Comparison.normalizedDrift_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.normalizedDrift_bounded

/-- info: 'AmericanConvexity.Boundary.movingStrip_isCompact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.movingStrip_isCompact

/-- info: 'AmericanConvexity.Boundary.parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.parabolic_maximum

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_le_of_initial_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_le_of_initial_le

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_positive_at_earlier_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_positive_at_earlier_time

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_le_of_initial_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_le_of_initial_le

/-- info: 'AmericanConvexity.Boundary.terminal_hopf' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.terminal_hopf

/-- info: 'AmericanConvexity.Boundary.movingLineTransform_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.movingLineTransform_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.lineDifference_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.lineDifference_equation

/-- info: 'AmericanConvexity.Boundary.Comparison.lineDifference_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.lineDifference_fit

/-- info: 'AmericanConvexity.Boundary.Comparison.lineDifference_no_positive_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.lineDifference_no_positive_rectangle

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_no_positive_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_no_positive_rectangle

/-- info: 'AmericanConvexity.Boundary.eventually_lt_tangent_of_second_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.eventually_lt_tangent_of_second_deriv_neg

/-- info: 'AmericanConvexity.Boundary.curvature_nonneg_of_negative_intercepts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.curvature_nonneg_of_negative_intercepts

/-- info: 'AmericanConvexity.Boundary.Comparison.no_isolated_contact_of_positive_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.no_isolated_contact_of_positive_intervals

/-- info: 'AmericanConvexity.Boundary.Comparison.curvature_nonneg_of_tangent_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.curvature_nonneg_of_tangent_intervals

/-- info: 'AmericanConvexity.Boundary.Comparison.dividend_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.dividend_curvature_of_comparison_inputs

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_curvature_of_comparison_inputs

/-- info: 'AmericanConvexity.Boundary.deriv2_stockBoundary_pos_of_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.deriv2_stockBoundary_pos_of_nonneg

/-- info: 'AmericanConvexity.Boundary.Comparison.stock_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.stock_curvature_of_comparison_inputs

/-- info: 'AmericanConvexity.Boundary.Comparison.initialDifference_exact_two_simple_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.initialDifference_exact_two_simple_roots

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_initial_simple_root' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_initial_simple_root

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_two_root_confinement' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_two_root_confinement

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_initialization_of_derivative_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_initialization_of_derivative_traces

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_level_initialization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_level_initialization

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_level_initialization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_level_initialization

/-- info: 'AmericanConvexity.Boundary.superlevel_ordConnected_of_two_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.superlevel_ordConnected_of_two_roots

/-- info: 'AmericanConvexity.Boundary.positive_set_ordConnected_of_positive_levels' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.positive_set_ordConnected_of_positive_levels

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_superlevel_of_two_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_superlevel_of_two_roots

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_positive_interval_of_level_counts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_positive_interval_of_level_counts

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_positive_interval_of_level_counts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_positive_interval_of_level_counts

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.price_hasDerivAt_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.price_hasDerivAt_boundary

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_neg

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_forcing_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_forcing_pos

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.price_supersolution_off_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.price_supersolution_off_boundary

/-- info: 'AmericanConvexity.Boundary.second_deriv_nonpos_at_left_stationary_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.second_deriv_nonpos_at_left_stationary_max

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.spatial_test_at_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.spatial_test_at_boundary

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_test_residual_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_test_residual_pos

/-- info: 'AmericanConvexity.Boundary.twoSidedStrip_isCompact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.twoSidedStrip_isCompact

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison

/-- info: 'AmericanConvexity.Boundary.zeroDividend_obstacle_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.zeroDividend_obstacle_comparison

/-- info: 'AmericanConvexity.Boundary.expiryBarrier_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.expiryBarrier_subsolution

/-- info: 'AmericanConvexity.Boundary.expiryBarrier_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.expiryBarrier_continuousOn

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.expiryBarrier_le_price' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.expiryBarrier_le_price

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.exists_boundary_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.exists_boundary_sqrt_bound

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_ratio_tendsto_atBot

/-- info: 'AmericanConvexity.Boundary.zeroDividend_boundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.zeroDividend_boundary_ratio_tendsto_atBot

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison_of_local_tests' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison_of_local_tests

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.delayedPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.delayedPrice_equation

/-- info: 'AmericanConvexity.Boundary.localizationBarrier_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.localizationBarrier_supersolution

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.penalizedDelay_le_price' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.penalizedDelay_le_price

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.price_mono_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.price_mono_time

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_antitoneOn

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_deriv_neg_of_curvature_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_deriv_neg_of_curvature_neg

/-- info: 'AmericanConvexity.Boundary.zeroDividend_price_mono_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.zeroDividend_price_mono_time

/-- info: 'AmericanConvexity.Boundary.zeroDividend_boundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.zeroDividend_boundary_antitoneOn

/-- info: 'AmericanConvexity.Boundary.smoothValley_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.smoothValley_hasDeriv

/-- info: 'AmericanConvexity.Boundary.parabolic_smoothValley_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.parabolic_smoothValley_nonpos

/-- info: 'AmericanConvexity.Boundary.parabolic_three_point_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.parabolic_three_point_bound

/-- info: 'AmericanConvexity.Boundary.Comparison.straightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.straightDifference_positive_interval

/-- info: 'AmericanConvexity.Boundary.Comparison.dividend_log_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.dividend_log_curvature

/-- info: 'AmericanConvexity.Boundary.Comparison.dividend_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.dividend_curvature_claim

/-- info: 'AmericanConvexity.Boundary.Comparison.zeroDividend_weak_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.zeroDividend_weak_curvature_claim

/-- info: 'AmericanConvexity.Boundary.Comparison.liuRange_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.liuRange_curvature_claim

/-- info: 'AmericanConvexity.Boundary.Comparison.stock_curvature_of_strict_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.Comparison.stock_curvature_of_strict_speed

/-- info: 'AmericanConvexity.Boundary.positiveBump_operator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.positiveBump_operator

/-- info: 'AmericanConvexity.Boundary.positive_straight_tube' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.positive_straight_tube

/-- info: 'AmericanConvexity.Boundary.positive_later_of_positive_point' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.positive_later_of_positive_point

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_flat_tail_of_zero_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_flat_tail_of_zero_speed

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.incrementGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.incrementGauge_equation

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.incrementGauge_pos_on_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.incrementGauge_pos_on_flat_tail

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_no_flat_tail

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.boundary_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.boundary_deriv_neg

/-- info: 'AmericanConvexity.Boundary.dividend_stock_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.dividend_stock_curvature

/-- info: 'AmericanConvexity.Boundary.dividend_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.dividend_remainingTime_curvature

/-- info: 'AmericanConvexity.Boundary.zeroDividend_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.zeroDividend_remainingTime_curvature

/-- info: 'AmericanConvexity.Boundary.liuRange_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.liuRange_remainingTime_curvature

/-- info: 'AmericanConvexity.Boundary.dividend_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.dividend_boundary_conclusions

/-- info: 'AmericanConvexity.Stopping.putReward_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.putReward_integrable

/-- info: 'AmericanConvexity.Stopping.value_at_expiry' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.value_at_expiry

/-- info: 'AmericanConvexity.Stopping.value_mono_horizon' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.value_mono_horizon

/-- info: 'AmericanConvexity.Stopping.value_convexOn_spot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.value_convexOn_spot

/-- info: 'AmericanConvexity.Stopping.exerciseSet_eq_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exerciseSet_eq_interval

/-- info: 'AmericanConvexity.Stopping.brownian_filtered' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_filtered

/-- info: 'AmericanConvexity.Stopping.brownianAmericanPut_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianAmericanPut_bounds

/-- info: 'AmericanConvexity.Stopping.brownianExerciseBoundary_contact_set' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianExerciseBoundary_contact_set

/-- info: 'AmericanConvexity.Stopping.brownianExerciseBoundary_antitone' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianExerciseBoundary_antitone

/-- info: 'AmericanConvexity.Stopping.threshold_eq_of_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.threshold_eq_of_price_identification

/-- info: 'AmericanConvexity.Stopping.brownian_boundary_curvature_of_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_boundary_curvature_of_price_identification

/-- info: 'AmericanConvexity.Stopping.expected_stoppedValue_le_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_stoppedValue_le_initial

/-- info: 'AmericanConvexity.Stopping.expected_stoppedValue_eq_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_stoppedValue_eq_initial

/-- info: 'AmericanConvexity.Stopping.value_eq_of_contact_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.value_eq_of_contact_martingale

/-- info: 'AmericanConvexity.Stopping.classical_price_eq_value_of_verification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.classical_price_eq_value_of_verification

/-- info: 'AmericanConvexity.Stopping.firstContactRule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.firstContactRule

/-- info: 'AmericanConvexity.Stopping.classicalContactRule_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.classicalContactRule_contact

/-- info: 'AmericanConvexity.Stopping.classicalContactRule_continuation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.classicalContactRule_continuation

/-- info: 'AmericanConvexity.Stopping.brownian_price_identification_of_martingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_price_identification_of_martingales

/-- info: 'AmericanConvexity.Stopping.brownian_boundary_curvature_of_martingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_boundary_curvature_of_martingales

/-- info: 'AmericanConvexity.Stopping.brownianPriceKernel_heat_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianPriceKernel_heat_equation

/-- info: 'AmericanConvexity.Stopping.brownianPriceKernel_localization_zero_drift' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianPriceKernel_localization_zero_drift

/-- info: 'AmericanConvexity.Stopping.plane_ito_localMartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.plane_ito_localMartingale

/-- info: 'AmericanConvexity.Stopping.local_price_ito' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.local_price_ito

/-- info: 'AmericanConvexity.Stopping.locally_bounded_localMartingale_is_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.locally_bounded_localMartingale_is_martingale

/-- info: 'AmericanConvexity.Stopping.martingale_smaller_filtration' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.martingale_smaller_filtration

/-- info: 'AmericanConvexity.Stopping.brownian_stoppedCandidate_martingale_of_local' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_stoppedCandidate_martingale_of_local

/-- info: 'AmericanConvexity.Stopping.brownian_boundary_curvature_of_localMartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_boundary_curvature_of_localMartingales

/-- info: 'AmericanConvexity.Stopping.interiorRule_at_positive_exit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.interiorRule_at_positive_exit

/-- info: 'AmericanConvexity.Stopping.interiorRule_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.interiorRule_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.martingale_of_bounded_limits' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.martingale_of_bounded_limits

/-- info: 'AmericanConvexity.Stopping.brownianInteriorRule_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianInteriorRule_tendsto

/-- info: 'AmericanConvexity.Stopping.brownian_contact_martingale_of_interior_localMartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_contact_martingale_of_interior_localMartingales
