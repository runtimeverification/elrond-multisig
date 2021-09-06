// breadth = 2
//@ proof
module LEMMA-PLISTLEN-LIST-SWAP-REMOVE-LIST-FIND
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/list-find.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// require "protocol-correctness/lib/plistlen-functions.k"
// 
// module TRUSTED-LEMMA-PLISTLEN-LIST-SWAP-REMOVE-LIST-FIND
//@ end

  imports INT
  imports K-EQUAL
  imports LIST-FIND-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" -> 
              case "e" == "e1" of
                | True -> .Induction .
                | False ->
                  // TODO: The case below should not be needed, it just
                  // forces predicate re-evaluation. Should
                  // minimize and report a Haskell backend error.
                  case "es1" of
                    | . -> .Induction .
                    | "e2" <> "es2" -> .Induction .
                  esac
                  ~~> reinduction("e", "es1")
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      pListLen([#listSwapRemove(Es:ExpressionCSV, #listFind([Es], E:Expression))])
      => pListLen([Es]) -Int 1
    requires
      #listFind([Es], E) >=Int 0 andBool isKResult(Es) andBool isKResult(E)
    [simplification]
    endlemma

endmodule
