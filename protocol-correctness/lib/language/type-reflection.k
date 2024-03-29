require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/flow.k"
require "protocol-correctness/lib/language/maybe.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/language/running-syntax.k"

module TYPE-REFLECTION-SYNTAX
    syntax ReflectionType ::= "rUsize"
                          | "rExpressionList"
                          | "rBool"
                          | "rAddress"
                          | "rBoxedBytes"
                          | "rBigUint"

    syntax KItem ::= cast(KItem, ReflectionType)  [strict(1)]
    syntax KItem ::= castNoValue(KItem, ReflectionType)

    syntax KItem ::= defaultValue(ReflectionType)  [function, functional]
    syntax Bool ::= isDefaultValue(KItem, ReflectionType)  [function, functional]
    syntax Bool ::= valueOfType(KItem, ReflectionType)  [function, functional]

    syntax ValueMapperType ::= SingleValue(ReflectionType)

endmodule

module TYPE-REFLECTION
  imports BOOL

  imports BASE-TYPES-SYNTAX
  imports FLOW-SYNTAX
  imports K-EQUAL-SYNTAX
  imports MAYBE-SYNTAX
  imports TYPE-REFLECTION-REFLECTION
  imports TYPE-REFLECTION-SYNTAX
  imports RUNNING-SYNTAX

  rule castNoValue(K:KItem, T:ReflectionType) => cast(K, T) ~> removeValue

  rule cast(value(K:KItem) => K, _:ReflectionType)  [label(castValue)]

  rule cast(U:Usize, rUsize) => U  [label(castUsize)]
  rule (.K => stuck) ~> cast(V:KItem, rUsize)
    ensures notBool isUsize(V)
    [owise, label(castUsizeStuck)]

  rule cast(V:ExpressionList, rExpressionList) => V  [label(castExpressionList)]
  rule (.K => stuck) ~> cast(V:KItem, rExpressionList)
    ensures notBool isExpressionList(V)
    [owise, label(castExpressionListStuck)]

  rule cast(A:Address, rAddress) => A  [label(castAddress)]
  rule (.K => stuck) ~> cast(V:KItem, rAddress)
    ensures notBool isAddress(V)
    [owise, label(castAddressStuck)]

  rule defaultValue(rUsize) => u(0)
  rule defaultValue(rExpressionList) => [.]
  rule defaultValue(rBool) => false
  // Address is not nullable
  // rule defaultValue(rAddress) => stuck
  rule defaultValue(rBoxedBytes) => bytes("")
  rule defaultValue(rBigUint) => big(0)

  rule isDefaultValue(K:KItem, T:ReflectionType) => K ==K defaultValue(T)
    [owise]  // allow overriding

  rule valueOfType(V:KItem, rUsize) => isUsize(V)
  rule valueOfType(V:KItem, rExpressionList) => isExpressionList(V)
  rule valueOfType(V:KItem, rBool) => isBool(V)
  rule valueOfType(V:KItem, rAddress) => isAddress(V)
  rule valueOfType(V:KItem, rBoxedBytes) => isBoxedBytes(V)
  rule valueOfType(V:KItem, rBigUint) => isBigUint(V)
endmodule

module TYPE-REFLECTION-REFLECTION
  imports TYPE-REFLECTION-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply(
          $castNoValue, reflectionArgument(K:KItem), reflectionArgument(R:ReflectionType))
      => castNoValue(K, R)

  rule reflectionApply0($rUsize) => rUsize
  rule reflectionApply0($rExpressionList) => rExpressionList
  rule reflectionApply0($rBool) => rBool
  rule reflectionApply0($rAddress) => rAddress
  rule reflectionApply0($rBoxedBytes) => rBoxedBytes
  rule reflectionApply0($rBigUint) => rBigUint

endmodule
