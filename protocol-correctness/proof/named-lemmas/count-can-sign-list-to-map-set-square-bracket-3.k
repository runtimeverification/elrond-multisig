require "protocol-correctness/lib/language/base-types.k"

module NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP

  syntax KItem ::= lemmaCountCanSignListToMapSetSquareBracket3(
                      ExpressionList,
                      ExpressionList,
                      Map,
                      Expression,
                      Expression,
                      Expression)
endmodule

module NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX

  rule lemmaCountCanSignListToMapSetSquareBracket3(
                      _:ExpressionList,
                      _:ExpressionList,
                      _:Map,
                      _:Expression,
                      _:Expression,
                      _:Expression)
      => .K
endmodule
