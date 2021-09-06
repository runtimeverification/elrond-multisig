require "protocol-correctness/lib/language/reflection.k"

module INDUCTION-SYNTAX
  imports BASIC-K
  imports REFLECTION-SYNTAX

  syntax KItem ::= induction(InductionInstructions, InductionData)

  syntax InductionDataItem ::= "(" InductionId "," KItem ")"
  syntax InductionData  ::= InductionDataItem
                          | InductionDataItem "<>" InductionData
  syntax MaybeInductionData ::= ".EmptyInductionData" | InductionData

  syntax InductionId ::= ReflectionId

  syntax InductionInstructions  ::= NonEmptyInductionInstructions
                                  | ".Induction"
  syntax NonEmptyInductionInstructions  ::= InductionInstruction
                                          | InductionInstruction "~~>" NonEmptyInductionInstructions

  syntax InductionInstruction ::= reinduction(InductionExpressionList)
                    | "case" InductionExpression "of" "|" InductionCases "esac"

  syntax InductionCases ::= InductionCase | InductionCase "|" InductionCases

  syntax InductionCase ::= ReflectionPattern "->" InductionInstructions "."

  syntax EvaluatedExpression

  syntax InductionExpression  ::= InductionId
                                | Int
                                | EvaluatedExpression
                                | InductionExpression "==" InductionExpression
                                | InductionExpression "-" InductionExpression
                                | SymbolReflection "(" InductionExpressionList ")"
                                | SymbolReflection "(" ")"

  syntax InductionExpressionList  ::= InductionExpression
                                    | InductionExpression "," InductionExpressionList
endmodule
