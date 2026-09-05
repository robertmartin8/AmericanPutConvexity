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
import AmericanConvexity.Stopping.ContactMartingale
import AmericanConvexity.Stopping.LinearPriceComparison
import AmericanConvexity.Stopping.ClassicalHeatComparison
import AmericanConvexity.Stopping.ClassicalSupermartingale
import AmericanConvexity.Stopping.UsualBrownianValue
import AmericanConvexity.Stopping.CanonicalPrice
import AmericanConvexity.Stopping.StrictExerciseGeometry
import AmericanConvexity.Stopping.BoundarySemicontinuity
import AmericanConvexity.Stopping.ActualContact
import AmericanConvexity.Stopping.BermudanConvergence
import AmericanConvexity.Stopping.DiscreteStoppingValue
import AmericanConvexity.Stopping.GridBellman
import AmericanConvexity.Stopping.UsualGridMarkov
import AmericanConvexity.Stopping.ActualSupermartingale
import AmericanConvexity.Stopping.ActualOptimality
import AmericanConvexity.Stopping.ActualContactMartingale
import AmericanConvexity.Stopping.ActualLocalMeanValue
import AmericanConvexity.Stopping.ActualTestFunctions
import AmericanConvexity.Stopping.PricingTests
import AmericanConvexity.Stopping.ActualSmoothComparison
import AmericanConvexity.Stopping.ContinuousPriceEvolution
import AmericanConvexity.Stopping.HeatBoundaryExtension
import AmericanConvexity.Stopping.HeatBoundaryEquation

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

/-- info: 'AmericanConvexity.Stopping.exists_compact_set_localization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_compact_set_localization

/-- info: 'AmericanConvexity.Stopping.brownianPriceKernel_compact_localization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianPriceKernel_compact_localization

/-- info: 'AmericanConvexity.Stopping.brownianInteriorRule_smooth_extension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianInteriorRule_smooth_extension

/-- info: 'AmericanConvexity.Stopping.ae_eq_through_positive_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.ae_eq_through_positive_time

/-- info: 'AmericanConvexity.Stopping.brownianInteriorRule_ito_representation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianInteriorRule_ito_representation

/-- info: 'AmericanConvexity.Stopping.localMartingale_stopped_indicator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.localMartingale_stopped_indicator

/-- info: 'AmericanConvexity.Stopping.brownianInteriorRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianInteriorRule_martingale

/-- info: 'AmericanConvexity.Stopping.brownianClassicalContactRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianClassicalContactRule_martingale

/-- info: 'AmericanConvexity.Stopping.brownian_boundary_curvature_of_supermartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_boundary_curvature_of_supermartingales

/-- info: 'AmericanConvexity.Stopping.brownianClassicalContactRule_expectedReward' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianClassicalContactRule_expectedReward

/-- info: 'AmericanConvexity.Stopping.classicalPrice_le_brownianAmericanPut' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.classicalPrice_le_brownianAmericanPut

/-- info: 'AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison_unbounded_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.DividendPutSolution.obstacle_comparison_unbounded_window

/-- info: 'AmericanConvexity.Stopping.compact_heatFlow_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_heatFlow_contDiff

/-- info: 'AmericanConvexity.Stopping.compact_heatFlow_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_heatFlow_equation

/-- info: 'AmericanConvexity.Stopping.brownianHeatFlow_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianHeatFlow_continuous

/-- info: 'AmericanConvexity.Stopping.brownianHeatFlow_eq_kernel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianHeatFlow_eq_kernel

/-- info: 'AmericanConvexity.Stopping.linearPriceEvolution_le_classical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.linearPriceEvolution_le_classical

/-- info: 'AmericanConvexity.Stopping.exists_smooth_compact_minorant_sequence' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_smooth_compact_minorant_sequence

/-- info: 'AmericanConvexity.Stopping.classicalPrice_gaussian_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.classicalPrice_gaussian_comparison

/-- info: 'AmericanConvexity.Stopping.condExp_independent_kernel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.condExp_independent_kernel

