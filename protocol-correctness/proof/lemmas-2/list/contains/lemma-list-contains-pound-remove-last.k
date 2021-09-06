// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
  imports LEMMAS-1-EXECUTE-SYNTAX
  imports INDUCTION
//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-REMOVE-LAST
//@ end

  imports K-EQUAL-SYNTAX
  imports LAST-FUNCTIONS
  imports LIST-CONTAINS-SYNTAX
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
      #listContains([#removeLast(E1, Es:ExpressionCSV)], E)
      => #listContains([E1, Es:ExpressionCSV], E)
    requires
      notBool E ==K #last(E1, Es)
    [simplification]
    endlemma
endmodule
