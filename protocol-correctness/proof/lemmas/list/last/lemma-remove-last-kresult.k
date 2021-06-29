// breadth = 2
//@ proof
module LEMMA-REMOVE-LAST-KRESULT
  imports LIST-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
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

  rule isKResult(removeLast(Es)) => true
    requires isKResult(Es)
    ensures pListLen([Es]) >Int 0
    [simplification]

endmodule
