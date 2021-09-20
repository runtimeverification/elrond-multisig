// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LAST-POUND-REMOVE-LAST
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST-POUND-REMOVE-LAST
//@ end

  imports K-EQUAL
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "e2" == $#last("e1", "es") of
            | True -> .Induction .
            | False -> .Induction .
          esac,
          ("e1", E1:Expression) <> ("es", Es:ExpressionCSV) <> ("e2", E2:Expression)
        )
      => .K
    proves
      #listContainsUnsafe([#last(E1, Es), #removeLast(E1, Es:ExpressionCSV)], E2)
      => #listContainsUnsafe([E1, Es], E2)
    requires
      true
    [simplification]
    endlemma

endmodule
