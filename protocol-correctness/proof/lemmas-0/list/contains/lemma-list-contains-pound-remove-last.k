// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-elements-are-distinct.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
//@ end

  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      lemmaIterateListContains1([Es], E) => .K
    proves
      #listContains([#removeLast(E, Es:ExpressionCSV)], #last(E, Es)) => false
    requires
      listElementsAreDistinct([E, Es])
    [simplification]
    endlemma
endmodule
