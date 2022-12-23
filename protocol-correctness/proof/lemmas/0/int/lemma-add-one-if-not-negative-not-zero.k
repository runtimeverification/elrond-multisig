// breadth = 2
//@ proof
module LEMMA-ADD-ONE-IF-NOT-NEGATIVE-NOT-ZERO
  imports CONCRETIZE-VALUE-SYNTAX
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/add-one-if-not-negative.k"
// 
// module TRUSTED-LEMMA-ADD-ONE-IF-NOT-NEGATIVE-NOT-ZERO
//@ end

  imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX
  imports BOOL
  imports INT
  imports K-EQUAL-SYNTAX

  lemma
      concretizeValue(X >=Int 0) => .K
    proves
      notBool addOneIfNotNegative(X:Int) ==Int 0 => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule
