require "protocol-correctness/pseudocode.k"

module INSTRUMENTATION-CONCRETIZE
  imports MAP

  imports PSEUDOCODE

  syntax KItem ::= concretizeValue(KItem)

  rule concretizeValue([CSV:ExpressionCSV]) => concretizeValue(CSV)  [label(concretizeValueCsv)]

  rule concretizeValue(u(V:Int)) => concretizeValue(V)  [label(concretizeValueUsize)]

  rule concretizeValue(address(V:Int)) => concretizeValue(V)  [label(concretizeValueAddress)]

  rule concretizeValue(big(V:Int)) => concretizeValue(V)  [label(concretizeValueBig)]

  rule concretizeValue(meta(V:Int)) => concretizeValue(V)  [label(concretizeValueMeta)]

  rule concretizeValue(bytes(V:String)) => concretizeValue(V)  [label(concretizeValueBytes)]

  rule concretizeValue(BoardMember) => .K  [label(concretizeValueBoardMember)]
  rule concretizeValue(Proposer) => .K  [label(concretizeValueProposer)]
  rule concretizeValue(None) => .K  [label(concretizeValueNone)]

  rule concretizeValue(false) => .K  [label(concretizeValueFalse)]
  rule concretizeValue(true) => .K  [label(concretizeValueTrue)]

  rule concretizeValue(_) => .K [priority(200)]

  syntax KItem ::= concretizeExpressionList(ExpressionList, Int)
  rule concretizeExpressionList([.:ExpressionCSV], X:Int) => .K
    requires X >Int 0
  rule concretizeExpressionList([_:Expression , L:ExpressionCSV], X:Int)
      => concretizeExpressionList([L], X -Int 1)
    requires X >Int 0
    [label(concretizeListElement)]
  rule concretizeExpressionList([_:ExpressionCSV], X:Int)
      => .K
    requires X <=Int 0
    [label(concretizeListEnd)]

  syntax Expression ::= expressionListGetOrDefault(ExpressionList, Int, Expression)  [function, functional]
  rule expressionListGetOrDefault([.], _:Int, Default:Expression) => Default
  rule expressionListGetOrDefault([_:ExpressionCSV], X:Int, Default:Expression) => Default
    requires X <Int 0
  rule expressionListGetOrDefault([E:Expression, _:ExpressionCSV], 0, _:Expression) => E
  rule expressionListGetOrDefault([_:Expression, Es:ExpressionCSV], X:Int, Default:Expression)
      => expressionListGetOrDefault([Es:ExpressionCSV], X -Int 1, Default)
    requires X >Int 0

  syntax Singleton ::= "singleton"

  syntax IntVarList ::= vars(Int, IntVarList)
                    |   ".IntVarList"

  syntax Bool ::= isLazyConcretize(KItem)  [function, functional]
  rule isLazyConcretize(lazyConcretizeKeysFreezer) => true
  rule isLazyConcretize(lazyConcretizeKeys(_:Map)) => true
  rule isLazyConcretize(lazyConcretizeValues(_:Map)) => true
  rule isLazyConcretize(_:KItem) => false  [owise]

  syntax Singleton ::= concretizeKeys(Map, IntVarList)  [function, functional]
  rule concretizeKeys((K:Usize |-> _:KItem M:Map) #as _:Map, vars(U:Int, Vars:IntVarList))
      => concretizeKeys(M, Vars)
    ensures K ==K u(U:Int)
      // => concretizeKeys(M, Vars) #And #Ceil(K #And u(U:Int))
    [simplification(40)]
  rule concretizeKeys(_:Map, _:IntVarList) => singleton
    [simplification(50)]

  syntax Singleton ::= concretizeValues(Map, IntVarList)  [function, functional]
  rule concretizeValues((_:KItem |-> V:Usize M:Map) #as _:Map, vars(U:Int, Vars:IntVarList))
      => concretizeValues(M, Vars)
    ensures V ==K u(U:Int)
      // => concretizeKeys(M, Vars) #And #Ceil(K #And u(U:Int))
    [simplification(40)]
  rule concretizeValues(_:Map, _:IntVarList) => singleton
    [simplification(50)]

  syntax KItem ::= concretized(Singleton)
  rule concretized(singleton) => .K

  syntax KItem ::= "lazyConcretizeKeysFreezer"

  syntax KItem ::= lazyConcretizeKeys(Map)
  rule lazyConcretizeKeys(M:Map) => concretized(concretizeKeys(M, vars(?_, vars(?_, .IntVarList))))

  syntax KItem ::= lazyConcretizeValues(Map)
  rule lazyConcretizeValues(M:Map) => concretized(concretizeValues(M, vars(?_, vars(?_, .IntVarList))))

  // TODO: Rename this.
  // TODO: If I know the number of concretized elements already in the map, and I usually do,
  // I can do this instead of concretizeMapKey:
  // syntax KItem ::= makeConcreteValue2(key:KItem, key2:KItem, Map)
  // rule makeConcreteValue2(Key:KItem, Key2:KItem, Key2 |-> _:KItem M:Map)
  //     => .K
  //   requires Key in_keys(M) andBool notBool (Key ==K Key2)
  //   ensures M ==K Key |-> ?_Value:KItem ?Remainder:Map andBool notBool Key in_keys(?Remainder)
  syntax KItem ::= makeConcreteValue(key:KItem, valueType:ReflectionType, Map)
  rule makeConcreteValue(Key:KItem, ValueType:ReflectionType, M:Map)
    =>    concretizeMapKey(Key, M)
      ~>  cast(M[Key], ValueType)
      ~>  removeValue
      ~>  concretizeValue(M[Key])
    requires Key in_keys(M)

  syntax KItem ::= concretizeCastInKeys(key:KItem, valueType:ReflectionType, Map)
  rule concretizeCastInKeys(Key:KItem, ValueType:ReflectionType, M:Map)
    =>    concretizeMapKey(Key, M)
      ~>  cast(M[Key], ValueType)
      ~>  removeValue
    requires Key in_keys(M)

  syntax KItem ::= makeConcrete(value:KItem, valueType:ReflectionType)
  rule makeConcrete(Value:KItem, ValueType:ReflectionType)
    =>    cast(Value, ValueType)
      ~>  removeValue
      ~>  concretizeValue(Value)
endmodule
