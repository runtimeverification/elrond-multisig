// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-2-ELEMENT-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports INDUCTION-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-2-ELEMENT-SWAP-REMOVE-FIND-UNSAFE-NEQ
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports K-EQUAL-SYNTAX

  lemma
      induction(
        case "e" == "e1" of
          | True -> .Induction .
          | False -> .Induction .
        esac,
        ("e", E:Expression)
          <> ("e1", E1:Expression)
          <> ("e2", E2:Expression)
          <> ("er", Er:Expression)
          <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ E1:Expression
          , E2:Expression
          , #listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], Er))
          ]
        , E:Expression 
        )
      => #listContainsUnsafe([E1, E2, Es], E)
    requires
      true
      andBool E =/=K Er
    [simplification]
    endlemma

endmodule

/*
  #listContainsUnsafe([E1, E2, #listSwapRemove(Es, #listFindUnsafe([Es], Er))], E)
      => #listContainsUnsafe([E1, E2, Es], E)
    requires E =/= Er

  case E1 == E:
    True -> Ok.
    False ->
      #listContainsUnsafe([E2, #listSwapRemove(Es, #listFindUnsafe([Es], Er))], E)
          => #listContainsUnsafe([E2, Es], E)
        requires E =/= Er
      LEMMA-LIST-CONTAINS-UNSAFE-1-ELEMENT-SWAP-REMOVE-FIND-UNSAFE-NEQ
*/