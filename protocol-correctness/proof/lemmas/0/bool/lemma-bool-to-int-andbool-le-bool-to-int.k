// breadth = 3
//@ proof
module LEMMA-BOOL-TO-INT-ANDBOOL-LE-BOOL-TO-INT
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// module TRUSTED-LEMMA-BOOL-TO-INT-ANDBOOL-LE-BOOL-TO-INT
//@ end

  imports BOOL-TO-INT-SYNTAX

  lemma
      induction(
          case "a" of
            | False -> .Induction .
            | True ->
              case "b" of
                | False -> .Induction .
                | True -> .Induction .
              esac .
          esac,
          ("a", A:Bool) <> ("b", B:Bool)
      )
      => .K
    proves
      boolToInt(A andBool B) <=Int boolToInt(A) => true
    requires
      true
    [simplification, smt-lemma]
    endlemma

endmodule
