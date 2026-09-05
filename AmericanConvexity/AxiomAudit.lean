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
import AmericanConvexity.Stopping.IntervalHeatBoundary
import AmericanConvexity.Stopping.ActualInteriorRegularity
import AmericanConvexity.Stopping.PositiveExerciseBoundary
import AmericanConvexity.Stopping.ActualBoundaryContinuity
import AmericanConvexity.Stopping.ContactTimeBoundary
import AmericanConvexity.Stopping.ActualSmoothFit
import AmericanConvexity.Stopping.ActualGradientTrace
import AmericanConvexity.Stopping.ActualClassicalContract
import AmericanConvexity.Stopping.ActualSpatialRegularity
import AmericanConvexity.Stopping.ActualBoundaryNondegeneracy
import AmericanConvexity.Stopping.ActualQuadraticSeparation
import AmericanConvexity.Stopping.ActualBoundaryIncrement
import AmericanConvexity.Stopping.ActualTemporalModulus
import AmericanConvexity.Stopping.ActualBoundaryTemporalModulus
import AmericanConvexity.Stopping.ActualExpiryUpperBound
import AmericanConvexity.Stopping.ActualBoundaryQuarterBound
import AmericanConvexity.Stopping.ActualBoundaryHalfBound
import AmericanConvexity.Stopping.ActualLogConvexity
import AmericanConvexity.Stopping.ActualStockConvexity
import AmericanConvexity.Stopping.PhysicalBoundaryConvexity
import AmericanConvexity.Stopping.ActualContactDifferentiability
import AmericanConvexity.Stopping.ActualBoundaryOneSided
import AmericanConvexity.Stopping.QuadraticUpper
import AmericanConvexity.Stopping.ActualSpatialSecondBound
import AmericanConvexity.Stopping.ActualQuadraticUpper
import AmericanConvexity.Stopping.ActualContactIncrement
import AmericanConvexity.Boundary.DiscountedMaximum
import AmericanConvexity.Boundary.StationaryBarrier
import AmericanConvexity.Stopping.ActualIncrementComparison
import AmericanConvexity.Stopping.ActualTemporalTraceBound
import AmericanConvexity.Stopping.ActualTimeDerivativeContinuity
import AmericanConvexity.Stopping.ActualSpatialSecondTrace
import AmericanConvexity.Stopping.ActualPriceC1
import AmericanConvexity.Stopping.ActualCurvatureExtension
import AmericanConvexity.Stopping.PlanePricingDerivative
import AmericanConvexity.Stopping.ActualTheta
import AmericanConvexity.Stopping.ActualThetaPositivity
import AmericanConvexity.Boundary.QuantitativeHopf
import AmericanConvexity.Stopping.ActualThetaContactGrowth
import AmericanConvexity.Stopping.ActualBoundaryHeatJump
import AmericanConvexity.Stopping.ActualBoundaryHeatLayer
import AmericanConvexity.Stopping.ActualHeatDensity
import AmericanConvexity.Boundary.NeumannExterior
import AmericanConvexity.Stopping.HeatLayerMatching
import AmericanConvexity.Stopping.ActualHeatSource
import AmericanConvexity.Stopping.ActualHeatForcing
import AmericanConvexity.Stopping.SourceHeatEquation
import AmericanConvexity.Stopping.LocalSourceEquation
import AmericanConvexity.Stopping.ActualHeatFlux
import AmericanConvexity.Stopping.ActualThetaFlux
import AmericanConvexity.Stopping.ActualThetaGradientTrace
import AmericanConvexity.Stopping.MovingHeatLayerBridge

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

/-- info: 'AmericanConvexity.Stopping.boundaryArrivalMass_lt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.boundaryArrivalMass_lt_one

/-- info: 'AmericanConvexity.Stopping.heatBoundaryExtension_finite_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryExtension_finite_bound

/-- info: 'AmericanConvexity.Stopping.crossBoundaryCausal_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.crossBoundaryCausal_lipschitz

/-- info: 'AmericanConvexity.Stopping.coupledBoundaryStep_contracting' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.coupledBoundaryStep_contracting

/-- info: 'AmericanConvexity.Stopping.exists_coupled_boundary_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_coupled_boundary_inputs

/-- info: 'AmericanConvexity.Stopping.exists_coupled_compact_boundary_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_coupled_compact_boundary_inputs

/-- info: 'AmericanConvexity.Stopping.exists_boundary_time_cutoff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_boundary_time_cutoff

/-- info: 'AmericanConvexity.Stopping.intervalHeatCorrection_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.intervalHeatCorrection_equation

/-- info: 'AmericanConvexity.Stopping.exists_interval_heat_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_interval_heat_boundary_solution

/-- info: 'AmericanConvexity.Stopping.exists_interval_heat_boundary_solution_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_interval_heat_boundary_solution_continuous

