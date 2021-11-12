// breadth = 1
//@ proof
module PROOF-BOOL-TO-INT-SUM-AND-NOT
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// require "protocol-correctness/proof/named-lemmas/bool-to-int-sum-and-not.k"
// module TRUSTED-BOOL-TO-INT-SUM-AND-NOT
//@ end

  imports BOOL
  imports BOOL-TO-INT-SYNTAX
  imports INT
  imports K-EQUAL-SYNTAX
  imports NAMED-LEMMA-BOOL-TO-INT-SUM-AND-NOT-SYNTAX

  claim lemmaBoolToIntSumAndNot(A:Bool, B:Bool) => .K
    requires true
    ensures
        boolToInt(A andBool B) +Int boolToInt(A andBool notBool B) ==K boolToInt(A)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
