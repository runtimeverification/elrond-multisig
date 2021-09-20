// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
  imports LEMMAS-1-EXECUTE-SYNTAX
  imports INDUCTION
//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
//@ end

  imports K-EQUAL-SYNTAX
  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e2" <> "es2" ->
            case "e" == "e1" of
              | True -> .Induction .
              | False -> reinduction("e2", "es2", "e") .
            esac .
        esac,
        ("e1", E1:Expression) <> ("es", Es:ExpressionCSV) <> ("e", E:Expression)
      )
      => .K
    proves
      #listContainsUnsafe([#removeLast(E1, Es:ExpressionCSV)], E)
      => #listContainsUnsafe([E1, Es:ExpressionCSV], E)
    requires
      notBool E ==K #last(E1, Es)
    [simplification]
    endlemma
endmodule
