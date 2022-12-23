require "protocol-correctness/lib/functions/concretize-value.k"

module NAMED-LEMMA-BOOL-TO-INT-SUM-AND-NOT-SYNTAX
  imports BOOL

  syntax KItem ::= lemmaBoolToIntSumAndNot(common:Bool, flipping:Bool)
endmodule

module NAMED-LEMMA-BOOL-TO-INT-SUM-AND-NOT
  imports NAMED-LEMMA-BOOL-TO-INT-SUM-AND-NOT-SYNTAX

  imports CONCRETIZE-VALUE-SYNTAX

  rule lemmaBoolToIntSumAndNot(_Common:Bool, Flipping:Bool) => concretizeValue(Flipping)
endmodule
