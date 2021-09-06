// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
  imports LEMMAS-1-EXECUTE-SYNTAX
  imports INDUCTION
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-elements-are-distinct.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST-POUND-LAST
//@ end

  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            case "e" == $#last("e1", "es1") of
              | True -> .Induction .
              | False -> reinduction("e1", "es1") .
            esac .
        esac,
        ("e", E:Expression) <> ("es", Es:ExpressionCSV)
      )
      => .K
    proves
      #listContains([#removeLast(E, Es:ExpressionCSV)], #last(E, Es)) => false
    requires
      listElementsAreDistinct([E, Es])
    [simplification]
    endlemma
endmodule