/-- info: 'AmericanConvexity.Stopping.priceFromHeat_pricingOperator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.priceFromHeat_pricingOperator

/-- info: 'AmericanConvexity.Stopping.exists_interval_pricing_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_interval_pricing_boundary_solution

/-- info: 'AmericanConvexity.Stopping.exists_pricing_dirichlet_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_pricing_dirichlet_solution

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_locally_eq_smooth_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_locally_eq_smooth_solution

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contDiffOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contDiffOn

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_continuation_pde' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_continuation_pde

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_le_of_upper_supports' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_le_of_upper_supports

/-- info: 'AmericanConvexity.Stopping.stationaryPutCap_upper_support' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.stationaryPutCap_upper_support

/-- info: 'AmericanConvexity.Stopping.exists_stationaryPutCap_parameters' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_stationaryPutCap_parameters

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_le_stationaryPutCap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_le_stationaryPutCap

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_uniform_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_uniform_pos

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalStockBoundary_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalStockBoundary_pos

/-- info: 'AmericanConvexity.Stopping.exp_canonicalLogBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exp_canonicalLogBoundary

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_value_matching' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_value_matching

/-- info: 'AmericanConvexity.Stopping.canonicalContinuationRegion_eq_logBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalContinuationRegion_eq_logBoundary

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_monotone_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_monotone_time

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_forcing

/-- info: 'AmericanConvexity.Stopping.no_small_forced_profile' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.no_small_forced_profile

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_no_instantaneous_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_no_instantaneous_interval

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_exists_later_gt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_exists_later_gt

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_continuousOn

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_continuousOn

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_antitoneOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_continuousOn

/-- info: 'ProbabilityTheory.IsBrownianReal.indep_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms ProbabilityTheory.IsBrownianReal.indep_zero

/-- info: 'AmericanConvexity.Stopping.brownianProbe_hasLaw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianProbe_hasLaw

/-- info: 'AmericanConvexity.Stopping.brownianNegativeGerm_measurable_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianNegativeGerm_measurable_germ

/-- info: 'AmericanConvexity.Stopping.brownianNegativeGerm_prob_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianNegativeGerm_prob_one

/-- info: 'AmericanConvexity.Stopping.brownian_downward_excursions_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownian_downward_excursions_ae

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactTime_le_of_downcrossing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactTime_le_of_downcrossing

/-- info: 'AmericanConvexity.Stopping.brownianUsualActualContactTime_tendsto_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualActualContactTime_tendsto_boundary

/-- info: 'AmericanConvexity.Stopping.putPayoff_norm_sub_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.putPayoff_norm_sub_le

/-- info: 'AmericanConvexity.Stopping.discountedPutSlope_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.discountedPutSlope_bound

/-- info: 'AmericanConvexity.Stopping.discountedPutSlope_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.discountedPutSlope_tendsto

/-- info: 'AmericanConvexity.Stopping.actualContactSlope_integral_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualContactSlope_integral_tendsto

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_slope_le_contactSlope' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_slope_le_contactSlope

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_slope_tendsto_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_slope_tendsto_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_smooth_fit

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_smooth_fit

/-- info: 'AmericanConvexity.Stopping.convex_deriv_tendsto_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.convex_deriv_tendsto_right

/-- info: 'AmericanConvexity.Stopping.canonicalStockPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockPrice_smooth_fit

/-- info: 'AmericanConvexity.Stopping.canonicalStockPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockPrice_gradient_trace

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_gradient_trace

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_gradient_trace

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_gradient_trace

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_dividendPutSolution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_dividendPutSolution_of_boundary_smooth

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_solution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_solution_of_boundary_smooth

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_solution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_solution_of_boundary_smooth

/-- info: 'AmericanConvexity.Stopping.continuousAt_deriv_convex_slices' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.continuousAt_deriv_convex_slices

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_hasDerivAt_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_hasDerivAt_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_differentiableAt_spatial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_differentiableAt_spatial

/-- info: 'AmericanConvexity.Stopping.canonicalStockPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockPrice_gradient_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_gradient_continuousAt

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_gradient_continuousAt

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_gradient_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalBoundary_forcing_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalBoundary_forcing_pos

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanConvexity.Stopping.quadratic_separation_of_deriv2_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.quadratic_separation_of_deriv2_lower

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_separation_of_deriv2_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_separation_of_deriv2_lower

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_separation_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_separation_near_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_increment_bounds

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_bounds

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_increment_bounds

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_spatial_deriv_gt_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_spatial_deriv_gt_exercise

/-- info: 'AmericanConvexity.Stopping.canonicalTimeIncrement_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTimeIncrement_equation

/-- info: 'AmericanConvexity.Stopping.canonicalTimeIncrement_no_positive_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTimeIncrement_no_positive_max

