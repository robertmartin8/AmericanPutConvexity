import AmericanPutConvexity.Finance
import AmericanPutConvexity.Boundary.Coordinates
import AmericanPutConvexity.Boundary.Limits
import AmericanPutConvexity.Boundary.InitialProfileCheck
import AmericanPutConvexity.Boundary.Profiles
import AmericanPutConvexity.Boundary.ProfileConcentration
import AmericanPutConvexity.Boundary.ProfileOperator
import AmericanPutConvexity.Boundary.DividendProblem
import AmericanPutConvexity.Boundary.Comparison
import AmericanPutConvexity.Boundary.GaugeTransform
import AmericanPutConvexity.Boundary.ComparisonTail
import AmericanPutConvexity.Boundary.ComparisonCoefficients
import AmericanPutConvexity.Boundary.ComparisonMaximum
import AmericanPutConvexity.Boundary.ComparisonHopf
import AmericanPutConvexity.Boundary.ComparisonAssembly
import AmericanPutConvexity.Boundary.RootStability
import AmericanPutConvexity.Boundary.ComparisonIntervals
import AmericanPutConvexity.Boundary.ObstacleComparison
import AmericanPutConvexity.Boundary.ComparisonConclusion
import AmericanPutConvexity.Boundary.StockConclusion
import AmericanPutConvexity.Stopping.ClassicalBridge
import AmericanPutConvexity.Stopping.ClassicalCandidate
import AmericanPutConvexity.Stopping.BrownianVerification
import AmericanPutConvexity.Stopping.LocalPriceIto
import AmericanPutConvexity.Stopping.BrownianLocalVerification
import AmericanPutConvexity.Stopping.BrownianInteriorLocalization
import AmericanPutConvexity.Stopping.ContactMartingale
import AmericanPutConvexity.Stopping.LinearPriceComparison
import AmericanPutConvexity.Stopping.ClassicalHeatComparison
import AmericanPutConvexity.Stopping.ClassicalSupermartingale
import AmericanPutConvexity.Stopping.UsualBrownianValue
import AmericanPutConvexity.Stopping.CanonicalPrice
import AmericanPutConvexity.Stopping.StrictExerciseGeometry
import AmericanPutConvexity.Stopping.BoundarySemicontinuity
import AmericanPutConvexity.Stopping.ActualContact
import AmericanPutConvexity.Stopping.BermudanConvergence
import AmericanPutConvexity.Stopping.DiscreteStoppingValue
import AmericanPutConvexity.Stopping.GridBellman
import AmericanPutConvexity.Stopping.UsualGridMarkov
import AmericanPutConvexity.Stopping.ActualSupermartingale
import AmericanPutConvexity.Stopping.ActualOptimality
import AmericanPutConvexity.Stopping.ActualContactMartingale
import AmericanPutConvexity.Stopping.ActualLocalMeanValue
import AmericanPutConvexity.Stopping.ActualTestFunctions
import AmericanPutConvexity.Stopping.PricingTests
import AmericanPutConvexity.Stopping.ActualSmoothComparison
import AmericanPutConvexity.Stopping.ContinuousPriceEvolution
import AmericanPutConvexity.Stopping.HeatBoundaryExtension
import AmericanPutConvexity.Stopping.HeatBoundaryEquation
import AmericanPutConvexity.Stopping.IntervalHeatBoundary
import AmericanPutConvexity.Stopping.ActualInteriorRegularity
import AmericanPutConvexity.Stopping.PositiveExerciseBoundary
import AmericanPutConvexity.Stopping.ActualBoundaryContinuity
import AmericanPutConvexity.Stopping.ContactTimeBoundary
import AmericanPutConvexity.Stopping.ActualSmoothFit
import AmericanPutConvexity.Stopping.ActualGradientTrace
import AmericanPutConvexity.Stopping.ActualClassicalContract
import AmericanPutConvexity.Stopping.ActualSpatialRegularity
import AmericanPutConvexity.Stopping.ActualBoundaryNondegeneracy
import AmericanPutConvexity.Stopping.ActualQuadraticSeparation
import AmericanPutConvexity.Stopping.ActualBoundaryIncrement
import AmericanPutConvexity.Stopping.ActualTemporalModulus
import AmericanPutConvexity.Stopping.ActualBoundaryTemporalModulus
import AmericanPutConvexity.Stopping.ActualExpiryUpperBound
import AmericanPutConvexity.Stopping.ActualBoundaryQuarterBound
import AmericanPutConvexity.Stopping.ActualBoundaryHalfBound
import AmericanPutConvexity.Stopping.ActualLogConvexity
import AmericanPutConvexity.Stopping.ActualStockConvexity
import AmericanPutConvexity.Stopping.PhysicalBoundaryConvexity
import AmericanPutConvexity.Stopping.ActualContactDifferentiability
import AmericanPutConvexity.Stopping.ActualBoundaryOneSided
import AmericanPutConvexity.Stopping.QuadraticUpper
import AmericanPutConvexity.Stopping.ActualSpatialSecondBound
import AmericanPutConvexity.Stopping.ActualQuadraticUpper
import AmericanPutConvexity.Stopping.ActualContactIncrement
import AmericanPutConvexity.Boundary.DiscountedMaximum
import AmericanPutConvexity.Boundary.StationaryBarrier
import AmericanPutConvexity.Stopping.ActualIncrementComparison
import AmericanPutConvexity.Stopping.ActualTemporalTraceBound
import AmericanPutConvexity.Stopping.ActualTimeDerivativeContinuity
import AmericanPutConvexity.Stopping.ActualSpatialSecondTrace
import AmericanPutConvexity.Stopping.ActualPriceC1
import AmericanPutConvexity.Stopping.ActualCurvatureExtension
import AmericanPutConvexity.Stopping.PlanePricingDerivative
import AmericanPutConvexity.Stopping.ActualTheta
import AmericanPutConvexity.Stopping.ActualThetaPositivity
import AmericanPutConvexity.Boundary.QuantitativeHopf
import AmericanPutConvexity.Stopping.ActualThetaContactGrowth
import AmericanPutConvexity.Stopping.ActualBoundaryHeatJump
import AmericanPutConvexity.Stopping.ActualBoundaryHeatLayer
import AmericanPutConvexity.Stopping.ActualHeatDensity
import AmericanPutConvexity.Boundary.NeumannExterior
import AmericanPutConvexity.Stopping.HeatLayerMatching
import AmericanPutConvexity.Stopping.ActualHeatSource
import AmericanPutConvexity.Stopping.ActualHeatForcing
import AmericanPutConvexity.Stopping.SourceHeatEquation
import AmericanPutConvexity.Stopping.LocalSourceEquation
import AmericanPutConvexity.Stopping.ActualHeatFlux
import AmericanPutConvexity.Stopping.ActualThetaFlux
import AmericanPutConvexity.Stopping.ActualThetaGradientTrace
import AmericanPutConvexity.Stopping.ActualStefanVelocity
import AmericanPutConvexity.Stopping.ActualHistoryTimeBounds
import AmericanPutConvexity.Stopping.ActualHistoryHolder
import AmericanPutConvexity.Stopping.ActualHeatFluxHolder
import AmericanPutConvexity.Stopping.ActualGraphRemainder
import AmericanPutConvexity.Stopping.ActualRemainderTime
import AmericanPutConvexity.Stopping.HeatRemainderOverlap
import AmericanPutConvexity.Stopping.ActualHistoryThreeQuarter
import AmericanPutConvexity.Stopping.ActualVelocityThreeQuarter
import AmericanPutConvexity.Stopping.ActualFrozenDerivative
import AmericanPutConvexity.Stopping.ActualRecentRemainder
import AmericanPutConvexity.Stopping.ActualCommonPastDerivative
import AmericanPutConvexity.Stopping.ActualHeatFluxRightDerivative
import AmericanPutConvexity.Stopping.LocalHistoryRateIdentity
import AmericanPutConvexity.Stopping.PhysicalBoundaryCurvature
import AmericanPutConvexity.Stopping.AEHorizonCurvature
import AmericanPutConvexity.Stopping.MovingHeatLayerBridge

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

/-- info: 'AmericanPutConvexity.Boundary.deriv2_stockBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.deriv2_stockBoundary

/-- info: 'AmericanPutConvexity.Boundary.deriv2_stockBoundary_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.deriv2_stockBoundary_pos

/-- info: 'AmericanPutConvexity.Boundary.stockBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stockBoundary_convexOn

/-- info: 'AmericanPutConvexity.Boundary.convexOn_of_pointwise_limit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.convexOn_of_pointwise_limit

/-- info: 'AmericanPutConvexity.Boundary.flatInitialProfile_conditions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.flatInitialProfile_conditions

/-- info: 'AmericanPutConvexity.Boundary.initial_speed_eq_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.initial_speed_eq_zero

/-- info: 'AmericanPutConvexity.Boundary.NormalizedPutSolution.contact_in_stock_units' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.NormalizedPutSolution.contact_in_stock_units

/-- info: 'AmericanPutConvexity.Boundary.NormalizedPutSolution.boundary_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.NormalizedPutSolution.boundary_unique

/-- info: 'AmericanPutConvexity.Boundary.NormalizedPutSolution.stock_curvature_of_log_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.NormalizedPutSolution.stock_curvature_of_log_curvature

/-- info: 'AmericanPutConvexity.Boundary.appendixProfile_initialData' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.appendixProfile_initialData

/-- info: 'AmericanPutConvexity.Boundary.appendixProfile_slope_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.appendixProfile_slope_pos

/-- info: 'AmericanPutConvexity.Boundary.flatInitialProfile_initialData' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.flatInitialProfile_initialData

/-- info: 'AmericanPutConvexity.Boundary.appendixProfile_concentration' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.appendixProfile_concentration

/-- info: 'AmericanPutConvexity.Boundary.appendixProfile_sign_conditions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.appendixProfile_sign_conditions

/-- info: 'AmericanPutConvexity.Boundary.operator_quotient_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.operator_quotient_deriv_neg

/-- info: 'AmericanPutConvexity.Boundary.dividendPutSolution_zero_iff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.dividendPutSolution_zero_iff

/-- info: 'AmericanPutConvexity.Boundary.liu_condition_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.liu_condition_normalization

/-- info: 'AmericanPutConvexity.Boundary.ode_nonneg_of_factored_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.ode_nonneg_of_factored_forcing

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightPrice_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightPrice_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightPrice_fit

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightPrice_dominates' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightPrice_dominates

/-- info: 'AmericanPutConvexity.Boundary.Comparison.slope_gap_crosses_up' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.slope_gap_crosses_up

