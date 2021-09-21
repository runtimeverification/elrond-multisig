// breadth = 2
//@ proof
module LEMMA-BOOL-TO-INT-GE-0
  imports CONCRETIZE-VALUE-SYNTAX
  imports K-EQUAL
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// module TRUSTED-LEMMA-BOOL-TO-INT-GE-0
//@ end

  imports BOOL-TO-INT-SYNTAX

  lemma
      concretizeValue(B:Bool) => .K
    proves
      0 <=Int boolToInt(B) => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule
