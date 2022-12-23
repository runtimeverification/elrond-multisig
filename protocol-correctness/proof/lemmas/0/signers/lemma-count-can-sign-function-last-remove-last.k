// breadth = 1
//@ proof
module LEMMA-COUNT-CAN-SIGN-FUNCTION-LAST-REMOVE-LAST
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/remove-last.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-LAST-REMOVE-LAST
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
        .Induction,
        ("e", E:Usize) <> ("es", Es:ExpressionCSV) <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      countCanSignFunction 
        ( [ #last ( E , Es:ExpressionCSV ) 
          , #removeLast ( E , Es:ExpressionCSV ) 
          ]
        , UserIdToRole:Map 
        )
      => countCanSignFunction([E, Es], UserIdToRole)
    requires
      true
    [simplification]
    endlemma

endmodule