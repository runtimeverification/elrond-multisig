require "protocol-correctness/lib/functions/map-representation.k"

module MAP-UNIFICATION-SYNTAX
  imports MAP

  syntax Bool ::= mapUnification(first:Map, second:Map, varNotUsedElsewhere:Map)
    [function, functional]
endmodule

module MAP-UNIFICATION-INTERNAL-SYNTAX
  imports MAP

  syntax KeyValueList ::= ".KeyValueList"
                        | keyValueList(key:KItem, value:KItem, KeyValueList)
  // TODO: This is not actually functional, figure out what to do with it and its callers.
  syntax Map ::= addListToMap(KeyValueList, Map)  [function, functional]
  syntax ConcatMap ::= addListToConcatMap(KeyValueList, ConcatMap)  [function, functional]

  syntax Bool ::= mapUnificationHelper(
                      firstList:KeyValueList, first:ConcatMap,
                      second:ConcatMap,
                      varNotUsedElsewhere:Map)
    [function, functional]
  syntax Bool ::= mapUnificationHelperElement(
                      key:KItem, value:KItem,
                      firstList:KeyValueList, first:ConcatMap,
                      secondList:KeyValueList, second:ConcatMap,
                      varNotUsedElsewhere:Map)
    [function, functional]
  syntax Bool ::= mapUnificationEnd(
                      firstList:KeyValueList, firstMap:Map,
                      secondList:KeyValueList, secondMap:ConcatMap,
                      varNotUsedElsewhere:Map)
    [function, functional]
endmodule

/*
  rule a(K, K |-> V M) => .K

  pattern:
  a(X, Y |-> V1 M) #And notBool X in (Y |-> V1 M) #And notBool X ==K Y
  a(X, Y |-> V1 M) #And notBool X in M #And notBool X ==K Y

  a(X, (X |-> V M') #as N')
      #And (X |-> V M' ==K Y |-> V1 M)
      #And notBool X ==K Y
      #And notBool X in M

  rule a(K, M) => mapUnifyThing(K, M, ?V, ?N, ?X) - function
  mapUnifyThing(K, M, V, N, X) => .K #And true == mapUnify(K |-> V N, M, X:Map) => .K

  rule a(K, M) => .K requires mapUnify(K |-> V N, M, X:Map) => .K

  a(X, (X |-> V Y |-> V1 Var))
      #And notBool X ==K Y
      #And notBool X in X |-> V Var
      #And M' == Y |-> V1 Var
      #And M == X |-> V Var


*/

module MAP-UNIFICATION
  imports MAP-UNIFICATION-SYNTAX
  imports MAP-UNIFICATION-INTERNAL-SYNTAX

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP-REPRESENTATION-SYNTAX

  // Definition rules, not meant to be actually used in most cases.
  rule mapUnification(.Map, .Map, _:Map) => true
  rule mapUnification(K:KItem |-> _:KItem _M:Map, N:Map, _:Map) => false
    requires notBool K in_keys(N)
    [simplification(50)]
  rule mapUnification(K:KItem |-> V1:KItem M:Map, K |-> V2:KItem N:Map, Variable:Map)
    => V1 ==K V2 andBool mapUnification(M, N, Variable)
    [simplification(50)]

  // Simplification rules, which should be used in most cases.
  // TODO: Proofs for these (without the `ensures` part when applicable).

  rule mapUnification(M:Map, N:Map, V:Map)
      => mapUnificationHelper(.KeyValueList, mapOpaque(M), mapOpaque(N), V)
    [simplification(100)]

  rule mapUnificationHelper(
          FirstList:KeyValueList, mapConcat(K:KItem, V:KItem, FirstMap:ConcatMap),
          SecondMap:ConcatMap,
          Variable:Map)
      => mapUnificationHelperElement(
          K, V,
          FirstList, FirstMap,
          .KeyValueList, SecondMap,
          Variable)
    [simplification(100)]
  rule mapUnificationHelper(
        FirstList:KeyValueList, mapOpaque(FirstMap:Map),
        SecondMap:ConcatMap,
        Variable:Map)
      => mapUnificationEnd(FirstList, FirstMap, .KeyValueList, SecondMap, Variable)
    [simplification(100)]

  rule mapUnificationHelperElement(
          K1:KItem, V1:KItem,
          FirstList:KeyValueList, FirstMap:ConcatMap,
          SecondList:KeyValueList, mapConcat(K2:KItem, V2:KItem, SecondMap:ConcatMap),
          Variable:Map)
      =>  ( K1 ==K K2 andBool V1 ==K V2
          andBool mapUnificationHelper(
                      FirstList, FirstMap,
                      addListToConcatMap(SecondList, SecondMap),
                      Variable
                  )
          )
        orBool  ( K1 =/=K K2
                andBool mapUnificationHelperElement(
                        K1, V1,
                        FirstList, FirstMap,
                        keyValueList(K2, V2, SecondList), SecondMap,
                        Variable
                    )
                )
    [simplification(100)]
  rule mapUnificationHelperElement(
          K:KItem, V:KItem,
          FirstList:KeyValueList, FirstMap:ConcatMap,
          SecondList:KeyValueList, mapOpaque(_:Map) #as SecondMap:ConcatMap,
          Variable:Map)
      => mapUnificationHelper(
          keyValueList(K, V, FirstList), FirstMap,
          addListToConcatMap(SecondList, SecondMap),
          Variable)
    [simplification(100)]

  rule mapUnificationEnd(
          FirstList:KeyValueList, FirstMap:Map,
          SecondList:KeyValueList, mapConcat(K:KItem, V:KItem, SecondMap:ConcatMap),
          Variable:Map)
    => mapUnificationEnd(
          FirstList, FirstMap,
          keyValueList(K, V, SecondList), SecondMap,
          Variable)
    [simplification]
  // The fishy rule of the entire unification thing.
  rule mapUnificationEnd(
          FirstList:KeyValueList, FirstMap:Map,
          SecondList:KeyValueList, mapOpaque(SecondMap:Map),
          Variable:Map)
    => addListToMap(FirstList, FirstMap) ==K addListToMap(SecondList, SecondMap)
    ensures
      FirstMap ==K addListToMap(SecondList, Variable)
      andBool (SecondMap ==K addListToMap(FirstList, Variable))
    [simplification]

  rule addListToConcatMap(.KeyValueList, M:ConcatMap) => M
  rule addListToConcatMap(
          keyValueList(K:KItem, V:KItem, L:KeyValueList), M:ConcatMap
      )
      => addListToConcatMap(L, mapConcat(K, V, M))

  rule addListToMap(.KeyValueList, M:Map) => M
  rule addListToMap(
          keyValueList(K:KItem, V:KItem, L:KeyValueList), M:Map
      )
      => addListToMap(L, K |-> V M)
endmodule
