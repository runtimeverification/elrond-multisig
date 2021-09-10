require "protocol-correctness/lib/proof/induction/syntax.k"
require "protocol-correctness/lib/proof/induction/internal-syntax.k"

module INDUCTION-CALL-SYNTAX
  imports BASIC-K
  imports INDUCTION-SYNTAX
endmodule

module INDUCTION-CALL
  imports INDUCTION-CALL-SYNTAX
  imports INDUCTION-INTERNAL-SYNTAX

  context runInductionInstruction(
          call {HOLE:InductionExpression => evaluate(HOLE, D)}:>InductionExpression,
          D:InductionData)
      [result(InductionEvaluatedExpression)]

  rule runInductionInstruction(call evaluated(K:KItem), D:InductionData)
      => K ~> D
endmodule
