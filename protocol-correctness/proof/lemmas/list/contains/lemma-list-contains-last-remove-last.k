// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-LAST-REMOVE-LAST
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-elements-are-distinct.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-LAST-REMOVE-LAST
//@ end

  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      ??? => .K
    proves
      #listContains([#last(E1, Es), #removeLast(E1, Es:ExpressionCSV)], E2)
      => #listContains([E1, Es], E2)
    requires
      true
    [simplification]
    endlemma

endmodule
