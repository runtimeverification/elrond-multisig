require "protocol-correctness/lib/language/base-types.k"

module NAMED-LEMMAS-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaListContainsUnsafeListToMapSetSquareBracket3(
                      contained:Expression,
                      container:ExpressionList,
                      Expression,
                      eDelete:Expression,
                      diffList:ExpressionList)
endmodule

module NAMED-LEMMAS-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET
  imports NAMED-LEMMAS-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX

  rule lemmaListContainsUnsafeListToMapSetSquareBracket3(
            _:Expression,
            _:ExpressionList,
            _:Expression,
            _:Expression,
            _:ExpressionList)
      => .K
endmodule

