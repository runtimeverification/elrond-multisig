// breadth = 2
//@ proof
module LEMMA-REMOVE-LAST-USIZE
  imports LIST-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/list-elements-are-usize.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-REMOVE-LAST-USIZE
//   imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaSplitList2([Es:ExpressionCSV]) => .K
    proves
      listElementsAreUsize([removeLast(Es)]) => true
    requires
      listElementsAreUsize([Es]) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
