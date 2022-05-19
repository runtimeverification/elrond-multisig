require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP

  syntax KItem ::= lemmaCountCanSignListToMapSetSquareBracket3(
                      container1:ExpressionList,
                      container2:ExpressionList,
                      countmap:Map,
                      toadd1:Expression,
                      toadd2:Expression,
                      todelete:Expression)
endmodule

module NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX

  imports INDUCTION-SYNTAX

  rule lemmaCountCanSignListToMapSetSquareBracket3(
                      [Es1:ExpressionCSV],
                      [Es2:ExpressionCSV],
                      M:Map,
                      E1:Expression,
                      E2:Expression,
                      EDelete:Expression)
      => induction(
        case "m" of
          | . -> .Induction .
          | "m1"["k" <- "v"] ->
            call $castNoValue("v", $rUserRole())
            ~~> call $castNoValue("k", $rUsize())
            ~~> call $lemmaListContainsUnsafeChangeList3
                          ("k", "e1", "e2", "edelete", "es1", "es2")
            ~~> call $lemmaCountCanSignListToMapSetSquareBracket3
                          ("e1", "es1", "e2", "edelete", "es2", "m1")
            .
        esac,
        ("e1", E1)
            <> ("es1", Es1)
            <> ("e2", E2)
            <> ("edelete", EDelete)
            <> ("es2", Es2)
            <> ("m", M)
      )

  rule  reflectionApply($lemmaCountCanSignListToMapSetSquareBracket3,
            ( reflectionArgument(E1:Expression)
            , reflectionArgument(Es1:ExpressionCSV)
            , reflectionArgument(E2:Expression)
            , reflectionArgument(EDelete:Expression)
            , reflectionArgument(Es2:ExpressionCSV)
            , reflectionArgument(M:Map)
            )
        )
    => lemmaCountCanSignListToMapSetSquareBracket3
            ([Es1], [Es2], M, E1, E2, EDelete)
endmodule
