require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET-SYNTAX
  imports MAP

  syntax KItem ::= lemmaInKeysSquareBracketSquareBracket(Map, tofind:KItem, toadd:KItem)
endmodule

module NAMED-LEMMA-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET
  imports INDUCTION-SYNTAX
  imports NAMED-LEMMA-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET-SYNTAX

  rule lemmaInKeysSquareBracketSquareBracket(M:Map, E:KItem, E1:KItem)
    =>
      induction(
          case "e" == "e1" of
            | False -> .Induction .
            | True -> .Induction .
          esac,
          ("m", M) <> ("e", E) <> ("e1", E1)
        )

  rule reflectionApply($lemmaInKeysSquareBracketSquareBracket,
          ( reflectionArgument(M:Map)
          , reflectionArgument(K1:KItem)
          , reflectionArgument(K2:KItem)))
    => lemmaInKeysSquareBracketSquareBracket(M, K1, K2)
endmodule
