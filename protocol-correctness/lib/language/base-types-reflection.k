require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module BASE-TYPES-REFLECTION
  imports BASE-TYPES-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($expressionList, reflectionArgument(Es:ExpressionCSV))
      => [Es]
endmodule