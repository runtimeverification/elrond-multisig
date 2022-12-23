// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-FUNCTION-ELEMENT-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-ELEMENT-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX

  lemma
      induction(
        .Induction,
        ("e", E:Expression) <> ("es", Es:ExpressionCSV) <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction
        ( [ E:Expression, lastToStart(Es:ExpressionCSV) ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E, Es], UserIdToRole)
    requires
      true
    [simplification]
    endlemma

endmodule