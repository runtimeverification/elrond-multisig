require "protocol-correctness/lib/language/map-utils.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/proof/instrumentation-proof.k"

module NAMED-LEMMAS-SYNTAX
  imports BOOL
  imports MAP

  syntax KItem ::= lemmaCommuteMapSquareBracketAssignmentSameValue(Map, key1:KItem, key2:KItem, value:KItem)
  syntax KItem ::= lemmaSquareBracketSubstitution(
            m1:Map, k1:KItem, v1:KItem, m2:Map, k2:KItem, v2:KItem, Bool)
  syntax KItem ::= lemmaEqualityTransitivity(KItem, KItem, KItem)
  syntax KItem ::= lemmaImplies(Bool, Bool)
endmodule

module NAMED-LEMMAS
  imports INSTRUMENTATION-PROOF
  imports MAP-UTILS-SYNTAX
  imports NAMED-LEMMAS-SYNTAX
  imports REFLECTION-SYNTAX

  rule lemmaCommuteMapSquareBracketAssignmentSameValue(M:Map, K1:KItem, K2:KItem, V:KItem)
      =>  branchK(K1 ==K K2,
            .K,
            branchK(K1 in_keys(M),
                concretizeMapKey(K1, M),
                .K
              )
            ~> branchK(K2 in_keys(M),
                concretizeMapKey(K2, M),
                .K
              )
          )

  rule reflectionApply($lemmaCommuteMapSquareBracketAssignmentSameValue,
          ( reflectionArgument(M:Map)
          , reflectionArgument(K1:KItem)
          , reflectionArgument(K2:KItem)
          , reflectionArgument(V:KItem)))
    => lemmaCommuteMapSquareBracketAssignmentSameValue(M, K1, K2, V)


  rule lemmaSquareBracketSubstitution(
            _:Map, _:KItem, _:KItem, _:Map, _:KItem, _:KItem, true)
      => .K
  rule lemmaSquareBracketSubstitution(
            _:Map, _:KItem, _:KItem, _:Map, _:KItem, _:KItem, false)
      => .K

  rule reflectionApply($lemmaSquareBracketSubstitution,
          ( reflectionArgument(M:Map)
          , reflectionArgument(K1:KItem)
          , reflectionArgument(V1:KItem)
          , reflectionArgument(N:Map)
          , reflectionArgument(K2:KItem)
          , reflectionArgument(V2:KItem)
          , reflectionArgument(B:Bool)))
    => lemmaSquareBracketSubstitution(M, K1, V1, N, K2, V2, B)


  rule lemmaEqualityTransitivity(_:KItem, _:KItem, _:KItem) => .K

  rule reflectionApply($lemmaEqualityTransitivity,
          ( reflectionArgument(A:KItem)
          , reflectionArgument(B:KItem)
          , reflectionArgument(C:KItem)))
    => lemmaEqualityTransitivity(A, B, C)


  rule lemmaImplies(A:Bool, _:Bool) => concretizeValue(A)

  rule reflectionApply($lemmaEqualityTransitivity,
          ( reflectionArgument(A:Bool)
          , reflectionArgument(B:Bool)))
    => lemmaImplies(A, B)

endmodule