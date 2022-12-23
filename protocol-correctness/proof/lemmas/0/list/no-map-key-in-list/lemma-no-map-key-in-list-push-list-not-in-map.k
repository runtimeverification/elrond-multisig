// breadth = 2
//@ proof
module LEMMA-NO-MAP-KEY-IN-LIST-PUSH-LIST-NOT-IN-MAP
  imports INDUCTION-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/no-map-key-in-list.k"
// require "protocol-correctness/lib/functions/push-list.k"
// 
// module TRUSTED-LEMMA-NO-MAP-KEY-IN-LIST-PUSH-LIST-NOT-IN-MAP
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP
  imports NO-MAP-KEY-IN-LIST-SYNTAX
  imports PUSH-LIST-SYNTAX

  lemma
      induction(
          .Induction,
          ("m", M:Map) <> ("e1", E1:Expression) <> ("e2", E2:Expression)
          <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      noMapKeyInList
          ( M:Map
          , [ E1:Expression
            , #pushList(Es:ExpressionCSV, E2:Expression)
            ]
          )
      => noMapKeyInList
          ( M
          , [ E1:Expression, Es:ExpressionCSV ]
          )
    requires
      notBool E2 in_keys(M)
    [simplification]
    endlemma

endmodule
