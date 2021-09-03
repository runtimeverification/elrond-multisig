// breadth = 6
//@ proof
module LEMMA-LIST-CONTAINS-LAST-TO-START
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-to-start.k"
// require "protocol-correctness/lib/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaIterateListContains1([Es], E) => .K
    proves
      #listContains([lastToStart(Es:ExpressionCSV)], E:Expression)
          => #listContains([Es], E)
    requires
      true
    [simplification]
    endlemma

endmodule
