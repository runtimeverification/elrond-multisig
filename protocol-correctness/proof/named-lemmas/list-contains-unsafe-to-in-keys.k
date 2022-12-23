require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaListContainsUnsafeToInKeys(KItem, ExpressionCSV)
endmodule

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX

  imports INDUCTION-SYNTAX

  rule lemmaListContainsUnsafeToInKeys(E:KItem, Es:ExpressionCSV)
    => induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            case "e" == "e1" of
              | True -> .Induction .
              | False -> call $lemmaListContainsUnsafeToInKeys("e", "es1") .
            esac
            .
        esac,
        ("e", E) <> ("es", Es)
      )

  rule  reflectionApply($lemmaListContainsUnsafeToInKeys,
            ( reflectionArgument(E:KItem)
            , reflectionArgument(Es:ExpressionCSV)
            )
        )
    => lemmaListContainsUnsafeToInKeys(E, Es)
  rule  reflectionApply($lemmaListContainsUnsafeToInKeys,
            ( reflectionArgument(E:KItem)
            , reflectionArgument([Es:ExpressionCSV])
            )
        )
    => lemmaListContainsUnsafeToInKeys(E, Es)
endmodule
