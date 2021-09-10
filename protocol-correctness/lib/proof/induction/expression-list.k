require "protocol-correctness/lib/proof/induction/expression.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION-EXPRESSION-LIST-SYNTAX
  imports INDUCTION-SYNTAX

  syntax Bool ::= isInductionEvaluatedExpressionInductionExpressionList(InductionExpressionList)
    [function, functional]
endmodule

module INDUCTION-EXPRESSION-LIST
  imports BOOL
  imports INDUCTION-EXPRESSION-LIST-SYNTAX
  imports INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  rule isInductionEvaluatedExpression(Es:InductionExpressionList)
      => isInductionEvaluatedExpressionInductionExpressionList(Es)

  rule isInductionEvaluatedExpressionInductionExpressionList(I:InductionExpression)
      => #isInductionEvaluatedExpression(I)
  rule isInductionEvaluatedExpressionInductionExpressionList(
              I:InductionExpression , Is:InductionExpressionList
          )
      => #isInductionEvaluatedExpression(I) andBool isInductionEvaluatedExpressionInductionExpressionList(Is)

  context evaluateList
          ( {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
          , Data:InductionData
          )
    [result(InductionEvaluatedExpression)]
  context evaluateList
          ( ({HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
            , _Is:InductionExpressionList
            )
          , Data:InductionData
          )
    [result(InductionEvaluatedExpression)]
  context evaluateList
          ( ( I:InductionExpression
            , {HOLE:InductionExpressionList => evaluateList(HOLE, Data)}:>InductionExpressionList
            )
          , Data:InductionData
          )
    requires isInductionEvaluatedExpression(I)
    [result(InductionEvaluatedExpression)]
endmodule
