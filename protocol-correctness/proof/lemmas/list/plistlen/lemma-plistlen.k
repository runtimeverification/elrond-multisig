// breadth = 2
//@ proof
module LEMMA-PLISTLEN
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/plistlen-functions.k"
// //
// module TRUSTED-LEMMA-PLISTLEN
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX

  //@ proof
  claim lemmaSplitList([Es:ExpressionCSV]) => .K
    ensures pListLen([Es]) >=Int 0 ==K true
  //@ trusted
  //@ end

  lemma
      lemmaSplitList(L) => .K
    proves
      pListLen(L) >=Int 0 => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule