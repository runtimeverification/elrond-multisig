require "protocol-correctness/lib/proof/induction/expression.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION-EXPRESSION-LIST-SYNTAX
  imports INDUCTION-SYNTAX

  syntax Bool ::= isKResultInductionExpressionList(InductionExpressionList)
    [function, functional]
endmodule

module INDUCTION-EXPRESSION-LIST
  imports BOOL
  imports INDUCTION-EXPRESSION-LIST-SYNTAX
  imports INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  syntax KResult

  rule isKResult(Es:InductionExpressionList) => isKResultInductionExpressionList(Es)

  rule isKResultInductionExpressionList(I:InductionExpression) => isKResultInductionExpression(I)
  rule isKResultInductionExpressionList(
              I:InductionExpression , Is:InductionExpressionList
          )
      => isKResultInductionExpression(I) andBool isKResultInductionExpressionList(Is)

  context evaluateList
          ( {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
          , Data:InductionData
          )
  context evaluateList
          ( ({HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
            , _Is:InductionExpressionList
            )
          , Data:InductionData
          )
  context evaluateList
          ( ( I:InductionExpression
            , {HOLE:InductionExpressionList => evaluateList(HOLE, Data)}:>InductionExpressionList
            )
          , Data:InductionData
          )
    requires isKResult(I)
endmodule