/-- info: 'AmericanConvexity.Stopping.brownian_condExp_transition' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_condExp_transition

/-- info: 'AmericanConvexity.Stopping.brownianClassicalCandidate_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianClassicalCandidate_supermartingale

/-- info: 'AmericanConvexity.Stopping.brownian_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_price_identification

/-- info: 'AmericanConvexity.Stopping.brownian_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_boundary_conclusions

/-- info: 'AmericanConvexity.Stopping.brownian_zeroDividend_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_zeroDividend_boundary_conclusions

/-- info: 'AmericanConvexity.Stopping.brownian_liuRange_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_liuRange_boundary_conclusions

/-- info: 'AmericanConvexity.Stopping.bounded_continuous_supermartingale_rightCont' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.bounded_continuous_supermartingale_rightCont

/-- info: 'AmericanConvexity.Stopping.brownianRightAugAmericanPut_eq_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianRightAugAmericanPut_eq_raw

/-- info: 'AmericanConvexity.Stopping.bounded_supermartingale_completion' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.bounded_supermartingale_completion

/-- info: 'AmericanConvexity.Stopping.brownianUsualFiltration_isComplete' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualFiltration_isComplete

/-- info: 'AmericanConvexity.Stopping.brownianUsualAmericanPut_eq_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualAmericanPut_eq_raw

/-- info: 'AmericanConvexity.Stopping.brownianUsual_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsual_boundary_conclusions

/-- info: 'AmericanConvexity.Stopping.americanPutValue_continuous_horizon' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.americanPutValue_continuous_horizon

/-- info: 'AmericanConvexity.Stopping.americanPutValue_joint_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.americanPutValue_joint_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_continuous

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_initial

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_bounds

/-- info: 'AmericanConvexity.Stopping.americanPutValue_spot_decay' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.americanPutValue_spot_decay

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_decay' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_decay

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_decay_uniform' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_decay_uniform

/-- info: 'AmericanConvexity.Stopping.brownianAmericanPut_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianAmericanPut_pos

/-- info: 'AmericanConvexity.Stopping.brownianUsualAmericanPut_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualAmericanPut_pos

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_lt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_lt_one

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_strict_continuation_iff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_strict_continuation_iff

/-- info: 'AmericanConvexity.Stopping.canonicalContinuationRegion_isOpen' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalContinuationRegion_isOpen

/-- info: 'AmericanConvexity.Stopping.threshold_upperSemicontinuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.threshold_upperSemicontinuous

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_continuousWithinAt_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_continuousWithinAt_left

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactRule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactRule

/-- info: 'AmericanConvexity.Stopping.canonicalContactRule_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalContactRule_contact

/-- info: 'AmericanConvexity.Stopping.canonicalContactRule_continuation_before' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalContactRule_continuation_before

/-- info: 'AmericanConvexity.Stopping.canonicalContactRule_exercise_before_expiry' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalContactRule_exercise_before_expiry

/-- info: 'AmericanConvexity.Stopping.rounded_time_stopping' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.rounded_time_stopping

/-- info: 'AmericanConvexity.Stopping.expectedReward_roundUp_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expectedReward_roundUp_tendsto

/-- info: 'AmericanConvexity.Stopping.gridValue_tendsto_americanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.gridValue_tendsto_americanValue

/-- info: 'AmericanConvexity.Stopping.americanValue_eq_sup_gridValues' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.americanValue_eq_sup_gridValues

/-- info: 'AmericanConvexity.Stopping.canonicalGridPrice_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalGridPrice_tendsto

/-- info: 'AmericanConvexity.Stopping.finiteBellman_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.finiteBellman_supermartingale

/-- info: 'AmericanConvexity.Stopping.finiteBellman_le_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.finiteBellman_le_supermartingale

/-- info: 'AmericanConvexity.Stopping.discrete_stopped_martingale_of_before' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.discrete_stopped_martingale_of_before

