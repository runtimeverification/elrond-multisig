require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"
require "protocol-correctness/lib/functions/plistlen-functions.k"

module REMOVE-LAST-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= removeLast(ExpressionCSV)  [function]
endmodule

module REMOVE-LAST-ADDITIONAL-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= #removeLast(Expression, ExpressionCSV)  [function, functional]
  syntax ExpressionCSV ::= #removeLast0(ExpressionCSV)  [function, functional]
endmodule

module REMOVE-LAST
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX
  imports REMOVE-LAST-REFLECTION
  imports REMOVE-LAST-SYNTAX


  rule removeLast(E:Expression, Es:ExpressionCSV) => #removeLast(E, Es)

  rule #removeLast(_:Expression, .)
      => .:ExpressionCSV
  rule #removeLast(E:Expression, Es:ExpressionCSV)
      => E, #removeLast0(Es)
      requires pListLen([Es]) >Int 0

  rule #removeLast0(.) => .
  rule #removeLast0(E:Expression, Es:ExpressionCSV) => #removeLast(E, Es)

  rule #Ceil(removeLast(@Es:ExpressionCSV))
      =>  {pListLen([@Es]) >Int 0 #Equals true}
          #And #Ceil(@Es)
    [anywhere, simplification]
endmodule

module REMOVE-LAST-REFLECTION
  imports REMOVE-LAST-ADDITIONAL-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($#removeLast, (reflectionArgument(E:Expression) , reflectionArgument(Es:ExpressionCSV)))
      => #removeLast(E, Es)
endmodule
