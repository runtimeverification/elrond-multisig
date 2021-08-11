require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/proof/instrumentation-concretize.k"

module INSTRUMENTATION-LEMMA-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP

  syntax IterateArguments ::= ".A"
                            | args1(KItem)
                            | args2(KItem, KItem)
                            | args3(KItem, KItem, KItem)
                            | args4(KItem, KItem, KItem, KItem)

  syntax KItem ::= lemmaSplitList(ExpressionList)
  syntax KItem ::= lemmaSplitList2(ExpressionList)

  syntax KItem ::= lemmaSplitListExpression(Expression, ExpressionList)
  syntax KItem ::= lemmaSplitListExpression2(Expression, ExpressionList)

  syntax KItem ::= lemmaIterateList(ExpressionList, IterateArguments)
  syntax KItem ::= lemmaIterateList2(ExpressionList, IterateArguments)

  syntax KItem ::= lemmaIterateListContains1(ExpressionList, Expression)
  syntax KItem ::= lemmaIterateListContains2(ExpressionList, Int)

  syntax KItem ::= lemmaNop()

  syntax KItem ::= splitIntSign(Int)
  syntax KItem ::= splitIntSign2(Int)

  syntax KItem ::= lemmaLastDistinct(Expression, Expression, ExpressionCSV)

  syntax KItem ::= lemmaIterateMap(Map, IterateArguments)

  syntax KItem ::= lemmaIterateMapSplitInKeys(Map, IterateArguments, Map)
endmodule

module INSTRUMENTATION-LEMMA
  imports INSTRUMENTATION-CONCRETIZE
  imports INSTRUMENTATION-LEMMA-SYNTAX

  rule  lemmaSplitList([.:ExpressionCSV]) => .K
  rule  lemmaSplitList([_, L:ExpressionCSV])
        => lemmaSplitList([L])

  rule  lemmaSplitList2([.:ExpressionCSV]) => .K
  rule  lemmaSplitList2([_, .:ExpressionCSV]) => .K
  rule  lemmaSplitList2([_, ((_, _:ExpressionCSV) #as L:ExpressionCSV)])
        => lemmaSplitList2([L])

  rule  lemmaSplitListExpression(_:Expression, [.:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression(_:Expression, [E:Expression, L:ExpressionCSV])
        => lemmaSplitListExpression(E, [L])

  rule  lemmaSplitListExpression2(_:Expression, [.:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression2(_:Expression, [_:Expression, .:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression2(_:Expression, [E:Expression, ((_, _:ExpressionCSV) #as L:ExpressionCSV)])
        => lemmaSplitListExpression2(E, [L])

  rule  lemmaIterateList([.:ExpressionCSV], _:IterateArguments) => .K
  rule  lemmaIterateList([_:Expression, L:ExpressionCSV], A:IterateArguments)
        => lemmaIterateList([L], A)

  rule  lemmaIterateList2([.:ExpressionCSV], _:IterateArguments) => .K
  rule  lemmaIterateList2([_:Expression, .:ExpressionCSV], _:IterateArguments) => .K
  rule  lemmaIterateList2([_:Expression, ((_, _:ExpressionCSV) #as L:ExpressionCSV)], A:IterateArguments)
        => lemmaIterateList2([L], A)

  rule lemmaIterateListContains1([.:ExpressionCSV], _:Expression) => .K
  rule lemmaIterateListContains1([E1:Expression, .:ExpressionCSV], E2:Expression) => concretizeValue(E2 ==K E1)
  rule lemmaIterateListContains1([E1:Expression, ((_, _:ExpressionCSV) #as L:ExpressionCSV)], E2:Expression)
        =>  concretizeValue(E1 ==K last(L))
            ~> concretizeValue(E2 ==K last(L))
            ~> concretizeValue(E2 ==K E1)
            ~> lemmaIterateListContains1([L], E2)

  rule lemmaIterateListContains2([.:ExpressionCSV], I:Int) => splitIntSign(I)
  rule lemmaIterateListContains2([_:Expression, .:ExpressionCSV], I:Int) => splitIntSign2(I)
  rule lemmaIterateListContains2([_:Expression, ((_, _:ExpressionCSV) #as L:ExpressionCSV)], I:Int)
        =>  splitIntSign2(I)
            ~> lemmaIterateListContains2([L], I)

  rule lemmaNop() => .K

  rule splitIntSign(I:Int) => .K requires I <Int 0
  rule splitIntSign(I:Int) => .K requires I ==Int 0
  rule splitIntSign(I:Int) => .K requires I >Int 0

  rule splitIntSign2(I:Int) => .K requires I <Int 0
  rule splitIntSign2(I:Int) => .K requires I ==Int 0
  rule splitIntSign2(I:Int) => .K requires I ==Int 1
  rule splitIntSign2(I:Int) => .K requires I >Int 1

  rule lemmaLastDistinct(E1:Expression, E2:Expression, .:ExpressionCSV) => concretizeValue(E1 ==K E2)
  rule lemmaLastDistinct(E:Expression, E1:Expression, (E2:Expression, Es:ExpressionCSV))
      => concretizeValue(E ==K E2) ~> concretizeValue(E ==K E1) ~> concretizeValue(E1 ==K E2) ~> lemmaLastDistinct(E, E2, Es)

  rule lemmaIterateMap(.Map, _:IterateArguments) => .K
  rule lemmaIterateMap(M:Map, A:IterateArguments) => lemmaIterateMap(?M:Map, A)
    requires notBool M ==K .Map
    ensures M ==K ?_Key:KItem |-> ?_Value:KItem ?M

  rule lemmaIterateMapSplitInKeys(.Map, _:IterateArguments, _:Map) => .K
  rule lemmaIterateMapSplitInKeys(M:Map, A:IterateArguments, N:Map)
      =>   concretizeValue(?Key in_keys(N))
        ~> lemmaIterateMapSplitInKeys(?M:Map, A, N)
    requires notBool M ==K .Map
    ensures M ==K ?Key:KItem |-> ?_Value:KItem ?M

  // TODO: move to a better place
  rule A ==Bool B => true requires {A #Equals B}
    [simplification]
endmodule
