require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX
  imports INDUCTION-SYNTAX
  imports REFLECTION-SYNTAX

  syntax EvaluatedExpression ::= findInductionDataValue(InductionId, InductionData)
    [function, functional]

  syntax ReflectionArgumentsOrError ::= ReflectionArguments | InductionError
  syntax ReflectionArgumentsOrError ::= extractReflectionArgumentList(InductionExpressionList)
    [function, functional]
  syntax ReflectionArgumentsOrError ::= concatRAOE(ReflectionArgument, ReflectionArgumentsOrError)
    [function, functional]

  syntax KItem ::= reflectionApplyOrError(SymbolReflection, ReflectionArgumentsOrError)
endmodule

module INDUCTION-EXPRESSION
  imports BOOL
  imports INDUCTION-EXPRESSION-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX
  imports K-EQUAL
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

  // ==
  context evaluate(
              {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression
                  == _:InductionExpression,
              Data:InductionData
          )
  context evaluate(
              E:InductionExpression
                  == {HOLE:InductionExpression => evaluate(HOLE, Data)}:>InductionExpression,
              Data:InductionData
          )
      requires isKResult(E)
  rule evaluate(
              (E1:InductionExpression == E2:InductionExpression) => evaluated(E1 ==K E2),
              _Data:InductionData
          )
      requires isKResult(E1) andBool isKResult(E2)

  // application
  context evaluate(
              _SymbolId:SymbolReflection(
                  {HOLE:InductionExpressionList => evaluateList(HOLE, Data)}:>InductionExpressionList
                ),
              Data:InductionData
          )
  rule evaluate(SymbolId:SymbolReflection(Es:InductionExpressionList), _:InductionData)
      => reflectionApplyOrError(SymbolId, extractReflectionArgumentList(Es))
    requires isKResult(Es)
  rule evaluate(SymbolId:SymbolReflection(), _:InductionData)
      => reflectionApply0(SymbolId)

  rule reflectionApplyOrError(SymbolId:SymbolReflection, A:ReflectionArguments)
      => reflectionApply(SymbolId, A)
  rule reflectionApplyOrError(_:SymbolReflection, E:InductionError) => E

  rule extractReflectionArgumentList(evaluated(K:KItem)) => reflectionArgument(K)
  rule extractReflectionArgumentList(evaluated(K:KItem) , D:InductionExpressionList)
      => concatRAOE(reflectionArgument(K), extractReflectionArgumentList(D))
  rule extractReflectionArgumentList(D:InductionExpressionList)
      => unevaluatedError(D, "extractReflectionArgumentList")
    [owise]

  rule concatRAOE(A:ReflectionArgument, L:ReflectionArguments) => A , L
  rule concatRAOE(_:ReflectionArgument, E:InductionError) => E
endmodule