/-- info: 'AmericanPutConvexity.Boundary.Comparison.positive_root_gap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.positive_root_gap

/-- info: 'AmericanPutConvexity.Boundary.upward_zero_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.upward_zero_unique

/-- info: 'AmericanPutConvexity.Boundary.Comparison.initialDifference_level_subset_pair' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.initialDifference_level_subset_pair

/-- info: 'AmericanPutConvexity.Boundary.Comparison.initialDifference_simple_level' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.initialDifference_simple_level

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDifference_initial_superlevel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDifference_initial_superlevel

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_initial_superlevel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_initial_superlevel

/-- info: 'AmericanPutConvexity.Boundary.Comparison.gauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.gauge_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDifference_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDifference_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDifference_shifted_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDifference_shifted_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDifference_negative_near_corner' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDifference_negative_near_corner

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDifference_boundary_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDifference_boundary_neg

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_tail_estimate' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_tail_estimate

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_uniform_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_uniform_tail

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_right_negative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_right_negative

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_uniform_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_uniform_tail

/-- info: 'AmericanPutConvexity.Boundary.Comparison.normalizedDrift_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.normalizedDrift_bounded

/-- info: 'AmericanPutConvexity.Boundary.movingStrip_isCompact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.movingStrip_isCompact

/-- info: 'AmericanPutConvexity.Boundary.parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.parabolic_maximum

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_le_of_initial_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_le_of_initial_le

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_at_earlier_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_at_earlier_time

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_le_of_initial_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_le_of_initial_le

/-- info: 'AmericanPutConvexity.Boundary.terminal_hopf' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.terminal_hopf

/-- info: 'AmericanPutConvexity.Boundary.movingLineTransform_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.movingLineTransform_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.lineDifference_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.lineDifference_equation

/-- info: 'AmericanPutConvexity.Boundary.Comparison.lineDifference_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.lineDifference_fit

/-- info: 'AmericanPutConvexity.Boundary.Comparison.lineDifference_no_positive_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.lineDifference_no_positive_rectangle

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_no_positive_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_no_positive_rectangle

/-- info: 'AmericanPutConvexity.Boundary.eventually_lt_tangent_of_second_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.eventually_lt_tangent_of_second_deriv_neg

/-- info: 'AmericanPutConvexity.Boundary.curvature_nonneg_of_negative_intercepts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.curvature_nonneg_of_negative_intercepts

/-- info: 'AmericanPutConvexity.Boundary.Comparison.no_isolated_contact_of_positive_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.no_isolated_contact_of_positive_intervals

/-- info: 'AmericanPutConvexity.Boundary.Comparison.curvature_nonneg_of_tangent_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.curvature_nonneg_of_tangent_intervals

/-- info: 'AmericanPutConvexity.Boundary.Comparison.dividend_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.dividend_curvature_of_comparison_inputs

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_curvature_of_comparison_inputs

/-- info: 'AmericanPutConvexity.Boundary.deriv2_stockBoundary_pos_of_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.deriv2_stockBoundary_pos_of_nonneg

/-- info: 'AmericanPutConvexity.Boundary.Comparison.stock_curvature_of_comparison_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.stock_curvature_of_comparison_inputs

/-- info: 'AmericanPutConvexity.Boundary.Comparison.initialDifference_exact_two_simple_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.initialDifference_exact_two_simple_roots

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_initial_simple_root' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_initial_simple_root

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_two_root_confinement' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_two_root_confinement

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_initialization_of_derivative_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_initialization_of_derivative_traces

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_level_initialization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_level_initialization

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_level_initialization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_level_initialization

/-- info: 'AmericanPutConvexity.Boundary.superlevel_ordConnected_of_two_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.superlevel_ordConnected_of_two_roots

/-- info: 'AmericanPutConvexity.Boundary.positive_set_ordConnected_of_positive_levels' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.positive_set_ordConnected_of_positive_levels

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_superlevel_of_two_roots' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_superlevel_of_two_roots

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_interval_of_level_counts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_interval_of_level_counts

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_positive_interval_of_level_counts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_positive_interval_of_level_counts

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.price_hasDerivAt_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.price_hasDerivAt_boundary

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_neg

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_forcing_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_forcing_pos

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.price_supersolution_off_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.price_supersolution_off_boundary

/-- info: 'AmericanPutConvexity.Boundary.second_deriv_nonpos_at_left_stationary_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.second_deriv_nonpos_at_left_stationary_max

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.spatial_test_at_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.spatial_test_at_boundary

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_test_residual_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_test_residual_pos

/-- info: 'AmericanPutConvexity.Boundary.twoSidedStrip_isCompact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.twoSidedStrip_isCompact

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison

/-- info: 'AmericanPutConvexity.Boundary.zeroDividend_obstacle_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.zeroDividend_obstacle_comparison

/-- info: 'AmericanPutConvexity.Boundary.expiryBarrier_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.expiryBarrier_subsolution

/-- info: 'AmericanPutConvexity.Boundary.expiryBarrier_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.expiryBarrier_continuousOn

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.expiryBarrier_le_price' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.expiryBarrier_le_price

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.exists_boundary_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.exists_boundary_sqrt_bound

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_ratio_tendsto_atBot

/-- info: 'AmericanPutConvexity.Boundary.zeroDividend_boundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.zeroDividend_boundary_ratio_tendsto_atBot

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison_of_local_tests' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison_of_local_tests

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.delayedPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.delayedPrice_equation

/-- info: 'AmericanPutConvexity.Boundary.localizationBarrier_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.localizationBarrier_supersolution

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.penalizedDelay_le_price' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.penalizedDelay_le_price

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.price_mono_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.price_mono_time

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_antitoneOn

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_deriv_neg_of_curvature_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_deriv_neg_of_curvature_neg

/-- info: 'AmericanPutConvexity.Boundary.zeroDividend_price_mono_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.zeroDividend_price_mono_time

/-- info: 'AmericanPutConvexity.Boundary.zeroDividend_boundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.zeroDividend_boundary_antitoneOn

/-- info: 'AmericanPutConvexity.Boundary.smoothValley_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.smoothValley_hasDeriv

/-- info: 'AmericanPutConvexity.Boundary.parabolic_smoothValley_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.parabolic_smoothValley_nonpos

/-- info: 'AmericanPutConvexity.Boundary.parabolic_three_point_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.parabolic_three_point_bound

/-- info: 'AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.straightDifference_positive_interval

/-- info: 'AmericanPutConvexity.Boundary.Comparison.dividend_log_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.dividend_log_curvature

/-- info: 'AmericanPutConvexity.Boundary.Comparison.dividend_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.dividend_curvature_claim

/-- info: 'AmericanPutConvexity.Boundary.Comparison.zeroDividend_weak_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.zeroDividend_weak_curvature_claim

/-- info: 'AmericanPutConvexity.Boundary.Comparison.liuRange_curvature_claim' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.liuRange_curvature_claim

/-- info: 'AmericanPutConvexity.Boundary.Comparison.stock_curvature_of_strict_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.Comparison.stock_curvature_of_strict_speed

/-- info: 'AmericanPutConvexity.Boundary.positiveBump_operator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.positiveBump_operator

/-- info: 'AmericanPutConvexity.Boundary.positive_straight_tube' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.positive_straight_tube

/-- info: 'AmericanPutConvexity.Boundary.positive_later_of_positive_point' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.positive_later_of_positive_point

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_flat_tail_of_zero_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_flat_tail_of_zero_speed

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.incrementGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.incrementGauge_equation

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.incrementGauge_pos_on_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.incrementGauge_pos_on_flat_tail

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_no_flat_tail

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.boundary_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.boundary_deriv_neg

/-- info: 'AmericanPutConvexity.Boundary.dividend_stock_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.dividend_stock_curvature

/-- info: 'AmericanPutConvexity.Boundary.dividend_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.dividend_remainingTime_curvature

/-- info: 'AmericanPutConvexity.Boundary.zeroDividend_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.zeroDividend_remainingTime_curvature

/-- info: 'AmericanPutConvexity.Boundary.liuRange_remainingTime_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.liuRange_remainingTime_curvature

/-- info: 'AmericanPutConvexity.Boundary.dividend_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.dividend_boundary_conclusions

/-- info: 'AmericanPutConvexity.Stopping.putReward_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.putReward_integrable

/-- info: 'AmericanPutConvexity.Stopping.value_at_expiry' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.value_at_expiry

/-- info: 'AmericanPutConvexity.Stopping.value_mono_horizon' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.value_mono_horizon

/-- info: 'AmericanPutConvexity.Stopping.value_convexOn_spot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.value_convexOn_spot

/-- info: 'AmericanPutConvexity.Stopping.exerciseSet_eq_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exerciseSet_eq_interval

/-- info: 'AmericanPutConvexity.Stopping.brownian_filtered' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_filtered

/-- info: 'AmericanPutConvexity.Stopping.brownianAmericanPut_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAmericanPut_bounds

/-- info: 'AmericanPutConvexity.Stopping.brownianExerciseBoundary_contact_set' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianExerciseBoundary_contact_set

/-- info: 'AmericanPutConvexity.Stopping.brownianExerciseBoundary_antitone' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianExerciseBoundary_antitone

/-- info: 'AmericanPutConvexity.Stopping.threshold_eq_of_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.threshold_eq_of_price_identification

/-- info: 'AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_price_identification

/-- info: 'AmericanPutConvexity.Stopping.expected_stoppedValue_le_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_stoppedValue_le_initial

/-- info: 'AmericanPutConvexity.Stopping.expected_stoppedValue_eq_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_stoppedValue_eq_initial

/-- info: 'AmericanPutConvexity.Stopping.value_eq_of_contact_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.value_eq_of_contact_martingale

/-- info: 'AmericanPutConvexity.Stopping.classical_price_eq_value_of_verification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.classical_price_eq_value_of_verification

/-- info: 'AmericanPutConvexity.Stopping.firstContactRule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.firstContactRule

/-- info: 'AmericanPutConvexity.Stopping.classicalContactRule_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.classicalContactRule_contact

/-- info: 'AmericanPutConvexity.Stopping.classicalContactRule_continuation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.classicalContactRule_continuation

/-- info: 'AmericanPutConvexity.Stopping.brownian_price_identification_of_martingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_price_identification_of_martingales

/-- info: 'AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_martingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_martingales

/-- info: 'AmericanPutConvexity.Stopping.brownianPriceKernel_heat_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianPriceKernel_heat_equation

