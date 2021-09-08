// breadth = 6
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
  imports LEMMAS-0-EXECUTE-SYNTAX
  imports INDUCTION
//@ trusted
// require "protocol-correctness/lib/list-contains.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
//@ end

  imports LIST-CONTAINS-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  lemma
        induction(
          case "e" == "e1" of
            | True -> .Induction .
            | False ->
              case "es" of
                | . ->
                  case "i" of
                    | = 0 -> .Induction .
                    | < 0 -> .Induction .
                    | > 0 -> .Induction .
                  esac .
                | "e2" <> "es2" ->
                  case "i" of
                    | = 0 ->
                      case "e" == "e2" of
                        | True -> .Induction .
                        | False -> .Induction .
                      esac .
                    | < 0 -> .Induction .
                    | > 0 -> reinduction("e", "e2", "es2", "i" - v(1)) .
                  esac .
              esac
              .
          esac,
          ("e", E:Expression)
              <> ("e1", E1:Expression)
              <> ("es", Es:ExpressionCSV)
              <> ("i", I:Int)
        )
        => .K
    proves
      #listContains([E1:Expression, #listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContains([E1, Es], E)
    [simplification]
    endlemma

endmodule
