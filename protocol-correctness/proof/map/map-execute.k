require "protocol-correctness/proof/base.k"

module MAP-EXECUTE-SYNTAX
  imports INT
  imports MAP

  syntax MapElementProperty ::= "MEP.AlwaysFalse"
                              | "MEP.AlwaysTrue"
                              | "MEP.AnyProperty"
                              | "MEP.IsValue" "(" KItem ")"

  syntax Int ::= mapCount(Map, MapElementProperty)  [function, functional, smtlib(mapCount)]
  syntax Bool ::= applyMapElementProperty(
          MapElementProperty,
          key:KItem,
          value:KItem
      )  [function, functional]

  syntax KItem ::= mapSelected(key:KItem, value:KItem, Map)
  syntax KItem ::= "mapNotFound"

  syntax KItem ::= mapSelectProperty(Map, MapElementProperty)
  syntax KItem ::= #mapSelectProperty(
                      toProcess:Map, MapElementProperty, processed:Map)

  syntax KItem ::= lazyMapSelectProperty(Map, MapElementProperty)
endmodule

module MAP-EXECUTE
  imports BASE
  imports BOOL
  imports INT
  imports K-EQUAL-SYNTAX
  imports MAP
  imports MAP-EXECUTE-SYNTAX

  syntax Bool ::= uninterpretedElementProperty(key:KItem, value:KItem)
      [function, functional, no-evaluators]

  rule applyMapElementProperty(MEP.AlwaysFalse, _:KItem, _:KItem) => false
  rule applyMapElementProperty(MEP.AlwaysTrue, _:KItem, _:KItem) => true
  rule applyMapElementProperty(MEP.AnyProperty, Key:KItem, Value:KItem)
      => uninterpretedElementProperty(Key, Value)
  rule applyMapElementProperty(MEP.IsValue(V:KItem), _Key:KItem, Value:KItem)
      => V ==K Value

  syntax Int ::= countMapElementProperty(
          MapElementProperty,
          key:ExplicitKItem,
          value:ExplicitKItem
      )  [function, functional, smtlib(countMapElementProperty)]

  rule countMapElementProperty(Property:MapElementProperty, wrap(Key:KItem), wrap(Value:KItem))
      => 0
    requires notBool applyMapElementProperty(Property, Key, Value)
  rule countMapElementProperty(Property:MapElementProperty, wrap(Key:KItem), wrap(Value:KItem))
      => 1
    requires applyMapElementProperty(Property, Key, Value)

  rule countMapElementProperty(_, _, _) >=Int 0 => true  [simplification, smt-lemma]
  rule countMapElementProperty(_, _, _) <=Int 1 => true  [simplification, smt-lemma]

  // TODO: Use this everywhere
  rule mapCount(.Map, _:MapElementProperty) => 0
  rule mapCount(K:KItem |-> V:KItem M:Map, Property:MapElementProperty)
      => countMapElementProperty(Property, wrap(K), wrap(V)) +Int mapCount(M, Property)
    [simplification]

  rule mapCount(_:Map, _:MapElementProperty) >=Int 0 => true
    [simplification, smt-lemma]

  rule mapCount(M:Map, MEP.AlwaysTrue) >Int 0 => notBool (M ==K .Map)
    [simplification]

  syntax SelectPropertyIntermediateResult ::= found(key:KItem, value:KItem, Map)
                                            | notFoundYet(inner:Map, MapElementProperty, checked:Map)
  syntax KItem ::= #lazyMapSelectProperty(result:SelectPropertyIntermediateResult)
  syntax KItem ::= mapSelectPropertyAddBack(Map)
  syntax KItem ::= "mapSelectPropertyEnd"

  syntax KItem ::= findInnerMap(Map, MapElementProperty, SelectPropertyIntermediateResult)  [function, functional]
  syntax KItem ::= #findInnerMap(Map, MapElementProperty, checked:Map, SelectPropertyIntermediateResult)  [function, functional]

  rule lazyMapSelectProperty(M:Map, P:MapElementProperty)
      => findInnerMap(M, P, ?Result:SelectPropertyIntermediateResult)
      ~> #lazyMapSelectProperty(?Result)

  rule #lazyMapSelectProperty(notFoundYet(Inner:Map, Property:MapElementProperty, Checked:Map))
      => mapSelectProperty(Inner, Property) ~> mapSelectPropertyAddBack(Checked)
  rule #lazyMapSelectProperty(found(Key:KItem, Value:KItem, M:Map)) => mapSelected(Key, Value, M)

  rule mapSelected(Key:KItem, Value:KItem, M:Map) ~> mapSelectPropertyAddBack(N:Map)
      => mapSelected(Key, Value, M N)
  rule mapNotFound ~> mapSelectPropertyAddBack(_:Map)
      => mapNotFound

  rule mapSelectPropertyEnd => .K

  rule findInnerMap(M:Map, P:MapElementProperty, Result:SelectPropertyIntermediateResult)
      => #findInnerMap(M, P, .Map, Result)
  rule #findInnerMap(K:KItem |-> V:KItem M:Map, P:MapElementProperty, Checked:Map, Result:SelectPropertyIntermediateResult)
      => #findInnerMap(M, P, K |-> V Checked, Result)
    requires notBool applyMapElementProperty(P, K, V)
    [simplification(20)]
  rule #findInnerMap(K:KItem |-> V:KItem M:Map, P:MapElementProperty, Checked:Map, Result:SelectPropertyIntermediateResult)
      => mapSelectPropertyEnd
    requires applyMapElementProperty(P, K, V)
    ensures Result ==K found(K, V, iterateConcat(M, Checked))
    [simplification(20)]
  rule #findInnerMap(M:Map, P:MapElementProperty, Checked:Map, Result:SelectPropertyIntermediateResult)
      => mapSelectPropertyEnd
    ensures Result ==K notFoundYet(M, P, Checked)
    [simplification(50)]

  // TODO: Remove after https://github.com/kframework/kore/issues/2494 is fixed
  syntax Map ::= iterateConcat(Map, Map)  [function]
  rule iterateConcat(M:Map, .Map) => M
  rule iterateConcat(M:Map, K:KItem |-> V:KItem N) => iterateConcat(K |-> V M, N)
    requires notBool K in_keys(M)
    ensures notBool K in_keys(N)
    [simplification(20)]
  rule iterateConcat(M, N) => M N
    [simplification(50)]

  syntax KItem ::= #mapSelectedProperty(
                      key:KItem, value:KItem,
                      toProcess:Map, MapElementProperty, processed:Map)

  rule mapSelectProperty(M:Map, Property:MapElementProperty)
      => #mapSelectProperty(M, Property, .Map)

  rule #mapSelectProperty(.Map, _:MapElementProperty, _:Map)
      => mapNotFound
  rule #mapSelectProperty(
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => #mapSelectedProperty(?Key, ?Value, ?M, Property, Processed)
    requires notBool (M ==K .Map)
    ensures (M ==K (?Key:KItem |-> ?Value:KItem ?M:Map))

  rule #mapSelectedProperty(
          Key:KItem,
          Value:KItem,
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => mapSelected(Key, Value, M Processed)
    requires applyMapElementProperty(Property, Key, Value)
    [label(mapSelectedPropertyTrue)]
  rule #mapSelectedProperty(
          Key:KItem,
          Value:KItem,
          M:Map,
          Property:MapElementProperty,
          Processed:Map)
      => #mapSelectProperty(M, Property, Key |-> Value Processed)
    requires notBool applyMapElementProperty(Property, Key, Value)
    [label(mapSelectedPropertyFalse)]

endmodule