/-- info: 'AmericanPutConvexity.Stopping.brownianPriceKernel_localization_zero_drift' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianPriceKernel_localization_zero_drift

/-- info: 'AmericanPutConvexity.Stopping.plane_ito_localMartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.plane_ito_localMartingale

/-- info: 'AmericanPutConvexity.Stopping.local_price_ito' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.local_price_ito

/-- info: 'AmericanPutConvexity.Stopping.locally_bounded_localMartingale_is_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.locally_bounded_localMartingale_is_martingale

/-- info: 'AmericanPutConvexity.Stopping.martingale_smaller_filtration' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.martingale_smaller_filtration

/-- info: 'AmericanPutConvexity.Stopping.brownian_stoppedCandidate_martingale_of_local' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_stoppedCandidate_martingale_of_local

/-- info: 'AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_localMartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_localMartingales

/-- info: 'AmericanPutConvexity.Stopping.interiorRule_at_positive_exit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.interiorRule_at_positive_exit

/-- info: 'AmericanPutConvexity.Stopping.interiorRule_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.interiorRule_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.martingale_of_bounded_limits' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.martingale_of_bounded_limits

/-- info: 'AmericanPutConvexity.Stopping.brownianInteriorRule_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianInteriorRule_tendsto

/-- info: 'AmericanPutConvexity.Stopping.brownian_contact_martingale_of_interior_localMartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_contact_martingale_of_interior_localMartingales

/-- info: 'AmericanPutConvexity.Stopping.exists_compact_set_localization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_compact_set_localization

/-- info: 'AmericanPutConvexity.Stopping.brownianPriceKernel_compact_localization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianPriceKernel_compact_localization

/-- info: 'AmericanPutConvexity.Stopping.brownianInteriorRule_smooth_extension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianInteriorRule_smooth_extension

/-- info: 'AmericanPutConvexity.Stopping.ae_eq_through_positive_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.ae_eq_through_positive_time

/-- info: 'AmericanPutConvexity.Stopping.brownianInteriorRule_ito_representation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianInteriorRule_ito_representation

/-- info: 'AmericanPutConvexity.Stopping.localMartingale_stopped_indicator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.localMartingale_stopped_indicator

/-- info: 'AmericanPutConvexity.Stopping.brownianInteriorRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianInteriorRule_martingale

/-- info: 'AmericanPutConvexity.Stopping.brownianClassicalContactRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianClassicalContactRule_martingale

/-- info: 'AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_supermartingales' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_boundary_curvature_of_supermartingales

/-- info: 'AmericanPutConvexity.Stopping.brownianClassicalContactRule_expectedReward' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianClassicalContactRule_expectedReward

/-- info: 'AmericanPutConvexity.Stopping.classicalPrice_le_brownianAmericanPut' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.classicalPrice_le_brownianAmericanPut

/-- info: 'AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison_unbounded_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.DividendPutSolution.obstacle_comparison_unbounded_window

/-- info: 'AmericanPutConvexity.Stopping.compact_heatFlow_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_heatFlow_contDiff

/-- info: 'AmericanPutConvexity.Stopping.compact_heatFlow_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_heatFlow_equation

/-- info: 'AmericanPutConvexity.Stopping.brownianHeatFlow_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianHeatFlow_continuous

/-- info: 'AmericanPutConvexity.Stopping.brownianHeatFlow_eq_kernel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianHeatFlow_eq_kernel

/-- info: 'AmericanPutConvexity.Stopping.linearPriceEvolution_le_classical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearPriceEvolution_le_classical

/-- info: 'AmericanPutConvexity.Stopping.exists_smooth_compact_minorant_sequence' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_smooth_compact_minorant_sequence

/-- info: 'AmericanPutConvexity.Stopping.classicalPrice_gaussian_comparison' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.classicalPrice_gaussian_comparison

/-- info: 'AmericanPutConvexity.Stopping.condExp_independent_kernel' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.condExp_independent_kernel

/-- info: 'AmericanPutConvexity.Stopping.brownian_condExp_transition' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_condExp_transition

/-- info: 'AmericanPutConvexity.Stopping.brownianClassicalCandidate_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianClassicalCandidate_supermartingale

/-- info: 'AmericanPutConvexity.Stopping.brownian_price_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_price_identification

/-- info: 'AmericanPutConvexity.Stopping.brownian_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_boundary_conclusions

/-- info: 'AmericanPutConvexity.Stopping.brownian_zeroDividend_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_zeroDividend_boundary_conclusions

/-- info: 'AmericanPutConvexity.Stopping.brownian_liuRange_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_liuRange_boundary_conclusions

/-- info: 'AmericanPutConvexity.Stopping.bounded_continuous_supermartingale_rightCont' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.bounded_continuous_supermartingale_rightCont

/-- info: 'AmericanPutConvexity.Stopping.brownianRightAugAmericanPut_eq_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianRightAugAmericanPut_eq_raw

/-- info: 'AmericanPutConvexity.Stopping.bounded_supermartingale_completion' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.bounded_supermartingale_completion

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualFiltration_isComplete' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualFiltration_isComplete

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualAmericanPut_eq_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualAmericanPut_eq_raw

/-- info: 'AmericanPutConvexity.Stopping.brownianUsual_boundary_conclusions' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsual_boundary_conclusions

/-- info: 'AmericanPutConvexity.Stopping.americanPutValue_continuous_horizon' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.americanPutValue_continuous_horizon

/-- info: 'AmericanPutConvexity.Stopping.americanPutValue_joint_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.americanPutValue_joint_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_continuous

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_initial

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_bounds

/-- info: 'AmericanPutConvexity.Stopping.americanPutValue_spot_decay' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.americanPutValue_spot_decay

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_decay' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_decay

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_decay_uniform' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_decay_uniform

/-- info: 'AmericanPutConvexity.Stopping.brownianAmericanPut_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAmericanPut_pos

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualAmericanPut_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualAmericanPut_pos

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_lt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_lt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_strict_continuation_iff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_strict_continuation_iff

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationRegion_isOpen' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationRegion_isOpen

/-- info: 'AmericanPutConvexity.Stopping.threshold_upperSemicontinuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.threshold_upperSemicontinuous

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_continuousWithinAt_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_continuousWithinAt_left

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactRule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactRule

/-- info: 'AmericanPutConvexity.Stopping.canonicalContactRule_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContactRule_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalContactRule_continuation_before' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContactRule_continuation_before

/-- info: 'AmericanPutConvexity.Stopping.canonicalContactRule_exercise_before_expiry' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContactRule_exercise_before_expiry

/-- info: 'AmericanPutConvexity.Stopping.rounded_time_stopping' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.rounded_time_stopping

/-- info: 'AmericanPutConvexity.Stopping.expectedReward_roundUp_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expectedReward_roundUp_tendsto

/-- info: 'AmericanPutConvexity.Stopping.gridValue_tendsto_americanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.gridValue_tendsto_americanValue

/-- info: 'AmericanPutConvexity.Stopping.americanValue_eq_sup_gridValues' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.americanValue_eq_sup_gridValues

/-- info: 'AmericanPutConvexity.Stopping.canonicalGridPrice_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalGridPrice_tendsto

/-- info: 'AmericanPutConvexity.Stopping.finiteBellman_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.finiteBellman_supermartingale

/-- info: 'AmericanPutConvexity.Stopping.finiteBellman_le_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.finiteBellman_le_supermartingale

/-- info: 'AmericanPutConvexity.Stopping.discrete_stopped_martingale_of_before' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.discrete_stopped_martingale_of_before

/-- info: 'AmericanPutConvexity.Stopping.finiteBellmanContact_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.finiteBellmanContact_martingale

/-- info: 'AmericanPutConvexity.Stopping.finiteBellmanContact_optimal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.finiteBellmanContact_optimal

/-- info: 'AmericanPutConvexity.Stopping.discreteStoppingValue_eq_bellman' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.discreteStoppingValue_eq_bellman

/-- info: 'AmericanPutConvexity.Stopping.finiteBellmanRule_attains_value' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.finiteBellmanRule_attains_value

/-- info: 'AmericanPutConvexity.Stopping.gridValue_eq_discreteValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.gridValue_eq_discreteValue

/-- info: 'AmericanPutConvexity.Stopping.gridValue_eq_bellman' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.gridValue_eq_bellman

/-- info: 'AmericanPutConvexity.Stopping.optimalGridRule_attains_value' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.optimalGridRule_attains_value

/-- info: 'AmericanPutConvexity.Stopping.optimalGridRule_payoffs_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.optimalGridRule_payoffs_tendsto

/-- info: 'AmericanPutConvexity.Stopping.canonicalOptimalGridRule_payoffs_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalOptimalGridRule_payoffs_tendsto

/-- info: 'AmericanPutConvexity.Stopping.bellmanAux_eq_brownianGridMarkovAux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.bellmanAux_eq_brownianGridMarkovAux

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_eq_gridValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_eq_gridValue

/-- info: 'AmericanPutConvexity.Stopping.brownianTerminalValue_usual_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianTerminalValue_usual_martingale

/-- info: 'AmericanPutConvexity.Stopping.brownianLogState_usual_condExp_transition' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianLogState_usual_condExp_transition

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_eq_usualGridValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_eq_usualGridValue

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualAmericanPut_eq_raw_of_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualAmericanPut_eq_raw_of_pos

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_tendsto_canonical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_tendsto_canonical

/-- info: 'AmericanPutConvexity.Stopping.delayedGrid_bellman_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.delayedGrid_bellman_eq

/-- info: 'AmericanPutConvexity.Stopping.delayedGridPrice_le_american' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.delayedGridPrice_le_american

/-- info: 'AmericanPutConvexity.Stopping.brownianAmericanPut_wait' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAmericanPut_wait

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_wait' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_wait

/-- info: 'AmericanPutConvexity.Stopping.canonicalDiscountedPrice_gap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalDiscountedPrice_gap

/-- info: 'AmericanPutConvexity.Stopping.canonicalDiscountedPrice_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalDiscountedPrice_supermartingale

/-- info: 'AmericanPutConvexity.Stopping.canonicalDiscountedPrice_usual_supermartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalDiscountedPrice_usual_supermartingale

/-- info: 'AmericanPutConvexity.Stopping.expected_stoppedValue_le_of_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_stoppedValue_le_of_le

/-- info: 'AmericanPutConvexity.Stopping.min_time_tendsto_firstContact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.min_time_tendsto_firstContact

/-- info: 'AmericanPutConvexity.Stopping.exists_subseq_gap_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_subseq_gap_tendsto_zero

