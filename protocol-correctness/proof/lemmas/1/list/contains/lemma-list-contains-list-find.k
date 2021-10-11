// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-LIST-FIND
  imports INDUCTION-SYNTAX
  imports K-EQUAL
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-find.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-LIST-FIND
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "e" == "e1" of
                | True -> .Induction .
                | False -> reinduction("e", "es1") .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      #listContainsUnsafe([Es:ExpressionCSV], E:Expression) => true
    requires
      #listFindUnsafe([Es], E) >=Int 0
    [simplification]
    endlemma

endmodule
