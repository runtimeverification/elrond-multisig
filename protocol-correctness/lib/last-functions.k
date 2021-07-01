require "protocol-correctness/lib/base-types.k"
require "protocol-correctness/lib/plistlen-functions.k"

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
  imports LAST-FUNCTIONS-SYNTAX
  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX

  imports PLISTLEN-FUNCTIONS

  rule last(Es:ExpressionCSV) => #last0(Es)
    requires pListLen([Es]) >Int 0

  rule #last(E:Expression, .) => E
  rule #last(_:Expression, Es:ExpressionCSV) => #last0(Es)
    requires pListLen([Es]) >Int 0

  rule #last0(E:Expression, Es:ExpressionCSV) => #last(E, Es)

  rule #Ceil(last(@Es:ExpressionCSV))
      =>  {pListLen([@Es]) >Int 0 #Equals true}
          #And #Ceil(@Es)
    [anywhere, simplification]
endmodule