/-- info: 'AmericanPutConvexity.Stopping.expected_firstContact_eq_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_firstContact_eq_initial

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactRule_optimal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactRule_optimal

/-- info: 'AmericanPutConvexity.Stopping.expected_value_eq_before_optimal_rule' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_value_eq_before_optimal_rule

/-- info: 'AmericanPutConvexity.Stopping.stopped_martingale_of_expected_value_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.stopped_martingale_of_expected_value_eq

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactRule_value_preserving' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactRule_value_preserving

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactRule_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactRule_martingale

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contact_meanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contact_meanValue

/-- info: 'AmericanPutConvexity.Stopping.exists_continuationRectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_continuationRectangle

/-- info: 'AmericanPutConvexity.Stopping.actualRectangleExit_boundary_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualRectangleExit_boundary_ae

/-- info: 'AmericanPutConvexity.Stopping.actualRectangleExit_le_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualRectangleExit_le_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_rectangle_meanValue' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_rectangle_meanValue

/-- info: 'AmericanPutConvexity.Stopping.planeResidual_localMartingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.planeResidual_localMartingale

/-- info: 'AmericanPutConvexity.Stopping.planeResidual_stopped_martingale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.planeResidual_stopped_martingale

/-- info: 'AmericanPutConvexity.Stopping.plane_dynkin_compact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.plane_dynkin_compact

/-- info: 'AmericanPutConvexity.Stopping.rawRectangleExit_path_mem_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.rawRectangleExit_path_mem_ae

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_rectangle_meanValue_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_rectangle_meanValue_raw

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_rectangle_upper_test_of_patch' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_rectangle_upper_test_of_patch

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_rectangle_lower_test_of_patch' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_rectangle_lower_test_of_patch

/-- info: 'AmericanPutConvexity.Stopping.expected_rectangle_drift_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_rectangle_drift_pos

/-- info: 'AmericanPutConvexity.Stopping.expected_rectangle_drift_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expected_rectangle_drift_neg

/-- info: 'AmericanPutConvexity.Stopping.exists_continuationRectangle_in_nhds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_continuationRectangle_in_nhds

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_upper_generator_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_upper_generator_test

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_lower_generator_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_lower_generator_test

/-- info: 'AmericanPutConvexity.Stopping.pricingTestKernel_generator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.pricingTestKernel_generator

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_upper_pricing_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_upper_pricing_test

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_lower_pricing_test' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_lower_pricing_test

/-- info: 'AmericanPutConvexity.Stopping.pricingOperator_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.pricingOperator_barrier

/-- info: 'AmericanPutConvexity.Stopping.smoothPricingSubsolution_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smoothPricingSubsolution_le

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_smooth_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_smooth_subsolution

/-- info: 'AmericanPutConvexity.Stopping.neg_canonicalPrice_smooth_subsolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.neg_canonicalPrice_smooth_subsolution

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_le_smooth_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_le_smooth_on_cylinder

/-- info: 'AmericanPutConvexity.Stopping.smooth_le_canonicalPrice_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_le_canonicalPrice_on_cylinder

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_eq_smooth_on_cylinder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_eq_smooth_on_cylinder

/-- info: 'AmericanPutConvexity.Stopping.compact_continuous_heatFlow_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_continuous_heatFlow_smooth

/-- info: 'AmericanPutConvexity.Stopping.linearPriceKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearPriceKernel_equation

/-- info: 'AmericanPutConvexity.Stopping.linearPriceEvolution_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearPriceEvolution_smoothAt

/-- info: 'AmericanPutConvexity.Stopping.linearPriceEvolution_pricingOperator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearPriceEvolution_pricingOperator

/-- info: 'AmericanPutConvexity.Stopping.exists_smooth_initial_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_smooth_initial_solution

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalPrice_initial_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalPrice_initial_solution

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_equation

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_integral

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_integrable

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_scale

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_continuous

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_boundary

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_tendsto

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_causal

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_eq_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_eq_integral

/-- info: 'AmericanPutConvexity.Stopping.flatRpow_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.flatRpow_smooth

/-- info: 'AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_eq

/-- info: 'AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_smoothAt

/-- info: 'AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatBoundaryKernel_equation

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_eq_causalBoundaryIntegral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_eq_causalBoundaryIntegral

/-- info: 'AmericanPutConvexity.Stopping.compact_heatBoundaryExtension_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_heatBoundaryExtension_smooth

/-- info: 'AmericanPutConvexity.Stopping.compact_kernelIntegral_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_kernelIntegral_hasDeriv

/-- info: 'AmericanPutConvexity.Stopping.compact_causalBoundaryIntegral_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_causalBoundaryIntegral_equation

/-- info: 'AmericanPutConvexity.Stopping.compact_heatBoundaryExtension_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_heatBoundaryExtension_equation

/-- info: 'AmericanPutConvexity.Stopping.exists_halfLine_heat_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_halfLine_heat_boundary_solution

/-- info: 'AmericanPutConvexity.Stopping.boundaryArrivalMass_lt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.boundaryArrivalMass_lt_one

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryExtension_finite_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryExtension_finite_bound

/-- info: 'AmericanPutConvexity.Stopping.crossBoundaryCausal_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.crossBoundaryCausal_lipschitz

/-- info: 'AmericanPutConvexity.Stopping.coupledBoundaryStep_contracting' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.coupledBoundaryStep_contracting

/-- info: 'AmericanPutConvexity.Stopping.exists_coupled_boundary_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_coupled_boundary_inputs

/-- info: 'AmericanPutConvexity.Stopping.exists_coupled_compact_boundary_inputs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_coupled_compact_boundary_inputs

/-- info: 'AmericanPutConvexity.Stopping.exists_boundary_time_cutoff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_boundary_time_cutoff

/-- info: 'AmericanPutConvexity.Stopping.intervalHeatCorrection_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.intervalHeatCorrection_equation

/-- info: 'AmericanPutConvexity.Stopping.exists_interval_heat_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_interval_heat_boundary_solution

/-- info: 'AmericanPutConvexity.Stopping.exists_interval_heat_boundary_solution_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_interval_heat_boundary_solution_continuous

/-- info: 'AmericanPutConvexity.Stopping.priceFromHeat_pricingOperator' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.priceFromHeat_pricingOperator

/-- info: 'AmericanPutConvexity.Stopping.exists_interval_pricing_boundary_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_interval_pricing_boundary_solution

/-- info: 'AmericanPutConvexity.Stopping.exists_pricing_dirichlet_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_pricing_dirichlet_solution

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_locally_eq_smooth_solution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_locally_eq_smooth_solution

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contDiffOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contDiffOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_continuation_pde' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_continuation_pde

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_le_of_upper_supports' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_le_of_upper_supports

/-- info: 'AmericanPutConvexity.Stopping.stationaryPutCap_upper_support' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.stationaryPutCap_upper_support

/-- info: 'AmericanPutConvexity.Stopping.exists_stationaryPutCap_parameters' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_stationaryPutCap_parameters

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_le_stationaryPutCap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_le_stationaryPutCap

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_uniform_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_uniform_pos

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalStockBoundary_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalStockBoundary_pos

/-- info: 'AmericanPutConvexity.Stopping.exp_canonicalLogBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exp_canonicalLogBoundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_value_matching' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_value_matching

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationRegion_eq_logBoundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationRegion_eq_logBoundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_monotone_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_monotone_time

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_forcing

/-- info: 'AmericanPutConvexity.Stopping.no_small_forced_profile' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.no_small_forced_profile

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_no_instantaneous_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_no_instantaneous_interval

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_exists_later_gt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_exists_later_gt

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_antitoneOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_antitoneOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_continuousOn

/-- info: 'ProbabilityTheory.IsBrownianReal.indep_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms ProbabilityTheory.IsBrownianReal.indep_zero

/-- info: 'AmericanPutConvexity.Stopping.brownianProbe_hasLaw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianProbe_hasLaw

/-- info: 'AmericanPutConvexity.Stopping.brownianNegativeGerm_measurable_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianNegativeGerm_measurable_germ

/-- info: 'AmericanPutConvexity.Stopping.brownianNegativeGerm_prob_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianNegativeGerm_prob_one

/-- info: 'AmericanPutConvexity.Stopping.brownian_downward_excursions_ae' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownian_downward_excursions_ae

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactTime_le_of_downcrossing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactTime_le_of_downcrossing

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualActualContactTime_tendsto_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualActualContactTime_tendsto_boundary

/-- info: 'AmericanPutConvexity.Stopping.putPayoff_norm_sub_le' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.putPayoff_norm_sub_le

/-- info: 'AmericanPutConvexity.Stopping.discountedPutSlope_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.discountedPutSlope_bound

/-- info: 'AmericanPutConvexity.Stopping.discountedPutSlope_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.discountedPutSlope_tendsto

/-- info: 'AmericanPutConvexity.Stopping.actualContactSlope_integral_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualContactSlope_integral_tendsto

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_slope_le_contactSlope' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_slope_le_contactSlope

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_slope_tendsto_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_slope_tendsto_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_smooth_fit

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_smooth_fit

/-- info: 'AmericanPutConvexity.Stopping.convex_deriv_tendsto_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.convex_deriv_tendsto_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockPrice_smooth_fit' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockPrice_smooth_fit

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockPrice_gradient_trace

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_gradient_trace

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_gradient_trace

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_gradient_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_gradient_trace

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_dividendPutSolution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_dividendPutSolution_of_boundary_smooth

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_solution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_solution_of_boundary_smooth

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_solution_of_boundary_smooth' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_solution_of_boundary_smooth

/-- info: 'AmericanPutConvexity.Stopping.continuousAt_deriv_convex_slices' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.continuousAt_deriv_convex_slices

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_hasDerivAt_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_hasDerivAt_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_differentiableAt_spatial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_differentiableAt_spatial

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockPrice_gradient_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_gradient_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_gradient_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_gradient_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalBoundary_forcing_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalBoundary_forcing_pos

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_lower_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_lower_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.quadratic_separation_of_deriv2_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.quadratic_separation_of_deriv2_lower

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_separation_of_deriv2_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_separation_of_deriv2_lower

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_separation_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_separation_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_increment_bounds

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_bounds

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_increment_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_increment_bounds

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_spatial_deriv_gt_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_spatial_deriv_gt_exercise

/-- info: 'AmericanPutConvexity.Stopping.canonicalTimeIncrement_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTimeIncrement_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalTimeIncrement_no_positive_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTimeIncrement_no_positive_max

