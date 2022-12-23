// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-2-ELEMENTS-SWAP-REMOVE-FIND-UNSAFE-NOT-IN-KEYS
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-2-ELEMENTS-SWAP-REMOVE-FIND-UNSAFE-NOT-IN-KEYS
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports MAP

  lemma
      induction(
        .Induction,
        ("e", E:Expression)
          <> ("e1", E1:Expression)
          <> ("e2", E2:Expression)
          <> ("es", Es:ExpressionCSV)
          <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction
        ( [ E1:Expression
          , E2:Expression
          , #listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], E:Expression))
          ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E1, E2, Es], UserIdToRole)
    requires
      true
      andBool notBool E in_keys(UserIdToRole)
    [simplification]
    endlemma

endmodule