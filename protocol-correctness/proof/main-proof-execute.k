require "protocol-correctness/pseudocode.k"
require "protocol-correctness/proof/base.k"
require "protocol-correctness/proof/invariant.k"
require "protocol-correctness/proof/execution-proof-helpers.k"

module MAIN-PROOF-EXECUTE-SYNTAX
  imports PSEUDOCODE-SYNTAX
endmodule

module CONCRETIZE-INSTRUMENTATION
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

module PROOF-INSTRUMENTATION
  imports MAP

  imports PSEUDOCODE

  imports CONCRETIZE-INSTRUMENTATION

  syntax KItem ::= splitBoolean(Bool)
  rule splitBoolean(true) => .K  [label(splitBooleanTrue)]
  rule splitBoolean(false) => .K  [label(splitBooleanFalse)]

  syntax KItem ::= branchK(Bool, K, K)
  rule branchK(true, K:K, _:K) => K  [label(branchKTrue)]
  rule branchK(false, _:K, K:K) => K  [label(branchKFalse)]

  syntax KItem ::= "unsign-new.k"
  syntax KItem ::= "unsign-no-role.k"

  rule unsign-new.k => .K
  rule unsign-no-role.k => .K

  syntax KItem ::= "discard-action-no-user.k"
  syntax KItem ::= "discard-action-no-role.k"

  rule discard-action-no-user.k => .K
  rule discard-action-no-role.k => .K

  syntax PerformBranch ::= "perform-new.k"
  syntax PerformBranch ::= "perform-none.k"
  syntax PerformBranch ::= "perform-no-quorum.k"
  syntax PerformBranch ::= "perform-add-board-member-New.k"
  syntax PerformBranch ::= "perform-add-board-member-None.k"
  syntax PerformBranch ::= "perform-add-board-member-BoardMember.k"
  syntax PerformBranch ::= "perform-add-board-member-Proposer.k"
  syntax PerformBranch ::= "perform-add-board-member-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-add-board-member-Proposer-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-New.k"
  syntax PerformBranch ::= "perform-add-proposer-None.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-no-quorum.k"
  syntax PerformBranch ::= "perform-add-proposer-Proposer.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-BoardMember-no-quorum-eq.k"
  syntax PerformBranch ::= "perform-add-proposer-Proposer-eq.k"
  syntax PerformBranch ::= "perform-change-quorum.k"
  syntax PerformBranch ::= "perform-change-quorum-no-quorum.k"
  syntax PerformBranch ::= "perform-nothing.k"
  syntax PerformBranch ::= "perform-remove-user-New.k"
  syntax PerformBranch ::= "perform-remove-user-None.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-too-few.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-nobody-left.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-nobody-left-eq.k"
  syntax PerformBranch ::= "perform-remove-user-Proposer-eq.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-too-few-eq.k"
  syntax PerformBranch ::= "perform-remove-user-BoardMember-eq.k"
  syntax PerformBranch ::= "perform-sc-call.k"
  syntax PerformBranch ::= "perform-sc-deploy.k"
  syntax PerformBranch ::= "perform-send-egld.k"

  syntax KItem ::= PerformBranch

  // TODO: It might be faster to enumerate all cases separately.
  rule _:PerformBranch => .K

  // The Haskell backend sometimes leaves traces of
  // (trusted) claims that failed to apply in the predicate.
  // Sometimes, these traces increase the execution time by a lot,
  // so we have to work around this.
  //
  // The symbols below allow us to wrap those claims in another set of claims,
  // which can be attemped without leaving traces.
  syntax ProofBranch ::= "new.k"
  syntax ProofBranch ::= "none.k"
  syntax ProofBranch ::= "no-quorum.k"
  syntax ProofBranch ::= "add-board-member-New.k"
  syntax ProofBranch ::= "add-board-member-None.k"
  syntax ProofBranch ::= "add-board-member-BoardMember.k"
  syntax ProofBranch ::= "add-board-member-Proposer.k"
  syntax ProofBranch ::= "add-board-member-BoardMember-eq.k"
  syntax ProofBranch ::= "add-board-member-Proposer-eq.k"
  syntax ProofBranch ::= "add-proposer-New.k"
  syntax ProofBranch ::= "add-proposer-None.k"
  syntax ProofBranch ::= "add-proposer-BoardMember.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-no-quorum.k"
  syntax ProofBranch ::= "add-proposer-Proposer.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-eq.k"
  syntax ProofBranch ::= "add-proposer-BoardMember-no-quorum-eq.k"
  syntax ProofBranch ::= "add-proposer-Proposer-eq.k"
  syntax ProofBranch ::= "change-quorum.k"
  syntax ProofBranch ::= "change-quorum-no-quorum.k"
  syntax ProofBranch ::= "nothing.k"
  syntax ProofBranch ::= "remove-user-New.k"
  syntax ProofBranch ::= "remove-user-None.k"
  syntax ProofBranch ::= "remove-user-BoardMember-too-few.k"
  syntax ProofBranch ::= "remove-user-BoardMember.k"
  syntax ProofBranch ::= "remove-user-Proposer-nobody-left.k"
  syntax ProofBranch ::= "remove-user-Proposer.k"
  syntax ProofBranch ::= "remove-user-Proposer-nobody-left-eq.k"
  syntax ProofBranch ::= "remove-user-Proposer-eq.k"
  syntax ProofBranch ::= "remove-user-BoardMember-too-few-eq.k"
  syntax ProofBranch ::= "remove-user-BoardMember-eq.k"
  syntax ProofBranch ::= "sc-call.k"
  syntax ProofBranch ::= "sc-deploy.k"
  syntax ProofBranch ::= "send-egld.k"

  syntax KItem ::= ProofBranch

  // TODO: It might be faster to enumerate all cases separately.
  rule _:ProofBranch => .K

  syntax KItem ::= "propose-sc-deploy-no-user.k"
  syntax KItem ::= "propose-sc-deploy-no-role.k"
  syntax KItem ::= "propose-sc-deploy-role.k"

  rule propose-sc-deploy-no-user.k => .K
  rule propose-sc-deploy-no-role.k => .K
  rule propose-sc-deploy-role.k => .K
endmodule

module MAIN-PROOF-EXECUTE-BOOL
  imports BOOL

  // rule B1:Bool orBool _:Bool => true
  //   requires B1
  //   [simplification]
  // rule _:Bool orBool B2:Bool => true
  //   requires B2
  //   [simplification]
  rule B1:Bool orBool B2:Bool => B2
    requires notBool B1
    [simplification]
  // rule B1:Bool orBool B2:Bool => B1
  //   requires notBool B2
  //   [simplification]
endmodule

module MAIN-PROOF-EXECUTE
  imports MAIN-PROOF-EXECUTE-BOOL
  imports EXECUTION-PROOF-HELPERS
  imports PROOF-INSTRUMENTATION

  imports BASE
  imports INVARIANT
endmodule