/-- info: 'AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_of_initial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_of_initial_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_expiry_gap_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_expiry_gap_le_atStrike

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_temporal_modulus

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_atStrike_tendsto_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_atStrike_tendsto_zero

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_modulus

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_modulus' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_modulus

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_increment_le_atStrike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_increment_le_atStrike

/-- info: 'AmericanPutConvexity.Stopping.expiryUpperCap_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expiryUpperCap_supersolution

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_le_expiryUpperCap' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_le_expiryUpperCap

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_atStrike_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_atStrike_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.quarter_bound_of_square_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.quarter_bound_of_square_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_squared_increment_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_squared_increment_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_local_quarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_local_quarter_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv_bounds

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_positive_max_continuation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_positive_max_continuation

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_equation

/-- info: 'AmericanPutConvexity.Stopping.dilationBarrier_supersolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.dilationBarrier_supersolution

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_source_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_source_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_no_positive_corrected_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_no_positive_corrected_max

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_le_on_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_le_on_rectangle

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumDilation_le_barrier

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPremiumDilation_le_barrier

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPremiumDilation_le_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPremiumDilation_le_barrier

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_dilation_differential_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_dilation_differential_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_le_dilationBound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_le_dilationBound

/-- info: 'AmericanPutConvexity.Stopping.increment_le_of_deriv_bound_on_positive' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.increment_le_of_deriv_bound_on_positive

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_lipschitz_on_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_temporal_lipschitz_on_interval

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_squared_increment_linear_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_squared_increment_linear_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_local_half_bound

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_local_half_bound

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_local_half_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_local_half_bound

/-- info: 'AmericanPutConvexity.Boundary.exists_first_nonnegative_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.exists_first_nonnegative_contact

/-- info: 'AmericanPutConvexity.Boundary.boundaryRatio_monotone_of_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.boundaryRatio_monotone_of_line_intervals

/-- info: 'AmericanPutConvexity.Boundary.convexOn_of_ratio_monotone_and_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.convexOn_of_ratio_monotone_and_line_intervals

/-- info: 'AmericanPutConvexity.Boundary.convexOn_of_negative_line_intervals' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.convexOn_of_negative_line_intervals

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_continuousBoundaryPutSolution' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_continuousBoundaryPutSolution

/-- info: 'AmericanPutConvexity.Stopping.canonicalStraightDifference_superlevel_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStraightDifference_superlevel_interval

/-- info: 'AmericanPutConvexity.Stopping.canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStraightDifference_positive_interval

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_no_return_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_no_return_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalStraightDifference_positive_interval

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalStraightDifference_positive_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalStraightDifference_positive_interval

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_below_line_time_interval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_below_line_time_interval

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_spatial_test_in_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_spatial_test_in_exercise

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_no_positive_convex_lower_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_no_positive_convex_lower_max

/-- info: 'AmericanPutConvexity.Stopping.convex_subsolution_le_canonicalPrice_on_strip' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.convex_subsolution_le_canonicalPrice_on_strip

/-- info: 'AmericanPutConvexity.Stopping.expiryBarrier_le_canonicalPrice' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expiryBarrier_le_canonicalPrice

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_exists_expiryBarrier_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_exists_expiryBarrier_window

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_exists_sqrt_upper_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_exists_sqrt_upper_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_below_linear_eventually' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_below_linear_eventually

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_ratio_tendsto_atBot' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_ratio_tendsto_atBot

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalIncrementGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIncrementGauge_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalIncrementGauge_pos_above_strike' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIncrementGauge_pos_above_strike

/-- info: 'AmericanPutConvexity.Stopping.canonicalIncrementGauge_pos_on_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIncrementGauge_pos_on_flat_tail

/-- info: 'AmericanPutConvexity.Stopping.canonicalIncrementGauge_fit_of_same_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIncrementGauge_fit_of_same_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_no_flat_tail

/-- info: 'AmericanPutConvexity.Boundary.strictAntiOn_of_convex_antitone_no_flat_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.strictAntiOn_of_convex_antitone_no_flat_tail

/-- info: 'AmericanPutConvexity.Boundary.strictConvexOn_exp_of_convex_injective' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.strictConvexOn_exp_of_convex_injective

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_strictAntiOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_locallyLipschitzOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalStockBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalStockBoundary_locallyLipschitzOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_strictAntiOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Stopping.BoundedRule.roundUp_time_tendsto_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.BoundedRule.roundUp_time_tendsto_of_mesh

/-- info: 'AmericanPutConvexity.Stopping.expectedReward_roundUp_tendsto_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.expectedReward_roundUp_tendsto_of_mesh

/-- info: 'AmericanPutConvexity.Stopping.gridValue_tendsto_americanValue_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.gridValue_tendsto_americanValue_of_mesh

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_tendsto_usual_of_mesh' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_tendsto_usual_of_mesh

/-- info: 'AmericanPutConvexity.Stopping.brownianGridMarkovAux_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridMarkovAux_scale

/-- info: 'AmericanPutConvexity.Stopping.discountedLogPayoff_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.discountedLogPayoff_scale

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_scale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_scale

/-- info: 'AmericanPutConvexity.Stopping.brownianGridPrice_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianGridPrice_normalization

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualAmericanPut_normalization_log' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualAmericanPut_normalization_log

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualAmericanPut_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualAmericanPut_normalization

/-- info: 'AmericanPutConvexity.Stopping.brownianAmericanPut_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAmericanPut_normalization

/-- info: 'AmericanPutConvexity.Stopping.normalized_rates_admissible' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.normalized_rates_admissible

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualExerciseBoundary_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualExerciseBoundary_normalization

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualExerciseBoundary_eq_scaled_canonical' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualExerciseBoundary_eq_scaled_canonical

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualLogBoundary_normalization' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualLogBoundary_normalization

/-- info: 'AmericanPutConvexity.Stopping.convexOn_positive_time_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.convexOn_positive_time_rescale

/-- info: 'AmericanPutConvexity.Stopping.strictConvexOn_positive_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.strictConvexOn_positive_rescale

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualStockBoundary_strictAntiOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualStockBoundary_strictAntiOn

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualStockBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualStockBoundary_locallyLipschitzOn

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualLogBoundary_locallyLipschitzOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualLogBoundary_locallyLipschitzOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_brownianUsualLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Stopping.liuRange_brownianUsualLogBoundary_convexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_brownianUsualLogBoundary_convexOn

/-- info: 'AmericanPutConvexity.Stopping.liuRange_brownianUsualStockBoundary_strictConvexOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_brownianUsualStockBoundary_strictConvexOn

/-- info: 'AmericanPutConvexity.Boundary.hasFDerivAt_zero_of_flat_lipschitz_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.hasFDerivAt_zero_of_flat_lipschitz_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_local_pointwise_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_local_pointwise_lipschitz

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_hasFDerivAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_hasDerivAt_time_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_hasDerivAt_time_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_hasDerivAt_time_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_hasDerivAt_time_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_joint_differentiableAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_joint_differentiableAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_differentiableAt_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_differentiableAt_time

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_hasFDerivAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_hasFDerivAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_monotone' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_monotone

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_differentiableAt_iff_oneSided_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_differentiableAt_iff_oneSided_eq

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_neg_of_differentiableAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_neg_of_differentiableAt

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_oneSided_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_oneSided_speed

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_oneSided_speed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_oneSided_speed

/-- info: 'AmericanPutConvexity.Stopping.quadratic_upper_of_deriv2_upper' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.quadratic_upper_of_deriv2_upper

/-- info: 'AmericanPutConvexity.Stopping.actualSpatialSecondBound_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualSpatialSecondBound_pos

/-- info: 'AmericanPutConvexity.Stopping.actualSpatialSecondBound_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualSpatialSecondBound_continuous

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_le_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_le_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_upper_near' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_upper_near

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_upper_of_deriv2_upper' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_upper_of_deriv2_upper

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_upper_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_upper_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_local_pairwise_lipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_local_pairwise_lipschitz

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contact_difference_quotient_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contact_difference_quotient_bound

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_contact_increment_quadratic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_contact_increment_quadratic

/-- info: 'AmericanPutConvexity.Boundary.discounted_parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.discounted_parabolic_maximum

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_contDiff

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_hasDerivAt

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_deriv2' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_deriv2

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_nonneg

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_pos

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_mono_distance' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_mono_distance

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_le_linear' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_le_linear

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_operator_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_operator_nonpos

/-- info: 'AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_affine_operator_nonpos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.stationaryBoundaryBarrier_affine_operator_nonpos

/-- info: 'AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_stationary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_stationary

/-- info: 'AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_exponential' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTimeIncrement_le_exponential

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_rectangle' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_temporal_lipschitz_on_rectangle

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_linear_near_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_linear_near_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_exercise' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_exercise

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_time_deriv_continuousAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_time_deriv_continuousAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_deriv2_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_eq_partial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_eq_partial

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_time_deriv_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.fderiv_plane_eq_partials' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.fderiv_plane_eq_partials

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_fderiv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_fderiv_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contDiffAt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalPrice_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalPrice_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalPrice_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_eq_deriv2' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_eq_deriv2

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumCurvatureExtension_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_right_slope_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalIntrinsicPremium_gradient_right_slope_tendsto

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalIntrinsicPremium_gradient_hasDerivWithinAt_contact

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_comm' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_comm

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_comm_third' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_comm_third

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_pricing_combination' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_pricing_combination

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_spatial_second' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_spatial_second

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_pricing_equation_derivative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_pricing_equation_derivative

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_nonneg

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_exercise_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_exercise_zero

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_partial_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_partial_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalPrice_mixed_derivs_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPrice_mixed_derivs_eq

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaGauge_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaGauge_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaGauge_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaGauge_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaGauge_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaGauge_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaGauge_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaGauge_nonneg

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_positive_earlier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_positive_earlier

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_pos

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_pos

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalTheta_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalTheta_pos

/-- info: 'AmericanPutConvexity.Boundary.terminal_linear_lower_of_barrier' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.terminal_linear_lower_of_barrier

/-- info: 'AmericanPutConvexity.Boundary.terminal_linear_lower' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.terminal_linear_lower

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_linear_lower_at_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_linear_lower_at_boundary

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_contact_slope_bounds

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_not_differentiableAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_not_differentiableAt_contact

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_contact_slope_bounds

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalTheta_contact_slope_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalTheta_contact_slope_bounds

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_deriv_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_deriv_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_sub_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_lipschitz_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_lipschitz_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.integrableOn_inverse_sqrt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integrableOn_inverse_sqrt

/-- info: 'AmericanPutConvexity.Stopping.movingHeatRemainder_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatRemainder_integrable

