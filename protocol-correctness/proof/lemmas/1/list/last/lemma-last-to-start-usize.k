// breadth = 3
//@ proof
module LEMMA-LAST-TO-START-USIZE
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports INSTRUMENTATION-CONCRETIZE

//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// 
// module TRUSTED-LEMMA-LAST-TO-START-USIZE
//   imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
//@ end

  imports LAST-TO-START-SYNTAX

  lemma
      lemmaSplitList2([Es]) => .K
    proves
      listElementsAreUsize([lastToStart(Es)]) => listElementsAreUsize([Es])
    requires
      true
    [simplification]
    endlemma

endmodule