/-- info: 'AmericanConvexity.Stopping.finiteBellmanContact_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.finiteBellmanContact_martingale

/-- info: 'AmericanConvexity.Stopping.finiteBellmanContact_optimal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.finiteBellmanContact_optimal

/-- info: 'AmericanConvexity.Stopping.discreteStoppingValue_eq_bellman' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.discreteStoppingValue_eq_bellman

/-- info: 'AmericanConvexity.Stopping.finiteBellmanRule_attains_value' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.finiteBellmanRule_attains_value

/-- info: 'AmericanConvexity.Stopping.gridValue_eq_discreteValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.gridValue_eq_discreteValue

/-- info: 'AmericanConvexity.Stopping.gridValue_eq_bellman' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.gridValue_eq_bellman

/-- info: 'AmericanConvexity.Stopping.optimalGridRule_attains_value' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.optimalGridRule_attains_value

/-- info: 'AmericanConvexity.Stopping.optimalGridRule_payoffs_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.optimalGridRule_payoffs_tendsto

/-- info: 'AmericanConvexity.Stopping.canonicalOptimalGridRule_payoffs_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalOptimalGridRule_payoffs_tendsto

/-- info: 'AmericanConvexity.Stopping.bellmanAux_eq_brownianGridMarkovAux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.bellmanAux_eq_brownianGridMarkovAux

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_eq_gridValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_eq_gridValue

/-- info: 'AmericanConvexity.Stopping.brownianTerminalValue_usual_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianTerminalValue_usual_martingale

/-- info: 'AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_eq_usualGridValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_eq_usualGridValue

/-- info: 'AmericanConvexity.Stopping.brownianUsualAmericanPut_eq_raw_of_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualAmericanPut_eq_raw_of_pos

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_tendsto_canonical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_tendsto_canonical

/-- info: 'AmericanConvexity.Stopping.delayedGrid_bellman_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.delayedGrid_bellman_eq

/-- info: 'AmericanConvexity.Stopping.delayedGridPrice_le_american' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.delayedGridPrice_le_american

/-- info: 'AmericanConvexity.Stopping.brownianAmericanPut_wait' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianAmericanPut_wait

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_wait' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_wait

/-- info: 'AmericanConvexity.Stopping.canonicalDiscountedPrice_gap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalDiscountedPrice_gap

/-- info: 'AmericanConvexity.Stopping.canonicalDiscountedPrice_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalDiscountedPrice_supermartingale

/-- info: 'AmericanConvexity.Stopping.canonicalDiscountedPrice_usual_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalDiscountedPrice_usual_supermartingale

/-- info: 'AmericanConvexity.Stopping.expected_stoppedValue_le_of_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_stoppedValue_le_of_le

/-- info: 'AmericanConvexity.Stopping.min_time_tendsto_firstContact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.min_time_tendsto_firstContact

/-- info: 'AmericanConvexity.Stopping.exists_subseq_gap_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_subseq_gap_tendsto_zero

/-- info: 'AmericanConvexity.Stopping.expected_firstContact_eq_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_firstContact_eq_initial

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactRule_optimal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactRule_optimal

/-- info: 'AmericanConvexity.Stopping.expected_value_eq_before_optimal_rule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_value_eq_before_optimal_rule

/-- info: 'AmericanConvexity.Stopping.stopped_martingale_of_expected_value_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.stopped_martingale_of_expected_value_eq

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactRule_value_preserving' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactRule_value_preserving

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactRule_martingale

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contact_meanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contact_meanValue

/-- info: 'AmericanConvexity.Stopping.exists_continuationRectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_continuationRectangle

/-- info: 'AmericanConvexity.Stopping.actualRectangleExit_boundary_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualRectangleExit_boundary_ae

/-- info: 'AmericanConvexity.Stopping.actualRectangleExit_le_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualRectangleExit_le_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_rectangle_meanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_rectangle_meanValue

/-- info: 'AmericanConvexity.Stopping.planeResidual_localMartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.planeResidual_localMartingale