/-- info: 'AmericanPutConvexity.Stopping.movingHeatRemainder_integral_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatRemainder_integral_continuous

/-- info: 'AmericanPutConvexity.Stopping.movingHeatBoundaryKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatBoundaryKernel_jump

/-- info: 'AmericanPutConvexity.Stopping.movingHeatKernel_deriv_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatKernel_deriv_jump

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_heat_displacement' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_heat_displacement

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_heatKernel_jump' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_heatKernel_jump

/-- info: 'AmericanPutConvexity.Stopping.heatKernel_inverse_sqrt_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatKernel_inverse_sqrt_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_away_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_away_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatBoundaryKernel_away_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatBoundaryKernel_away_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_integrable

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_continuous

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_deriv_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_deriv_tendsto

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayerFlux_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayerFlux_continuous

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_heatLayer_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_heatLayer_flux

/-- info: 'AmericanPutConvexity.Stopping.integral_inverse_sqrt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integral_inverse_sqrt

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryNormBound_mono' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryNormBound_mono

/-- info: 'AmericanPutConvexity.Stopping.exists_small_heatHistory_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_small_heatHistory_window

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_integrable

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_continuous

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_bound

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryBCF_dist' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryBCF_dist

/-- info: 'AmericanPutConvexity.Stopping.heatDensityStep_contracting' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatDensityStep_contracting

/-- info: 'AmericanPutConvexity.Stopping.exists_unique_causal_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_unique_causal_heat_density

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_eq_causal_past' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_eq_causal_past

/-- info: 'AmericanPutConvexity.Stopping.exists_local_causal_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_local_causal_heat_density

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_local_lipschitz_extension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_local_lipschitz_extension

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalLogBoundary_heat_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalLogBoundary_heat_density

/-- info: 'AmericanPutConvexity.Boundary.right_deriv_nonpos_at_max' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.right_deriv_nonpos_at_max

/-- info: 'AmericanPutConvexity.Boundary.strict_neumann_parabolic_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.strict_neumann_parabolic_maximum

/-- info: 'AmericanPutConvexity.Boundary.bounded_neumann_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.bounded_neumann_heat_maximum

/-- info: 'AmericanPutConvexity.Boundary.bounded_neumann_heat_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.bounded_neumann_heat_zero

/-- info: 'AmericanPutConvexity.Boundary.bounded_neumann_heat_zero_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.bounded_neumann_heat_zero_left

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_reflect' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_reflect

/-- info: 'AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact_left' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatLayer_hasDerivWithinAt_contact_left

/-- info: 'AmericanPutConvexity.Stopping.heatDensity_flux_matching' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatDensity_flux_matching

/-- info: 'AmericanPutConvexity.Stopping.heatFromPrice_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatFromPrice_equation

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatTheta_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatTheta_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatTheta_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatTheta_equation

/-- info: 'AmericanPutConvexity.Stopping.heatLocalizationSource_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatLocalizationSource_equation

/-- info: 'AmericanPutConvexity.Stopping.actualHeatLocalizationSource_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatLocalizationSource_continuous

/-- info: 'AmericanPutConvexity.Stopping.actualHeatLocalizationSource_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatLocalizationSource_bounded

/-- info: 'AmericanPutConvexity.Stopping.actualHeatLocalizationSource_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatLocalizationSource_equation

/-- info: 'AmericanPutConvexity.Stopping.actualHeatLocalizationSource_exercise_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatLocalizationSource_exercise_zero

/-- info: 'AmericanPutConvexity.Stopping.actualHeatTheta_localization_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatTheta_localization_continuous

/-- info: 'AmericanPutConvexity.Stopping.actualHeatTheta_localization_bounded' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatTheta_localization_bounded

/-- info: 'AmericanPutConvexity.Stopping.exists_graph_heat_cutoff_after' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_graph_heat_cutoff_after

/-- info: 'AmericanPutConvexity.Stopping.exists_actualHeatTheta_source_after' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_actualHeatTheta_source_after

/-- info: 'AmericanPutConvexity.Stopping.exists_actualHeatTheta_source' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_actualHeatTheta_source

/-- info: 'AmericanPutConvexity.Stopping.heatSourceMoment_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceMoment_continuous

/-- info: 'AmericanPutConvexity.Stopping.heatKernel_integral_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatKernel_integral_rescale

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_integral_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_integral_rescale

/-- info: 'AmericanPutConvexity.Stopping.heatSourceSpatial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceSpatial_bound

/-- info: 'AmericanPutConvexity.Stopping.compact_heat_convolution_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_heat_convolution_hasDeriv

/-- info: 'AmericanPutConvexity.Stopping.heatSourceAverage_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceAverage_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_continuous

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_continuous

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_bound

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_bound

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_causal

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotentialSpatial_causal

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_eq_causal_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_eq_causal_integral

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_apply' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_apply

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_actualHeatSource_density

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_actualHeatSource_density

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_actualHeatSource_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_actualHeatSource_density

/-- info: 'AmericanPutConvexity.Stopping.causalHeatKernel_smoothAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatKernel_smoothAt

/-- info: 'AmericanPutConvexity.Stopping.causalHeatKernel_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatKernel_equation

/-- info: 'AmericanPutConvexity.Stopping.causalHeatKernelPlane_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatKernelPlane_equation

/-- info: 'AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_space

/-- info: 'AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_hasDeriv_time

/-- info: 'AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_contDiffOn_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_movingPlaneIntegral_contDiffOn_space

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_equation

/-- info: 'AmericanPutConvexity.Stopping.exists_compact_causal_density' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_compact_causal_density

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_equation_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_equation_of_causal

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_contDiffAt_space_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_contDiffAt_space_of_causal

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_differentiableAt_time_of_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_differentiableAt_time_of_causal

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_eq_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_eq_elapsed

/-- info: 'AmericanPutConvexity.Stopping.elapsedMovingHeatLayer_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.elapsedMovingHeatLayer_continuous

/-- info: 'AmericanPutConvexity.Stopping.elapsedMovingHeatLayer_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.elapsedMovingHeatLayer_bound

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_continuousOn_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_continuousOn_window

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_bound_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_bound_window

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_zero_initial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_zero_initial

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_normal_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_normal_traces

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_contDiff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_contDiff

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_hasCompactSupport' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_hasCompactSupport

/-- info: 'AmericanPutConvexity.Stopping.heatSourceMoment_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceMoment_hasDeriv_space

/-- info: 'AmericanPutConvexity.Stopping.heatSourceMoment_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceMoment_hasDeriv_time

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_space

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_hasDeriv_time

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_deriv2_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_deriv2_space

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourceSpatial_eq_average_partial' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourceSpatial_eq_average_partial

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_contDiff_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_contDiff_space

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_pair' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_pair

/-- info: 'AmericanPutConvexity.Stopping.heatSource_scaled_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSource_scaled_hasDeriv

/-- info: 'AmericanPutConvexity.Stopping.heatKernel_integral_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatKernel_integral_one

/-- info: 'AmericanPutConvexity.Stopping.heatSourceAverage_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceAverage_zero

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed_raw' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed_raw

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourceAverage_hasDeriv_elapsed

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_equation_with_endpoint' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_equation_with_endpoint

/-- info: 'AmericanPutConvexity.Stopping.smooth_heatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.smooth_heatSourcePotential_equation

/-- info: 'AmericanPutConvexity.Stopping.heatLocalizationSource_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatLocalizationSource_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.exists_compact_smooth_source_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_compact_smooth_source_germ

/-- info: 'AmericanPutConvexity.Stopping.compact_smooth_source_remainder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.compact_smooth_source_remainder

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeat_off_contact_isOpen' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeat_off_contact_isOpen

/-- info: 'AmericanPutConvexity.Stopping.actualHeatLocalizationSource_contDiffAt_off_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatLocalizationSource_contDiffAt_off_contact

/-- info: 'AmericanPutConvexity.Stopping.exists_actualHeatSource_smooth_germ' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_actualHeatSource_smooth_germ

/-- info: 'AmericanPutConvexity.Stopping.supported_kernelProduct_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.supported_kernelProduct_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.supported_planeIntegral_hasDeriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.supported_planeIntegral_hasDeriv

/-- info: 'AmericanPutConvexity.Stopping.sourceKernel_offOrigin' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourceKernel_offOrigin

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneKernel_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneKernel_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_integrable

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_hasDeriv_space

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_hasDeriv_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_hasDeriv_time

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_contDiffOn_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_contDiffOn_space

/-- info: 'AmericanPutConvexity.Stopping.causalHeatSourceIntegral_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatSourceIntegral_equation

/-- info: 'AmericanPutConvexity.Stopping.heatKernel_sub_comm' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatKernel_sub_comm

/-- info: 'AmericanPutConvexity.Stopping.causalHeatSourceIntegral_eq_potential' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalHeatSourceIntegral_eq_potential

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourcePotential_eventuallyEq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourcePotential_eventuallyEq

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourcePotential_equation

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourcePotential_contDiffAt_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourcePotential_contDiffAt_space

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourcePotential_differentiableAt_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourcePotential_differentiableAt_time

/-- info: 'AmericanPutConvexity.Stopping.heatSourceAverage_add' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourceAverage_add

/-- info: 'AmericanPutConvexity.Stopping.heatSourcePotential_add' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatSourcePotential_add

/-- info: 'AmericanPutConvexity.Stopping.source_deriv2_add_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.source_deriv2_add_at

/-- info: 'AmericanPutConvexity.Stopping.local_heatSourcePotential_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.local_heatSourcePotential_regular

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSourcePotential_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSourcePotential_regular

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_actualHeatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_actualHeatSourcePotential_equation

/-- info: 'AmericanPutConvexity.Stopping.liuRange_actualHeatSourcePotential_equation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_actualHeatSourcePotential_equation

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_bound

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_causal' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_causal

/-- info: 'AmericanPutConvexity.Stopping.heat_deriv2_sub_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heat_deriv2_sub_at

/-- info: 'AmericanPutConvexity.Stopping.heat_deriv2_const_mul_at' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heat_deriv2_const_mul_at

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_regular' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_regular

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_shifted_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_shifted_traces

/-- info: 'AmericanPutConvexity.Stopping.unshift_hasDerivWithinAt_Iic' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.unshift_hasDerivWithinAt_Iic

/-- info: 'AmericanPutConvexity.Stopping.unshift_hasDerivWithinAt_Ici' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.unshift_hasDerivWithinAt_Ici

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_normal_traces' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_normal_traces

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_zero_exterior' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_zero_exterior

