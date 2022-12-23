require "protocol-correctness/lib/functions/concretize-expression-list.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-LIST-TO-MAP-SET-CONCRETIZE-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaListToMapSetConcretize(
                      ExpressionCSV, toAdd:Expression, toDelete:Expression)
endmodule

module NAMED-LEMMA-LIST-TO-MAP-SET-CONCRETIZE
  imports NAMED-LEMMA-LIST-TO-MAP-SET-CONCRETIZE-SYNTAX

  imports CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports INDUCTION-SYNTAX

  rule lemmaListToMapSetConcretize(
            Es:ExpressionCSV, ToAdd:Expression, ToRemove:Expression)
      => induction(
          case $firstOrDefault("es", "toremove") == "toremove" of
            | True ->
              case "es" of
                | . -> .Induction .
                | "e1" <> "es1" ->
                  call $lemmaListContainsUnsafeToInKeys
                          ( $firstOrDefault("es1", "e1")
                          , $removeFirstOrDefault("es1", "es1")
                          )
                  ~~> case "es1" of
                    | . -> .Induction .
                    | "e2" <> "es2" -> .Induction .
                  esac
                  .
              esac
              .
            | False ->
              case "es" of
                | . -> .Induction .
                | "e1" <> "es1" -> .Induction .
              esac
              .
          esac,
          ("toadd", ToAdd:Expression)
            <> ("toremove", ToRemove:Expression)
            <> ("es", Es:ExpressionCSV)
        )
endmodule
