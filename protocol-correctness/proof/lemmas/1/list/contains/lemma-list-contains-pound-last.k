// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LAST
  imports INDUCTION-SYNTAX
  imports K-EQUAL
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "e" == $#last("e", "es") of
                | True -> .Induction .
                | False -> reinduction("e1", "es1") .
              esac
              .
          esac,
          ("e", Exp:Expression) <> ("es", Exps:ExpressionCSV)
        )
      => .K
    proves
      #listContainsUnsafe([Exp, Exps], #last(Exp, Exps)) => true
    requires
      true
    [simplification]
    endlemma

endmodule
