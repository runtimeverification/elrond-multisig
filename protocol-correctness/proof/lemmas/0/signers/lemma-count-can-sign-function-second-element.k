// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-FUNCTION-SECOND-ELEMENT
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-SECOND-ELEMENT
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports MAP

  lemma
      induction(
        .Induction,
        ("e1", E1:Expression) <> ("e2", E2:Expression) <> ("es", Es:ExpressionCSV) <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction
        ( [ E1:Expression, E2:Expression, Es:ExpressionCSV ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E1, Es], UserIdToRole)
    requires
      notBool E2 in_keys(UserIdToRole)
    [simplification]
    endlemma

endmodule