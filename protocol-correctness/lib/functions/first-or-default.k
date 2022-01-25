require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module FIRST-OR-DEFAULT-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Expression ::= firstOrDefault(ExpressionList, Expression)  [function, functional]
endmodule

module FIRST-OR-DEFAULT
  imports FIRST-OR-DEFAULT-SYNTAX
  imports FIRST-OR-DEFAULT-REFLECTION

  rule firstOrDefault([.], E:Expression) => E
  rule firstOrDefault([E:Expression, _:ExpressionCSV], _:Expression) => E
endmodule

module FIRST-OR-DEFAULT-REFLECTION
  imports FIRST-OR-DEFAULT-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($firstOrDefault, (reflectionArgument(L:ExpressionList) , reflectionArgument(E:Expression)))
      => firstOrDefault(L, E)
endmodule
