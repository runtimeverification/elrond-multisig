// breadth = 3
//@ proof
module LEMMA-POUND-REMOVE-LAST-KRESULT
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// 
// module TRUSTED-LEMMA-POUND-REMOVE-LAST-KRESULT
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      isKResult(#removeLast(E, Es)) => true
    requires
      isKResult(E) andBool isKResult(Es)
    [simplification]
    endlemma

endmodule
