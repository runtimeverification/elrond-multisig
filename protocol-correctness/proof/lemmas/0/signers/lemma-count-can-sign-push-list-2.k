// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-PUSH-LIST-2
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/lib/functions/push-list.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-PUSH-LIST-2
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports PUSH-LIST-SYNTAX
  imports MAP

  lemma
      induction(
        .Induction,
        ("e", E:Expression)
          <> ("e1", E1:Expression)
          <> ("es", Es:ExpressionCSV)
          <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction
        ( [ E1:Expression, #pushList(Es:ExpressionCSV, E:Expression) ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E1, E, Es], UserIdToRole)
    requires
      true
    [simplification]
    endlemma

endmodule