/-- info: 'AmericanConvexity.Stopping.canonicalTimeIncrement_le_of_initial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTimeIncrement_le_of_initial_bound

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_expiry_gap_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_expiry_gap_le_atStrike

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_temporal_modulus

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_atStrike_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_atStrike_tendsto_zero

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_modulus

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_modulus

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanConvexity.Stopping.expiryUpperCap_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expiryUpperCap_supersolution

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_le_expiryUpperCap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_le_expiryUpperCap

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_atStrike_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_atStrike_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.quarter_bound_of_square_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.quarter_bound_of_square_bound

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_squared_increment_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_squared_increment_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv_bounds

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_equation

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_positive_max_continuation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_positive_max_continuation

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_equation

/-- info: 'AmericanConvexity.Stopping.dilationBarrier_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.dilationBarrier_supersolution

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_source_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_source_bound

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_no_positive_corrected_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_no_positive_corrected_max

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_le_on_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_le_on_rectangle

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumDilation_le_barrier

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPremiumDilation_le_barrier

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPremiumDilation_le_barrier

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_dilation_differential_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_dilation_differential_bound

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_le_dilationBound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_le_dilationBound

/-- info: 'AmericanConvexity.Stopping.increment_le_of_deriv_bound_on_positive' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.increment_le_of_deriv_bound_on_positive

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_squared_increment_linear_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_squared_increment_linear_bound

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_local_half_bound

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_half_bound

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_local_half_bound

/-- info: 'AmericanConvexity.Boundary.exists_first_nonnegative_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.exists_first_nonnegative_contact

/-- info: 'AmericanConvexity.Boundary.boundaryRatio_monotone_of_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.boundaryRatio_monotone_of_line_intervals

/-- info: 'AmericanConvexity.Boundary.convexOn_of_ratio_monotone_and_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.convexOn_of_ratio_monotone_and_line_intervals

/-- info: 'AmericanConvexity.Boundary.convexOn_of_negative_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.convexOn_of_negative_line_intervals

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanConvexity.Stopping.canonicalStraightDifference_superlevel_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStraightDifference_superlevel_interval

/-- info: 'AmericanConvexity.Stopping.canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStraightDifference_positive_interval

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_no_return_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_no_return_contact

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalStraightDifference_positive_interval

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalStraightDifference_positive_interval

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_spatial_test_in_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_spatial_test_in_exercise

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_no_positive_convex_lower_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_no_positive_convex_lower_max

/-- info: 'AmericanConvexity.Stopping.convex_subsolution_le_canonicalPrice_on_strip' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.convex_subsolution_le_canonicalPrice_on_strip

/-- info: 'AmericanConvexity.Stopping.expiryBarrier_le_canonicalPrice' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expiryBarrier_le_canonicalPrice

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_exists_expiryBarrier_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_exists_expiryBarrier_window

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_exists_sqrt_upper_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_exists_sqrt_upper_bound

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_below_linear_eventually' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_below_linear_eventually

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_ratio_tendsto_atBot

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.canonicalIncrementGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIncrementGauge_equation

/-- info: 'AmericanConvexity.Stopping.canonicalIncrementGauge_pos_above_strike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIncrementGauge_pos_above_strike

/-- info: 'AmericanConvexity.Stopping.canonicalIncrementGauge_pos_on_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIncrementGauge_pos_on_flat_tail

/-- info: 'AmericanConvexity.Stopping.canonicalIncrementGauge_fit_of_same_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIncrementGauge_fit_of_same_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_no_flat_tail

/-- info: 'AmericanConvexity.Boundary.strictAntiOn_of_convex_antitone_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.strictAntiOn_of_convex_antitone_no_flat_tail

/-- info: 'AmericanConvexity.Boundary.strictConvexOn_exp_of_convex_injective' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.strictConvexOn_exp_of_convex_injective

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_strictAntiOn

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_locallyLipschitzOn

/-- info: 'AmericanConvexity.Stopping.canonicalStockBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalStockBoundary_locallyLipschitzOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Stopping.BoundedRule.roundUp_time_tendsto_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.BoundedRule.roundUp_time_tendsto_of_mesh

/-- info: 'AmericanConvexity.Stopping.expectedReward_roundUp_tendsto_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.expectedReward_roundUp_tendsto_of_mesh

/-- info: 'AmericanConvexity.Stopping.gridValue_tendsto_americanValue_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.gridValue_tendsto_americanValue_of_mesh

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_tendsto_usual_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_tendsto_usual_of_mesh

/-- info: 'AmericanConvexity.Stopping.brownianGridMarkovAux_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridMarkovAux_scale

/-- info: 'AmericanConvexity.Stopping.discountedLogPayoff_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.discountedLogPayoff_scale

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_scale

/-- info: 'AmericanConvexity.Stopping.brownianGridPrice_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianGridPrice_normalization

