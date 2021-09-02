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

  rule runInductionInstruction(
          case evaluated(K:KItem) #as E:InductionExpression of
            | Cases:InductionCases
          esac,
          D:InductionData)
      => runInductionCases(K, Cases, D)
    requires isKResult(E)

  rule runInductionCases(E:KItem, Case:InductionCase, Data:InductionData)
      => runInductionCase(E, Case, Data, .K)
  rule runInductionCases(E:KItem, Case:InductionCase | Cases:InductionCases, Data:InductionData)
      => runInductionCase(E, Case, Data, runInductionCases(E, Cases, Data))

  rule runInductionCase(
              evaluated(E:KItem),
              P:Pattern -> Is:InductionInstructions .,
              Data:InductionData,
              NotMatchedBranch:K
          )
      => matchPatternOrElse(
          P, E,
          mergeDataFreezer(Data) ~> #runInductionFreezer(Is),
          NotMatchedBranch)
endmodule
