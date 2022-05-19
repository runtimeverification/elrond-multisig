require "protocol-correctness/lib/functions/list-to-map-set.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/proof/named-lemmas/in-keys-substitution.k"
require "protocol-correctness/proof/named-lemmas/list-contains-unsafe-to-in-keys.k"

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaListContainsUnsafeChangeList3
                      ( e:KItem
                      , e1:KItem
                      , e2:KItem
                      , edelete:KItem
                      , ExpressionCSV
                      , ExpressionCSV
                      )
endmodule

module NAMED-LEMMA-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3-SYNTAX

  imports LIST-TO-MAP-SET-SYNTAX
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX
  imports NAMED-LEMMA-IN-KEYS-SUBSTITUTION-SYNTAX
  imports REFLECTION-SYNTAX

  rule lemmaListContainsUnsafeChangeList3
          ( E:KItem
          , E1:KItem
          , E2:KItem
          , EDelete:KItem
          , Es1:ExpressionCSV
          , Es2:ExpressionCSV
          )
    =>    lemmaListContainsUnsafeToInKeys(E, Es1)
      ~>  lemmaListContainsUnsafeToInKeys(E, Es2)
      ~>  lemmaInKeysSubstitution
              ( E
              , listToMapSet([Es1])[E2 <- 0][EDelete <- undef]
              , E
              , listToMapSet([Es2])[E1 <- 0][E2 <- 0][EDelete <- undef]
              , true
              )

  rule  reflectionApply($lemmaListContainsUnsafeChangeList3,
            ( reflectionArgument(E:KItem)
            , reflectionArgument(E1:KItem)
            , reflectionArgument(E2:KItem)
            , reflectionArgument(EDelete:KItem)
            , reflectionArgument(Es1:ExpressionCSV)
            , reflectionArgument(Es2:ExpressionCSV)
            )
        )
    => lemmaListContainsUnsafeChangeList3(E, E1, E2, EDelete, Es1, Es2)
endmodule
