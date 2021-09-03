// breadth = 2
//@ proof
module LEMMA-PLISTLEN-REMOVE-LAST
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-PLISTLEN-REMOVE-LAST
//@ end

  imports K-EQUAL
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" -> reinduction("e1", "es1") .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      pListLen([#removeLast(E:Expression, Es)])
      => pListLen([Es])
    requires
      true
    [simplification]
    endlemma

endmodule