/-- info: 'AmericanPutConvexity.Stopping.bounded_inhomogeneous_heat_unique' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.bounded_inhomogeneous_heat_unique

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_identification' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_identification

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentation_transfer_right_trace' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentation_transfer_right_trace

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatGraph_clamp_window_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatGraph_clamp_window_bound

/-- info: 'AmericanPutConvexity.Stopping.actualHeatTheta_localized_representation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatTheta_localized_representation

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatTheta_has_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatTheta_has_right_flux

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatTheta_continuous_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatTheta_continuous_right_flux

/-- info: 'AmericanPutConvexity.Boundary.strict_dirichlet_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.strict_dirichlet_heat_maximum

/-- info: 'AmericanPutConvexity.Boundary.bounded_dirichlet_heat_maximum' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.bounded_dirichlet_heat_maximum

/-- info: 'AmericanPutConvexity.Boundary.bounded_dirichlet_heat_zero' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.bounded_dirichlet_heat_zero

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_eq_inverse_heat' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_eq_inverse_heat

/-- info: 'AmericanPutConvexity.Stopping.inverseThetaHeatGauge_hasDeriv_space' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.inverseThetaHeatGauge_hasDeriv_space

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_hasDerivWithinAt_of_heat_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_hasDerivWithinAt_of_heat_flux

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalTheta_local_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalTheta_local_right_flux

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_hasDerivWithinAt_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_hasDerivWithinAt_right_flux

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_pos

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_contact_ratio_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_contact_ratio_tendsto

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_pos

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_pos

/-- info: 'AmericanPutConvexity.Stopping.movingHeatNormalExtension_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatNormalExtension_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.movingHeatNormalExtension_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatNormalExtension_boundary

/-- info: 'AmericanPutConvexity.Stopping.movingHeatNormalExtension_eq_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatNormalExtension_eq_integral

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayer_hasDerivAt_normalExtension' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayer_hasDerivAt_normalExtension

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayerRightGradient_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayerRightGradient_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.causalMovingHeatLayerRightGradient_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.causalMovingHeatLayerRightGradient_boundary

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationRightGradient_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationRightGradient_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationCandidate_hasDerivAt_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationCandidate_hasDerivAt_rightGradient

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentationRightGradient_boundary' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentationRightGradient_boundary

/-- info: 'AmericanPutConvexity.Stopping.heatRepresentation_transfer_interior_gradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatRepresentation_transfer_interior_gradient

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatTheta_local_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatTheta_local_rightGradient

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_hasDerivAt_of_heat_gradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_hasDerivAt_of_heat_gradient

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalTheta_local_rightGradient' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalTheta_local_rightGradient

/-- info: 'AmericanPutConvexity.Stopping.canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalTheta_gradient_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalTheta_gradient_tendsto_contact

/-- info: 'AmericanPutConvexity.Boundary.hasDerivAt_of_lipschitz_zero_graph' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Boundary.hasDerivAt_of_lipschitz_zero_graph

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumGradient_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumGradient_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumGradient_time_deriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumGradient_time_deriv

/-- info: 'AmericanPutConvexity.Stopping.plane_fderiv_eq_partials' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.plane_fderiv_eq_partials

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumGradient_fderiv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumGradient_fderiv

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumGradient_fderiv_tendsto_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumGradient_fderiv_tendsto_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationRegion_convex' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationRegion_convex

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationAfter_convex' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationAfter_convex

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationAfter_isOpen' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationAfter_isOpen

/-- info: 'AmericanPutConvexity.Stopping.canonicalContinuationAfter_closure_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalContinuationAfter_closure_time

/-- info: 'AmericanPutConvexity.Stopping.canonicalBoundary_mem_closure_continuationAfter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalBoundary_mem_closure_continuationAfter

/-- info: 'AmericanPutConvexity.Stopping.canonicalPremiumGradient_hasFDerivWithinAt_contact' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalPremiumGradient_hasFDerivWithinAt_contact

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_hasDerivAt_velocity' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_hasDerivAt_velocity

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_eq_velocity' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_eq_velocity

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_eq_stefan' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_eq_stefan

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_neg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_neg

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_oneSidedDerivs_eq

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_hasDerivAt_velocity' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_hasDerivAt_velocity

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_hasDerivAt_velocity' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_hasDerivAt_velocity

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_scaling_derivative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_scaling_derivative

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_time_deriv_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_time_deriv_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_deriv_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_deriv_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_time_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_time_sub_bound

/-- info: 'AmericanPutConvexity.Stopping.inverse_mul_sqrt_eq_rpow' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.inverse_mul_sqrt_eq_rpow

/-- info: 'AmericanPutConvexity.Stopping.integrableOn_inverse_mul_sqrt_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integrableOn_inverse_mul_sqrt_tail

/-- info: 'AmericanPutConvexity.Stopping.integral_inverse_mul_sqrt_tail' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integral_inverse_mul_sqrt_tail

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_integrable

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_nonneg

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_integral

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_near' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_near

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_far' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryTimeMajorant_far

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_time_majorant' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_time_majorant

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_overlap_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_overlap_bound

/-- info: 'AmericanPutConvexity.Stopping.exists_C1_window_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_C1_window_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatGraph_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatGraph_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_C1_window_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_C1_window_bound

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_time_bounds' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_time_bounds

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_overlap_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_overlap_bound

/-- info: 'AmericanPutConvexity.Stopping.setIntegral_Ioo_reflect' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.setIntegral_Ioo_reflect

/-- info: 'AmericanPutConvexity.Stopping.integrableOn_Ioo_reflect_iff' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integrableOn_Ioo_reflect_iff

/-- info: 'AmericanPutConvexity.Stopping.setIntegral_Ioo_split' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.setIntegral_Ioo_split

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_elapsed_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_elapsed_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_elapsed_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_elapsed_integrable

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_source_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_source_integrable

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_recent_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_recent_bound

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_eq_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_eq_elapsed

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_time_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_time_sub_bound

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_holder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_holder_bound

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatHistory_holder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatHistory_holder_bound

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatHistory_holder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatHistory_holder_bound

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_curve_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_curve_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneCurveDerivative_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneCurveDerivative_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.sourcePlaneIntegral_curve_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.sourcePlaneIntegral_curve_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourcePotentialSpatial_eq_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourcePotentialSpatial_eq_integral

/-- info: 'AmericanPutConvexity.Stopping.separated_heatSourceForcing_curve_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.separated_heatSourceForcing_curve_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.heatPartial_eventuallyEq_zero_of_constant' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatPartial_eventuallyEq_zero_of_constant

/-- info: 'AmericanPutConvexity.Stopping.heatLocalizationSource_notMem_tsupport_of_constant' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatLocalizationSource_notMem_tsupport_of_constant

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_contDiffAt_of_separated' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatSourceForcing_contDiffAt_of_separated

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSourceForcing_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSourceForcing_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSourceForcing_locallyLipschitz' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSourceForcing_locallyLipschitz

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatDensity_holder_of_C1_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatDensity_holder_of_C1_forcing

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSource_density_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSource_density_holder

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatTheta_hasDerivWithinAt_right_flux' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatTheta_hasDerivWithinAt_right_flux

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.LocalHalfHolderAt.congr' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalHalfHolderAt.congr

/-- info: 'AmericanPutConvexity.Stopping.LocalHalfHolderAt.positive_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalHalfHolderAt.positive_rescale

/-- info: 'AmericanPutConvexity.Stopping.LocalHalfHolderAt.mul_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalHalfHolderAt.mul_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_eq_gauged_heat' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_eq_gauged_heat

/-- info: 'AmericanPutConvexity.Stopping.inverseThetaHeatGauge_boundary_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.inverseThetaHeatGauge_boundary_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_holder

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_holder

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_holder

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv_holder

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv_holder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv_holder

/-- info: 'AmericanPutConvexity.Stopping.firstOrder_remainder_of_halfHolder_deriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.firstOrder_remainder_of_halfHolder_deriv

/-- info: 'AmericanPutConvexity.Stopping.LocalHalfHolderAt.exists_positive_deriv_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalHalfHolderAt.exists_positive_deriv_window

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_linear_remainder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_linear_remainder_bound

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_integrand_linear_remainder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_integrand_linear_remainder_bound

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_halfHolder_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_halfHolder_window

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatGraph_halfHolder_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatGraph_halfHolder_window

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatGraph_halfHolder_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatGraph_halfHolder_window

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_linear_kernel_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_linear_kernel_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_second_deriv_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_second_deriv_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryKernel_gradient_sub_motion_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryKernel_gradient_sub_motion_bound

/-- info: 'AmericanPutConvexity.Stopping.movingHeatHistoryKernel_hasDerivAt_motion' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.movingHeatHistoryKernel_hasDerivAt_motion

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistoryKernel_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistoryKernel_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_sub_linear' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_sub_linear

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_linear_remainder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_linear_remainder_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_linear_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_linear_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_time_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_time_sub_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_source_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_source_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_remainder_time_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_remainder_time_control

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatGraph_remainder_time_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatGraph_remainder_time_control

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatGraph_remainder_time_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatGraph_remainder_time_control

/-- info: 'AmericanPutConvexity.Stopping.integral_inverse_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integral_inverse_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.near_far_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.near_far_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.integrable_and_integral_threeQuarter_of_near_far' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integrable_and_integral_threeQuarter_of_near_far

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_overlap_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_overlap_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistory_integrand_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistory_integrand_bound

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistory_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistory_integrable

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistory_time_sub_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistory_time_sub_bound

/-- info: 'AmericanPutConvexity.Stopping.firstOrder_remainder_of_deriv_deviation' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.firstOrder_remainder_of_deriv_deviation

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_recent_linear_remainder_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_recent_linear_remainder_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_recent_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_recent_bound

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistory_source_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistory_source_integrable

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_source_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_source_integrable

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_sub_reference' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_sub_reference

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_decomposition' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_decomposition

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.halfHolder_pair_bound_on_subinterval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.halfHolder_pair_bound_on_subinterval

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_threeQuarter_of_halfHolder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_threeQuarter_of_halfHolder

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_threeQuarter_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatHistory_threeQuarter_control

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatHistory_threeQuarter_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_exists_canonicalHeatHistory_threeQuarter_control

/-- info: 'AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatHistory_threeQuarter_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_exists_canonicalHeatHistory_threeQuarter_control

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatHistory_source_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatHistory_source_integrable

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatHistory_split' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatHistory_split

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalOlderHistory_time_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalOlderHistory_time_bound