/-- info: 'AmericanConvexity.Stopping.brownianUsualAmericanPut_normalization_log' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualAmericanPut_normalization_log

/-- info: 'AmericanConvexity.Stopping.brownianUsualAmericanPut_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualAmericanPut_normalization

/-- info: 'AmericanConvexity.Stopping.brownianAmericanPut_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianAmericanPut_normalization

/-- info: 'AmericanConvexity.Stopping.normalized_rates_admissible' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.normalized_rates_admissible

/-- info: 'AmericanConvexity.Stopping.brownianUsualExerciseBoundary_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualExerciseBoundary_normalization

/-- info: 'AmericanConvexity.Stopping.brownianUsualExerciseBoundary_eq_scaled_canonical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualExerciseBoundary_eq_scaled_canonical

/-- info: 'AmericanConvexity.Stopping.brownianUsualLogBoundary_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualLogBoundary_normalization

/-- info: 'AmericanConvexity.Stopping.convexOn_positive_time_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.convexOn_positive_time_rescale

/-- info: 'AmericanConvexity.Stopping.strictConvexOn_positive_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.strictConvexOn_positive_rescale

/-- info: 'AmericanConvexity.Stopping.brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Stopping.brownianUsualStockBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualStockBoundary_strictAntiOn

/-- info: 'AmericanConvexity.Stopping.brownianUsualStockBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualStockBoundary_locallyLipschitzOn

/-- info: 'AmericanConvexity.Stopping.brownianUsualLogBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.brownianUsualLogBoundary_locallyLipschitzOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_brownianUsualLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Stopping.liuRange_brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_brownianUsualLogBoundary_convexOn

/-- info: 'AmericanConvexity.Stopping.liuRange_brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanConvexity.Boundary.hasFDerivAt_zero_of_flat_lipschitz_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.hasFDerivAt_zero_of_flat_lipschitz_contact

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_local_pointwise_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_local_pointwise_lipschitz

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_hasFDerivAt_contact

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_hasDerivAt_time_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_hasDerivAt_time_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_hasDerivAt_time_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_hasDerivAt_time_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_joint_differentiableAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_joint_differentiableAt

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_differentiableAt_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_differentiableAt_time

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_monotone' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_monotone

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_differentiableAt_iff_oneSided_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_differentiableAt_iff_oneSided_eq

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_deriv_neg_of_differentiableAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_deriv_neg_of_differentiableAt

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_oneSided_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_oneSided_speed

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_oneSided_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_oneSided_speed

/-- info: 'AmericanConvexity.Stopping.quadratic_upper_of_deriv2_upper' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.quadratic_upper_of_deriv2_upper

/-- info: 'AmericanConvexity.Stopping.actualSpatialSecondBound_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualSpatialSecondBound_pos

/-- info: 'AmericanConvexity.Stopping.actualSpatialSecondBound_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualSpatialSecondBound_continuous

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_le_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_le_bound

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_upper_near' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_upper_near

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_upper_of_deriv2_upper' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_upper_of_deriv2_upper

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_upper_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_upper_near_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_local_pairwise_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_local_pairwise_lipschitz

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contact_difference_quotient_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contact_difference_quotient_bound

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanConvexity.Boundary.discounted_parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.discounted_parabolic_maximum

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_contDiff

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_hasDerivAt

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_deriv2' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_deriv2

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_nonneg

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_pos

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_mono_distance' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_mono_distance

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_le_linear' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_le_linear

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_operator_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_operator_nonpos

/-- info: 'AmericanConvexity.Boundary.stationaryBoundaryBarrier_affine_operator_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.stationaryBoundaryBarrier_affine_operator_nonpos

/-- info: 'AmericanConvexity.Stopping.canonicalTimeIncrement_le_stationary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTimeIncrement_le_stationary

/-- info: 'AmericanConvexity.Stopping.canonicalTimeIncrement_le_exponential' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTimeIncrement_le_exponential

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_rectangle

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_linear_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_linear_near_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_exercise

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_eq_partial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_eq_partial

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_time_deriv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_time_deriv_continuousAt

/-- info: 'AmericanConvexity.Stopping.fderiv_plane_eq_partials' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.fderiv_plane_eq_partials

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_fderiv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_fderiv_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contDiffAt_one

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_contDiffOn_one

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalPrice_contDiffOn_one

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalPrice_contDiffOn_one

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_eq_deriv2' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_eq_deriv2

/-- info: 'AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPremiumCurvatureExtension_contact

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_right_slope_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalIntrinsicPremium_gradient_right_slope_tendsto

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanConvexity.Stopping.heatPartial_comm' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_comm

/-- info: 'AmericanConvexity.Stopping.heatPartial_comm_third' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_comm_third

/-- info: 'AmericanConvexity.Stopping.heatPartial_pricing_combination' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_pricing_combination