/-- info: 'AmericanConvexity.Stopping.planeResidual_stopped_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.planeResidual_stopped_martingale

/-- info: 'AmericanConvexity.Stopping.plane_dynkin_compact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.plane_dynkin_compact

/-- info: 'AmericanConvexity.Stopping.rawRectangleExit_path_mem_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.rawRectangleExit_path_mem_ae

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_rectangle_meanValue_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_rectangle_meanValue_raw

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_rectangle_upper_test_of_patch' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_rectangle_upper_test_of_patch

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_rectangle_lower_test_of_patch' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_rectangle_lower_test_of_patch

/-- info: 'AmericanConvexity.Stopping.expected_rectangle_drift_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_rectangle_drift_pos

/-- info: 'AmericanConvexity.Stopping.expected_rectangle_drift_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expected_rectangle_drift_neg

/-- info: 'AmericanConvexity.Stopping.exists_continuationRectangle_in_nhds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_continuationRectangle_in_nhds

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_upper_generator_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_upper_generator_test

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_lower_generator_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_lower_generator_test

/-- info: 'AmericanConvexity.Stopping.pricingTestKernel_generator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.pricingTestKernel_generator

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_upper_pricing_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_upper_pricing_test

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_lower_pricing_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_lower_pricing_test

/-- info: 'AmericanConvexity.Stopping.pricingOperator_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.pricingOperator_barrier

/-- info: 'AmericanConvexity.Stopping.smoothPricingSubsolution_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smoothPricingSubsolution_le

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_smooth_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_smooth_subsolution

/-- info: 'AmericanConvexity.Stopping.neg_canonicalPrice_smooth_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.neg_canonicalPrice_smooth_subsolution

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_le_smooth_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_le_smooth_on_cylinder

/-- info: 'AmericanConvexity.Stopping.smooth_le_canonicalPrice_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_le_canonicalPrice_on_cylinder

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_eq_smooth_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_eq_smooth_on_cylinder

/-- info: 'AmericanConvexity.Stopping.compact_continuous_heatFlow_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_continuous_heatFlow_smooth

/-- info: 'AmericanConvexity.Stopping.linearPriceKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.linearPriceKernel_equation

/-- info: 'AmericanConvexity.Stopping.linearPriceEvolution_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.linearPriceEvolution_smoothAt

/-- info: 'AmericanConvexity.Stopping.linearPriceEvolution_pricingOperator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.linearPriceEvolution_pricingOperator

/-- info: 'AmericanConvexity.Stopping.exists_smooth_initial_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_smooth_initial_solution

/-- info: 'AmericanConvexity.Stopping.exists_canonicalPrice_initial_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalPrice_initial_solution

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_equation

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_integral

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_integrable

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_scale

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_continuous

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_boundary

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_tendsto

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_causal

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_bound

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_eq_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_eq_integral

/-- info: 'AmericanConvexity.Stopping.flatRpow_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.flatRpow_smooth

/-- info: 'AmericanConvexity.Stopping.causalHeatBoundaryKernel_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatBoundaryKernel_eq

/-- info: 'AmericanConvexity.Stopping.causalHeatBoundaryKernel_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatBoundaryKernel_smoothAt

/-- info: 'AmericanConvexity.Stopping.causalHeatBoundaryKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatBoundaryKernel_equation

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_eq_causalBoundaryIntegral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_eq_causalBoundaryIntegral

/-- info: 'AmericanConvexity.Stopping.compact_heatBoundaryExtension_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_heatBoundaryExtension_smooth

/-- info: 'AmericanConvexity.Stopping.compact_kernelIntegral_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_kernelIntegral_hasDeriv

/-- info: 'AmericanConvexity.Stopping.compact_causalBoundaryIntegral_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_causalBoundaryIntegral_equation

/-- info: 'AmericanConvexity.Stopping.compact_heatBoundaryExtension_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_heatBoundaryExtension_equation

/-- info: 'AmericanConvexity.Stopping.exists_halfLine_heat_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_halfLine_heat_boundary_solution
