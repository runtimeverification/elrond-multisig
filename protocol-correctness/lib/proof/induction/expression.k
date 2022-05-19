require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX
  imports INDUCTION-SYNTAX
  imports REFLECTION-SYNTAX

  syntax InductionEvaluatedExpression ::= findInductionDataValue(InductionId, InductionData)
    [function, functional]

  syntax ReflectionArgumentsOrError ::= ReflectionArguments | InductionError
  syntax ReflectionArgumentsOrError ::= extractReflectionArgumentList(InductionExpressionList)
    [function, functional]
  syntax ReflectionArgumentsOrError ::= concatRAOE(ReflectionArgument, ReflectionArgumentsOrError)
    [function, functional]

  syntax KItem ::= reflectionApplyOrError(SymbolReflection, ReflectionArgumentsOrError, InductionData)
  syntax KItem ::= wrapEvaluated(KItem, InductionData)  [function, functional]

  syntax Bool ::= #isInductionEvaluatedExpression(InductionExpression)
    [function, functional]
endmodule

module INDUCTION-EXPRESSION
  imports BOOL
  imports INT
  imports INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX
  imports K-EQUAL-SYNTAX
  imports REFLECTION-SYNTAX

  // Identifiers
  rule evaluate(
              Identifier:InductionId => findInductionDataValue(Identifier, Data),
              Data:InductionData
          )

  rule findInductionDataValue(Identifier:InductionId, (Identifier, Item:KItem))
      => evaluated(Item)
  rule findInductionDataValue(
              Identifier:InductionId,
              (Identifier, Item:KItem) <> _:InductionData
          )
      => evaluated(Item)
  rule findInductionDataValue(
              Identifier1:InductionId,
              (Identifier2, _Item:KItem) <> Data:InductionData
          )
      => findInductionDataValue(Identifier1, Data)
    requires Identifier1 =/=K Identifier2

  // raw values
  rule evaluate(
              I:Int => evaluated(I),
              _Data:InductionData
          )

  rule evaluate(
              B:Bool => evaluated(B),
              _Data:InductionData
          )

  // ==
  context evaluate(
              {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
                  == _:InductionExpression,
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]
  context evaluate(
              E:InductionExpression
                  == {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression,
              Data:InductionData
          )
      requires isInductionEvaluatedExpression(E)
      [result(InductionEvaluatedExpression)]
  rule evaluate(
              (evaluated(E1:KItem) == evaluated(E2:KItem)) => evaluated(E1 ==K E2),
              _Data:InductionData
          )

  // ==
  context evaluate(
              {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
                  key _:InductionExpression,
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]
  context evaluate(
              E:InductionExpression
                  key {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression,
              Data:InductionData
          )
      requires isInductionEvaluatedExpression(E)
      [result(InductionEvaluatedExpression)]
  rule evaluate(
              (evaluated(E1:KItem) key evaluated(E2:KItem))
                  => evaluated(reflectionKey(E1, E2)),
              _Data:InductionData
          )

  // -
  context evaluate(
              {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
                  - _:InductionExpression,
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]
  context evaluate(
              E:InductionExpression
                  - {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression,
              Data:InductionData
          )
      requires isInductionEvaluatedExpression(E)
      [result(InductionEvaluatedExpression)]
  rule evaluate(
              (evaluated(E1:Int) - evaluated(E2:Int)) => evaluated(E1 -Int E2),
              _Data:InductionData
          )

  // -
  context evaluate(
              {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
                  + _:InductionExpression,
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]
  context evaluate(
              E:InductionExpression
                  + {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression,
              Data:InductionData
          )
      requires isInductionEvaluatedExpression(E)
      [result(InductionEvaluatedExpression)]
  rule evaluate(
              (evaluated(E1:Int) + evaluated(E2:Int)) => evaluated(E1 +Int E2),
              _Data:InductionData
          )

  // application
  context evaluate(
              _SymbolId:SymbolReflection(
                  {HOLE:InductionExpressionList => evaluateList(HOLE, Data)}:>InductionExpressionList
                ),
              Data:InductionData
          )
      [result(InductionEvaluatedExpression)]
  rule evaluate(SymbolId:SymbolReflection(Es:InductionExpressionList), Data:InductionData)
      => reflectionApplyOrError(SymbolId, extractReflectionArgumentList(Es), Data)
    requires isInductionEvaluatedExpression(Es)
  rule evaluate(SymbolId:SymbolReflection(), Data:InductionData)
      => wrapEvaluated(reflectionApply0(SymbolId), Data)

  rule reflectionApplyOrError(SymbolId:SymbolReflection, A:ReflectionArguments, Data:InductionData)
      => wrapEvaluated(reflectionApply(SymbolId, A), Data)
  rule reflectionApplyOrError(_:SymbolReflection, E:InductionError, _:InductionData)
      => E

  rule wrapEvaluated(E:ReflectionError, _Data:InductionData) => E
  rule wrapEvaluated(E:KItem, Data:InductionData) => evaluate(evaluated(E), Data)
    [owise]

  rule extractReflectionArgumentList(evaluated(K:KItem)) => reflectionArgument(K)
  rule extractReflectionArgumentList(evaluated(K:KItem) , D:InductionExpressionList)
      => concatRAOE(reflectionArgument(K), extractReflectionArgumentList(D))
  rule extractReflectionArgumentList(D:InductionExpressionList)
      => unevaluatedError(D, "extractReflectionArgumentList")
    [owise]

  rule concatRAOE(A:ReflectionArgument, L:ReflectionArguments) => A , L
  rule concatRAOE(_:ReflectionArgument, E:InductionError) => E

  rule isInductionEvaluatedExpression(E:InductionExpression) => #isInductionEvaluatedExpression(E)
  rule #isInductionEvaluatedExpression(_:InductionEvaluatedExpression) => true
  rule #isInductionEvaluatedExpression(_:InductionExpression) => false [owise]
endmodule
