require "protocol-correctness/lib/proof/induction/syntax.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"

module INDUCTION-CASE-SYNTAX
  imports BASIC-K
  imports INDUCTION-SYNTAX

  syntax KItem ::= runInductionCases(expression:KItem, InductionCases, InductionData)
  syntax KItem ::= runInductionCase(expression:KItem, InductionCase, InductionData, notMatchedBranch:K)
endmodule

module INDUCTION-CASE
  imports INDUCTION-CASE-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  context runInductionInstruction(
          case {HOLE:InductionExpression => evaluate(HOLE, D)}:>InductionExpression of
              | _Cases:InductionCases
          esac,
          D:InductionData)
      [result(InductionEvaluatedExpression)]

  rule runInductionInstruction(
          case evaluated(K:KItem) of
            | Cases:InductionCases
          esac,
          D:InductionData)
      => runInductionCases(K, Cases, D)

  rule runInductionCases(E:KItem, Case:InductionCase, Data:InductionData)
      => runInductionCase(E, Case, Data, errorNotAllCasesMatched(E))
  rule runInductionCases(E:KItem, Case:InductionCase | Cases:InductionCases, Data:InductionData)
      => runInductionCase(E, Case, Data, runInductionCases(E, Cases, Data))

  rule runInductionCase(
              E:KItem,
              P:ReflectionPattern -> Is:InductionInstructions .,
              Data:InductionData,
              NotMatchedBranch:K
          )
      => matchPatternOrElse(
          P, E,
          mergeDataFreezer(Data) ~> #runInductionFreezer(Is),
          NotMatchedBranch)
endmodule
