// breadth = 2
//@ proof
module LEMMA-BOOL-TO-INT-LE-1
  imports CONCRETIZE-VALUE-SYNTAX
  imports K-EQUAL
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// module TRUSTED-LEMMA-BOOL-TO-INT-LE-1
//@ end

  imports BOOL-TO-INT-SYNTAX

  lemma
      concretizeValue(B:Bool) => .K
    proves
      boolToInt(B) <=Int 1 => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule
