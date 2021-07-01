// breadth = 3
//@ proof
module LEMMA-POUND-LAST
  imports LIST-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// 
// module TRUSTED-LEMMA-POUND-LAST
//@ end

  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      isKResultExpression(#last(E, Es)) => true
    requires
       isKResult(E) andBool isKResult(Es)
    [simplification]
    endlemma

endmodule