/-- info: 'AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.congr' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.congr

/-- info: 'AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.add_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.add_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.exists_short_closed_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_short_closed_window

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryThreeQuarterConstant_le_uniform' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryThreeQuarterConstant_le_uniform

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatHistory_local_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatHistory_local_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatDensity_threeQuarter_of_C1_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatDensity_threeQuarter_of_C1_forcing

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSource_density_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSource_density_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.positive_rescale' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.positive_rescale

/-- info: 'AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.mul_contDiffAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.mul_contDiffAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatGraph_deriv_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalThetaRightFlux_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.threeQuarter_pair_bound_on_subinterval' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.threeQuarter_pair_bound_on_subinterval

/-- info: 'AmericanPutConvexity.Stopping.firstOrder_remainder_of_threeQuarter_deriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.firstOrder_remainder_of_threeQuarter_deriv

/-- info: 'AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.exists_positive_deriv_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.LocalThreeQuarterHolderAt.exists_positive_deriv_window

/-- info: 'AmericanPutConvexity.Stopping.threeQuarter_eq_quarter_mul_sqrt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.threeQuarter_eq_quarter_mul_sqrt

/-- info: 'AmericanPutConvexity.Stopping.quarter_div_eq_inverse_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.quarter_div_eq_inverse_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.integrable_and_integral_of_inverse_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integrable_and_integral_of_inverse_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_source_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_source_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_integrable_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_deriv_integrable_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_threeQuarter_window' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.exists_canonicalHeatGraph_threeQuarter_window

/-- info: 'AmericanPutConvexity.Stopping.canonicalFrozenHistoryDerivative_tail_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalFrozenHistoryDerivative_tail_control

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatFlux_frozenHistoryDerivative_tail_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatFlux_frozenHistoryDerivative_tail_control

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatFlux_frozenHistoryDerivative_tail_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatFlux_frozenHistoryDerivative_tail_control

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatFlux_frozenHistoryDerivative_tail_control' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatFlux_frozenHistoryDerivative_tail_control

/-- info: 'AmericanPutConvexity.Stopping.heatHistory_recent_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistory_recent_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_recent_threeQuarter' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_recent_threeQuarter

/-- info: 'AmericanPutConvexity.Stopping.quotient_tendsto_zero_of_fiveQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.quotient_tendsto_zero_of_fiveQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.hasDerivWithinAt_integral_Ici_of_dominated_slope' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.hasDerivWithinAt_integral_Ici_of_dominated_slope

/-- info: 'AmericanPutConvexity.Stopping.canonicalRecentFrozenHistory_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRecentFrozenHistory_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalRecentFrozenHistory_quotient_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRecentFrozenHistory_quotient_tendsto

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatFlux_recentFrozenHistory_quotient_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatFlux_recentFrozenHistory_quotient_tendsto

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatFlux_recentFrozenHistory_quotient_tendsto

/-- info: 'AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_time_sub_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenHeatHistoryRemainder_time_sub_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.frozenCommonPast_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.frozenCommonPast_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalCommonPast_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalCommonPast_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistoryIntegral_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistoryIntegral_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.linearHeatHistoryIntegral_shift_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatHistoryIntegral_shift_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.hasDerivWithinAt_Ici_of_increment_remainder' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.hasDerivWithinAt_Ici_of_increment_remainder

/-- info: 'AmericanPutConvexity.Stopping.tendsto_sub_nhdsGT' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.tendsto_sub_nhdsGT

/-- info: 'AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_increment_elapsed' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatHistoryFrom_frozen_increment_elapsed

/-- info: 'AmericanPutConvexity.Stopping.canonicalLocalHistory_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLocalHistory_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalOlderHistory_hasDerivAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalOlderHistory_hasDerivAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatHistoryFrom_split' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatHistoryFrom_split

/-- info: 'AmericanPutConvexity.Stopping.canonicalFullHistory_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalFullHistory_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalFullElapsedHistory_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalFullElapsedHistory_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatDensity_hasDerivWithinAt_right_of_C1_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatDensity_hasDerivWithinAt_right_of_C1_forcing

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSource_density_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSource_density_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_hasDerivWithinAt_right' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_hasDerivWithinAt_right

/-- info: 'AmericanPutConvexity.Stopping.integral_Ioo_moving_right_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integral_Ioo_moving_right_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.regularizedHistoryDerivative_eq_frozen_deriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.regularizedHistoryDerivative_eq_frozen_deriv

/-- info: 'AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_continuousAt_varying' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.heatBoundaryMotionDerivative_continuousAt_varying

/-- info: 'AmericanPutConvexity.Stopping.regularizedHistoryDerivative_continuousAt_time' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.regularizedHistoryDerivative_continuousAt_time

/-- info: 'AmericanPutConvexity.Stopping.regularizedHistoryDerivative_source_continuousOn' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.regularizedHistoryDerivative_source_continuousOn

/-- info: 'AmericanPutConvexity.Stopping.regularizedHistoryDerivative_threeQuarter_bound' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.regularizedHistoryDerivative_threeQuarter_bound

/-- info: 'AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalRegularizedHistoryRate_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalRegularizedHistoryRate_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalRegularizedHistoryRate_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalRegularizedHistoryRate_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalLocalHistory_hasDerivWithinAt_regularizedRate' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLocalHistory_hasDerivWithinAt_regularizedRate

/-- info: 'AmericanPutConvexity.Stopping.linearHeatMotion_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatMotion_integrable

/-- info: 'AmericanPutConvexity.Stopping.linearHeatMotion_integral' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.linearHeatMotion_integral

/-- info: 'AmericanPutConvexity.Stopping.canonicalRegularizedHistoryDerivative_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRegularizedHistoryDerivative_integrable

/-- info: 'AmericanPutConvexity.Stopping.canonicalOlderHistoryRate_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalOlderHistoryRate_integrable

/-- info: 'AmericanPutConvexity.Stopping.regularizedHistoryRate_split' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.regularizedHistoryRate_split

/-- info: 'AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_split' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_split

/-- info: 'AmericanPutConvexity.Stopping.canonicalHistory_hasDerivWithinAt_regularizedRate' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHistory_hasDerivWithinAt_regularizedRate

/-- info: 'AmericanPutConvexity.Stopping.canonicalHistoryRightDerivative_eq_regularizedRate' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHistoryRightDerivative_eq_regularizedRate

/-- info: 'AmericanPutConvexity.Stopping.canonicalLocalHistoryRightDerivative_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLocalHistoryRightDerivative_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.integral_Ioo_continuousAt_of_joint_continuous' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.integral_Ioo_continuousAt_of_joint_continuous

/-- info: 'AmericanPutConvexity.Stopping.canonicalOlderHistoryRate_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalOlderHistoryRate_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalFullHistoryRightDerivative_continuousAt' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalFullHistoryRightDerivative_continuousAt

/-- info: 'AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_continuousAt_all_starts' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRegularizedHistoryRate_continuousAt_all_starts

/-- info: 'AmericanPutConvexity.Stopping.hasDerivAt_of_continuous_right_derivative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.hasDerivAt_of_continuous_right_derivative

/-- info: 'AmericanPutConvexity.Stopping.contDiffOn_one_of_continuous_right_derivative' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.contDiffOn_one_of_continuous_right_derivative

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatDensity_contDiffAt_one_of_C1_forcing' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatDensity_contDiffAt_one_of_C1_forcing

/-- info: 'AmericanPutConvexity.Stopping.actualHeatSource_density_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.actualHeatSource_density_contDiffAt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_contDiffAt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalHeatThetaRightFlux_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalHeatThetaRightFlux_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_contDiffOn_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalHeatThetaRightFlux_contDiffOn_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalThetaRightFlux_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalThetaRightFlux_contDiffAt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_contDiffAt_one' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv_contDiffAt_one

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_contDiffOn_two' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_contDiffOn_two

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_contDiffOn_two' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_contDiffOn_two

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_contDiffOn_two' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_contDiffOn_two

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_hasDerivAt_deriv' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_hasDerivAt_deriv

/-- info: 'AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv2_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalLogBoundary_deriv2_nonneg

/-- info: 'AmericanPutConvexity.Stopping.canonicalRemainingTimeBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.canonicalRemainingTimeBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv2_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_canonicalLogBoundary_deriv2_nonneg

/-- info: 'AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv2_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_canonicalLogBoundary_deriv2_nonneg

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualLogBoundary_contDiffOn_two' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualLogBoundary_contDiffOn_two

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualStockBoundary_contDiffOn_two' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualStockBoundary_contDiffOn_two

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualLogBoundary_deriv2_nonneg' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualLogBoundary_deriv2_nonneg

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualStockBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualStockBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.brownianUsualBoundary_classical_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianUsualBoundary_classical_curvature

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_brownianUsualStockBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.liuRange_brownianUsualStockBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.liuRange_brownianUsualStockBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.AEBoundedRule.clip_expectedReward' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.AEBoundedRule.clip_expectedReward

/-- info: 'AmericanPutConvexity.Stopping.AEBoundedRule.reward_integrable' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.AEBoundedRule.reward_integrable

/-- info: 'AmericanPutConvexity.Stopping.aeExerciseValues_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.aeExerciseValues_eq

/-- info: 'AmericanPutConvexity.Stopping.aeAmericanPutValue_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.aeAmericanPutValue_eq

/-- info: 'AmericanPutConvexity.Stopping.aeExerciseValues_nonempty' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.aeExerciseValues_nonempty

/-- info: 'AmericanPutConvexity.Stopping.aeExerciseValues_bddAbove' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.aeExerciseValues_bddAbove

/-- info: 'AmericanPutConvexity.Stopping.aeExerciseThreshold_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.aeExerciseThreshold_eq

/-- info: 'AmericanPutConvexity.Stopping.brownianAEExerciseBoundary_eq' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAEExerciseBoundary_eq

/-- info: 'AmericanPutConvexity.Stopping.brownianAEBoundary_classical_curvature' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.brownianAEBoundary_classical_curvature

/-- info: 'AmericanPutConvexity.Stopping.zeroDividend_brownianAEBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.zeroDividend_brownianAEBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.equalRates_brownianAEBoundary_deriv2_pos' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.equalRates_brownianAEBoundary_deriv2_pos

/-- info: 'AmericanPutConvexity.Stopping.openRange_brownianAEBoundary_example' depends on axioms:
[propext, Classical.choice, Quot.sound] -/
#guard_msgs (whitespace := lax) in
#print axioms AmericanPutConvexity.Stopping.openRange_brownianAEBoundary_example
