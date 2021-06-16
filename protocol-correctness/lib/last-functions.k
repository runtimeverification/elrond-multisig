require "protocol-correctness/lib/base-types.k"
require "protocol-correctness/lib/plistlen-functions.k"

module LAST-FUNCTIONS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Expression ::= last(ExpressionCSV)  [function]
endmodule

module LAST-FUNCTIONS
  imports LAST-FUNCTIONS-SYNTAX

  imports PLISTLEN-FUNCTIONS

  rule last(E:Expression, .) => E
  rule last(_:Expression, Es:ExpressionCSV) => last(Es)
    requires pListLen([Es]) >Int 0

  rule #Ceil(last(@Es:ExpressionCSV))
      =>  {pListLen([@Es]) >Int 0 #Equals true}
          #And #Ceil(@Es)
    [anywhere, simplification]
endmodule
