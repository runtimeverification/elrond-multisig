require "protocol-correctness/lib/proof/induction/data-item.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module REINDUCTION-SYNTAX
  imports INDUCTION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  syntax InductionDataWithError ::= pairInductionData(
          InductionDataNames, InductionExpressionList
      )  [function, functional]

  syntax KItem ::= nextInductionStep(InductionInstructions)
  syntax KItem ::= afterReinduction(K)
endmodule

module REINDUCTION
  imports INDUCTION-DATA-ITEM-INTERNAL-SYNTAX
  imports REINDUCTION-SYNTAX

  context runInductionInstruction(
              reinduction(
                  {HOLE:InductionExpressionList => evaluateList(HOLE, Data)}:>InductionExpressionList
              ),
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]

  rule  runInductionInstruction(reinduction(E:InductionExpressionList), Data:InductionData)
        ~>  (  runInductionFreezer(_) #as Freezer:KItem
            => afterReinduction(Data ~> Freezer)
            )
    requires isInductionEvaluatedExpression(E)

  rule  runInductionInstruction(reinduction(E:InductionExpressionList), _Data:InductionData)
        ~>  (  afterReinduction(After:K) ~> runInductionFreezer(_) #as Freezer:KItem
            => afterReinduction(After ~> Freezer)
            )
    requires isInductionEvaluatedExpression(E)


  rule  (  runInductionInstruction(reinduction(E:InductionExpressionList), _Data:InductionData)
        ~> afterReinduction(After:K)
        ~> inductionFreezer(Is:InductionInstructions, Names:InductionDataNames) #as Freezer:KItem
        )
      => pairInductionData(Names, E) ~> nextInductionStep(Is) ~> After ~> Freezer
    requires isInductionEvaluatedExpression(E)

  rule  (  runInductionInstruction(reinduction(E:InductionExpressionList), _Data:InductionData)
        ~> inductionFreezer(Is:InductionInstructions, Names:InductionDataNames)
        )
      => pairInductionData(Names, E) ~> nextInductionStep(Is)
    requires isInductionEvaluatedExpression(E)

  rule (Data:InductionData ~> nextInductionStep(Is:InductionInstructions))
      => induction(Is, Data)

  rule pairInductionData(names(Name:InductionId), evaluated(Item:KItem)) => (Name, Item)
  rule pairInductionData(
          names(Name:InductionId , Names:InductionDataNamesList),
          (evaluated(Item:KItem), Expressions:InductionExpressionList))
      => prepend((Name, Item), pairInductionData(names(Names), Expressions))
  rule pairInductionData(Names:InductionDataNames, Expressions:InductionExpressionList)
      => errorNamePairing(Names, Expressions)  [owise]
endmodule
