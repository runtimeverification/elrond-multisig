// breadth = 2
//@ proof
module LEMMA-REMOVE-LAST-KRESULT
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// 
// module TRUSTED-LEMMA-REMOVE-LAST-KRESULT
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaSplitList2([Es]) => .K
    proves
      isKResult(removeLast(Es)) => true
    requires
      isKResult(Es) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
