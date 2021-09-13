// breadth = 2
//@ proof
module LEMMA-PLISTLEN-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL

//@ trusted
// require "protocol-correctness/lib/plistlen-functions.k"
// require "protocol-correctness/lib/last-to-start.k"
// 
// module TRUSTED-LEMMA-PLISTLEN-LAST-TO-START
//@ end

  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports LAST-TO-START-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" -> .Induction .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      pListLen([lastToStart(Es)]) => pListLen([Es])
    requires
      true
    [simplification]
    endlemma

endmodule
