require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module CONCRETIZE-VALUE-SYNTAX
  syntax KItem ::= concretizeValue(KItem)
endmodule

module CONCRETIZE-VALUE
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports CONCRETIZE-VALUE-REFLECTION
  imports CONCRETIZE-VALUE-SYNTAX
  imports INT
  imports STRING
  
  rule concretizeValue([CSV:ExpressionCSV]) => concretizeValue(CSV)  [label(concretizeValueCsv)]

  rule concretizeValue(u(V:Int)) => concretizeValue(V)  [label(concretizeValueUsize)]

  rule concretizeValue(address(V:Int)) => concretizeValue(V)  [label(concretizeValueAddress)]

  rule concretizeValue(big(V:Int)) => concretizeValue(V)  [label(concretizeValueBig)]

  rule concretizeValue(bytes(V:String)) => concretizeValue(V)  [label(concretizeValueBytes)]

  rule concretizeValue(true) => .K  [label(concretizeValueTrue)]
  rule concretizeValue(false) => .K  [label(concretizeValueFalse)]

  rule concretizeValue(_) => .K [priority(200), label(concretizeValueDefault)]

endmodule

module CONCRETIZE-VALUE-REFLECTION
  imports CONCRETIZE-VALUE-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply(
          $concretizeValue, reflectionArgument(K:KItem))
      => concretizeValue(K)

endmodule
