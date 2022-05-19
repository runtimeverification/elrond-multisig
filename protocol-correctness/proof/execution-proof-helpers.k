require "protocol-correctness/lib/functions/all-keys-become-keys.k"
require "protocol-correctness/lib/functions/list-elements-are-usize.k"
require "protocol-correctness/lib/functions/list-elements-are-distinct.k"
require "protocol-correctness/lib/functions/list-to-map-set.k"
require "protocol-correctness/lib/functions/map-included.k"
require "protocol-correctness/lib/functions/map-keys-are-below-limit.k"
require "protocol-correctness/lib/functions/map-values-are-below-limit.k"
require "protocol-correctness/lib/functions/map-values-become-keys.k"
require "protocol-correctness/lib/functions/no-map-key-in-list.k"
require "protocol-correctness/lib/functions/push-list.k"
require "protocol-correctness/lib/functions/value-not-in-map-values.k"
require "protocol-correctness/lib/language/cast.k"
require "protocol-correctness/lib/proof/unsorted/formula-expansion.k"

require "protocol-correctness/proof/base.k"
require "protocol-correctness/proof/map/map-execute.k"
require "protocol-correctness/pseudocode.k"

module EXECUTION-PROOF-HELPERS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
endmodule

module EXECUTION-PROOF-HELPERS
  imports EXECUTION-PROOF-HELPERS-SYNTAX

  imports MAP-SYMBOLIC
  imports SET

  imports PSEUDOCODE
  imports MAP-EXECUTE

  imports CAST-SYNTAX
  imports EXPLICIT-KITEM-INJECTION
  imports FORMULA-EXPANSION-SYNTAX
  imports LAST-TO-START-SYNTAX
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE
  imports LIST-ELEMENTS-ARE-DISTINCT
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP-INCLUDED-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-BECOME-KEYS-ADDITIONAL-SYNTAX
  imports MAP-VALUES-ARE-BELOW-LIMIT-ADDITIONAL-SYNTAX
  imports NO-MAP-KEY-IN-LIST-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports PUSH-LIST-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-SYNTAX
  imports VALUE-NOT-IN-MAP-VALUES-SYNTAX

  imports ALL-KEYS-BECOME-KEYS

  // Override the default behaviour.
  rule isDefaultValue(E:ExpressionList, rExpressionList)
      => notBool (pListLen(E) >Int 0)
  rule pListLen([#pushList(_, _)]) >Int 0 => true
      [simplification]

  rule listElementsAreDistinctUnsafe([removeLast(L:ExpressionCSV)]) => true
    requires listElementsAreDistinctUnsafe([L])
    [simplification]
  rule listElementsAreDistinctUnsafe([#removeLast(E:Expression, L:ExpressionCSV)]) => true
    requires listElementsAreDistinctUnsafe([E, L])
    [simplification]

  rule forall-v-greater-or-equal-than-u-v-not-in-m(_:Usize, .Map, _:ExpressionList)
      => true  [simplification]

  rule listElementsAreDistinctUnsafe([#pushList(L:ExpressionCSV, E:Expression)])
      => listElementsAreDistinctUnsafe([L])
    requires notBool #listContainsSafe([L], E)
    [simplification]
  rule listElementsAreDistinctUnsafe([#listSwapRemove(L:ExpressionCSV, _:Int)])
      => true
    requires listElementsAreDistinctUnsafe([L])
    [simplification]
  rule listElementsAreDistinctUnsafe([lastToStart(L:ExpressionCSV) => L])
    [simplification]

  rule valueNotInMapValues(u(X:Int +Int 4), M:Map) => true
    requires #mapValuesAreBelowLimit(X +Int 3, M, expanded)
    [simplification]

  rule mapValuesAreBelowLimit(Index:Int, M:Map, Handling:PropertyHandling)
      => true
        andBool valueNotInMapValues(u(Index), M)
        andBool #mapValuesAreBelowLimit(Index, M, Handling)
    [simplification(50)]

  rule #mapValuesAreBelowLimit(Index:Int, M:Map, expand(Expand:Expand))
      =>  mapValuesAreBelowLimit(Index +Int 1, M, Expand)
    [simplification(50)]

  rule #mapValuesAreBelowLimit(X:Int, M:Map, usesExpanded)
      => true
    requires false
      orBool #mapValuesAreBelowLimit(X, M, expanded)
      orBool (true
          andBool valueNotInMapValues(u(X), M)
          andBool #mapValuesAreBelowLimit(X +Int 1, M, expanded)
      )
      orBool (true
          andBool valueNotInMapValues(u(X), M)
          andBool valueNotInMapValues(u(X +Int 1), M)
          andBool #mapValuesAreBelowLimit(X +Int 2, M, expanded)
      )
    [simplification]

  rule #mapValuesAreBelowLimit(X:Int +Int 4, M:Map, expanded)
      => true
    requires #mapValuesAreBelowLimit(X +Int 3, M, expanded)
    [simplification]
  rule #mapValuesAreBelowLimit(X:Int +Int 2, M:Map, expanded)
      => true
    requires true
      andBool #mapValuesAreBelowLimit(X +Int 3, M, expanded)
      andBool valueNotInMapValues(u(X +Int 2), M)
    [simplification]

  rule #mapValuesBecomeKeys(M:Map, K |-> _ N:Map) => true
    requires #mapValuesBecomeKeys(M, N)
    ensures notBool K in_keys(N)
    [simplification]

  rule #mapValuesBecomeKeys(M:Map, keysMap(N:Map)) => true requires mapsAreReverseHalf(M, N)
    [simplification]

  rule mapIncluded(M:Map, M:Map) => true
    [simplification]
  rule mapIncluded(M1:Map, _:KItem |-> _:KItem M2:Map) => true
    requires M1 ==K M2
    [simplification]
  // Not sure why this does not work instead of the above:
  rule mapIncluded(M:Map, _:KItem |-> _:KItem M:Map) => true
    [simplification]

  rule X:Int -Int X:Int => 0  [simplification]
  // Int addition normalization
  rule X:Int +Int (Y:Int +Int Z:Int) => (X +Int Y) +Int Z  [simplification]
  // rule (X:Int +Int Y:Int) => (Y +Int X)  [simplification, concrete(X), symbolic(Y)]
  rule (A:Int +Int I:Int) +Int B:Int => (A +Int B) +Int I [simplification, concrete(I), symbolic(A,B)]
  //rule (X:Int +Int Y:Int) +Int Z:Int => X +Int (Y +Int Z) [simplification, concrete(Y), concrete(Z)]

  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int, M:Map, expand(Expand:Expand))
    => notBool u(LastIndex) in_keys(M)  // TODO: Maybe check before wrapping
      andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 1, M, Expand)
    [simplification]

  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int +Int 4, M:Map, expanded)
    => true
    requires mapKeysAreBelowLimitUnsafe(LastIndex +Int 3, M, expanded)
    [simplification]
  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int +Int 2, M:Map, expanded)
    => true
    requires true
      andBool notBool u(LastIndex +Int 2) in_keys(M)
      andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 3, M, expanded)
    [simplification]

  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int, M:Map, usesExpanded)
    => true
    requires false
      orBool mapKeysAreBelowLimitUnsafe(LastIndex, M, expanded)
      orBool (true
        andBool notBool u(LastIndex) in_keys(M)
        andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 1, M, expanded)
      )
      orBool (true
        andBool notBool u(LastIndex) in_keys(M)
        andBool notBool u(LastIndex +Int 1) in_keys(M)
        andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 2, M, expanded)
      )
    [simplification]

  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int +Int 1, keysMap(M):Map, usesExpanded)
    => true
    requires true
        andBool notBool u(LastIndex +Int 1) in_keys(M)
        andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 2, keysMap(M), expanded)
    [simplification]

  /*
  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int +Int 1, M:Map, usesExpanded)
    => true
    requires notBool u(LastIndex +Int 1) in_keys(M)
      andBool mapKeysAreBelowLimitUnsafe(LastIndex +Int 2, M, expanded)
    [simplification]
  */

  // syntax Bool ::= unusedIdsInMapValues(lastIndex:Int, Map, handling:PropertyHandling)  [function, functional]
  // rule unusedIdsInMapValues(_:Int, .Map, _:PropertyHandling) => true
  // rule unusedIdsInMapValues(
  //         LastIndex:Int,
  //         (_:KItem |-> Value:Usize M:Map) #as _:Map,
  //         Handling:PropertyHandling
  //     )
  //     => unusedIdsInMapValues(LastIndex, M, Handling)
  //     andBool LastIndex >Int usizeToInt(Value)
  //   [simplification(10)]
  // rule unusedIdsInMapValues(LastIndex:Int, M:Map, expand(_:Expand))
  //     => unusedIdsInMapValues(LastIndex, M, expanded)

  // rule unusedIdsInMapValues(LastIndex:Int +Int 3, M:Map, _:PropertyHandling)
  //     => true
  //   requires unusedIdsInMapValues(LastIndex +Int 2, M, expanded)
  //   [simplification]

  // rule unusedIdsInMapValues(LastIndex:Int, M:Map, usesExpanded)
  //     => true
  //   requires false
  //     orBool unusedIdsInMapValues(LastIndex -Int 1, M, expanded)
  //     orBool unusedIdsInMapValues(LastIndex, M, expanded)
  //   [simplification]

  rule noMapKeyInList((K:KItem |-> _:KItem M:Map) #as _:Map, L:ExpressionList)
    => true
      andBool notBool #listContainsSafe(L, K)
      andBool noMapKeyInList(M, L)
    [simplification]
  rule noMapKeyInList(M:Map, [#pushList(L:ExpressionCSV, E:Expression)])
    => true
    requires noMapKeyInList(M, [L])
      andBool notBool E in_keys(M)
    [simplification]

  rule X:KItem in_keys(keysMap(M:Map)) => X in_keys(M)
    [simplification]

  rule #Ceil(@M:Map (@K:KItem |-> @V:KItem))
      =>  {(@K in_keys(@M)) #Equals false}
          #And #Ceil(@M)
          #And #Ceil(@K)
          #And #Ceil(@V)
    [anywhere, simplification(20)]

  rule countCanSignFunction([#pushList(Es:ExpressionCSV, UserId:Usize)], UserId |-> Role:UserRole M:Map)
      => 1 +Int countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires canSignFunction(Role)
    [simplification]
  rule countCanSignFunction([#pushList(Es:ExpressionCSV, UserId:Usize)], UserId |-> Role:UserRole M:Map)
      => countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires notBool canSignFunction(Role)
    [simplification]

  rule 0 <=Int countCanSignFunction(_, _) => true  [simplification, smt-lemma]

  rule isKResult(toExpressionListOrDefault(K:KItem, L:ExpressionList)) => true
    requires isKResult(K) andBool isKResult(L)
    [simplification]
  rule isKResultExpressionList(toExpressionListOrDefault(K:KItem, L:ExpressionList)) => true
    requires isKResult(K) andBool isKResult(L)
    [simplification]

  rule pListLen([#pushList(Es:ExpressionCSV, E:Expression)]) => pListLen([E, Es])
    [simplification]
  rule listElementsAreDistinctUnsafe([#pushList(Es:ExpressionCSV, E:Expression)])
      => listElementsAreDistinctUnsafe([E, Es]) 
    [simplification]
  rule listToMapSet([#pushList(Es:ExpressionCSV, E:Expression)])
      => listToMapSet([E, Es])
    [simplification]
  rule #listContainsUnsafe([#pushList(Es:ExpressionCSV, E1:Expression)], E2:Expression)
      => #listContainsUnsafe([E1, Es], E2)
    [simplification]
  rule #listContainsUnsafe([E:Expression, #pushList(Es:ExpressionCSV, E1:Expression)], E2:Expression)
      => #listContainsUnsafe([E, E1, Es], E2)
    [simplification]
  rule #listContainsUnsafe([E1:Expression, E2:Expression, Es:ExpressionCSV], E:Expression)
      => #listContainsUnsafe([E1, Es], E)
    requires E2 =/=K E
    [simplification]

  rule mapKeysAreOfType(keysMap(M:Map) => M, rUsize)
    [simplification]

endmodule
