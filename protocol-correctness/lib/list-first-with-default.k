require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module LIST-FIRST-WITH-DEFAULT-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Expression ::= #listFirstWithDefault(ExpressionList, Expression)  [function, functional]

endmodule

module LIST-FIRST-WITH-DEFAULT
  imports LIST-FIRST-WITH-DEFAULT-REFLECTION
  imports LIST-FIRST-WITH-DEFAULT-SYNTAX

  rule #listFirstWithDefault([.:ExpressionCSV], E:Expression) => E
  rule #listFirstWithDefault([E:Expression , Es:ExpressionCSV], _:Expression) => E
endmodule

module LIST-FIRST-WITH-DEFAULT-REFLECTION
  imports LIST-FIRST-WITH-DEFAULT-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($#listFirstWithDefault,
          (reflectionArgument(Es:ExpressionCSV), reflectionArgument(E:Expression))
      )
      => #listFirstWithDefault([Es], E)
endmodule
