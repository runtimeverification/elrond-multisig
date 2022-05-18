require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/functions/plistlen-functions.k"

module REMOVE-FIRST-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionList ::= removeFirstOrDefault(ExpressionList, ExpressionList)  [function, functional]
endmodule

module REMOVE-FIRST
  imports REMOVE-FIRST-SYNTAX
  imports REMOVE-FIRST-REFLECTION

  rule  removeFirstOrDefault([.], E:ExpressionList) => E
  rule  removeFirstOrDefault([_:Expression, Es:ExpressionCSV], _:ExpressionList)
        => [Es]
endmodule

module REMOVE-FIRST-REFLECTION
  imports REMOVE-FIRST-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($removeFirstOrDefault, (reflectionArgument(L:ExpressionList) , reflectionArgument(L1:ExpressionList)))
      => removeFirstOrDefault(L, L1)
endmodule
