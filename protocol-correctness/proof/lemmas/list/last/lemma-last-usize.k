// breadth = 2
//@ proof
module LEMMA-LAST-USIZE
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/list-elements-are-usize.k"
// 
// module TRUSTED-LEMMA-LAST-USIZE
//@ end

  imports LAST-FUNCTIONS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  lemma
      lemmaSplitList2([Es]) => .K
    proves
      isUsize(last(Es)) => true
    requires
      listElementsAreUsize([Es]) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
