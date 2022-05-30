require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/functions/plistlen-functions.k"

module LAST-FUNCTIONS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Expression ::= last(ExpressionCSV)  [function]
endmodule

module LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Expression ::= #last(Expression, ExpressionCSV)  [function, functional]
  syntax Expression ::= #last0(ExpressionCSV)  [function, functional]
endmodule

module LAST-FUNCTIONS
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LAST-FUNCTIONS-SYNTAX
  imports LAST-FUNCTIONS-REFLECTION

  imports PLISTLEN-FUNCTIONS-SYNTAX

  rule last(Es:ExpressionCSV) => #last0(Es)
    requires pListLen([Es]) >Int 0

  rule #last(E:Expression, .) => E
  rule #last(_:Expression, Es:ExpressionCSV) => #last0(Es)
    requires pListLen([Es]) >Int 0

  rule #last0(E:Expression, Es:ExpressionCSV) => #last(E, Es)
  // #last0 is total, but can't be fully evaluated.
  // We could add something like 'rule #last0(.) => u(0)' in order to fix that,
  // but that would make debugging harder.

  rule #Ceil(last(@Es:ExpressionCSV))
      =>  {pListLen([@Es]) >Int 0 #Equals true}
          #And #Ceil(@Es)
    [anywhere, simplification]
endmodule

module LAST-FUNCTIONS-REFLECTION
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($#last, (reflectionArgument(E:Expression) , reflectionArgument(Es:ExpressionCSV)))
      => #last(E, Es)
endmodule
