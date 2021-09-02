require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION-INTERNAL-SYNTAX
  imports INDUCTION-SYNTAX
  imports STRING

  syntax InductionDataNamesList ::= InductionId
                                  | InductionId "," InductionDataNamesList
  syntax InductionDataNames ::= names(InductionDataNamesList)
  
  syntax KItem ::= runInduction(InductionInstructions, InductionData)
  syntax KItem ::= runInductionInstruction(InductionInstruction, InductionData)
  syntax KItem ::= inductionFreezer(InductionInstructions, InductionDataNames)
  syntax KItem ::= runInductionFreezer(InductionInstructions)
  syntax K ::= #runInductionFreezer(InductionInstructions) [function, functional]
  syntax KItem ::= evaluate(InductionExpression, InductionData)
  syntax KItem ::= evaluateList(InductionExpressionList, InductionData)
  syntax KItem ::= mergeDataFreezer(InductionData)
  syntax KItem ::= mergeDataFreezer2(InductionData)

  syntax KItem ::= evaluate(InductionExpression)
  syntax KItem ::= evaluateList(InductionExpressionList)

  syntax InductionDataNamesList ::= extractNames(InductionData)  [function, functional]

  syntax EvaluatedExpression ::= evaluated(KItem)
  syntax KResult ::= EvaluatedExpression
  syntax InductionExpression  ::= EvaluatedExpression

  syntax InductionError ::= unevaluatedError(KItem, String)
endmodule
