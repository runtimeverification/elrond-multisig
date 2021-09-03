// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-REMOVE-LAST
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-elements-are-distinct.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST
//@ end

  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaSplitList([Es]) => .K
    proves
      #listContains([removeLast(Es:ExpressionCSV)], last(Es)) => false
    requires
      listElementsAreDistinct([Es]) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
