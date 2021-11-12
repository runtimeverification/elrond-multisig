// breadth = 13
// timeout = moderate
//@ proof
module LEMMA-LIST-CONTAINS-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  // imports LAST-FUNCTIONS
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  // imports PLISTLEN-FUNCTIONS-SYNTAX
  // imports REMOVE-LAST-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "es1" of
                | . ->
                  case "e" == "e1" of
                    | True -> .Induction .
                    | False -> .Induction .
                  esac
                  .
                | "e2" <> "es2" ->
                  case "e1" == $#last("e2", "es2") of
                    | True -> .Induction .
                    | False -> .Induction .
                  esac
                  ~~> case "e" == $#last("e2", "es2") of
                    | True -> .Induction .
                    | False -> .Induction .
                  esac
                  ~~> case "e" == "e1" of
                    | True -> .Induction .
                    | False -> .Induction .
                  esac
                  ~~> reinduction("e", "es1")
                  // TODO: This forces term re-evaluation. Should not be needed.
                  // Haskell backend bug, most likely
                  // https://github.com/kframework/kore/issues/2829
                  ~~> case "es2" of
                    | . -> .Induction .
                    | "e3" <> "es3" -> .Induction .
                  esac
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      #listContainsUnsafe([lastToStart(Es:ExpressionCSV)], E:Expression)
          => #listContainsUnsafe([Es], E)
    requires
      true
    [simplification]
    endlemma

endmodule

/*
  #listContainsUnsafe([lastToStart(Es)], E)
      => #listContainsUnsafe([Es], E)
  case es:
    .:
      #listContainsUnsafe([lastToStart(.)], E)
          => #listContainsUnsafe([.], E)
      obvious
    e1:es1:
      #listContainsUnsafe([last(Es), removeLast(Es)], E)
          => #listContainsUnsafe([Es], E)
      #listContainsUnsafe([last(e1:es1), removeLast(e1:es1)], E)
          => #listContainsUnsafe([e1:es1], E)
      #listContainsUnsafe([#last(e1, es1), #removeLast(e1, es1)], E)
          => #listContainsUnsafe([e1:es1], E)
      case es1:
        .:
          #listContainsUnsafe([#last(e1, .), #removeLast(e1, .)], E)
              => #listContainsUnsafe([e1:.], E)
          #listContainsUnsafe([e1:.], E)
              => #listContainsUnsafe([e1:.], E)
        e2:es2:
          #listContainsUnsafe([#last(e1, e2:es2), #removeLast(e1, e2:es2)], E)
              => #listContainsUnsafe([e1:e2:es2], E)
          #listContainsUnsafe([#last(e2, es2), e1, #removeLast(e2, es2)], E)
              => #listContainsUnsafe([e1:e2:es2], E)
          case E == last(e2, es2):
            True:
              true => #listContainsUnsafe([e1:e2:es2], E)
              case e == e1:
                True:
                  true => true
                False:
                  true => #listContainsUnsafe([e2:es2], E)
                  [induction
                    #listContainsUnsafe([last(e2, es2), removeLast(e2, es2)], E:Expression)
                        => #listContainsUnsafe([e2, es2], E)
                    true => #listContainsUnsafe([e2, es2], E)
                  ]
            False:
              #listContainsUnsafe([e1, #removeLast(e2, es2)], E)
                  => #listContainsUnsafe([e1:e2:es2], E)
              case e == e1:
                True:
                  true => true
                False:
                  #listContainsUnsafe([#removeLast(e2, es2)], E)
                      => #listContainsUnsafe([e2:es2], E)
                  [induction
                    #listContainsUnsafe([last(e2, es2), removeLast(e2, es2)], E:Expression)
                        => #listContainsUnsafe([e2, es2], E)
                    #listContainsUnsafe([removeLast(e2, es2)], E:Expression)
                        => #listContainsUnsafe([e2, es2], E)
                  ]
 */