/-- info: 'AmericanConvexity.Stopping.heatPartial_spatial_second' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_spatial_second

/-- info: 'AmericanConvexity.Stopping.heatPartial_pricing_equation_derivative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_pricing_equation_derivative

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_nonneg

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_exercise_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_exercise_zero

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_contDiffAt

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_partial_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_partial_equation

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_equation

/-- info: 'AmericanConvexity.Stopping.canonicalPrice_mixed_derivs_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalPrice_mixed_derivs_eq

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalTheta_equation

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalTheta_equation

/-- info: 'AmericanConvexity.Stopping.canonicalThetaGauge_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaGauge_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalThetaGauge_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaGauge_contDiffAt

/-- info: 'AmericanConvexity.Stopping.canonicalThetaGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaGauge_equation

/-- info: 'AmericanConvexity.Stopping.canonicalThetaGauge_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaGauge_nonneg

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_positive_earlier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_positive_earlier

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_pos

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalTheta_pos

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalTheta_pos

/-- info: 'AmericanConvexity.Boundary.terminal_linear_lower_of_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.terminal_linear_lower_of_barrier

/-- info: 'AmericanConvexity.Boundary.terminal_linear_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.terminal_linear_lower

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_linear_lower_at_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_linear_lower_at_boundary

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_contact_slope_bounds

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_not_differentiableAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_not_differentiableAt_contact

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalTheta_contact_slope_bounds

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalTheta_contact_slope_bounds

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_deriv_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_deriv_bound

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_sub_bound

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_lipschitz_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_lipschitz_motion_bound

/-- info: 'AmericanConvexity.Stopping.integrableOn_inverse_sqrt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.integrableOn_inverse_sqrt

/-- info: 'AmericanConvexity.Stopping.movingHeatRemainder_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatRemainder_integrable

/-- info: 'AmericanConvexity.Stopping.movingHeatRemainder_integral_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatRemainder_integral_continuous

/-- info: 'AmericanConvexity.Stopping.movingHeatBoundaryKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatBoundaryKernel_jump

/-- info: 'AmericanConvexity.Stopping.movingHeatKernel_deriv_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatKernel_deriv_jump

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_heat_displacement' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_heat_displacement

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanConvexity.Stopping.heatKernel_inverse_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatKernel_inverse_sqrt_bound

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_away_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_away_bound

/-- info: 'AmericanConvexity.Stopping.movingHeatBoundaryKernel_away_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatBoundaryKernel_away_bound

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_integrable

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_continuous

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_hasDerivAt

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_deriv_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_deriv_tendsto

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact

/-- info: 'AmericanConvexity.Stopping.movingHeatLayerFlux_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayerFlux_continuous

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanConvexity.Stopping.integral_inverse_sqrt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.integral_inverse_sqrt

/-- info: 'AmericanConvexity.Stopping.heatHistoryNormBound_mono' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistoryNormBound_mono

/-- info: 'AmericanConvexity.Stopping.exists_small_heatHistory_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_small_heatHistory_window

/-- info: 'AmericanConvexity.Stopping.heatHistory_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistory_integrable

/-- info: 'AmericanConvexity.Stopping.heatHistory_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistory_continuous

/-- info: 'AmericanConvexity.Stopping.heatHistory_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistory_bound

/-- info: 'AmericanConvexity.Stopping.heatHistoryBCF_dist' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistoryBCF_dist

/-- info: 'AmericanConvexity.Stopping.heatDensityStep_contracting' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatDensityStep_contracting

/-- info: 'AmericanConvexity.Stopping.exists_unique_causal_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_unique_causal_heat_density

/-- info: 'AmericanConvexity.Stopping.heatHistory_eq_causal_past' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatHistory_eq_causal_past

/-- info: 'AmericanConvexity.Stopping.exists_local_causal_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_local_causal_heat_density

/-- info: 'AmericanConvexity.Stopping.canonicalLogBoundary_local_lipschitz_extension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalLogBoundary_local_lipschitz_extension

/-- info: 'AmericanConvexity.Stopping.exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanConvexity.Stopping.zeroDividend_exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanConvexity.Stopping.liuRange_exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanConvexity.Boundary.right_deriv_nonpos_at_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.right_deriv_nonpos_at_max

/-- info: 'AmericanConvexity.Boundary.strict_neumann_parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.strict_neumann_parabolic_maximum

/-- info: 'AmericanConvexity.Boundary.bounded_neumann_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.bounded_neumann_heat_maximum

/-- info: 'AmericanConvexity.Boundary.bounded_neumann_heat_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.bounded_neumann_heat_zero

/-- info: 'AmericanConvexity.Boundary.bounded_neumann_heat_zero_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.bounded_neumann_heat_zero_left

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_reflect' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_reflect

/-- info: 'AmericanConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact_left

