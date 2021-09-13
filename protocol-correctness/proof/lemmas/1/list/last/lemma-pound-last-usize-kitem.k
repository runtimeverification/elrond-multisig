// breadth = 3
//@ proof
module LEMMA-POUND-LAST-USIZE-KITEM
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/list-elements-are-usize.k"
// 
// module TRUSTED-LEMMA-POUND-LAST-USIZE-KITEM
//@ end

  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LAST-FUNCTIONS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      isUsizeKItem(#last(E, Es)) => true
    requires
      isUsize(E) andBool listElementsAreUsize([Es])
    [simplification]
    endlemma

endmodule
