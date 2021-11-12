require "protocol-correctness/lib/language/maybe.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/language/type-reflection.k"

module MAP-UTILS-SYNTAX
  imports MAP
  imports TYPE-REFLECTION-SYNTAX

  syntax KItem ::= concretizeMapKey(KItem, Map)

  syntax KItem ::= nullableMapLookup(key:KItem, Map, ReflectionType)
  syntax KItem ::= nullableMapSet(key:KItem, value:KItem, Map, ReflectionType)
endmodule

module MAP-UTILS
  imports MAP-REFLECTION
  imports MAP-UTILS-BASIC
  imports MAP-UTILS-LANGUAGE
endmodule

module MAP-UTILS-SYNTAX-PRIVATE
  imports MAP

  syntax KItem ::= mapLookup(KItem, Map)
  syntax KItem ::= mapDelete(key:KItem, Map)
  syntax KItem ::= mapSet(key:KItem, value:KItem, Map)
endmodule

module MAP-UTILS-BASIC
  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP
  imports MAP-UTILS-SYNTAX
  imports MAP-UTILS-SYNTAX-PRIVATE
  imports MAYBE
  imports TYPE-REFLECTION-SYNTAX

  rule concretizeMapKey(Key:KItem, M:Map) => splitMap(Key, M, ?_Value, ?_Remainder)
    requires Key in_keys(M)
    [label(concretizeMapKey)]
  rule concretizeMapKey(Key:KItem, M:Map) => .K
    requires notBool Key in_keys(M)
    [label(concretizeKeyNotInMap)]


  syntax KItem ::= "splitMapStuck" | "endSplitMap"
  rule endSplitMap => .K


  syntax KItem ::= splitMap(key:KItem, toSplit:Map, value:KItem, remainder:Map)
      [function, functional]
  rule splitMap(Key:KItem, M:Map, _Value:KItem, _Remainder:Map) => splitMapStuck
    requires notBool Key in_keys(M)
  rule splitMap(Key:KItem, (Key |-> _:KItem) M:Map, _Value:KItem, _Remainder:Map)
      => endSplitMap
    ensures notBool Key in_keys(M)
    [simplification(30)]
  rule splitMap(Key:KItem, (K1:KItem |-> _SomeValue:KItem) M:Map, Value:KItem, Remainder:Map)
      => splitMap(Key, M, Value, Remainder)
    requires notBool (Key ==K K1) andBool Key in_keys(M)
    ensures notBool K1 in_keys(M)
    [simplification(30)]
  rule splitMap(Key:KItem, M:Map, Value:KItem, Remainder:Map)
      => endSplitMap
    requires Key in_keys(M)
    ensures M ==K (Key |-> Value Remainder)
    [simplification(50)]

  /*
  syntax Map ::= splitMap(key:KItem, Map, Map)  [function, functional]

  rule  splitMap(K:KItem, (K |-> _:KItem _:Map) #as _:Map, M:Map)
        => M
    [simplification]
  rule  splitMap(K:KItem, (K1 |-> _ M:Map) #as _:Map, N:Map)
        => splitMap(K, M, N)
    requires notBool (K ==K K1)
    [simplification]
  rule  splitMap(K:KItem, M:Map, N:Map)
        =>
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
              #And N
            )
            #Or (N #And {true #Equals (notBool (K in_keys(M)))})

  rule  splitMap(K:KItem, M:Map, N:Map)
        =>(
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
            )
            #Or
            ({true #Equals (notBool (K in_keys(M)))})
          )
          #And N


  rule  splitMap(K:KItem, M:Map, N:Map) => N
        ensures
          (
            (
              (#Ceil(M #And (K |-> ?_:KItem ?_:Map)))
              #And
              {true #Equals (K in_keys(M))}
            )
            #Or
            ({true #Equals (notBool (K in_keys(M)))})
          )



  */

  // Do the map lookups in a way that makes the Haskell backend happy.

  rule mapLookup(K:KItem, M:Map)
      =>  concretizeMapKey(K, M) ~> #mapLookup(K, M)
    requires K in_keys(M)
    [label(mapLookupInKeys)]
  rule mapLookup(K:KItem, M:Map)
      =>  nothing
    requires notBool K in_keys(M)
    [label(mapLookupNotInKeys)]

  syntax KItem ::= #mapLookup(KItem, Map)
  rule #mapLookup(K:KItem, ((K |-> V:KItem) _:Map) #as M:Map) => just(V)
    ensures K in_keys(M)
  rule #mapLookup(K:KItem, M:Map) => nothing
    ensures notBool (K in_keys(M))
    [owise]

  rule mapDelete(K:KItem, M:Map) => #mapDelete(K, M)
    requires K in_keys(M)
  rule mapDelete(K:KItem, M:Map) => M
    requires notBool (K in_keys(M))

  syntax KItem ::= #mapDelete(key:KItem, Map)
  rule #mapDelete(K:KItem, (K |-> _:KItem) M:Map) => M
  rule #mapDelete(_:KItem, M:Map) => M
    ensures false
    [owise]

  rule mapSet(K:KItem, V:KItem, M:Map) => #mapSet(K, V, M)
    requires K in_keys(M)
  rule mapSet(K:KItem, V:KItem, M:Map) => K |-> V M
    requires notBool (K in_keys(M))

  syntax KItem ::= #mapSet(key:KItem, value:KItem, Map)
  rule #mapSet(K:KItem, V:KItem, (K |-> _:KItem) M:Map) => K |-> V M
  rule #mapSet(_:KItem, _:KItem, M:Map) => M
    ensures false
    [owise]


  rule X:KItem in_keys(Y:KItem |-> _:KItem M:Map)
        => X ==K Y orBool X in_keys(M)
    ensures notBool Y in_keys(M)
    [simplification]
  rule K1 in_keys(M [ K2 <- undef ]) => K1 in_keys(M)
    requires notBool K1 ==K K2
    [simplification]

  rule M:Map[Key:KItem] orDefault _:KItem => M[Key]
    requires Key in_keys(M)
    [simplification]
  rule M:Map[Key:KItem] orDefault D:KItem => D
    requires notBool Key in_keys(M)
    [simplification]
endmodule

module MAP-UTILS-LANGUAGE
  imports BOOL
  imports MAP-UTILS-SYNTAX
  imports MAP-UTILS-SYNTAX-PRIVATE
  imports MAYBE-SYNTAX

  rule nullableMapLookup(K:KItem, M:Map, T:ReflectionType)
        => cast(orElse(mapLookup(K, M), defaultValue(T)), T)

  rule nullableMapSet(Key:KItem, Value:KItem, M:Map, T:ReflectionType)
        => mapDelete(Key, M)
    requires isDefaultValue(Value, T)
    [label(nullableMapSetDeleteEmpty)]
  rule nullableMapSet(Key:KItem, Value:KItem, M:Map, T:ReflectionType)
        => mapSet(Key, Value, M)
    requires notBool isDefaultValue(Value, T)
    [label(nullableMapSetAddNonEmpty)]
endmodule

module MAP-REFLECTION
  imports MAP
  imports REFLECTION-SYNTAX

  rule reflectionApply(
          $mapUpdate,
          ( reflectionArgument(M:Map)
          , reflectionArgument(K:KItem)
          , reflectionArgument(V:KItem)
          )
        )
      => M[K <- V]

  rule reflectionApply(
          $mapDelete,
          ( reflectionArgument(M:Map)
          , reflectionArgument(K:KItem)
          )
        )
      => M[K <- undef]
endmodule