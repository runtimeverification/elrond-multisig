// breadth = 2
//@ proof
module LEMMA-PLISTLEN-LIST-SWAP-REMOVE-LIST-FIND
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// require "protocol-correctness/lib/functions/plistlen-functions.k"
// 
// module TRUSTED-LEMMA-PLISTLEN-LIST-SWAP-REMOVE-LIST-FIND
//@ end

  imports INT
  imports K-EQUAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" -> 
              case "e" == "e1" of
                | True -> .Induction .
                | False -> reinduction("e", "es1")
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      pListLen([#listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], E:Expression))])
      => pListLen([Es]) -Int 1
    requires
      #listFindUnsafe([Es], E) >=Int 0
    [simplification]
    endlemma

endmodule
