// breadth = 3
//@ proof
module LEMMA-POUND-REMOVE-LAST-USIZE
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/list-elements-are-usize.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-POUND-REMOVE-LAST-USIZE
//   imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      lemmaSplitListExpression2(E, [Es]) => .K
    proves
      listElementsAreUsize([#removeLast(E, Es)]) => true
    requires
      listElementsAreUsize([E, Es])
    [simplification]
    endlemma

endmodule
