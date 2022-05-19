// breadth = 3
//@ proof
module LEMMA-COUNT-CAN-SIGN-MAP-EMPTY
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP-EMPTY
//@ end

  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            call $castNoValue("e1", $rUsize())
            ~~> reinduction("es1")
            .
        esac,
        ("es", Es:ExpressionCSV)
      ) => .K
    proves
      countCanSignFunction( [ Es:ExpressionCSV ], .Map ) => 0
    requires
      true
      andBool isKResultExpressionCSV(Es)
      andBool listElementsAreUsize([Es])
    [simplification]
    endlemma

endmodule

/*
countCanSignFunction(L, .Map) ==K 0

case L1 of
  . ->
    countCanSignFunction(., .Map) ==K 0
    ok
  E <> L1 ->
    countCanSignFunction(E <> L1, .Map) ==K 0
    countCanSignFunction(L1, .Map) ==K 0
    induction(L1, .Map)
*/
