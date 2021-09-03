// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LAST-POUND-REMOVE-LAST
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST-POUND-REMOVE-LAST
//@ end

  imports K-EQUAL
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LIST-CONTAINS-SYNTAX
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
      #listContains([#last(E1, Es), #removeLast(E1, Es:ExpressionCSV)], E2)
      => #listContains([E1, Es], E2)
    requires
      true
    [simplification]
    endlemma

endmodule
