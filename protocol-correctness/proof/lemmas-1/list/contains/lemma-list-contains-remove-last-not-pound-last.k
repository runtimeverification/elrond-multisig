// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-REMOVE-LAST-NOT-POUND-LAST
  imports INDUCTION-SYNTAX
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-REMOVE-LAST-NOT-POUND-LAST
//@ end

  imports K-EQUAL
  imports LIST-CONTAINS-SYNTAX
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e3" <> "es1" ->
              case "e1" == "e2" of
                | True -> .Induction .
                | False -> reinduction("e3", "es1", "e2") .
              esac
              .
          esac,
          ("e1", Exp:Expression) <> ("es", Exps:ExpressionCSV) <> ("e2", E:Expression)
        )
      => .K
    proves
      #listContains([#removeLast(Exp, Exps)], E) => #listContains([Exp, Exps], E)
    requires
      E =/=K #last(Exp, Exps)
    [simplification]
    endlemma

endmodule
