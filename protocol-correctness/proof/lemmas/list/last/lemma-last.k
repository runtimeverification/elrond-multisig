// breadth = 2
//@ proof
module LEMMA-LAST
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// 
// module TRUSTED-LEMMA-LAST
//@ end

  imports LAST-FUNCTIONS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  lemma
      lemmaSplitList2([Es]) => .K
    proves
      isKResult(last(Es)) => true
    requires
      isKResult(Es) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