/-- info: 'AmericanConvexity.Stopping.heatDensity_flux_matching' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatDensity_flux_matching

/-- info: 'AmericanConvexity.Stopping.heatFromPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatFromPrice_equation

/-- info: 'AmericanConvexity.Stopping.canonicalHeatTheta_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatTheta_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatTheta_equation

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalHeatTheta_equation

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalHeatTheta_equation

/-- info: 'AmericanConvexity.Stopping.heatLocalizationSource_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatLocalizationSource_equation

/-- info: 'AmericanConvexity.Stopping.actualHeatLocalizationSource_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatLocalizationSource_continuous

/-- info: 'AmericanConvexity.Stopping.actualHeatLocalizationSource_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatLocalizationSource_bounded

/-- info: 'AmericanConvexity.Stopping.actualHeatLocalizationSource_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatLocalizationSource_equation

/-- info: 'AmericanConvexity.Stopping.actualHeatLocalizationSource_exercise_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatLocalizationSource_exercise_zero

/-- info: 'AmericanConvexity.Stopping.actualHeatTheta_localization_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatTheta_localization_continuous

/-- info: 'AmericanConvexity.Stopping.actualHeatTheta_localization_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatTheta_localization_bounded

/-- info: 'AmericanConvexity.Stopping.exists_graph_heat_cutoff_after' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_graph_heat_cutoff_after

/-- info: 'AmericanConvexity.Stopping.exists_actualHeatTheta_source_after' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_actualHeatTheta_source_after

/-- info: 'AmericanConvexity.Stopping.exists_actualHeatTheta_source' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_actualHeatTheta_source

/-- info: 'AmericanConvexity.Stopping.heatSourceMoment_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceMoment_continuous

/-- info: 'AmericanConvexity.Stopping.heatKernel_integral_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatKernel_integral_rescale

/-- info: 'AmericanConvexity.Stopping.heatBoundaryKernel_integral_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatBoundaryKernel_integral_rescale

/-- info: 'AmericanConvexity.Stopping.heatSourceSpatial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceSpatial_bound

/-- info: 'AmericanConvexity.Stopping.compact_heat_convolution_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_heat_convolution_hasDeriv

/-- info: 'AmericanConvexity.Stopping.heatSourceAverage_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceAverage_hasDerivAt

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_continuous

/-- info: 'AmericanConvexity.Stopping.heatSourcePotentialSpatial_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotentialSpatial_continuous

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_hasDerivAt

/-- info: 'AmericanConvexity.Stopping.heatSourcePotentialSpatial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotentialSpatial_bound

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_bound

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_causal

/-- info: 'AmericanConvexity.Stopping.heatSourcePotentialSpatial_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotentialSpatial_causal

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_eq_causal_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_eq_causal_integral

/-- info: 'AmericanConvexity.Stopping.canonicalHeatSourceForcing_apply' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatSourceForcing_apply

/-- info: 'AmericanConvexity.Stopping.canonicalHeatSourceForcing_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatSourceForcing_hasDerivAt

/-- info: 'AmericanConvexity.Stopping.exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_actualHeatSource_density

/-- info: 'AmericanConvexity.Stopping.zeroDividend_exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_exists_actualHeatSource_density

/-- info: 'AmericanConvexity.Stopping.liuRange_exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_exists_actualHeatSource_density

/-- info: 'AmericanConvexity.Stopping.causalHeatKernel_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatKernel_smoothAt

/-- info: 'AmericanConvexity.Stopping.causalHeatKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatKernel_equation

/-- info: 'AmericanConvexity.Stopping.causalHeatKernelPlane_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatKernelPlane_equation

/-- info: 'AmericanConvexity.Stopping.compact_movingPlaneIntegral_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_movingPlaneIntegral_continuousOn

/-- info: 'AmericanConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_space

/-- info: 'AmericanConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_time

/-- info: 'AmericanConvexity.Stopping.compact_movingPlaneIntegral_contDiffOn_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_movingPlaneIntegral_contDiffOn_space

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_equation

/-- info: 'AmericanConvexity.Stopping.exists_compact_causal_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_compact_causal_density

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_equation_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_equation_of_causal

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_contDiffAt_space_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_contDiffAt_space_of_causal

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_differentiableAt_time_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_differentiableAt_time_of_causal

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_eq_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_eq_elapsed

/-- info: 'AmericanConvexity.Stopping.elapsedMovingHeatLayer_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.elapsedMovingHeatLayer_continuous

/-- info: 'AmericanConvexity.Stopping.elapsedMovingHeatLayer_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.elapsedMovingHeatLayer_bound

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_continuousOn_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_continuousOn_window

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_bound_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_bound_window

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_zero_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_zero_initial

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_normal_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_normal_traces

/-- info: 'AmericanConvexity.Stopping.heatPartial_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_contDiff

/-- info: 'AmericanConvexity.Stopping.heatPartial_hasCompactSupport' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_hasCompactSupport

/-- info: 'AmericanConvexity.Stopping.heatSourceMoment_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceMoment_hasDeriv_space

/-- info: 'AmericanConvexity.Stopping.heatSourceMoment_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceMoment_hasDeriv_time

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_space

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_time

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_deriv2_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_deriv2_space

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourceSpatial_eq_average_partial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourceSpatial_eq_average_partial

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_contDiff_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_contDiff_space

/-- info: 'AmericanConvexity.Stopping.heatPartial_pair' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatPartial_pair

/-- info: 'AmericanConvexity.Stopping.heatSource_scaled_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSource_scaled_hasDeriv

/-- info: 'AmericanConvexity.Stopping.heatKernel_integral_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatKernel_integral_one

/-- info: 'AmericanConvexity.Stopping.heatSourceAverage_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceAverage_zero

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed_raw

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_equation_with_endpoint' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_equation_with_endpoint

/-- info: 'AmericanConvexity.Stopping.smooth_heatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.smooth_heatSourcePotential_equation

/-- info: 'AmericanConvexity.Stopping.heatLocalizationSource_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatLocalizationSource_contDiffAt

/-- info: 'AmericanConvexity.Stopping.exists_compact_smooth_source_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_compact_smooth_source_germ

/-- info: 'AmericanConvexity.Stopping.compact_smooth_source_remainder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.compact_smooth_source_remainder

/-- info: 'AmericanConvexity.Stopping.canonicalHeat_off_contact_isOpen' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeat_off_contact_isOpen

/-- info: 'AmericanConvexity.Stopping.actualHeatLocalizationSource_contDiffAt_off_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatLocalizationSource_contDiffAt_off_contact

/-- info: 'AmericanConvexity.Stopping.exists_actualHeatSource_smooth_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_actualHeatSource_smooth_germ

/-- info: 'AmericanConvexity.Stopping.supported_kernelProduct_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.supported_kernelProduct_continuousOn

/-- info: 'AmericanConvexity.Stopping.supported_planeIntegral_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.supported_planeIntegral_hasDeriv

/-- info: 'AmericanConvexity.Stopping.sourceKernel_offOrigin' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourceKernel_offOrigin

/-- info: 'AmericanConvexity.Stopping.sourcePlaneKernel_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneKernel_continuousAt

/-- info: 'AmericanConvexity.Stopping.sourcePlaneIntegral_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneIntegral_continuousOn

/-- info: 'AmericanConvexity.Stopping.sourcePlaneIntegral_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneIntegral_integrable

/-- info: 'AmericanConvexity.Stopping.sourcePlaneIntegral_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneIntegral_hasDeriv_space

/-- info: 'AmericanConvexity.Stopping.sourcePlaneIntegral_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneIntegral_hasDeriv_time

/-- info: 'AmericanConvexity.Stopping.sourcePlaneIntegral_contDiffOn_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.sourcePlaneIntegral_contDiffOn_space

/-- info: 'AmericanConvexity.Stopping.causalHeatSourceIntegral_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatSourceIntegral_equation

/-- info: 'AmericanConvexity.Stopping.heatKernel_sub_comm' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatKernel_sub_comm

/-- info: 'AmericanConvexity.Stopping.causalHeatSourceIntegral_eq_potential' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalHeatSourceIntegral_eq_potential

/-- info: 'AmericanConvexity.Stopping.separated_heatSourcePotential_eventuallyEq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.separated_heatSourcePotential_eventuallyEq

/-- info: 'AmericanConvexity.Stopping.separated_heatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.separated_heatSourcePotential_equation

/-- info: 'AmericanConvexity.Stopping.separated_heatSourcePotential_contDiffAt_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.separated_heatSourcePotential_contDiffAt_space

/-- info: 'AmericanConvexity.Stopping.separated_heatSourcePotential_differentiableAt_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.separated_heatSourcePotential_differentiableAt_time

/-- info: 'AmericanConvexity.Stopping.heatSourceAverage_add' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourceAverage_add

/-- info: 'AmericanConvexity.Stopping.heatSourcePotential_add' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatSourcePotential_add

/-- info: 'AmericanConvexity.Stopping.source_deriv2_add_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.source_deriv2_add_at

/-- info: 'AmericanConvexity.Stopping.local_heatSourcePotential_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.local_heatSourcePotential_regular

/-- info: 'AmericanConvexity.Stopping.actualHeatSourcePotential_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatSourcePotential_regular

/-- info: 'AmericanConvexity.Stopping.zeroDividend_actualHeatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_actualHeatSourcePotential_equation

/-- info: 'AmericanConvexity.Stopping.liuRange_actualHeatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_actualHeatSourcePotential_equation

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_continuousOn

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_bound

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_causal

