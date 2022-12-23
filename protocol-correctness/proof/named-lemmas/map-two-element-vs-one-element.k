require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"

module NAMED-LEMMA-MAP-TWO-ELEMENT-VS-ONE-ELEMENT-SYNTAX
  imports MAP

  syntax KItem ::= lemmaMapTwoElementVsOneElement(
                      k1:KItem, v1:KItem, k2:KItem, v2:KItem, m:Map)
endmodule

module NAMED-LEMMA-MAP-TWO-ELEMENT-VS-ONE-ELEMENT
  imports NAMED-LEMMA-MAP-TWO-ELEMENT-VS-ONE-ELEMENT-SYNTAX

  imports INDUCTION-SYNTAX

  rule lemmaMapTwoElementVsOneElement(K1:KItem, V1:KItem, K2:KItem, V2:KItem, M:Map)
    => induction(
        .Induction,
        ("k1", K1) <> ("v1", V1) <> ("k2", K2) <> ("v2", V2) <> ("m", M)
      )

  rule  reflectionApply($lemmaMapTwoElementVsOneElement,
            ( reflectionArgument(K1:KItem)
            , reflectionArgument(V1:KItem)
            , reflectionArgument(K2:KItem)
            , reflectionArgument(V2:KItem)
            , reflectionArgument(M:Map)
            )
        )
    => lemmaMapTwoElementVsOneElement(K1, V1, K2, V2, M)
endmodule
