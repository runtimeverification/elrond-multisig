require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaListContainsUnsafeListToMapSetSquareBracket3(
                      contained:Expression,
                      container:ExpressionList,
                      Expression,
                      eDelete:Expression,
                      diffList:ExpressionList)
endmodule

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX

  imports INDUCTION-SYNTAX

  rule lemmaListContainsUnsafeListToMapSetSquareBracket3(
            E:Expression,
            L:ExpressionList,
            E1:Expression,
            EDelete:Expression,
            L2:ExpressionList)
      => induction(
        call $lemmaInKeysSquareBracketSquareBracket($listToMapSet("l2"), "e", "e1")
        ~~> call $lemmaInKeysSubstitution
                  ( "e"
                  , $mapDelete
                      ( $mapUpdate($listToMapSet("l"), "e1", 0)
                      , "edelete"
                      )
                  , "e"
                  , $mapDelete
                      ( $mapUpdate
                          ( $mapUpdate($listToMapSet("l2"), "e", 0)
                          , "e1"
                          , 0
                          )
                      , "edelete"
                      )
                  , true
                  ),
        ("e", E) <> ("l", L) <> ("e1", E1) <> ("edelete", EDelete) <> ("l2", L2)
      )
endmodule

