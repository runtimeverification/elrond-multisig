// breadth = 7
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports K-EQUAL-SYNTAX
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
                    | > 0 -> reinduction("e", "es1", "i" - 1) .
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
