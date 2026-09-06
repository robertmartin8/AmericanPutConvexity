import paper.review.ValueAuditStatements

set_option pp.explicit true
set_option pp.fullNames true
set_option pp.proofs true
set_option pp.proofs.threshold 10000000
set_option pp.deepTerms true
set_option pp.universes true
set_option format.width 120
set_option pp.maxSteps 10000000
set_option maxRecDepth 10000

open Lean Elab Command in
elab "#audit_statement " n:ident : command => do
  let ci ← getConstInfo n.getId
  logInfo m!"{ci.name} : {ci.type}"

#eval IO.println "\n## 1. Value, boundary, stopping rules and GBM\n"
#eval IO.println "\n### AmericanConvexity.Stopping.brownianUsualAmericanPut\n\nCommand: #print AmericanConvexity.Stopping.brownianUsualAmericanPut\n"
#print AmericanConvexity.Stopping.brownianUsualAmericanPut
#eval IO.println "\n### AmericanConvexity.Stopping.brownianUsualExerciseBoundary\n\nCommand: #print AmericanConvexity.Stopping.brownianUsualExerciseBoundary\n"
#print AmericanConvexity.Stopping.brownianUsualExerciseBoundary
#eval IO.println "\n### AmericanConvexity.Stopping.americanPutValue\n\nCommand: #print AmericanConvexity.Stopping.americanPutValue\n"
#print AmericanConvexity.Stopping.americanPutValue
#eval IO.println "\n### AmericanConvexity.Stopping.exerciseValues\n\nCommand: #print AmericanConvexity.Stopping.exerciseValues\n"
#print AmericanConvexity.Stopping.exerciseValues
#eval IO.println "\n### AmericanConvexity.Stopping.exerciseThreshold\n\nCommand: #print AmericanConvexity.Stopping.exerciseThreshold\n"
#print AmericanConvexity.Stopping.exerciseThreshold
#eval IO.println "\n### AmericanConvexity.Stopping.exerciseSet\n\nCommand: #print AmericanConvexity.Stopping.exerciseSet\n"
#print AmericanConvexity.Stopping.exerciseSet
#eval IO.println "\n### AmericanConvexity.Stopping.BoundedRule\n\nCommand: #print AmericanConvexity.Stopping.BoundedRule\n"
#print AmericanConvexity.Stopping.BoundedRule
#eval IO.println "\n### AmericanConvexity.Stopping.BoundedRule.time\n\nCommand: #print AmericanConvexity.Stopping.BoundedRule.time\n"
#print AmericanConvexity.Stopping.BoundedRule.time
#eval IO.println "\n### AmericanConvexity.Stopping.putReward\n\nCommand: #print AmericanConvexity.Stopping.putReward\n"
#print AmericanConvexity.Stopping.putReward
#eval IO.println "\n### MathFin.gbmValue\n\nCommand: #print MathFin.gbmValue\n"
#print MathFin.gbmValue
#eval IO.println "\n### MeasureTheory.IsStoppingTime\n\nCommand: #print MeasureTheory.IsStoppingTime\n"
#print MeasureTheory.IsStoppingTime
#eval IO.println "\n## 2. Actual measure and filtration\n"
#eval IO.println "\n### AmericanConvexity.Stopping.completedMeasurableSpace\n\nCommand: #print AmericanConvexity.Stopping.completedMeasurableSpace\n"
#print AmericanConvexity.Stopping.completedMeasurableSpace
#eval IO.println "\n### AmericanConvexity.Stopping.completedMeasure\n\nCommand: #print AmericanConvexity.Stopping.completedMeasure\n"
#print AmericanConvexity.Stopping.completedMeasure
#eval IO.println "\n### AmericanConvexity.Stopping.brownianUsualFiltration\n\nCommand: #print AmericanConvexity.Stopping.brownianUsualFiltration\n"
#print AmericanConvexity.Stopping.brownianUsualFiltration
#eval IO.println "\n### AmericanConvexity.Stopping.completedAmbientFiltration\n\nCommand: #print AmericanConvexity.Stopping.completedAmbientFiltration\n"
#print AmericanConvexity.Stopping.completedAmbientFiltration
#eval IO.println "\n### AmericanConvexity.Stopping.ambientNullAugmentation\n\nCommand: #print AmericanConvexity.Stopping.ambientNullAugmentation\n"
#print AmericanConvexity.Stopping.ambientNullAugmentation
#eval IO.println "\n### MathFin.ItoLocalMartingale.nullsAlg\n\nCommand: #print MathFin.ItoLocalMartingale.nullsAlg\n"
#print MathFin.ItoLocalMartingale.nullsAlg
#eval IO.println "\n### AmericanConvexity.Stopping.brownianFiltration\n\nCommand: #print AmericanConvexity.Stopping.brownianFiltration\n"
#print AmericanConvexity.Stopping.brownianFiltration
#eval IO.println "\n### MeasureTheory.Filtration.natural\n\nCommand: #print MeasureTheory.Filtration.natural\n"
#print MeasureTheory.Filtration.natural
#eval IO.println "\n### MeasureTheory.Filtration.rightCont\n\nCommand: #print MeasureTheory.Filtration.rightCont\n"
#print MeasureTheory.Filtration.rightCont
#eval IO.println "\n### MeasureTheory.Filtration.rightCont_def\n\nCommand: #print MeasureTheory.Filtration.rightCont_def\n"
#print MeasureTheory.Filtration.rightCont_def
#print axioms MeasureTheory.Filtration.rightCont_def
#eval IO.println "\n### MeasureTheory.Filtration.rightCont_eq\n\nCommand: #print MeasureTheory.Filtration.rightCont_eq\n"
#print MeasureTheory.Filtration.rightCont_eq
#print axioms MeasureTheory.Filtration.rightCont_eq
#eval IO.println "\n### AmericanConvexity.Review.actualUsualFiltration_eq_iInf\n\nCommand: #print AmericanConvexity.Review.actualUsualFiltration_eq_iInf\n"
#print AmericanConvexity.Review.actualUsualFiltration_eq_iInf
#print axioms AmericanConvexity.Review.actualUsualFiltration_eq_iInf
#eval IO.println "\n### MeasureTheory.Filtration.const\n\nCommand: #print MeasureTheory.Filtration.const\n"
#print MeasureTheory.Filtration.const
#eval IO.println "\n### AmericanConvexity.Stopping.completion_isProbabilityMeasure\n\nCommand: #print AmericanConvexity.Stopping.completion_isProbabilityMeasure\n"
#print AmericanConvexity.Stopping.completion_isProbabilityMeasure
#eval IO.println "\n### ProbabilityTheory.IsProbabilityMeasure_gaussianLimit\n\nCommand: #print ProbabilityTheory.IsProbabilityMeasure_gaussianLimit\n"
#print ProbabilityTheory.IsProbabilityMeasure_gaussianLimit
#eval IO.println "\n### AmericanConvexity.Review.actualMeasure_probability\n\nCommand: #print AmericanConvexity.Review.actualMeasure_probability\n"
#print AmericanConvexity.Review.actualMeasure_probability
#eval IO.println "\n## 3. Brownian construction and the filtration distinction\n"
#eval IO.println "\n### ProbabilityTheory.gaussianLimit\n\nCommand: #print ProbabilityTheory.gaussianLimit\n"
#print ProbabilityTheory.gaussianLimit
#eval IO.println "\n### ProbabilityTheory.gaussianProjectiveFamily\n\nCommand: #print ProbabilityTheory.gaussianProjectiveFamily\n"
#print ProbabilityTheory.gaussianProjectiveFamily
#eval IO.println "\n### ProbabilityTheory.brownianCovMatrix\n\nCommand: #print ProbabilityTheory.brownianCovMatrix\n"
#print ProbabilityTheory.brownianCovMatrix
#eval IO.println "\n### MeasureTheory.projectiveLimit\n\nCommand: #print MeasureTheory.projectiveLimit\n"
#print MeasureTheory.projectiveLimit
#eval IO.println "\n### ProbabilityTheory.brownian\n\nCommand: #print ProbabilityTheory.brownian\n"
#print ProbabilityTheory.brownian
#eval IO.println "\n### ProbabilityTheory.preBrownian\n\nCommand: #print ProbabilityTheory.preBrownian\n"
#print ProbabilityTheory.preBrownian
#eval IO.println "\n### ProbabilityTheory.IsPreBrownianReal.mk\n\nCommand: #print ProbabilityTheory.IsPreBrownianReal.mk\n"
#print ProbabilityTheory.IsPreBrownianReal.mk
#eval IO.println "\n### ProbabilityTheory.isBrownianReal_brownian\n\nCommand: #print ProbabilityTheory.isBrownianReal_brownian\n"
#print ProbabilityTheory.isBrownianReal_brownian
#eval IO.println "\n### ProbabilityTheory.IsBrownianReal\n\nCommand: #print ProbabilityTheory.IsBrownianReal\n"
#print ProbabilityTheory.IsBrownianReal
#eval IO.println "\n### ProbabilityTheory.IsPreBrownianReal\n\nCommand: #print ProbabilityTheory.IsPreBrownianReal\n"
#print ProbabilityTheory.IsPreBrownianReal
#eval IO.println "\n### ProbabilityTheory.IsFilteredPreBrownian\n\nCommand: #print ProbabilityTheory.IsFilteredPreBrownian\n"
#print ProbabilityTheory.IsFilteredPreBrownian
#eval IO.println "\n### AmericanConvexity.Stopping.brownian_filtered\n\nCommand: #print AmericanConvexity.Stopping.brownian_filtered\n"
#print AmericanConvexity.Stopping.brownian_filtered
#eval IO.println "\n### AmericanConvexity.Stopping.brownianLogState\n\nCommand: #print AmericanConvexity.Stopping.brownianLogState\n"
#print AmericanConvexity.Stopping.brownianLogState
#eval IO.println "\n### AmericanConvexity.Stopping.brownianHeatFlow\n\nCommand: #print AmericanConvexity.Stopping.brownianHeatFlow\n"
#print AmericanConvexity.Stopping.brownianHeatFlow
#eval IO.println "\n## 4. All a.s.-bounded stopping times\n"
#eval IO.println "\n### AmericanConvexity.Stopping.AEBoundedRule\n\nCommand: #print AmericanConvexity.Stopping.AEBoundedRule\n"
#print AmericanConvexity.Stopping.AEBoundedRule
#eval IO.println "\n### AmericanConvexity.Stopping.AEBoundedRule.finiteTime\n\nCommand: #print AmericanConvexity.Stopping.AEBoundedRule.finiteTime\n"
#print AmericanConvexity.Stopping.AEBoundedRule.finiteTime
#eval IO.println "\n### AmericanConvexity.Stopping.AEBoundedRule.clip\n\nCommand: #print AmericanConvexity.Stopping.AEBoundedRule.clip\n"
#print AmericanConvexity.Stopping.AEBoundedRule.clip
#eval IO.println "\n### AmericanConvexity.Stopping.BoundedRule.ofWithTop\n\nCommand: #print AmericanConvexity.Stopping.BoundedRule.ofWithTop\n"
#print AmericanConvexity.Stopping.BoundedRule.ofWithTop
#eval IO.println "\n### AmericanConvexity.Stopping.aeExerciseValues\n\nCommand: #print AmericanConvexity.Stopping.aeExerciseValues\n"
#print AmericanConvexity.Stopping.aeExerciseValues
#eval IO.println "\n### AmericanConvexity.Stopping.aeAmericanPutValue\n\nCommand: #print AmericanConvexity.Stopping.aeAmericanPutValue\n"
#print AmericanConvexity.Stopping.aeAmericanPutValue
#eval IO.println "\n### AmericanConvexity.Stopping.aeExerciseValues_eq\n\nCommand: #print AmericanConvexity.Stopping.aeExerciseValues_eq\n"
#print AmericanConvexity.Stopping.aeExerciseValues_eq
#eval IO.println "\n### AmericanConvexity.Stopping.aeAmericanPutValue_eq\n\nCommand: #print AmericanConvexity.Stopping.aeAmericanPutValue_eq\n"
#print AmericanConvexity.Stopping.aeAmericanPutValue_eq
#eval IO.println "\n### AmericanConvexity.Review.actualValue_eq_ae_value\n\nCommand: #print AmericanConvexity.Review.actualValue_eq_ae_value\n"
#print AmericanConvexity.Review.actualValue_eq_ae_value
#eval IO.println "\n## 5. Statements and individual axiom reports\n"
#eval IO.println "\n### AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition\n"
#audit_statement AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition
#print axioms AmericanConvexity.Stopping.brownianLogState_usual_condExp_transition
#eval IO.println "\n### AmericanConvexity.Stopping.brownianUsual_adapted\n"
#audit_statement AmericanConvexity.Stopping.brownianUsual_adapted
#print axioms AmericanConvexity.Stopping.brownianUsual_adapted
#eval IO.println "\n### AmericanConvexity.Review.actualValue_contact_iff\n"
#audit_statement AmericanConvexity.Review.actualValue_contact_iff
#print axioms AmericanConvexity.Review.actualValue_contact_iff
#eval IO.println "\n### AmericanConvexity.Review.actualBoundary_strict_bounds\n"
#audit_statement AmericanConvexity.Review.actualBoundary_strict_bounds
#print axioms AmericanConvexity.Review.actualBoundary_strict_bounds
#eval IO.println "\n### AmericanConvexity.Review.actualValue_bounds\n"
#audit_statement AmericanConvexity.Review.actualValue_bounds
#print axioms AmericanConvexity.Review.actualValue_bounds
#eval IO.println "\n### AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact\n"
#audit_statement AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact
#print axioms AmericanConvexity.Review.actualBoundary_eq_sup_positive_contact