/-- info: 'AmericanConvexity.Stopping.heat_deriv2_sub_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heat_deriv2_sub_at

/-- info: 'AmericanConvexity.Stopping.heat_deriv2_const_mul_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heat_deriv2_const_mul_at

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_regular

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_shifted_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_shifted_traces

/-- info: 'AmericanConvexity.Stopping.unshift_hasDerivWithinAt_Iic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.unshift_hasDerivWithinAt_Iic

/-- info: 'AmericanConvexity.Stopping.unshift_hasDerivWithinAt_Ici' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.unshift_hasDerivWithinAt_Ici

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_normal_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_normal_traces

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_zero_exterior' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_zero_exterior

/-- info: 'AmericanConvexity.Stopping.bounded_inhomogeneous_heat_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.bounded_inhomogeneous_heat_unique

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_identification

/-- info: 'AmericanConvexity.Stopping.heatRepresentation_transfer_right_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentation_transfer_right_trace

/-- info: 'AmericanConvexity.Stopping.canonicalHeatGraph_clamp_window_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatGraph_clamp_window_bound

/-- info: 'AmericanConvexity.Stopping.actualHeatTheta_localized_representation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.actualHeatTheta_localized_representation

/-- info: 'AmericanConvexity.Stopping.exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanConvexity.Stopping.canonicalHeatTheta_has_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatTheta_has_right_flux

/-- info: 'AmericanConvexity.Stopping.zeroDividend_exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanConvexity.Stopping.liuRange_exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanConvexity.Boundary.strict_dirichlet_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.strict_dirichlet_heat_maximum

/-- info: 'AmericanConvexity.Boundary.bounded_dirichlet_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.bounded_dirichlet_heat_maximum

/-- info: 'AmericanConvexity.Boundary.bounded_dirichlet_heat_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Boundary.bounded_dirichlet_heat_zero

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_eq_inverse_heat' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_eq_inverse_heat

/-- info: 'AmericanConvexity.Stopping.inverseThetaHeatGauge_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.inverseThetaHeatGauge_hasDeriv_space

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_hasDerivWithinAt_of_heat_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_hasDerivWithinAt_of_heat_flux

/-- info: 'AmericanConvexity.Stopping.exists_canonicalTheta_local_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalTheta_local_right_flux

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_hasDerivWithinAt_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_hasDerivWithinAt_right_flux

/-- info: 'AmericanConvexity.Stopping.canonicalThetaRightFlux_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaRightFlux_continuousAt

/-- info: 'AmericanConvexity.Stopping.canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaRightFlux_pos

/-- info: 'AmericanConvexity.Stopping.canonicalThetaRightFlux_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalThetaRightFlux_continuousOn

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_contact_ratio_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_contact_ratio_tendsto

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_pos

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalThetaRightFlux_pos

/-- info: 'AmericanConvexity.Stopping.movingHeatNormalExtension_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatNormalExtension_continuousOn

/-- info: 'AmericanConvexity.Stopping.movingHeatNormalExtension_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatNormalExtension_boundary

/-- info: 'AmericanConvexity.Stopping.movingHeatNormalExtension_eq_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.movingHeatNormalExtension_eq_integral

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayer_hasDerivAt_normalExtension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayer_hasDerivAt_normalExtension

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayerRightGradient_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayerRightGradient_continuousOn

/-- info: 'AmericanConvexity.Stopping.causalMovingHeatLayerRightGradient_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.causalMovingHeatLayerRightGradient_boundary

/-- info: 'AmericanConvexity.Stopping.heatRepresentationRightGradient_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationRightGradient_continuousOn

/-- info: 'AmericanConvexity.Stopping.heatRepresentationCandidate_hasDerivAt_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationCandidate_hasDerivAt_rightGradient

/-- info: 'AmericanConvexity.Stopping.heatRepresentationRightGradient_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentationRightGradient_boundary

/-- info: 'AmericanConvexity.Stopping.heatRepresentation_transfer_interior_gradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.heatRepresentation_transfer_interior_gradient

/-- info: 'AmericanConvexity.Stopping.exists_canonicalHeatTheta_local_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalHeatTheta_local_rightGradient

/-- info: 'AmericanConvexity.Stopping.canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_hasDerivAt_of_heat_gradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_hasDerivAt_of_heat_gradient

/-- info: 'AmericanConvexity.Stopping.exists_canonicalTheta_local_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.exists_canonicalTheta_local_rightGradient

/-- info: 'AmericanConvexity.Stopping.canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.canonicalTheta_gradient_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.zeroDividend_canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.zeroDividend_canonicalTheta_gradient_tendsto_contact

/-- info: 'AmericanConvexity.Stopping.liuRange_canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanConvexity.Stopping.liuRange_canonicalTheta_gradient_tendsto_contact
