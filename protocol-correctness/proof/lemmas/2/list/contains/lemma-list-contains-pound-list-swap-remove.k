// breadth = 7
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports K-EQUAL
  imports INT
  imports INDUCTION-SYNTAX

//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX

  lemma
        induction(
          case "es" of
            | . -> //.Induction
              case "i" of
                | = 0 -> .Induction .
                | < 0 -> .Induction .
                | > 0 -> .Induction .
              esac
              .
            | "e1" <> "es1" -> // .Induction
              case "e" == "e1" of
                | True -> .Induction .
                | False ->
                  case "i" of
                    | = 0 -> .Induction .
                    | < 0 -> .Induction .
                    | > 0 ->
                      // TODO: The case below should not be needed, it just
                      // forces predicate re-evaluation. Should
                      // minimize and report a Haskell backend error.
                      // Might be caused by
                      // https://github.com/kframework/kore/issues/2829
                      case "es1" of
                        | . -> .Induction .
                        | "e2" <> "es2" -> .Induction .
                      esac
                      ~~> reinduction("e", "es1", "i" - 1) .
                  esac
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV) <> ("i", I:Int)
        ) => .K
    proves
      #listContainsUnsafe([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContainsUnsafe([Es], E)
    [simplification]
    endlemma

endmodule
