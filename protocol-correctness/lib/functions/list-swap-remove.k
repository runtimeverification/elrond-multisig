require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/functions/last-to-start.k"

module LIST-SWAP-REMOVE-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= #listSwapRemove(ExpressionCSV, Int)  [function, functional]

endmodule

module LIST-SWAP-REMOVE
  imports LIST-SWAP-REMOVE-REFLECTION
  imports LIST-SWAP-REMOVE-SYNTAX

  imports LAST-TO-START-SYNTAX

  rule  #listSwapRemove(.:ExpressionCSV, 0)
        => .:ExpressionCSV
  rule  #listSwapRemove(_:Expression , Es:ExpressionCSV, 0)
        => lastToStart(Es)
  rule  #listSwapRemove(.:ExpressionCSV, I:Int)
        => .:ExpressionCSV
    requires I >Int 0
  rule  #listSwapRemove(E:Expression , Es:ExpressionCSV, I:Int)
        => E , #listSwapRemove(Es, I -Int 1)
    requires I >Int 0
  rule  #listSwapRemove(Es:ExpressionCSV, I:Int)
        => Es
    requires I <Int 0

endmodule

module LIST-SWAP-REMOVE-REFLECTION
  imports LIST-SWAP-REMOVE-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply(
          $#listSwapRemove,
          (reflectionArgument(Es:ExpressionCSV), reflectionArgument(I:Int)))
      => #listSwapRemove(Es, I)
endmodule
