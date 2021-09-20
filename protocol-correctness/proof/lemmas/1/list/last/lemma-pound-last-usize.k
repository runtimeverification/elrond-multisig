// breadth = 3
//@ proof
module LEMMA-POUND-LAST-USIZE
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// 
// module TRUSTED-LEMMA-POUND-LAST-USIZE
//@ end

  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LAST-FUNCTIONS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      isUsize(#last(E, Es)) => true
    requires
      isUsize(E) andBool listElementsAreUsize([Es])
    [simplification]
    endlemma

endmodule
