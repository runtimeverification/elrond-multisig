// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-REMOVE-LAST
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-elements-are-distinct.k"
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST
//@ end

  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
        induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "es1" of
                | . -> .Induction .
                | "e2" <> "es2" ->
                  case "e1" == $#last("e2", "es2") of
                    | True -> .Induction .
                    | False -> reinduction("es1") .
                  esac .
              esac
              .
          esac,
          ("es", Es:ExpressionCSV)
        )
        => .K
    proves
      #listContainsUnsafe([removeLast(Es:ExpressionCSV)], last(Es)) => false
    requires
      listElementsAreDistinctUnsafe([Es]) andBool pListLen([Es]) >Int 0
    [simplification]
    endlemma

endmodule
