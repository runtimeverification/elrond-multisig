// breadth = 8
//@ proof
module LEMMA-LIST-CONTAINS-LAST-TO-START
  imports LEMMAS-0-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
      lemmaIterateListContains1([Es], E) => .K
    proves
      #listContainsUnsafe([lastToStart(Es:ExpressionCSV)], E:Expression)
          => #listContainsUnsafe([Es], E)
    requires
      true
    [simplification]
    endlemma

endmodule
