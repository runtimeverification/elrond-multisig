// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-PUSH-LIST
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/lib/functions/push-list.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-PUSH-LIST
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports PUSH-LIST-SYNTAX
  imports MAP

  lemma
      induction(
        .Induction,
        ("e", E:Expression)
          <> ("es", Es:ExpressionCSV)
          <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction
        ( [ #pushList(Es:ExpressionCSV, E:Expression) ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E, Es], UserIdToRole)
    requires
      true
    [simplification]
    endlemma

endmodule