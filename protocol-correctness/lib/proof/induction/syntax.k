require "protocol-correctness/lib/language/reflection.k"

module INDUCTION-SYNTAX
  imports BASIC-K
  imports REFLECTION-SYNTAX

  syntax KItem ::= induction(InductionInstructions, InductionData)
  syntax KItem ::= matchPatternOrElse(Pattern, KItem, matched:K, notMatched:K)

  syntax InductionDataItem ::= "(" InductionId "," KItem ")"
  syntax InductionData  ::= InductionDataItem
                          | InductionDataItem "<>" InductionData
  syntax MaybeInductionData ::= ".EmptyInductionData" | InductionData

  syntax InductionId ::= r"[A-Za-z_#][A-Za-z_0-9]*" [token]

  syntax InductionInstructions  ::= NonEmptyInductionInstructions
                                  | ".Induction"
  syntax NonEmptyInductionInstructions  ::= InductionInstruction
                                          | InductionInstruction "~~>" NonEmptyInductionInstructions

  syntax InductionInstruction ::= reinduction(InductionExpressionList)
                    | "case" InductionExpression "of" "|" InductionCases "esac"

  syntax InductionCases ::= InductionCase | InductionCase "|" InductionCases

  syntax InductionCase ::= Pattern "->" InductionInstructions "."

  syntax Pattern ::= "." | InductionId "<>" InductionId

  syntax EvaluatedExpression

  syntax InductionExpression  ::= InductionId
                                | EvaluatedExpression
                                | InductionExpression "==" InductionExpression
                                | SymbolReflection "(" InductionExpressionList ")"
                                | SymbolReflection "(" ")"

  syntax InductionExpressionList  ::= InductionExpression
                                    | InductionExpression "," InductionExpressionList
endmodule
