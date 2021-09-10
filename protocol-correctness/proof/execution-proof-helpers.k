require "protocol-correctness/lib/all-keys-become-keys.k"
require "protocol-correctness/lib/list-elements-are-usize.k"
require "protocol-correctness/lib/list-elements-are-distinct.k"
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
  imports EXPLICIT-KITEM-INJECTION
  imports LIST-ELEMENTS-ARE-USIZE
  imports LIST-ELEMENTS-ARE-DISTINCT

  imports ALL-KEYS-BECOME-KEYS

  // Expand and PropertyHandling form a stupid trick used to control symbolic
  // function application.
  // Any function that receives them as an argument should not depend on them,
  // i.e it should have the same value for all possible PropertyHandling values.
  syntax Expand ::= "expanded" | expand(Expand)
  syntax PropertyHandling ::= "usesExpanded" | Expand
  // TODO: Delete above or below.
  syntax Int ::= expand(Int)  [function, functional, no-evaluators]
  syntax Int ::= "usesExpanded"  [function, functional, no-evaluators]

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

  syntax Bool ::= noCommonItem(Usize, Map, ExpressionList)  [function, functional]
  rule noCommonItem(_:Usize, _:Map, [.]) => true
  rule noCommonItem(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV])
      =>  notBool (E in_keys(M))
          andBool noCommonItem(add(U, u(1)), (E |-> U) M, [Es])

  syntax Bool ::= noReusedIndexAddress(Usize, Map, ExpressionList)  [function, functional]
  rule noReusedIndexAddress(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule noReusedIndexAddress(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool noReusedIndexAddress(add(U, u(1)), (U |-> E) M, [Es])

  syntax Bool ::= noReusedIndexRole(Usize, Map, ExpressionList)  [function, functional]
  rule noReusedIndexRole(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule noReusedIndexRole(U:Usize, M:Map, [_:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool noReusedIndexRole(add(U, u(1)), (U |-> BoardMember) M, [Es])

  syntax Bool ::= "forall-v-greater-or-equal-than-u-v-not-in-m" "(" Usize "," Map "," ExpressionList ")"   [function, functional]
  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
      =>  notBool U in_keys(M)
  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [_:Expression , Es:ExpressionCSV])
      =>  notBool U in_keys(M)
          andBool forall-v-greater-or-equal-than-u-v-not-in-m(add(U, u(1)), M, [Es])
  rule forall-v-greater-or-equal-than-u-v-not-in-m(_:Usize, .Map, _:ExpressionList)
      => true  [simplification]

  syntax Usize ::= usizeWithDefault(KItem, Usize)  [function, functional]
  rule usizeWithDefault(uninitialized, Default:Usize) => Default
  rule usizeWithDefault(V:Usize, _:Usize) => V

  syntax Int ::= usizeToInt(Usize)  [function, functional]
  rule usizeToInt(u(V:Int)) => V

  syntax Bool ::= listElementsAreAddresses(ExpressionList)  [function, functional]
  rule listElementsAreAddresses([.]) => true
  rule listElementsAreAddresses([E:Expression , Es:ExpressionCSV])
      => isAddress(E) andBool listElementsAreAddresses([Es])

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

  syntax Bool ::= valuesAreExpressionListOfUsize(Map)  [function, functional]
  rule valuesAreExpressionListOfUsize(.Map) => true
  rule valuesAreExpressionListOfUsize((_ |-> V M:Map) #as _:Map)
      =>  isExpressionList(V)
          andBool listElementsAreUsize(V)
          andBool valuesAreExpressionListOfUsize(M)
  rule valuesAreExpressionListOfUsize((_ |-> V M:Map) #as _:Map)
      =>  isExpressionList(V)
          andBool listElementsAreUsize(V)
          andBool valuesAreExpressionListOfUsize(M)
    [simplification]

  syntax Bool ::= valuesAreKResult(Map)  [function, functional]
  rule valuesAreKResult(.Map) => true
  rule valuesAreKResult((_ |-> V M:Map) #as _:Map)
      => isKResult(V) andBool valuesAreKResult(M)
  rule valuesAreKResult((_ |-> V M:Map) #as _:Map)
      => isKResult(V) andBool valuesAreKResult(M)
    [simplification]

  syntax Bool ::= valuesAreOfType(Map, ReflectionType)  [function, functional]
  rule valuesAreOfType(.Map, _:ReflectionType) => true
  rule valuesAreOfType((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(V, T) andBool valuesAreOfType(M, T)
  rule valuesAreOfType((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(V, T) andBool valuesAreOfType(M, T)
    [simplification]

  syntax Bool ::= keysAreKResult(Map)  [function, functional]
  rule keysAreKResult(.Map) => true
  rule keysAreKResult((K:KItem |-> _:KItem M:Map) #as _:Map)
      => isKResult(K) andBool keysAreKResult(M)
  rule keysAreKResult((K:KItem |-> _:KItem M:Map) #as _:Map)
      => isKResult(K) andBool keysAreKResult(M)
    [simplification]

  syntax Bool ::= keysAreOfType(Map, ReflectionType)  [function, functional]
  rule keysAreOfType(.Map, _:ReflectionType) => true
  rule keysAreOfType((K:KItem |-> _:KItem M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(K, T) andBool keysAreOfType(M, T)
  rule keysAreOfType((K:KItem |-> _:KItem M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(K, T) andBool keysAreOfType(M, T)
    [simplification]

  syntax Bool ::= valueIsNotEmpty(KItem, ReflectionType)  [function, functional]
  rule valueIsNotEmpty(V:KItem, T:ReflectionType)
      => notBool (V ==K defaultValue(T))

  syntax Bool ::= valuesAreNotEmpty(Map, ReflectionType)  [function, functional]
  rule valuesAreNotEmpty(.Map, _:ReflectionType) => true
  rule valuesAreNotEmpty((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => valuesAreNotEmpty(M, T) andBool valueIsNotEmpty(V, T)
  rule valuesAreNotEmpty((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => valuesAreNotEmpty(M, T) andBool valueIsNotEmpty(V, T)
    [simplification]

  syntax Bool ::= valuesAreDistinct(Map)  [function, functional]
  rule valuesAreDistinct(.Map) => true
  rule valuesAreDistinct((_:KItem |-> V:KItem M:Map) #as _:Map)
      => valuesAreDistinct(M) andBool valueNotInMapValues(V, M)
    [simplification]

  syntax Bool ::= valueNotInMapValues(KItem, Map)  [function, functional]
  rule valueNotInMapValues(_:KItem, .Map) => true
  rule valueNotInMapValues(V1:KItem, (_:KItem |-> V2:KItem M:Map) #as _:Map)
      => (notBool (V1 ==K V2)) andBool valueNotInMapValues(V1, M)
    [simplification]
  rule valueNotInMapValues(u(X:Int +Int 4), M:Map) => true
    requires #noReusedIndexValue(X +Int 3, M, expanded)
    [simplification]

  syntax Bool ::= noReusedIndexValue(Int, Map, PropertyHandling)  [function, functional]
  syntax Bool ::= #noReusedIndexValue(Int, Map, PropertyHandling)  [function, functional]

  rule noReusedIndexValue(_Index:Int, .Map, _:PropertyHandling) => true

  rule noReusedIndexValue(Index:Int, (_:KItem |-> V:Usize M:Map) #as _:Map, Expand:PropertyHandling)
      => Index >Int usizeToInt(V) andBool noReusedIndexValue(Index, M, Expand)
    [simplification(20)]
  rule noReusedIndexValue(Index:Int, M:Map, Handling:PropertyHandling)
      => true
        andBool valueNotInMapValues(u(Index), M)
        andBool #noReusedIndexValue(Index, M, Handling)
    [simplification(50)]

  rule #noReusedIndexValue(_Index:Int, .Map, expanded) => true
  rule #noReusedIndexValue(Index:Int, (_:KItem |-> V:Usize M:Map) #as _:Map, Expand:PropertyHandling)
      => Index >Int usizeToInt(V) andBool #noReusedIndexValue(Index, M, Expand)
    [simplification(20)]
  rule #noReusedIndexValue(Index:Int, M:Map, expand(Expand:Expand))
      =>  noReusedIndexValue(Index +Int 1, M, Expand)
    [simplification(50)]

  rule #noReusedIndexValue(X:Int, M:Map, usesExpanded)
      => true
    requires false
      orBool #noReusedIndexValue(X, M, expanded)
      orBool (true
          andBool valueNotInMapValues(u(X), M)
          andBool #noReusedIndexValue(X +Int 1, M, expanded)
      )
      orBool (true
          andBool valueNotInMapValues(u(X), M)
          andBool valueNotInMapValues(u(X +Int 1), M)
          andBool #noReusedIndexValue(X +Int 2, M, expanded)
      )
    [simplification]

  rule #noReusedIndexValue(X:Int +Int 4, M:Map, expanded)
      => true
    requires #noReusedIndexValue(X +Int 3, M, expanded)
    [simplification]
  rule #noReusedIndexValue(X:Int +Int 2, M:Map, expanded)
      => true
    requires true
      andBool #noReusedIndexValue(X +Int 3, M, expanded)
      andBool valueNotInMapValues(u(X +Int 2), M)
    [simplification]

  syntax Bool ::= allValuesBecomeKeys(Map, Map)  [function, functional]
  syntax Bool ::= #allValuesBecomeKeys(Map, Map)  [function, functional]

  rule allValuesBecomeKeys(M:Map, N:Map) => #allValuesBecomeKeys(M, keysMap(N))

  rule #allValuesBecomeKeys(.Map, _:Map) => true
  // TODO: This does not work if the key is in the map. Fix it and everything else.
  rule #allValuesBecomeKeys(K |-> V M:Map, N:Map)
      => V in_keys(N) andBool #allValuesBecomeKeys(M, N)
    ensures notBool K in_keys(M)
    [simplification]
  rule #allValuesBecomeKeys(M:Map, K |-> _ N:Map) => true
    requires #allValuesBecomeKeys(M, N)
    ensures notBool K in_keys(N)
    [simplification]

  rule #allValuesBecomeKeys(M:Map, keysMap(N:Map)) => true requires mapsAreReverseHalf(M, N)
    [simplification]

  syntax Bool ::= mapsAreReverse(Map, Map) [function, functional]
  syntax Bool ::= mapsAreReverseHalf(Map, Map) [function, functional]

  rule mapsAreReverse(M:Map, N:Map)
      => mapsAreReverseHalf(M, N) andBool mapsAreReverseHalf(N, M)

  rule mapsAreReverseHalf(.Map, _:Map) => true
  rule mapsAreReverseHalf((K:KItem |-> V:KItem M:Map) #as _:Map, N:Map)
      => V in_keys(N) andBool N[V] ==K K andBool mapsAreReverseHalf(M, N)
    [simplification]
  rule mapsAreReverseHalf(M:Map, (K:KItem |-> V:KItem N:Map) #as _:Map)
      => M[V] orDefault K ==K K andBool mapsAreReverseHalf(M[V <- undef], N)
    [simplification]

  syntax Bool ::= mapIncluded(Map, Map) [function, functional]

  rule mapIncluded(.Map, _:Map) => true
  rule mapIncluded((K:KItem |-> V:KItem M:Map) #as _:Map, N:Map)
      => K in_keys(N) andBool N[K] ==K V andBool mapIncluded(M, N)
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

  syntax Bool ::= unusedIdsInMapKeys(lastIndex:Int, Map, expand:PropertyHandling)  [function, functional]

  rule unusedIdsInMapKeys(_:Int, .Map, _:PropertyHandling) => true
  rule unusedIdsInMapKeys(LastIndex:Int, (U:Usize |-> _:KItem M:Map) #as _:Map, Handling:PropertyHandling)
    => unusedIdsInMapKeys(LastIndex, M, Handling)
      andBool LastIndex >Int usizeToInt(U)
    [simplification(30)]
  rule unusedIdsInMapKeys(LastIndex:Int, M:Map, expand(Expand:Expand))
    => notBool u(LastIndex) in_keys(M)  // TODO: Maybe check before wrapping
      andBool unusedIdsInMapKeys(LastIndex +Int 1, M, Expand)
    [simplification]

  rule unusedIdsInMapKeys(LastIndex:Int +Int 4, M:Map, expanded)
    => true
    requires unusedIdsInMapKeys(LastIndex +Int 3, M, expanded)
    [simplification]
  rule unusedIdsInMapKeys(LastIndex:Int +Int 2, M:Map, expanded)
    => true
    requires true
      andBool notBool u(LastIndex +Int 2) in_keys(M)
      andBool unusedIdsInMapKeys(LastIndex +Int 3, M, expanded)
    [simplification]

  rule unusedIdsInMapKeys(LastIndex:Int, M:Map, usesExpanded)
    => true
    requires false
      orBool unusedIdsInMapKeys(LastIndex, M, expanded)
      orBool (true
        andBool notBool u(LastIndex) in_keys(M)
        andBool unusedIdsInMapKeys(LastIndex +Int 1, M, expanded)
      )
      orBool (true
        andBool notBool u(LastIndex) in_keys(M)
        andBool notBool u(LastIndex +Int 1) in_keys(M)
        andBool unusedIdsInMapKeys(LastIndex +Int 2, M, expanded)
      )
    [simplification]

  rule unusedIdsInMapKeys(LastIndex:Int +Int 1, keysMap(M):Map, usesExpanded)
    => true
    requires true
        andBool notBool u(LastIndex +Int 1) in_keys(M)
        andBool unusedIdsInMapKeys(LastIndex +Int 2, keysMap(M), expanded)
    [simplification]

  /*
  rule unusedIdsInMapKeys(LastIndex:Int +Int 1, M:Map, usesExpanded)
    => true
    requires notBool u(LastIndex +Int 1) in_keys(M)
      andBool unusedIdsInMapKeys(LastIndex +Int 2, M, expanded)
    [simplification]
  */

  syntax Bool ::= unusedIdsInMapValues(lastIndex:Int, Map, handling:PropertyHandling)  [function, functional]
  rule unusedIdsInMapValues(_:Int, .Map, _:PropertyHandling) => true
  rule unusedIdsInMapValues(
          LastIndex:Int,
          (_:KItem |-> Value:Usize M:Map) #as _:Map,
          Handling:PropertyHandling
      )
      => unusedIdsInMapValues(LastIndex, M, Handling)
      andBool LastIndex >Int usizeToInt(Value)
    [simplification(10)]
  rule unusedIdsInMapValues(LastIndex:Int, M:Map, expand(_:Expand))
      => unusedIdsInMapValues(LastIndex, M, expanded)

  rule unusedIdsInMapValues(LastIndex:Int +Int 3, M:Map, _:PropertyHandling)
      => true
    requires unusedIdsInMapValues(LastIndex +Int 2, M, expanded)
    [simplification]

  rule unusedIdsInMapValues(LastIndex:Int, M:Map, usesExpanded)
      => true
    requires false
      orBool unusedIdsInMapValues(LastIndex -Int 1, M, expanded)
      orBool unusedIdsInMapValues(LastIndex, M, expanded)
    [simplification]

  syntax Bool ::= noMapKeyInList(Map, ExpressionList)  [function, functional]
  rule noMapKeyInList(.Map, _:ExpressionList) => true
  rule noMapKeyInList(M:Map, [E:Expression, .]) => true
    requires notBool E in_keys(M)
    [simplification]
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

  syntax Map ::= keysMap(Map)  [function, functional]
  rule keysMap(.Map) => .Map
  rule keysMap(K:KItem |-> _:KItem M:Map) => K |-> 0 keysMap(M)
    [simplification]
  rule X:KItem in_keys(keysMap(M:Map)) => X in_keys(M)
    [simplification]

  rule #Ceil(@M:Map (@K:KItem |-> @V:KItem))
      =>  {(@K in_keys(@M)) #Equals false}
          #And #Ceil(@M)
          #And #Ceil(@K)
          #And #Ceil(@V)
    [anywhere, simplification(20)]

  syntax Int ::= boolToInt(Bool)  [function, functional, smtlib(boolToInt)]
  rule boolToInt(true) => 1
  rule boolToInt(false) => 0
  rule 0 <=Int boolToInt(_:Bool) => true  [simplification, smt-lemma]
  rule boolToInt(_:Bool) <=Int 1 => true [simplification, smt-lemma]

  syntax ExpressionList ::= toExpressionListOrDefault(KItem, ExpressionList)  [function, functional]
  rule toExpressionListOrDefault(E:ExpressionList, _Default:ExpressionList) => E
  rule toExpressionListOrDefault(_:KItem, Default:ExpressionList) => Default
    [owise]

  // TODO: Proof for this.
  syntax Bool ::= canSignFunction(UserRole)  [function, functional]
  rule canSignFunction(Role:UserRole) => Role ==K BoardMember

  syntax Int ::= countCanSignFunction(signerIDs:ExpressionList, userIdToRole:Map)  [function, functional, smtlib(countCanSignFunction)]
  syntax Int ::= #countCanSignFunction(userID:Usize, signerIDs:ExpressionList, userIdToRole:Map, value:KItem)  [function, functional]

  rule countCanSignFunction([.], _:Map) => 0
  rule countCanSignFunction([UserId:Usize, Es:ExpressionCSV], UserId |-> Role:UserRole M:Map)
      => 1 +Int countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires canSignFunction(Role)
  rule countCanSignFunction([UserId:Usize, Es:ExpressionCSV], M:Map)
      => countCanSignFunction([Es], M)
    requires notBool UserId in_keys(M)
  rule countCanSignFunction([_:Expression, Es:ExpressionCSV], M)
      => countCanSignFunction([Es], M)
    [owise]

  rule countCanSignFunction([#pushList(Es:ExpressionCSV, UserId:Usize)], UserId |-> Role:UserRole M:Map)
      => 1 +Int countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires canSignFunction(Role)
    [simplification]
  rule countCanSignFunction([#pushList(Es:ExpressionCSV, UserId:Usize)], UserId |-> Role:UserRole M:Map)
      => countCanSignFunction([Es], M)  // Remove UserId from the map since each user is counted at most once.
    requires notBool canSignFunction(Role)
    [simplification]

  rule countCanSignFunction(Es, UserId |-> Role:UserRole M:Map)
      =>  boolToInt(canSignFunction(Role) andBool #listContainsSafe(Es, UserId))
          +Int countCanSignFunction(Es, M)
    ensures notBool UserId in_keys(M)
    [simplification]

  rule 0 <=Int countCanSignFunction(_, _) => true  [simplification, smt-lemma]

  rule isKResult(toExpressionListOrDefault(K:KItem, L:ExpressionList)) => true
    requires isKResult(K) andBool isKResult(L)
    [simplification]
  rule isKResultExpressionList(toExpressionListOrDefault(K:KItem, L:ExpressionList)) => true
    requires isKResult(K) andBool isKResult(L)
    [simplification]

endmodule
